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

// ✅ Tap-to-open route
const ROUTE_ON_TAP = "restore";

// Optional: 7-day reminder aktivieren/deaktivieren
const ENABLE_7D_REMINDER = true;

/* -------------------- Users-only helpers -------------------- */

function normalizeLang(raw) {
  let lang = String(raw || "en")
    .trim()
    .toLowerCase();
  if (lang.includes("_")) lang = lang.split("_")[0];
  if (lang.includes("-")) lang = lang.split("-")[0];
  return ["en", "de", "es"].includes(lang) ? lang : "en";
}

async function getUserLang(uid) {
  try {
    if (!uid) return "en";
    const snap = await db.collection("Users").doc(uid).get();
    const u = snap.exists ? snap.data() || {} : {};
    return normalizeLang(u.appLanguage || "en");
  } catch {
    return "en";
  }
}

async function getTokensForUid(uid) {
  try {
    const snap = await db
      .collection("Users")
      .doc(uid)
      .collection("fcm_tokens")
      .get();
    if (snap.empty) return [];
    return snap.docs
      .map((d) => d.get("fcm_token") || d.get("token") || d.id)
      .filter((t) => typeof t === "string" && t.length > 10);
  } catch {
    return [];
  }
}

async function canNotifyRelationship(uid) {
  try {
    const snap = await db.collection("Users").doc(uid).get();
    const u = snap.exists ? snap.data() || {} : {};
    if (u.muteAllNotifications === true) return false;
    // ✅ consistent with your other logic: must be explicitly enabled
    if (u.relationshipAlertsEnabled !== true) return false;
    return true;
  } catch {
    return false;
  }
}

async function sendPush(uid, { title, body, data = {} }) {
  if (!(await canNotifyRelationship(uid)))
    return { sent: 0, skipped: true, reason: "DISABLED_BY_PREFS" };

  const tokens = await getTokensForUid(uid);
  if (!tokens.length) return { sent: 0, skipped: true, reason: "NO_TOKENS" };

  const res = await messaging.sendEachForMulticast({
    tokens,
    notification: { title, body },
    data: Object.entries({
      route: ROUTE_ON_TAP,
      ...data,
    }).reduce((acc, [k, v]) => {
      acc[String(k)] = String(v);
      return acc;
    }, {}),
  });

  return {
    sent: res.successCount || 0,
    failed: res.failureCount || 0,
    tokens: tokens.length,
  };
}

/* -------------------- Copy (DE/EN/ES + A/B variants) -------------------- */
/**
 * role: 'A' | 'B' (leicht unterschiedliche Formulierung)
 * ✅ Max 1 Emoji pro Push: Emoji nur im Title bei 7d & 1h
 */
const COPY = {
  "7d": {
    title: {
      en: "A little reminder 💜",
      de: "Kleiner Reminder 💜",
      es: "Un pequeño recordatorio 💜",
    },
    body: {
      en: {
        A: "You still have time to restore your connection and keep your shared memories.",
        B: "There’s still time to reconnect and keep what you shared together.",
      },
      de: {
        A: "Du hast noch Zeit, eure Verbindung wiederherzustellen und eure gemeinsamen Erinnerungen zu behalten.",
        B: "Ihr habt noch Zeit, euch wieder zu verbinden und eure gemeinsamen Erinnerungen zu behalten.",
      },
      es: {
        A: "Aún tienes tiempo para restaurar la conexión y conservar sus recuerdos compartidos.",
        B: "Todavía hay tiempo para reconectar y conservar lo que compartieron.",
      },
    },
  },

  "24h": {
    title: {
      en: "Still time to reconnect",
      de: "Noch Zeit zum Wiederverbinden",
      es: "Aún hay tiempo para reconectar",
    },
    body: {
      en: {
        A: "If you’d like to keep what you shared, now is a good moment to restore.",
        B: "If you want to keep your shared memories, now is a good moment to restore.",
      },
      de: {
        A: "Wenn du behalten möchtest, was ihr geteilt habt, ist jetzt ein guter Moment zum Wiederherstellen.",
        B: "Wenn ihr eure gemeinsamen Erinnerungen behalten möchtet, ist jetzt ein guter Moment zum Wiederherstellen.",
      },
      es: {
        A: "Si quieres conservar lo que compartieron, ahora es un buen momento para restaurar.",
        B: "Si quieren conservar sus recuerdos compartidos, ahora es un buen momento para restaurar.",
      },
    },
  },

  "1h": {
    title: {
      en: "Last moment 💜",
      de: "Letzter Moment 💜",
      es: "Último momento 💜",
    },
    body: {
      en: {
        A: "This is the last chance to restore your connection and keep your shared memories.",
        B: "Last chance to restore your connection and keep what you shared together.",
      },
      de: {
        A: "Das ist die letzte Chance, eure Verbindung wiederherzustellen und eure gemeinsamen Erinnerungen zu behalten.",
        B: "Letzte Chance: Stellt eure Verbindung wieder her und behaltet eure gemeinsamen Erinnerungen.",
      },
      es: {
        A: "Esta es la última oportunidad para restaurar la conexión y conservar sus recuerdos compartidos.",
        B: "Última oportunidad: restaura la conexión y conserva lo que compartieron.",
      },
    },
  },
};

