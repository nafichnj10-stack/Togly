const functions = require("firebase-functions");
const admin = require("firebase-admin");
try {
  admin.app();
} catch {
  admin.initializeApp();
}

const db = admin.firestore();
const REGION = "europe-west3";

function toNumber(v) {
  const n = Number(v);
  return Number.isFinite(n) ? n : null;
}

function haversineKm(lat1, lng1, lat2, lng2) {
  const R = 6371;
  const dLat = ((lat2 - lat1) * Math.PI) / 180;
  const dLng = ((lng2 - lng1) * Math.PI) / 180;

  const a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos((lat1 * Math.PI) / 180) *
      Math.cos((lat2 * Math.PI) / 180) *
      Math.sin(dLng / 2) *
      Math.sin(dLng / 2);

  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  return R * c;
}

exports.syncLoveBuddyDistance = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Authentication required.",
      );
    }

    const uid = context.auth.uid;

    const viewRef = db.collection("relationship_views").doc(uid);
    const viewSnap = await viewRef.get();

    if (!viewSnap.exists) {
      return {
        ok: false,
        code: "NO_RELATIONSHIP_VIEW",
      };
    }

    const view = viewSnap.data() || {};
    const relationshipId = String(view.relationship_id || "").trim();

    if (!relationshipId) {
      return {
        ok: false,
        code: "NO_RELATIONSHIP_ID",
      };
    }

    const myLat = toNumber(view.my_home_lat);
    const myLng = toNumber(view.my_home_lng);
    const partnerLat = toNumber(view.partner_home_lat);
    const partnerLng = toNumber(view.partner_home_lng);

    if (
      myLat === null ||
      myLng === null ||
      partnerLat === null ||
      partnerLng === null
    ) {
      return {
        ok: false,
        code: "MISSING_COORDINATES",
        hasMyLocation: myLat !== null && myLng !== null,
        hasPartnerLocation: partnerLat !== null && partnerLng !== null,
      };
    }

    const distanceKmRaw = haversineKm(myLat, myLng, partnerLat, partnerLng);
    const distanceKm = Math.round(distanceKmRaw);

    const now = admin.firestore.FieldValue.serverTimestamp();
    const relRef = db.collection("relationships").doc(relationshipId);

    const relSnap = await relRef.get();
    const relData = relSnap.exists ? relSnap.data() || {} : {};

    const updateData = {
      love_buddies_current_distance_km: distanceKm,
      love_buddies_distance_updated_at: now,
      love_buddies_updated_at: now,
    };

    if (typeof relData.love_buddies_start_distance_km !== "number") {
      updateData.love_buddies_start_distance_km = distanceKm;
    }

    await relRef.set(updateData, { merge: true });

    return {
      ok: true,
      code: "OK",
      relationshipId,
      distanceKm,
    };
  });
