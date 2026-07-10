const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code
exports.syncLoveBuddyViews = functions
  .region("europe-west3")
  .https.onCall(async (data, context) => {
    if (!context.auth || !context.auth.uid) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "You must be signed in.",
      );
    }

    const uid = context.auth.uid;
    const relationshipId = data.relationshipId;

    if (!relationshipId || typeof relationshipId !== "string") {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Missing relationshipId.",
      );
    }

    const db = admin.firestore();

    const relRef = db.collection("relationships").doc(relationshipId);
    const relSnap = await relRef.get();

    if (!relSnap.exists) {
      throw new functions.https.HttpsError(
        "not-found",
        "Relationship not found.",
      );
    }

    const rel = relSnap.data() || {};

    const userAId = rel.userA_id;
    const userBId = rel.userB_id;

    if (!userAId || !userBId) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Relationship is missing userA_id or userB_id.",
      );
    }

    if (uid !== userAId && uid !== userBId) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "You are not a member of this relationship.",
      );
    }

    const userAPet = rel.love_buddies_user_a_pet || "dog";
    const userBPet = rel.love_buddies_user_b_pet || "cat";

    const userAName = rel.love_buddies_user_a_name || "Bam";
    const userBName = rel.love_buddies_user_b_name || "Mimi";

    const now = admin.firestore.FieldValue.serverTimestamp();

    const batch = db.batch();

    batch.set(
      db.collection("relationship_views").doc(userAId),
      {
        my_love_buddy_pet: userAPet,
        my_love_buddy_name: userAName,
        partner_love_buddy_pet: userBPet,
        partner_love_buddy_name: userBName,
        updated_at: now,
      },
      { merge: true },
    );

    batch.set(
      db.collection("relationship_views").doc(userBId),
      {
        my_love_buddy_pet: userBPet,
        my_love_buddy_name: userBName,
        partner_love_buddy_pet: userAPet,
        partner_love_buddy_name: userAName,
        updated_at: now,
      },
      { merge: true },
    );

    await batch.commit();

    return null;
  });