function getRole(uid, userA, userB) {
  if (uid === userA) return "A";
  if (uid === userB) return "B";
  return "A";
}

function pickCopy(kind, lang, role) {
  const k = COPY[kind] || COPY["24h"];
  const title = k.title[lang] || k.title.en;
  const bodyPack = k.body[lang] || k.body.en;
  const body = bodyPack[role] || bodyPack.A;
  return { title, body };
}

/* -------------------- Main job -------------------- */

exports.relationshipPurgeReminders = functions
  .region(REGION)
  .pubsub.schedule("every 15 minutes")
  .timeZone("Europe/Berlin")
  .onRun(async () => {
    const now = admin.firestore.Timestamp.now();

    // Nur geparkte Beziehungen mit purge_at in der Zukunft
    const snap = await db
      .collection("relationships")
      .where("active", "==", false)
      .where("purge_at", ">", now)
      .limit(200)
      .get();

    if (snap.empty) return { ok: true, checked: 0, notified: 0 };

    let notified = 0;

    for (const doc of snap.docs) {
      const rel = doc.data() || {};
      const rid = doc.id;

      const purgeAt = rel.purge_at;
      if (!purgeAt?.toMillis) continue;

      const msLeft = purgeAt.toMillis() - now.toMillis();
      const hoursLeft = msLeft / (60 * 60 * 1000);

      const userA = rel.userA_id;
      const userB = rel.userB_id;
      if (!userA || !userB) continue;

      const notified7d = rel.notified_7d === true;
      const notified24h = rel.notified_24h === true;
      const notified1h = rel.notified_1h === true;

      const updates = {};

      // 7 Tage vorher (~168h)
      if (
        ENABLE_7D_REMINDER &&
        !notified7d &&
        hoursLeft <= 168 &&
        hoursLeft > 24
      ) {
        const [langA, langB] = await Promise.all([
          getUserLang(userA),
          getUserLang(userB),
        ]);
        const roleA = getRole(userA, userA, userB);
        const roleB = getRole(userB, userA, userB);

        const msgA = pickCopy("7d", langA, roleA);
        const msgB = pickCopy("7d", langB, roleB);

        await Promise.all([
          sendPush(userA, {
            title: msgA.title,
            body: msgA.body,
            data: { type: "purge_reminder_7d", relationshipid: rid },
          }).catch(() => null),
          sendPush(userB, {
            title: msgB.title,
            body: msgB.body,
            data: { type: "purge_reminder_7d", relationshipid: rid },
          }).catch(() => null),
        ]);

        updates.notified_7d = true;
        notified++;
      }

      // 24 Stunden vorher
      if (!notified24h && hoursLeft <= 24 && hoursLeft > 1) {
        const [langA, langB] = await Promise.all([
          getUserLang(userA),
          getUserLang(userB),
        ]);
        const roleA = getRole(userA, userA, userB);
        const roleB = getRole(userB, userA, userB);

        const msgA = pickCopy("24h", langA, roleA);
        const msgB = pickCopy("24h", langB, roleB);

        await Promise.all([
          sendPush(userA, {
            title: msgA.title,
            body: msgA.body,
            data: { type: "purge_reminder_24h", relationshipid: rid },
          }).catch(() => null),
          sendPush(userB, {
            title: msgB.title,
            body: msgB.body,
            data: { type: "purge_reminder_24h", relationshipid: rid },
          }).catch(() => null),
        ]);

        updates.notified_24h = true;
        notified++;
      }

      // 1 Stunde vorher
      if (!notified1h && hoursLeft <= 1 && hoursLeft > 0) {
        const [langA, langB] = await Promise.all([
          getUserLang(userA),
          getUserLang(userB),
        ]);
        const roleA = getRole(userA, userA, userB);
        const roleB = getRole(userB, userA, userB);

        const msgA = pickCopy("1h", langA, roleA);
        const msgB = pickCopy("1h", langB, roleB);

        await Promise.all([
          sendPush(userA, {
            title: msgA.title,
            body: msgA.body,
            data: { type: "purge_reminder_1h", relationshipid: rid },
          }).catch(() => null),
          sendPush(userB, {
            title: msgB.title,
            body: msgB.body,
            data: { type: "purge_reminder_1h", relationshipid: rid },
          }).catch(() => null),
        ]);

        updates.notified_1h = true;
        notified++;
      }

      if (Object.keys(updates).length) {
        updates.updated_at = now;
        await doc.ref.set(updates, { merge: true }).catch(() => null);
      }
    }

    return { ok: true, checked: snap.size, notified };
  });
