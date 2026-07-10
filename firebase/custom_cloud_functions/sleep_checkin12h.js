const functions = require("firebase-functions");
const admin = require("firebase-admin");
try {
  admin.app();
} catch {
  admin.initializeApp();
}

const db = admin.firestore();
const messaging = admin.messaging();

const REGION = "europe-west3";

/* -------------------- helpers -------------------- */

async function getTokensForUid(uid) {
  const snap = await db
    .collection("Users")
    .doc(uid)
    .collection("fcm_tokens")
    .get();
  if (snap.empty) return [];
  return snap.docs
    .map((d) => d.get("fcm_token") || d.get("token") || d.id)
    .filter((t) => typeof t === "string" && t.length > 10);
}

async function canNotifyRelationship(uid) {
  try {
    const snap = await db.collection("Users").doc(uid).get();
    const u = snap.exists ? snap.data() || {} : {};
    if (u.muteAllNotifications === true) return false;
    // Sleep-Checkin ist eher "relationship alert" (wie Reconnect etc.)
    if (u.relationshipAlertsEnabled === false) return false;
    return true;
  } catch {
    return false;
  }
}

async function sendPushToUid(uid, notification, data) {
  // prefs gate
  if (!(await canNotifyRelationship(uid)))
    return { ok: true, skipped: true, reason: "DISABLED_BY_PREFS" };

  const tokens = await getTokensForUid(uid);
  if (!tokens.length) return { ok: true, skipped: true, reason: "NO_TOKENS" };

  // FCM data => strings
  const safeData = Object.entries(data || {}).reduce((acc, [k, v]) => {
    acc[String(k)] = String(v);
    return acc;
  }, {});

  const res = await messaging.sendEachForMulticast({
    tokens,
    notification,
    data: safeData,
  });

  return {
    ok: true,
    sent: res.successCount || 0,
    failed: res.failureCount || 0,
  };
}

async function getUserLang(uid) {
  try {
    const snap = await db.collection("Users").doc(uid).get();
    let lang = String(
      snap.exists ? snap.data()?.appLanguage : "en",
    ).toLowerCase();
    if (lang.includes("-")) lang = lang.split("-")[0];
    if (lang.includes("_")) lang = lang.split("_")[0];
    return ["en", "de", "es"].includes(lang) ? lang : "en";
  } catch {
    return "en";
  }
}

async function getPublicUserByUid(uid) {
  try {
    const direct = await db.collection("PublicUsers").doc(uid).get();
    if (direct.exists) return direct.data() || null;

    const qs = await db
      .collection("PublicUsers")
      .where("uid", "==", uid)
      .limit(1)
      .get();
    if (qs.empty) return null;
    return qs.docs[0].data() || null;
  } catch {
    return null;
  }
}

function pickName(pub) {
  const raw =
    pub?.display_name ||
    pub?.displayName ||
    pub?.name ||
    pub?.full_name ||
    pub?.fullName ||
    "";
  const name = String(raw).trim();
  return name || "Your partner";
}

/* -------------------- copy -------------------- */

const COPY = {
  sleeper: {
    title: {
      en: "Still sleeping?",
      de: "Noch am Schlafen?",
      es: "¿Sigues durmiendo?",
    },
    body: {
      en: "You’ve been asleep for quite a while. Tap to let us know you’re okay 😴",
      de: "Du schläfst schon eine ganze Weile. Tippe hier, um kurz Bescheid zu geben 😴",
      es: "Has estado dormido/a por un buen rato. Toca aquí para confirmar que todo está bien 😴",
    },
  },

  partner: {
    title: {
      en: "Long sleep",
      de: "Langer Schlaf",
      es: "Sueño largo",
    },
    body: {
      en: (name) =>
        `${name} has been asleep for a while. Maybe check in gently ❤️`,
      de: (name) =>
        `${name} schläft schon eine ganze Weile. Vielleicht magst du kurz nachfragen ❤️`,
      es: (name) =>
        `${name} lleva bastante tiempo durmiendo. Quizás quieras comprobar cómo está ❤️`,
    },
  },
};

/* -------------------- main -------------------- */

exports.sleepCheckin12h = functions
  .region(REGION)
  .pubsub.schedule("every 15 minutes")
  .timeZone("Etc/UTC") // ist ok, weil wir mit Firestore Timestamps rechnen (12h)
  .onRun(async () => {
    const now = admin.firestore.Timestamp.now();
    const twelveHoursAgo = admin.firestore.Timestamp.fromMillis(
      now.toMillis() - 12 * 60 * 60 * 1000,
    );

    const snap = await db
      .collection("relationship_views")
      .where("my_sleep_status", "==", true)
      .where("my_sleep_checkin_12h_sent", "==", false)
      .where("my_sleep_started_at", "<=", twelveHoursAgo)
      .limit(200)
      .get();

    if (snap.empty) return null;

    const batch = db.batch();

    for (const doc of snap.docs) {
      const uid = doc.id;
      const v = doc.data() || {};
      const partnerUid = String(v.partner_uid || "").trim();

      // --- Push to sleeping user ---
      try {
        const lang = await getUserLang(uid);
        const title = COPY.sleeper.title[lang] || COPY.sleeper.title.en;
        const body = COPY.sleeper.body[lang] || COPY.sleeper.body.en;

        await sendPushToUid(
          uid,
          { title, body },
          { type: "sleep_checkin", stage: "12h" },
        );
      } catch (e) {
        console.error("[sleepCheckin12h] push to sleeper failed", uid, e);
      }

      // --- Push to partner ---
      if (partnerUid) {
        try {
          const lang = await getUserLang(partnerUid);
          const title = COPY.partner.title[lang] || COPY.partner.title.en;

          const sleeperPublic = await getPublicUserByUid(uid);
          const sleeperName = pickName(sleeperPublic);

          const bodyFn = COPY.partner.body[lang] || COPY.partner.body.en;
          const body = bodyFn(sleeperName);

          await sendPushToUid(
            partnerUid,
            { title, body },
            { type: "sleep_checkin", stage: "12h", partner_uid: uid },
          );
        } catch (e) {
          console.error(
            "[sleepCheckin12h] push to partner failed",
            partnerUid,
            e,
          );
        }
      }

      // --- Mark flags (only once per sleep phase) ---
      batch.set(
        doc.ref,
        { my_sleep_checkin_12h_sent: true, updated_at: now },
        { merge: true },
      );

      if (partnerUid) {
        batch.set(
          db.collection("relationship_views").doc(partnerUid),
          { partner_sleep_checkin_12h_sent: true, updated_at: now },
          { merge: true },
        );
      }
    }

    await batch.commit();
    return null;
  });
