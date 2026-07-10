const functions = require("firebase-functions");
const admin = require("firebase-admin");
try {
  admin.app();
} catch {
  admin.initializeApp();
}

const db = admin.firestore();
const REGION = "europe-west3";

const ALLOWED_MOODS = [
  "happy",
  "excited",
  "cool",
  "inlove",
  "strong",
  "shit",
  "sick",
  "sad",
  "angry",
  "tired",
];

exports.setMood = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    const uid = context.auth?.uid;
    if (!uid) {
      return {
        ok: false,
        code: "UNAUTHENTICATED",
        message: "Please log in again.",
      };
    }

    const mood = String(data?.mood || "")
      .toLowerCase()
      .trim();
    if (!ALLOWED_MOODS.includes(mood)) {
      return {
        ok: false,
        code: "INVALID_MOOD",
        message: `Invalid mood: ${mood}`,
      };
    }

    const now = admin.firestore.Timestamp.now();
    const myViewRef = db.collection("relationship_views").doc(uid);
    const myViewSnap = await myViewRef.get();

    if (!myViewSnap.exists) {
      return {
        ok: false,
        code: "NO_REL_VIEW",
        message: "Relationship view not found.",
      };
    }

    const myView = myViewSnap.data() || {};
    const partnerUid = String(myView.partner_uid || "").trim();
    const relationshipId = String(myView.relationship_id || "").trim();

    if (!partnerUid || !relationshipId) {
      return {
        ok: false,
        code: "NO_REL_CONTEXT",
        message: "Relationship context missing.",
      };
    }

    // ⛔ Hard spam protection (10s)
    const lastMs = myView.my_mood_updated_at?.toMillis?.() || 0;
    const nowMs = now.toMillis();
    const secondsSince = (nowMs - lastMs) / 1000;

    if (secondsSince < 10) {
      return {
        ok: false,
        code: "TOO_FAST",
        message: "Too fast 😅 Give it a moment.",
        mood,
        should_push: false,
        partnerUid,
        relationship_id: relationshipId,
      };
    }

    // 🔔 Push cooldown decision (60s)
    const SHOULD_PUSH = secondsSince >= 60;

    const partnerViewRef = db.collection("relationship_views").doc(partnerUid);

    // Update both views (transaction)
    await db.runTransaction(async (tx) => {
      tx.set(
        myViewRef,
        {
          my_mood: mood,
          my_mood_updated_at: now,
          updated_at: now,
        },
        { merge: true },
      );

      tx.set(
        partnerViewRef,
        {
          partner_mood: mood,
          partner_mood_updated_at: now,
          updated_at: now,
        },
        { merge: true },
      );
    });

    return {
      ok: true,
      code: "OK",
      message: "Mood updated.",
      mood,
      should_push: SHOULD_PUSH,
      partnerUid,
      relationship_id: relationshipId,
    };
  });
