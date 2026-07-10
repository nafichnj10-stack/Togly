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
    code: "ERROR",
    message: "Unknown error.",
    treasureId: "",
    treasurePath: "",
    unlockAtMs: 0,
    maxSurprises: 0,
    durationDays: 0,
    status: "error",
    ...overrides,
  };
}

function getMaxSurprises(durationDays) {
  if (durationDays === 3) return 10;
  if (durationDays === 7) return 15;
  if (durationDays === 14) return 20;
  return 0;
}

function extractUid(value) {
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

  if (typeof value === "object") {
    if (typeof value.id === "string" && value.id.trim()) {
      return value.id.trim();
    }
    if (typeof value.path === "string" && value.path.trim()) {
      const parts = value.path.split("/").filter(Boolean);
      return parts[parts.length - 1] || "";
    }
  }

  return "";
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

  if (typeof value === "object") {
    if (typeof value.id === "string" && value.id.trim()) {
      return value.id.trim();
    }

    if (typeof value.path === "string" && value.path.trim()) {
      const parts = value.path.split("/").filter(Boolean);
      return parts[parts.length - 1] || "";
    }
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

exports.loveTreasureStart = functions
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

      const durationDays = Number(data?.durationDays);
      if (![3, 7, 14].includes(durationDays)) {
        return makeResponse({
          code: "INVALID_DURATION",
          message: "durationDays must be 3, 7, or 14.",
        });
      }

      const userRef = db.collection("Users").doc(uid);
      const publicUserRef = db.collection("PublicUsers").doc(uid);

      const [userSnap, publicUserSnap] = await Promise.all([
        userRef.get(),
        publicUserRef.get(),
      ]);

      if (!userSnap.exists) {
        return makeResponse({
          code: "USER_NOT_FOUND",
          message: "Current user not found in Users.",
          durationDays,
        });
      }

      if (!publicUserSnap.exists) {
        return makeResponse({
          code: "PUBLIC_USER_NOT_FOUND",
          message: "Current user not found in PublicUsers.",
          durationDays,
        });
      }

      const publicUserData = publicUserSnap.data() || {};

      const partnerUid = extractUid(publicUserData.partnerUID);
      if (!partnerUid) {
        return makeResponse({
          code: "MISSING_PARTNER_UID",
          message: "No valid partnerUID found in PublicUsers.",
          durationDays,
        });
      }

      const relationshipId = extractRelationshipId(
        publicUserData.relationship_id,
      );
      if (!relationshipId) {
        return makeResponse({
          code: "MISSING_RELATIONSHIP_ID",
          message: "No valid relationship_id found in PublicUsers.",
          durationDays,
        });
      }

      const relationshipRef = db
        .collection("relationships")
        .doc(relationshipId);
      const partnerRef = db.collection("Users").doc(partnerUid);

      const [partnerSnap, relationshipSnap] = await Promise.all([
        partnerRef.get(),
        relationshipRef.get(),
      ]);

      if (!partnerSnap.exists) {
        return makeResponse({
          code: "PARTNER_NOT_FOUND",
          message: "Partner user not found in Users.",
          durationDays,
        });
      }

      if (!relationshipSnap.exists) {
        return makeResponse({
          code: "RELATIONSHIP_NOT_FOUND",
          message: "Relationship document not found.",
          durationDays,
        });
      }

      const relationshipData = relationshipSnap.data() || {};
      if (relationshipData.active !== true) {
        return makeResponse({
          code: "RELATIONSHIP_NOT_ACTIVE",
          message: "Relationship is not active.",
          durationDays,
        });
      }

      // IMPORTANT:
      // Block new treasure creation if there is already:
      // - an active treasure
      // - a ready treasure
      // - an opened treasure that is still re-openable within 24h
      const existingSnap = await db
        .collection("love_treasures")
        .where("relationship_id", "==", relationshipId)
        .where("status", "in", ["active", "ready", "opened"])
        .get();

      const validExistingDocs = existingSnap.docs.filter((doc) => {
        const data = doc.data() || {};
        const status = String(data.status || "");

        if (status === "active" || status === "ready") return true;
        if (status === "opened" && isOpenedStillReopenable(data)) return true;

        return false;
      });

      if (validExistingDocs.length > 0) {
        validExistingDocs.sort((a, b) => {
          const aData = a.data() || {};
          const bData = b.data() || {};

          const priorityDiff =
            getTreasurePriority(aData) - getTreasurePriority(bData);
          if (priorityDiff !== 0) return priorityDiff;

          const aCreatedAt = timestampToMs(aData.createdAt);
          const bCreatedAt = timestampToMs(bData.createdAt);
          return bCreatedAt - aCreatedAt; // newest first
        });

        const existingDoc = validExistingDocs[0];
        const existingData = existingDoc.data() || {};

        return {
          ok: false,
          code: "ALREADY_EXISTS",
          message:
            "There is already a Love Treasure for this relationship that should be reopened instead of creating a new one.",
          treasureId: existingDoc.id,
          treasurePath: existingDoc.ref.path,
          unlockAtMs: existingData.unlockAt?.toMillis?.() || 0,
          maxSurprises: Number(existingData.maxSurprises || 0),
          durationDays: Number(existingData.durationDays || durationDays),
          status: String(existingData.status || "active"),
        };
      }

      const maxSurprises = getMaxSurprises(durationDays);
      const createdAt = admin.firestore.Timestamp.now();

      const unlockDate = new Date(createdAt.toDate());
      unlockDate.setDate(unlockDate.getDate() + durationDays);
      const unlockAt = admin.firestore.Timestamp.fromDate(unlockDate);

      const treasureRef = db.collection("love_treasures").doc();

      await treasureRef.set({
        treasureId: treasureRef.id,
        relationship_id: relationshipId,
        createdBy: userRef,
        createdByUid: uid,
        partnerId: partnerRef,
        partnerUid: partnerUid,
        durationDays: durationDays,
        maxSurprises: maxSurprises,
        createdAt: createdAt,
        unlockAt: unlockAt,
        status: "active",
        surprisesCountUserA: 0,
        surprisesCountUserB: 0,
        openedAt: null,
        openedBy: null,
        isOpened: false,
      });

      return {
        ok: true,
        code: "OK",
        message: "Love Treasure created successfully.",
        treasureId: treasureRef.id,
        treasurePath: treasureRef.path,
        unlockAtMs: unlockAt.toMillis(),
        maxSurprises: maxSurprises,
        durationDays: durationDays,
        status: "active",
      };
    } catch (e) {
      console.error("loveTreasureStart error:", e);

      return makeResponse({
        code: "ERROR",
        message: String(e?.message || "Unknown error in loveTreasureStart."),
      });
    }
  });
