const functions = require("firebase-functions");
const admin = require("firebase-admin");

try {
  admin.app();
} catch {
  admin.initializeApp();
}

const db = admin.firestore();
const REGION = "europe-west3";
const OPENED_REOPEN_WINDOW_MS = 24 * 60 * 60 * 1000; // 24h

function makeResponse(overrides = {}) {
  return {
    ok: false,
    found: false,
    code: "ERROR",
    message: "Unknown error.",
    treasureId: "",
    treasurePath: "",
    unlockAtMs: 0,
    durationDays: 0,
    maxSurprises: 0,
    status: "",
    ...overrides,
  };
}

function extractRelationshipId(value) {
  if (!value) return "";

  if (typeof value === "string") {
    const trimmed = value.trim();
    if (!trimmed) return "";

    if (trimmed.includes("/")) {
      const parts = trimmed.split("/").filter(Boolean);
      return parts[parts.length - 1] || "";
    }

    return trimmed;
  }

  if (
    typeof value === "object" &&
    typeof value.id === "string" &&
    value.id.trim()
  ) {
    return value.id.trim();
  }

  if (
    typeof value === "object" &&
    typeof value.path === "string" &&
    value.path.trim()
  ) {
    const parts = value.path.split("/").filter(Boolean);
    return parts[parts.length - 1] || "";
  }

  return "";
}

function timestampToMs(value) {
  if (!value) return 0;
  if (typeof value.toMillis === "function") return value.toMillis();
  if (value instanceof Date) return value.getTime();
  return 0;
}

function isOpenedStillReopenable(data) {
  const status = String(data?.status || "");
  if (status !== "opened") return false;

  const openedAtMs = timestampToMs(data?.openedAt);
  if (!openedAtMs) return false;

  return Date.now() - openedAtMs <= OPENED_REOPEN_WINDOW_MS;
}

function getTreasurePriority(data) {
  const status = String(data?.status || "");

  if (status === "opened" && isOpenedStillReopenable(data)) return 1;
  if (status === "ready") return 2;
  if (status === "active") return 3;

  return 999;
}

exports.getActiveLoveTreasure = functions
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

      const publicUserRef = db.collection("PublicUsers").doc(uid);
      const publicUserSnap = await publicUserRef.get();

      if (!publicUserSnap.exists) {
        return makeResponse({
          code: "PUBLIC_USER_NOT_FOUND",
          message: "Current user not found in PublicUsers.",
        });
      }

      const publicUserData = publicUserSnap.data() || {};
      const relationshipId = extractRelationshipId(
        publicUserData.relationship_id,
      );

      if (!relationshipId) {
        return makeResponse({
          code: "MISSING_RELATIONSHIP_ID",
          message: "No valid relationship_id found in PublicUsers.",
        });
      }

      const snap = await db
        .collection("love_treasures")
        .where("relationship_id", "==", relationshipId)
        .where("status", "in", ["active", "ready", "opened"])
        .get();

      if (snap.empty) {
        return {
          ok: true,
          found: false,
          code: "NOT_FOUND",
          message: "No Love Treasure found.",
          treasureId: "",
          treasurePath: "",
          unlockAtMs: 0,
          durationDays: 0,
          maxSurprises: 0,
          status: "",
        };
      }

      const validDocs = snap.docs.filter((doc) => {
        const treasure = doc.data() || {};
        const status = String(treasure.status || "");

        if (status === "active" || status === "ready") return true;
        if (status === "opened" && isOpenedStillReopenable(treasure))
          return true;

        return false;
      });

      if (validDocs.length === 0) {
        return {
          ok: true,
          found: false,
          code: "NOT_FOUND",
          message:
            "No active, ready, or reopenable opened Love Treasure found.",
          treasureId: "",
          treasurePath: "",
          unlockAtMs: 0,
          durationDays: 0,
          maxSurprises: 0,
          status: "",
        };
      }

      validDocs.sort((a, b) => {
        const aData = a.data() || {};
        const bData = b.data() || {};

        const priorityDiff =
          getTreasurePriority(aData) - getTreasurePriority(bData);
        if (priorityDiff !== 0) return priorityDiff;

        const aCreatedAt = timestampToMs(aData.createdAt);
        const bCreatedAt = timestampToMs(bData.createdAt);
        return bCreatedAt - aCreatedAt; // newest first
      });

      const doc = validDocs[0];
      const treasure = doc.data() || {};

      return {
        ok: true,
        found: true,
        code: "OK",
        message: "Love Treasure found.",
        treasureId: doc.id,
        treasurePath: doc.ref.path,
        unlockAtMs: treasure.unlockAt?.toMillis?.() || 0,
        durationDays: Number(treasure.durationDays || 0),
        maxSurprises: Number(treasure.maxSurprises || 0),
        status: String(treasure.status || ""),
      };
    } catch (e) {
      console.error("getActiveLoveTreasure error:", e);

      return makeResponse({
        code: "ERROR",
        message: String(
          e?.message || "Unknown error in getActiveLoveTreasure.",
        ),
      });
    }
  });
