const functions = require("firebase-functions");
const admin = require("firebase-admin");
// Do not call admin.initializeApp() in FlutterFlow Cloud Functions.

exports.updateLoveBuddyName = functions
  .region("europe-west3")
  .https.onCall(async (data, context) => {
    if (!context.auth || !context.auth.uid) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "You must be signed in.",
      );
    }

    const uid = context.auth.uid;
    const relationshipId = String(data.relationshipId || "").trim();
    const newName = String(data.newName || "").trim();

    if (!relationshipId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Missing relationshipId.",
      );
    }

    if (!newName) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Pet name cannot be empty.",
      );
    }

    if (newName.length > 15) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Pet name is too long. Max 15 characters.",
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

    const updateData = {
      love_buddies_updated_at: admin.firestore.FieldValue.serverTimestamp(),
    };

    if (uid === userAId) {
      updateData.love_buddies_user_a_name = newName;
    } else {
      updateData.love_buddies_user_b_name = newName;
    }

    await relRef.set(updateData, { merge: true });

    return {
      success: true,
      newName: newName,
      message: `Your pet is now called ${newName}.`,
    };
  });
