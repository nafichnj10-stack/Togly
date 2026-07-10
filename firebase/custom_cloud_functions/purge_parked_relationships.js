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

  if (!files || !files.length) return 0;

  await Promise.all(files.map((f) => f.delete().catch(() => null)));

  return files.length;
}

async function purgeRelationshipById(rid) {
  const relRef = db.collection("relationships").doc(rid);
  const relSnap = await relRef.get();

  if (!relSnap.exists) {
    return {
      status: "already_deleted",
      relationship_id: rid,
    };
  }

  const rel = relSnap.data() || {};
  const userA = rel.userA_id || rel.userAId || rel.userA;
  const userB = rel.userB_id || rel.userBId || rel.userB;
  const members = [userA, userB].filter(Boolean);

  // 1) Delete relationship-bound top-level docs
  for (const col of RELATIONSHIP_BOUND_COLLECTIONS) {
    await deleteByQuery(col, "relationship_id", rid).catch(() => null);
  }

  // 2) Delete relationship subcollections
  await deleteSubcollection(relRef, "love_coupons").catch(() => null);

  // 3) relationship_views also by docId
  await Promise.all(
    members.map((uid) =>
      db
        .collection("relationship_views")
        .doc(uid)
        .delete()
        .catch(() => null),
    ),
  );

  // 4) Storage couples/<rid>/
  await deleteStoragePrefix(`couples/${rid}/`).catch(() => null);

  // 5) Users cleanup
  const now = admin.firestore.Timestamp.now();

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
    updated_at: now,
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

  // Fallback: if members are missing / field names were different
  const fallbackUsers = await db
    .collection("Users")
    .where("last_relationship_id", "==", rid)
    .get()
    .catch(() => null);

  if (fallbackUsers && !fallbackUsers.empty) {
    await Promise.all(
      fallbackUsers.docs.map((d) =>
        d.ref.set(userPatch, { merge: true }).catch(() => null),
      ),
    );
  }

  // 6) PublicUsers cleanup
  const publicPatch = {
    relationship_id: admin.firestore.FieldValue.delete(),
    partnerUID: admin.firestore.FieldValue.delete(),
    relationship_status: admin.firestore.FieldValue.delete(),
    updated_at: now,
  };

  for (const uid of members) {
    const ps = await db
      .collection("PublicUsers")
      .where("uid", "==", uid)
      .get()
      .catch(() => null);

    if (ps && !ps.empty) {
      await Promise.all(
        ps.docs.map((d) =>
          d.ref.set(publicPatch, { merge: true }).catch(() => null),
        ),
      );
    }
  }

  // 7) Finally delete relationship doc
  await relRef.delete();

  return {
    status: "purged",
    relationship_id: rid,
  };
}

exports.purgeParkedRelationships = functions
  .region(REGION)
  .pubsub.schedule("every 30 minutes")
  .timeZone("Europe/Berlin")
  .onRun(async () => {
    const now = admin.firestore.Timestamp.now();

    const snap = await db
      .collection("relationships")
      .where("active", "==", false)
      .where("purge_at", "<=", now)
      .limit(50)
      .get();

    if (snap.empty) {
      return {
        ok: true,
        purged: 0,
      };
    }

    const results = [];

    for (const doc of snap.docs) {
      try {
        const res = await purgeRelationshipById(doc.id);
        results.push({
          id: doc.id,
          status: res.status,
        });
      } catch (e) {
        results.push({
          id: doc.id,
          status: "error",
          error: String(e?.message || e),
        });
      }
    }

    return {
      ok: true,
      purged: results.filter((r) => r.status === "purged").length,
      results,
    };
  });
