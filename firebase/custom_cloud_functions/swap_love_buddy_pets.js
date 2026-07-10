const functions = require("firebase-functions");
const admin = require("firebase-admin");
// Do not call admin.initializeApp() in FlutterFlow Cloud Functions.

exports.swapLoveBuddyPets = functions
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

    if (!relationshipId) {
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

    await relRef.set(
      {
        love_buddies_user_a_pet: userBPet,
        love_buddies_user_b_pet: userAPet,

        love_buddies_user_a_name: userBName,
        love_buddies_user_b_name: userAName,

        love_buddies_updated_at: admin.firestore.FieldValue.serverTimestamp(),
      },
      { merge: true },
    );

    const newPet = uid === userAId ? userBPet : userAPet;
    const newPetName = uid === userAId ? userBName : userAName;

    return {
      success: true,
      newPet: newPet,
      newPetName: newPetName,
      message: `You are now the ${newPet}.`,
    };
  });
