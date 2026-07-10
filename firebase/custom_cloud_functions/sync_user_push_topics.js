const functions = require("firebase-functions");
const admin = require("firebase-admin");

// In FF-Templates ist initializeApp oft schon woanders aufgerufen.
// Dieser Guard verhindert "App named [DEFAULT] already exists".
try {
  admin.app();
} catch {
  admin.initializeApp();
}

/* ---------- Helpers ---------- */

// Tokens eines Users (Users/{uid}/fcm_tokens) lesen
async function getUserTokens(uid) {
  const snap = await admin
    .firestore()
    .collection("Users")
    .doc(uid)
    .collection("fcm_tokens")
    .get();
  return snap.docs
    .map((d) => d.get("fcm_token"))
    .filter((t) => typeof t === "string" && t.length > 0);
}

async function subscribe(tokens, topic) {
  if (!tokens.length) return { successCount: 0, failureCount: 0 };
  return admin.messaging().subscribeToTopic(tokens, topic);
}

async function unsubscribe(tokens, topic) {
  if (!tokens.length) return { successCount: 0, failureCount: 0 };
  return admin.messaging().unsubscribeFromTopic(tokens, topic);
}

/* ---------- Main ---------- */

exports.syncUserPushTopics = functions.https.onCall(async (data, context) => {
  const uid = context.auth?.uid;
  if (!uid) {
    throw new functions.https.HttpsError("unauthenticated", "Login required.");
  }

  const db = admin.firestore();

  // 1) User-Opt-ins laden
  const userDoc = await db.collection("Users").doc(uid).get();
  const user = userDoc.exists ? userDoc.data() || {} : {};

  // nur die 3 Topics, die wir wirklich brauchen
  const prefs = {
    general: user.pushGeneral !== false, // Master (true = nicht gemutet)
    dailyQuestionReminders: !!user.dailyQuestionReminders,
    stayConnectedReminders: !!user.stayConnectedReminders,
  };

  // 2) Aktive Beziehung prüfen (falls Reminders nur dann gelten sollen)
  const relCol = db.collection("relationships");
  const [aSnap, bSnap] = await Promise.all([
    relCol
      .where("active", "==", true)
      .where("userA_id", "==", uid)
      .limit(1)
      .get(),
    relCol
      .where("active", "==", true)
      .where("userB_id", "==", uid)
      .limit(1)
      .get(),
  ]);
  const hasActiveRelationship = !aSnap.empty || !bSnap.empty;

  // 3) Tokens holen
  const tokens = await getUserTokens(uid);

  // 4) Topics
  const topics = {
    general: "general",
    dailyQuestionReminders: "dailyQuestionReminders",
    stayConnectedReminders: "stayConnectedReminders",
  };

  const results = {
    subscribed: [],
    unsubscribed: [],
    tokens: tokens.length,
    active: hasActiveRelationship,
  };

  // 5) Wenn keine aktive Beziehung: überall unsubscriben
  if (!hasActiveRelationship) {
    await Promise.all(Object.values(topics).map((t) => unsubscribe(tokens, t)));
    results.unsubscribed = Object.values(topics);
    return results;
  }

  // 6) Je nach Opt-in (de)subscriben
  const plan = [
    ["general", prefs.general],
    ["dailyQuestionReminders", prefs.dailyQuestionReminders],
    ["stayConnectedReminders", prefs.stayConnectedReminders],
  ];

  await Promise.all(
    plan.map(async ([key, on]) => {
      const topic = topics[key];
      if (on) {
        await subscribe(tokens, topic).catch(() => null);
        results.subscribed.push(topic);
      } else {
        await unsubscribe(tokens, topic).catch(() => null);
        results.unsubscribed.push(topic);
      }
    }),
  );

  return results;
});
