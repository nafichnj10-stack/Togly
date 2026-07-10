const functions = require("firebase-functions");
const admin = require("firebase-admin");

try {
  admin.app();
} catch {
  admin.initializeApp();
}

const db = admin.firestore();
const REGION = "europe-west3";

function makeResponse(overrides = {}) {
  return {
    ok: false,
    code: "ERROR",
    message: "Unknown error.",
    treasureId: "",
    relationship_id: "",
    status: "",
    durationDays: 0,
    maxSurprises: 0,
    unlockAtMs: 0,
    createdAtMs: 0,
    surprisesCountUserA: 0,
    surprisesCountUserB: 0,
    mySurprisesCount: 0,
    partnerSurprisesCount: 0,
    openedAtMs: 0,
    createdByUid: "",
    partnerUid: "",
    isUnlocked: false,
    isOpened: false,
    ...overrides,
  };
}

exports.getLoveTreasureById = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    try {
      const uid = context?.auth?.uid;
      if (!uid) {
        return makeResponse({
          code: "UNAUTHENTICATED",
          message: "User must be authenticated.",
        });
      }

      const treasureId = String(data?.treasureId || "").trim();
      if (!treasureId) {
        return makeResponse({
          code: "MISSING_TREASURE_ID",
          message: "treasureId is required.",
        });
      }

      const treasureRef = db.collection("love_treasures").doc(treasureId);
      const treasureSnap = await treasureRef.get();

      if (!treasureSnap.exists) {
        return makeResponse({
          code: "NOT_FOUND",
          message: "Love Treasure not found.",
          treasureId,
        });
      }

      const t = treasureSnap.data() || {};

      const relationshipId = String(t.relationship_id || "").trim();
      const createdByUid = String(t.createdByUid || "").trim();
      const partnerUid = String(t.partnerUid || "").trim();

      if (uid !== createdByUid && uid !== partnerUid) {
        return makeResponse({
          code: "FORBIDDEN",
          message: "You are not allowed to access this Love Treasure.",
          treasureId,
          relationship_id: relationshipId,
        });
      }

      const unlockAtMs = t.unlockAt?.toMillis?.() || 0;
      const createdAtMs = t.createdAt?.toMillis?.() || 0;
      const openedAtMs = t.openedAt?.toMillis?.() || 0;

      const surprisesCountUserA = Number(t.surprisesCountUserA || 0);
      const surprisesCountUserB = Number(t.surprisesCountUserB || 0);

      let mySurprisesCount = 0;
      let partnerSurprisesCount = 0;

      if (uid === createdByUid) {
        mySurprisesCount = surprisesCountUserA;
        partnerSurprisesCount = surprisesCountUserB;
      } else {
        mySurprisesCount = surprisesCountUserB;
        partnerSurprisesCount = surprisesCountUserA;
      }

      const nowMs = Date.now();
      const isUnlocked = unlockAtMs > 0 && nowMs >= unlockAtMs;

      // Prefer explicit Firestore field, fallback to openedAt for old docs
      const isOpened =
        typeof t.isOpened === "boolean" ? t.isOpened : openedAtMs > 0;

      return {
        ok: true,
        code: "OK",
        message: "Love Treasure loaded successfully.",
        treasureId: treasureSnap.id,
        relationship_id: relationshipId,
        status: String(t.status || ""),
        durationDays: Number(t.durationDays || 0),
        maxSurprises: Number(t.maxSurprises || 0),
        unlockAtMs,
        createdAtMs,
        surprisesCountUserA,
        surprisesCountUserB,
        mySurprisesCount,
        partnerSurprisesCount,
        openedAtMs,
        createdByUid,
        partnerUid,
        isUnlocked,
        isOpened,
      };
    } catch (e) {
      console.error("getLoveTreasureById error:", e);

      return makeResponse({
        code: "ERROR",
        message: String(e?.message || "Unknown error in getLoveTreasureById."),
      });
    }
  });
