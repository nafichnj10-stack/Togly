const functions = require("firebase-functions");
const admin = require("firebase-admin");

if (!admin.apps.length) {
  admin.initializeApp();
}

const db = admin.firestore();
const REGION = "europe-west3";

exports.unlockTreasureCoupons = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    try {
      const uid = context && context.auth ? context.auth.uid : null;
      if (!uid) {
        throw new functions.https.HttpsError(
          "unauthenticated",
          "User must be logged in.",
        );
      }

      const treasureId =
        data && data.treasureId ? String(data.treasureId).trim() : "";
      const relationshipId =
        data && data.relationshipId ? String(data.relationshipId).trim() : "";

      if (!treasureId || !relationshipId) {
        throw new functions.https.HttpsError(
          "invalid-argument",
          "Missing treasureId or relationshipId.",
        );
      }

      // Check relationship exists
      const relationshipRef = db
        .collection("relationships")
        .doc(relationshipId);
      const relationshipSnap = await relationshipRef.get();

      if (!relationshipSnap.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Relationship not found.",
        );
      }

      const relationshipData = relationshipSnap.data() || {};

      // Check current user is part of this relationship
      let userAId = "";
      let userBId = "";

      if (typeof relationshipData.userA_id === "string") {
        userAId = relationshipData.userA_id;
      } else if (
        relationshipData.userA_id &&
        typeof relationshipData.userA_id.id === "string"
      ) {
        userAId = relationshipData.userA_id.id;
      }

      if (typeof relationshipData.userB_id === "string") {
        userBId = relationshipData.userB_id;
      } else if (
        relationshipData.userB_id &&
        typeof relationshipData.userB_id.id === "string"
      ) {
        userBId = relationshipData.userB_id.id;
      }

      if (uid !== userAId && uid !== userBId) {
        throw new functions.https.HttpsError(
          "permission-denied",
          "User is not part of this relationship.",
        );
      }

      // Check treasure exists and belongs to this relationship
      const treasureRef = db.collection("love_treasures").doc(treasureId);
      const treasureSnap = await treasureRef.get();

      if (!treasureSnap.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Treasure not found.",
        );
      }

      const treasureData = treasureSnap.data() || {};
      const treasureRelationshipId = treasureData.relationship_id
        ? String(treasureData.relationship_id).trim()
        : "";

      if (treasureRelationshipId !== relationshipId) {
        throw new functions.https.HttpsError(
          "failed-precondition",
          "Treasure does not belong to the given relationship.",
        );
      }

      // Get all coupons for this treasure
      const couponsRef = db
        .collection("relationships")
        .doc(relationshipId)
        .collection("love_coupons")
        .where("source_treasure_id", "==", treasureId);

      const snapshot = await couponsRef.get();

      if (snapshot.empty) {
        return {
          ok: true,
          success: true,
          updated: 0,
          message: "No coupons found for this treasure.",
        };
      }

      const batch = db.batch();
      const now = admin.firestore.FieldValue.serverTimestamp();

      snapshot.forEach((doc) => {
        batch.update(doc.ref, {
          is_visible_in_wallet: true,
          status: "active",
          unlocked_at: now,
          updated_at: now,
        });
      });

      await batch.commit();

      return {
        ok: true,
        success: true,
        updated: snapshot.size,
        message: "Treasure coupons unlocked successfully.",
      };
    } catch (error) {
      console.error("unlockTreasureCoupons error:", error);

      const code = error && error.code ? error.code : "internal";
      const message =
        error && error.message
          ? error.message
          : "Unknown error in unlockTreasureCoupons.";

      throw new functions.https.HttpsError(code, message);
    }
  });
