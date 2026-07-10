const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code
const REGION = "europe-west3";

exports.decrementTreasureSurpriseCount = functions
  .region(REGION)
  .firestore.document("treasure_surprises/{surpriseId}")
  .onDelete(async (snap, context) => {
    try {
      const surprise = snap.data() || {};

      const treasureRef = surprise.treasureRef;
      const surpriseCreatedByUid = String(surprise.createdByUid || "").trim();

      if (!treasureRef || !surpriseCreatedByUid) {
        console.warn(
          "Missing treasureRef or createdByUid on deleted treasure_surprises:",
          context.params.surpriseId,
        );
        return null;
      }

      const treasureSnap = await treasureRef.get();

      if (!treasureSnap.exists) {
        console.warn(
          "Treasure not found for deleted surprise:",
          context.params.surpriseId,
        );
        return null;
      }

      const treasure = treasureSnap.data() || {};
      const treasureCreatedByUid = String(treasure.createdByUid || "").trim();

      const fieldToDecrement =
        surpriseCreatedByUid === treasureCreatedByUid
          ? "surprisesCountUserA"
          : "surprisesCountUserB";

      await treasureRef.update({
        [fieldToDecrement]: admin.firestore.FieldValue.increment(-1),
      });

      return null;
    } catch (error) {
      console.error("decrementTreasureSurpriseCount error:", error);
      return null;
    }
  });
