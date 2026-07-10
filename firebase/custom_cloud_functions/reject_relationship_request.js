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
const ROUTE_ON_TAP = "connectV2";

/* -------------------- Helpers -------------------- */

function normalizeLang(raw) {
  let lang = String(raw || "en")
    .toLowerCase()
    .trim();
  if (lang.includes("-")) lang = lang.split("-")[0];
  if (lang.includes("_")) lang = lang.split("_")[0];
  return ["en", "de", "es"].includes(lang) ? lang : "en";
}

function t(lang, { en, de, es }) {
  return lang === "de" ? de : lang === "es" ? es : en;
}

async function getUserLang(uid) {
  try {
    if (!uid) return "en";
    const snap = await db.collection("Users").doc(uid).get();
    return normalizeLang(snap.exists ? snap.get("appLanguage") : "en");
  } catch {
    return "en";
  }
}

async function getPublicUserByUid(uid) {
  try {
    if (!uid) return null;
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
    (pub &&
      (pub.display_name ||
        pub.displayName ||
        pub.name ||
        pub.full_name ||
        pub.fullName)) ||
    "";
  const name = String(raw).trim();
  return name || "";
}

async function getTokensForUid(uid) {
  const snap = await db
    .collection("Users")
    .doc(uid)
    .collection("fcm_tokens")
    .get();
  if (snap.empty) return [];
  return snap.docs
    .map((d) => d.get("fcm_token") || d.get("token") || d.id)
    .filter((tok) => typeof tok === "string" && tok.length > 10);
}

async function canNotifyRelationship(uid) {
  const uSnap = await db.collection("Users").doc(uid).get();
  const u = uSnap.exists ? uSnap.data() || {} : {};
  if (u.muteAllNotifications === true) return false;
  if (u.relationshipAlertsEnabled !== true) return false;
  return true;
}

async function pushToUid(uid, { title, body, data }) {
  if (!(await canNotifyRelationship(uid)))
    return { ok: true, skipped: true, reason: "DISABLED_BY_PREFS" };

  const tokens = await getTokensForUid(uid);
  if (!tokens.length) return { ok: true, skipped: true, reason: "NO_TOKENS" };

  const res = await messaging.sendEachForMulticast({
    tokens,
    notification: { title, body },
    data: Object.entries(data || {}).reduce((acc, [k, v]) => {
      acc[String(k)] = String(v);
      return acc;
    }, {}),
  });

  return {
    ok: true,
    sent: res.successCount || 0,
    failed: res.failureCount || 0,
  };
}

/* -------------------- Texts -------------------- */

const TEXT = {
  response: {
    unauth: {
      en: "Please log in again.",
      de: "Bitte melde dich erneut an.",
      es: "Por favor, inicia sesión de nuevo.",
    },
    missingId: {
      en: "Missing request id.",
      de: "Anfrage-ID fehlt.",
      es: "Falta el ID de la solicitud.",
    },
    notTarget: {
      en: "Only the invited person can reject this request.",
      de: "Nur die eingeladene Person kann diese Anfrage ablehnen.",
      es: "Solo la persona invitada puede rechazar esta solicitud.",
    },
    notPending: {
      en: "This request is no longer pending.",
      de: "Diese Anfrage ist nicht mehr offen.",
      es: "Esta solicitud ya no está pendiente.",
    },
    rejected: {
      en: "Request declined.",
      de: "Anfrage abgelehnt.",
      es: "Solicitud rechazada.",
    },
  },

  pushRejected: (lang, nameOrFallback) => ({
    title: t(lang, {
      en: "Connection request declined 💔",
      de: "Verbindungsanfrage abgelehnt 💔",
      es: "Solicitud de conexión rechazada 💔",
    }),
    body: t(lang, {
      en: nameOrFallback
        ? `${nameOrFallback} declined your request. Take your time 💛`
        : `Your request was declined. Take your time 💛`,
      de: nameOrFallback
        ? `${nameOrFallback} hat deine Anfrage abgelehnt. Nimm dir Zeit 💛`
        : `Deine Anfrage wurde abgelehnt. Nimm dir Zeit 💛`,
      es: nameOrFallback
        ? `${nameOrFallback} rechazó tu solicitud. Tómate tu tiempo 💛`
        : `Tu solicitud fue rechazada. Tómate tu tiempo 💛`,
    }),
  }),
};

/* -------------------- Main Function -------------------- */

exports.rejectRelationshipRequest = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    const uid = context.auth?.uid;
    const lang = await getUserLang(uid);

    if (!uid) {
      return {
        ok: false,
        code: "UNAUTHENTICATED",
        message: TEXT.response.unauth[lang],
        request_id: "",
      };
    }

    const requestId = String(data?.request_id || data?.requestId || "").trim();
    if (!requestId) {
      return {
        ok: false,
        code: "MISSING_REQUEST_ID",
        message: TEXT.response.missingId[lang],
        request_id: "",
      };
    }

    const reqRef = db.collection("relationship_requests").doc(requestId);
    const snap = await reqRef.get();
    if (!snap.exists) {
      return { ok: true, status: "already_missing", request_id: requestId };
    }

    const req = snap.data() || {};
    if (req.target_id !== uid) {
      return {
        ok: false,
        code: "NOT_TARGET",
        message: TEXT.response.notTarget[lang],
        request_id: requestId,
      };
    }

    if (req.status !== "pending") {
      return {
        ok: true,
        status: `already_${req.status}`,
        request_id: requestId,
      };
    }

    const now = admin.firestore.Timestamp.now();
    await reqRef.update({ status: "rejected", updated_at: now });

    // ✅ Push to initiator (clean, localized to initiator)
    const initiatorUid = String(req.initiator_id || "").trim();
    if (initiatorUid) {
      const initiatorLang = await getUserLang(initiatorUid);

      const targetPublic = await getPublicUserByUid(uid);
      const targetName = pickName(targetPublic);

      const nameFallback =
        targetName ||
        t(initiatorLang, {
          en: "Your partner",
          de: "Dein Partner",
          es: "Tu pareja",
        });
      const copy = TEXT.pushRejected(initiatorLang, nameFallback);

      await pushToUid(initiatorUid, {
        title: copy.title,
        body: copy.body,
        data: {
          type: "relationship_request_rejected",
          route: ROUTE_ON_TAP,
          requestId: String(requestId),
          actorUid: String(uid),
        },
      }).catch(() => null);
    }

    return {
      ok: true,
      code: "REJECTED",
      message: TEXT.response.rejected[lang],
      request_id: requestId,
    };
  });
