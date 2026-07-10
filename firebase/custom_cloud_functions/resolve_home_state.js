const functions = require("firebase-functions");
const admin = require("firebase-admin");
try {
  admin.app();
} catch {
  admin.initializeApp();
}

const db = admin.firestore();
const REGION = "europe-west3";

function nonEmptyString(v) {
  return typeof v === "string" && v.trim().length > 0 ? v.trim() : "";
}

function timestampToIsoOrEmpty(v) {
  try {
    if (!v) return "";
    if (typeof v.toDate === "function") return v.toDate().toISOString();
    if (v instanceof Date) return v.toISOString();
    return "";
  } catch {
    return "";
  }
}

exports.resolveHomeState = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Authentication required.",
      );
    }

    const uid = context.auth.uid;

    const tzOffsetMinutes = Number(data?.tzOffsetMinutes);
    if (!Number.isFinite(tzOffsetMinutes)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "tzOffsetMinutes must be a number.",
      );
    }

    const userRef = db.collection("Users").doc(uid);
    const userSnap = await userRef.get();
    const user = userSnap.exists ? userSnap.data() || {} : {};

    const userRelationshipId = nonEmptyString(user.relationship_id);

    const restoreRequired = user.restore_required === true;
    const restoreRelationshipId = nonEmptyString(user.restore_relationship_id);
    const restoreState = nonEmptyString(user.restore_state);
    const restoreRequestId = nonEmptyString(user.restore_request_id);
    const disconnectCooldownUntil = user.disconnect_cooldown_until || null;

    // =====================================================
    // 1) ACTIVE COUPLE MODE
    // =====================================================
    if (userRelationshipId) {
      const myViewRef = db.collection("relationship_views").doc(uid);
      const myViewSnap = await myViewRef.get();

      if (!myViewSnap.exists) {
        return {
          ok: true,
          mode: "couple_missing_view",
          homeMode: "single_demo",
          hasActiveRelationship: false,
          isSingleMode: true,
          isReconnectMode: false,

          uid,
          partnerUid: "",
          relationshipId: "",
          relationshipStatus: "missing_view",

          restoreRequired: false,
          restoreRelationshipId: "",
          restoreState: "",
          restoreRequestId: "",
          disconnectCooldownUntil: "",

          tzOffsetMinutes,
        };
      }

      const myView = myViewSnap.data() || {};
      const partnerUid = nonEmptyString(myView.partner_uid);
      const viewRelationshipId = nonEmptyString(myView.relationship_id);

      if (!partnerUid || !viewRelationshipId) {
        return {
          ok: true,
          mode: "couple_incomplete_view",
          homeMode: "single_demo",
          hasActiveRelationship: false,
          isSingleMode: true,
          isReconnectMode: false,

          uid,
          partnerUid: "",
          relationshipId: "",
          relationshipStatus: "incomplete_view",

          restoreRequired: false,
          restoreRelationshipId: "",
          restoreState: "",
          restoreRequestId: "",
          disconnectCooldownUntil: "",

          tzOffsetMinutes,
        };
      }

      const relationshipId = viewRelationshipId || userRelationshipId;
      const now = admin.firestore.FieldValue.serverTimestamp();

      const partnerViewRef = db
        .collection("relationship_views")
        .doc(partnerUid);

      const batch = db.batch();

      // Own view: my current device timezone
      batch.set(
        myViewRef,
        {
          my_tz_offset_minutes: tzOffsetMinutes,
          my_tz_offset_updated_at: now,
          relationship_status: "active",
          updated_at: now,
        },
        { merge: true },
      );

      // Partner view: my timezone is their partner timezone
      batch.set(
        partnerViewRef,
        {
          partner_tz_offset_minutes: tzOffsetMinutes,
          partner_tz_offset_updated_at: now,
          relationship_status: "active",
          updated_at: now,
        },
        { merge: true },
      );

      // Keep user status lightweight
      batch.set(
        userRef,
        {
          relationship_status: "active",
          updated_at: now,
        },
        { merge: true },
      );

      await batch.commit();

      return {
        ok: true,
        mode: "couple",
        homeMode: "couple",
        hasActiveRelationship: true,
        isSingleMode: false,
        isReconnectMode: false,

        uid,
        partnerUid,
        relationshipId,
        relationshipStatus: "active",

        restoreRequired: false,
        restoreRelationshipId: "",
        restoreState: "",
        restoreRequestId: "",
        disconnectCooldownUntil: "",

        tzOffsetMinutes,
      };
    }

    // =====================================================
    // 2) RECONNECT PENDING MODE
    // =====================================================
    if (restoreRequired && restoreRelationshipId) {
      return {
        ok: true,
        mode: "reconnect_pending",
        homeMode: "reconnect_pending",
        hasActiveRelationship: false,
        isSingleMode: false,
        isReconnectMode: true,

        uid,
        partnerUid: "",
        relationshipId: "",
        relationshipStatus: "disconnect_pending",

        restoreRequired: true,
        restoreRelationshipId,
        restoreState,
        restoreRequestId,
        disconnectCooldownUntil: timestampToIsoOrEmpty(disconnectCooldownUntil),

        tzOffsetMinutes,
      };
    }

    // =====================================================
    // 3) SINGLE / DEMO MODE
    // =====================================================
    return {
      ok: true,
      mode: "single_demo",
      homeMode: "single_demo",
      hasActiveRelationship: false,
      isSingleMode: true,
      isReconnectMode: false,

      uid,
      partnerUid: "",
      relationshipId: "",
      relationshipStatus: "none",

      restoreRequired: false,
      restoreRelationshipId: "",
      restoreState: "",
      restoreRequestId: "",
      disconnectCooldownUntil: "",

      tzOffsetMinutes,
    };
  });
