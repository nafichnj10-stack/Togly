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

const USERS_COL = "Users";
const PUBLIC_COL = "PublicUsers";
const REL_COL = "relationships";
const REL_VIEWS_COL = "relationship_views";

const REL_BY_RELATIONSHIP = [
  "albums",
  "gallery",
  "bucket_list",
  "love_notes",
  "daily_questions",
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

const usersRef = (uid) => db.collection(USERS_COL).doc(uid);
const publicUsersCol = () => db.collection(PUBLIC_COL);
const relViewsRef = (uid) => db.collection(REL_VIEWS_COL).doc(uid);

async function deleteStoragePrefix(prefix) {
  const [files] = await bucket.getFiles({ prefix });
  if (!files?.length) return 0;
  await Promise.all(files.map((f) => f.delete().catch(() => null)));
  return files.length;
}

async function deleteByQuery({ collection, field, value, limit = 300 }) {
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
  while (true) {
    const snap = await parentRef
      .collection(subcollectionName)
      .limit(limit)
      .get();
    if (snap.empty) break;

    const batch = db.batch();
    snap.docs.forEach((d) => batch.delete(d.ref));
    await batch.commit();

    if (snap.size < limit) break;
  }
}

async function deletePublicUsersForUid(uid) {
  await publicUsersCol()
    .doc(uid)
    .delete()
    .catch(() => null);

  while (true) {
    const snap = await publicUsersCol()
      .where("uid", "==", uid)
      .limit(300)
      .get();
    if (snap.empty) break;

    const batch = db.batch();
    snap.docs.forEach((d) => batch.delete(d.ref));
    await batch.commit();

    if (snap.size < 300) break;
  }
}

async function clearPartnerPointers(partnerId) {
  if (!partnerId) return;

  await usersRef(partnerId)
    .set(
      {
        relationship_id: admin.firestore.FieldValue.delete(),
        partnerUID: admin.firestore.FieldValue.delete(),
        disconnect_cooldown_until: admin.firestore.FieldValue.delete(),
        last_relationship_id: admin.firestore.FieldValue.delete(),
        last_relationship_ref: admin.firestore.FieldValue.delete(),
      },
      { merge: true },
    )
    .catch(() => null);

  try {
    const ps = await publicUsersCol()
      .where("uid", "==", partnerId)
      .limit(300)
      .get();

    if (!ps.empty) {
      const batch = db.batch();

      ps.docs.forEach((d) =>
        batch.set(
          d.ref,
          {
            relationship_id: admin.firestore.FieldValue.delete(),
            partnerUID: admin.firestore.FieldValue.delete(),
          },
          { merge: true },
        ),
      );

      await batch.commit();
    }
  } catch (_) {}

  await relViewsRef(partnerId)
    .delete()
    .catch(() => null);
}

exports.deleteMyAccount = functions
  .region(REGION)
  .https.onCall(async (data, ctx) => {
    const uid = ctx.auth?.uid;

    if (!uid) {
      throw new functions.https.HttpsError("unauthenticated", "Auth required.");
    }

    const meRef = usersRef(uid);
    const meSnap = await meRef.get();
    const me = meSnap.exists ? meSnap.data() || {} : {};

    const relId =
      me.relationship_id ||
      me.last_relationship_id ||
      (me.last_relationship_ref && me.last_relationship_ref.id) ||
      null;

    const partnerUID = me.partnerUID || me.partner_uid || null;

    if (relId) {
      const relRef = db.collection(REL_COL).doc(String(relId));
      const relSnap = await relRef.get();

      if (relSnap.exists) {
        const rel = relSnap.data() || {};
        const partnerFromRel =
          rel.userA_id === uid ? rel.userB_id : rel.userA_id;
        await clearPartnerPointers(partnerFromRel).catch(() => null);
      } else {
        await clearPartnerPointers(partnerUID).catch(() => null);
      }

      // Delete relationship subcollections first
      await deleteSubcollection(relRef, "love_coupons").catch(() => null);

      // Delete relationship doc
      await relRef.delete().catch(() => null);

      // Delete relationship-bound collections
      for (const col of REL_BY_RELATIONSHIP) {
        await deleteByQuery({
          collection: col,
          field: "relationship_id",
          value: String(relId),
        }).catch(() => null);
      }

      // Delete couple storage folder
      await deleteStoragePrefix(`couples/${relId}/`).catch(() => null);
    } else {
      await clearPartnerPointers(partnerUID).catch(() => null);
    }

    await relViewsRef(uid)
      .delete()
      .catch(() => null);

    try {
      const [rq, rt] = await Promise.all([
        db
          .collection("reconnect_requests")
          .where("initiator_id", "==", uid)
          .get()
          .catch(() => null),
        db
          .collection("reconnect_requests")
          .where("target_id", "==", uid)
          .get()
          .catch(() => null),
      ]);

      if ((rq && !rq.empty) || (rt && !rt.empty)) {
        const batch = db.batch();

        if (rq && !rq.empty) rq.docs.forEach((d) => batch.delete(d.ref));
        if (rt && !rt.empty) rt.docs.forEach((d) => batch.delete(d.ref));

        await batch.commit().catch(() => null);
      }
    } catch (_) {}

    await deleteStoragePrefix(`users/${uid}/`).catch(() => null);

    await deletePublicUsersForUid(uid).catch(() => null);

    await deleteSubcollection(meRef, "fcm_tokens").catch(() => null);

    await meRef.delete().catch(() => null);

    await admin
      .auth()
      .deleteUser(uid)
      .catch((e) => {
        console.error("[deleteMyAccount] admin.auth().deleteUser failed", e);
        throw new functions.https.HttpsError(
          "internal",
          "Auth user deletion failed.",
        );
      });

    return {
      ok: true,
      uid,
      relationship_id: relId ?? null,
    };
  });
