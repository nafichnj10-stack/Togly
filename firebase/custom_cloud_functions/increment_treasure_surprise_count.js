const functions = require("firebase-functions");
const admin = require("firebase-admin");

if (!admin.apps.length) {
  admin.initializeApp();
}

const db = admin.firestore();
const REGION = "europe-west3";

exports.incrementTreasureSurpriseCount = functions
  .region(REGION)
  .firestore.document("treasure_surprises/{surpriseId}")
  .onCreate(async (snap, context) => {
    try {
      const surprise = snap.data() || {};

      const treasureRef = surprise.treasureRef;
      const surpriseCreatedByUid = String(surprise.createdByUid || "").trim();

      if (!treasureRef || !surpriseCreatedByUid) {
        console.warn(
          "Missing treasureRef or createdByUid on treasure_surprises:",
          context.params.surpriseId,
        );
        return null;
      }

      const treasureSnap = await treasureRef.get();

      if (!treasureSnap.exists) {
        console.warn(
          "Treasure not found for surprise:",
          context.params.surpriseId,
        );
        return null;
      }

      const treasure = treasureSnap.data() || {};
      const treasureCreatedByUid = String(treasure.createdByUid || "").trim();

      let fieldToIncrement = "";

      if (surpriseCreatedByUid === treasureCreatedByUid) {
        fieldToIncrement = "surprisesCountUserA";
      } else {
        fieldToIncrement = "surprisesCountUserB";
      }

      await treasureRef.update({
        [fieldToIncrement]: admin.firestore.FieldValue.increment(1),
      });

      return null;
    } catch (error) {
      console.error("incrementTreasureSurpriseCount error:", error);
      return null;
    }
  });
