const functions = require("firebase-functions");
const admin = require("firebase-admin");
// Do not call admin.initializeApp() in FlutterFlow Cloud Functions.

exports.syncLoveBuddyBirthdayState = functions
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

    const [userASnap, userBSnap] = await Promise.all([
      db.collection("Users").doc(userAId).get(),
      db.collection("Users").doc(userBId).get(),
    ]);

    const userA = userASnap.exists ? userASnap.data() || {} : {};
    const userB = userBSnap.exists ? userBSnap.data() || {} : {};

    const now = new Date();
    const todayMonth = now.getMonth();
    const todayDate = now.getDate();

    function isBirthdayToday(value) {
      if (!value) return false;

      let date;

      if (typeof value.toDate === "function") {
        date = value.toDate();
      } else {
        date = new Date(value);
      }

      if (!date || isNaN(date.getTime())) return false;

      return date.getMonth() === todayMonth && date.getDate() === todayDate;
    }

    const birthdayUserUids = [];

    if (isBirthdayToday(userA.birthday)) {
      birthdayUserUids.push(userAId);
    }

    if (isBirthdayToday(userB.birthday)) {
      birthdayUserUids.push(userBId);
    }

    const birthdayActive = birthdayUserUids.length > 0;

    const updateData = {
      love_buddies_birthday_active: birthdayActive,
      love_buddies_birthday_user_uids: birthdayUserUids,
      love_buddies_updated_at: admin.firestore.FieldValue.serverTimestamp(),
    };

    if (birthdayActive) {
      updateData.love_buddies_birthday_started_at =
        rel.love_buddies_birthday_active === true
          ? rel.love_buddies_birthday_started_at ||
            admin.firestore.FieldValue.serverTimestamp()
          : admin.firestore.FieldValue.serverTimestamp();

      updateData.love_buddies_birthday_ended_at = null;
    } else {
      if (rel.love_buddies_birthday_active === true) {
        updateData.love_buddies_birthday_ended_at =
          admin.firestore.FieldValue.serverTimestamp();
      }
    }

    await relRef.set(updateData, { merge: true });

    return {
      success: true,
      birthdayActive: birthdayActive,
      birthdayUserUids: birthdayUserUids,
    };
  });
