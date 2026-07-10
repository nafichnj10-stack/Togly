const functions = require("firebase-functions");
const admin = require("firebase-admin");
try {
  admin.app();
} catch {
  admin.initializeApp();
}

const db = admin.firestore();
const bucket = admin.storage().bucket();

const REGION = "europe-west3";

const RELATIONSHIP_BOUND_COLLECTIONS = [
  "albums",
  "gallery",
  "bucket_list",
  "love_notes",
  "answers",
  "calendar_events",
  "mood_updates",
  "wishes",
  "relationship_requests",
  "reconnect_requests",
  "relationship_views",
  "heartbeat_sessions",
  "heartbeat_answers",
  "relationship_emotion_checkins",
  "love_awards",

  // Love Treasure
  "love_treasures",
  "treasure_surprises",
  "treasure_reveals",
];

async function deleteByQuery(collection, field, value, limit = 300) {
  let total = 0;

  while (true) {
    const snap = await db
      .collection(collection)
      .where(field, "==", value)
      .limit(limit)
      .get();
    if (snap.empty) break;

    const batch = db.batch();
    snap.docs.forEach((d) => batch.delete(d.ref));
    await batch.commit();

    total += snap.size;
    if (snap.size < limit) break;
  }

  return total;
}

async function deleteSubcollection(parentRef, subcollectionName, limit = 300) {
  let total = 0;

  while (true) {
    const snap = await parentRef
      .collection(subcollectionName)
      .limit(limit)
      .get();
    if (snap.empty) break;

    const batch = db.batch();
    snap.docs.forEach((d) => batch.delete(d.ref));
    await batch.commit();

    total += snap.size;
    if (snap.size < limit) break;
  }

  return total;
}

async function deleteStoragePrefix(prefix) {
  const [files] = await bucket.getFiles({ prefix });
  if (!files?.length) return 0;

  await Promise.all(files.map((f) => f.delete().catch(() => null)));

  return files.length;
}

async function patchPublicUsersByUid(uid, data) {
  const snap = await db.collection("PublicUsers").where("uid", "==", uid).get();
  if (snap.empty) return;

  await Promise.all(
    snap.docs.map((d) => d.ref.set(data, { merge: true }).catch(() => null)),
  );
}

async function purgeRelationshipById(rid) {
  const relRef = db.collection("relationships").doc(rid);
  const relSnap = await relRef.get();

  let members = [];

  if (relSnap.exists) {
    const rel = relSnap.data() || {};
    const userA = rel.userA_id || rel.userAId || rel.userA;
    const userB = rel.userB_id || rel.userBId || rel.userB;
    members = [userA, userB].filter(Boolean);
  }

  const deletedByCol = {};

  for (const col of RELATIONSHIP_BOUND_COLLECTIONS) {
    deletedByCol[col] = await deleteByQuery(col, "relationship_id", rid).catch(
      () => 0,
    );
  }

  if (relSnap.exists) {
    deletedByCol["relationships/love_coupons"] = await deleteSubcollection(
      relRef,
      "love_coupons",
    ).catch(() => 0);
  }

  await Promise.all(
    members.map((uid) =>
      db
        .collection("relationship_views")
        .doc(uid)
        .delete()
        .catch(() => null),
    ),
  );

  const storageDeleted = await deleteStoragePrefix(`couples/${rid}/`).catch(
    () => 0,
  );

  const userPatch = {
    relationship_id: admin.firestore.FieldValue.delete(),
    partnerUID: admin.firestore.FieldValue.delete(),
    relationship_status: admin.firestore.FieldValue.delete(),
    disconnect_cooldown_until: admin.firestore.FieldValue.delete(),
    last_relationship_id: admin.firestore.FieldValue.delete(),
    last_relationship_ref: admin.firestore.FieldValue.delete(),
    restore_required: admin.firestore.FieldValue.delete(),
    restore_state: admin.firestore.FieldValue.delete(),
    restore_request_id: admin.firestore.FieldValue.delete(),
    restore_relationship_id: admin.firestore.FieldValue.delete(),
    celebrate_reconnect: admin.firestore.FieldValue.delete(),
    celebrate_reconnect_at: admin.firestore.FieldValue.delete(),
  };

  await Promise.all(
    members.map((uid) =>
      db
        .collection("Users")
        .doc(uid)
        .set(userPatch, { merge: true })
        .catch(() => null),
    ),
  );

  const fallbackUsers = await db
    .collection("Users")
    .where("last_relationship_id", "==", rid)
    .limit(500)
    .get()
    .catch(() => null);

  if (fallbackUsers && !fallbackUsers.empty) {
    await Promise.all(
      fallbackUsers.docs.map((d) =>
        d.ref.set(userPatch, { merge: true }).catch(() => null),
      ),
    );
  }

  const publicPatch = {
    relationship_id: admin.firestore.FieldValue.delete(),
    partnerUID: admin.firestore.FieldValue.delete(),
    relationship_status: admin.firestore.FieldValue.delete(),
  };

  await Promise.all(
    members.map((uid) =>
      patchPublicUsersByUid(uid, publicPatch).catch(() => null),
    ),
  );

  if (relSnap.exists) {
    await relRef.delete();

    return {
      status: "purged",
      relationship_id: rid,
      members,
      storageDeleted,
      deletedByCol,
    };
  }

  return {
    status: "already_deleted",
    relationship_id: rid,
    members,
    storageDeleted,
    deletedByCol,
  };
}

exports.purgeRelationshipNow = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    const uid = context.auth?.uid;

    if (!uid) {
      throw new functions.https.HttpsError("unauthenticated", "Auth required.");
    }

    const meSnap = await db.collection("Users").doc(uid).get();
    const me = meSnap.exists ? meSnap.data() || {} : {};

    const ridFromClient = String(
      data?.relationshipid || data?.relationshipId || "",
    ).trim();

    const ridFromUser =
      String(me.last_relationship_id || "").trim() ||
      String(me.relationship_id || "").trim() ||
      String(me.last_relationship_ref?.id || "").trim();

    const rid = ridFromClient || ridFromUser;

    if (!rid) {
      return {
        ok: true,
        status: "no_relationship_to_purge",
        relationship_id: "",
      };
    }

    const relRef = db.collection("relationships").doc(rid);
    const relSnap = await relRef.get();

    if (relSnap.exists) {
      const rel = relSnap.data() || {};
      const userA = rel.userA_id || rel.userAId || rel.userA;
      const userB = rel.userB_id || rel.userBId || rel.userB;
      const isMember = uid === userA || uid === userB;
      const allowedByLast = String(me.last_relationship_id || "") === rid;

      if (!isMember && !allowedByLast) {
        throw new functions.https.HttpsError(
          "permission-denied",
          "Not allowed to purge this relationship.",
        );
      }
    }

    const res = await purgeRelationshipById(rid);

    return {
      ok: true,
      ...res,
    };
  });
