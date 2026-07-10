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
const REQUESTS_COL = "relationship_requests";
const CONNECT_ROUTE = "connectV2";

/* -------------------- helpers -------------------- */

function normalizeLang(raw) {
  let lang = String(raw || "en")
    .toLowerCase()
    .trim();
  if (lang.includes("-")) lang = lang.split("-")[0];
  if (lang.includes("_")) lang = lang.split("_")[0];
  return ["en", "de", "es"].includes(lang) ? lang : "en";
}

async function getUserLang(uid) {
  try {
    if (!uid) return "en";
    const snap = await db.collection("Users").doc(uid).get();
    return normalizeLang(snap.exists ? snap.get("appLanguage") : "en");
  } catch (_) {
    return "en";
  }
}

async function canReceiveRelationshipAlerts(uid) {
  try {
    const snap = await db.collection("Users").doc(uid).get();
    const u = snap.exists ? snap.data() || {} : {};
    if (u.muteAllNotifications === true) return false;
    if (u.relationshipAlertsEnabled !== true) return false;
    return true;
  } catch {
    return false;
  }
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
    .filter((t) => typeof t === "string" && t.length > 10);
}

async function sendPushToUid(uid, payload) {
  const tokens = await getTokensForUid(uid);
  if (!tokens.length) return { ok: true, skipped: true, reason: "NO_TOKENS" };

  const res = await messaging.sendEachForMulticast({
    tokens,
    notification: payload.notification,
    data: payload.data || {},
  });

  return {
    ok: true,
    sent: res.successCount || 0,
    failed: res.failureCount || 0,
  };
}

// PublicUsers kann docId==uid sein ODER docId!=uid mit field uid
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

function pickDisplayName(pub) {
  const raw =
    pub?.display_name ||
    pub?.displayName ||
    pub?.name ||
    pub?.full_name ||
    pub?.fullName ||
    "";
  const s = String(raw).trim();
  return s.length ? s : "Someone";
}

/* -------------------- texts -------------------- */

const TEXT = {
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
  notFound: {
    en: "Request not found.",
    de: "Anfrage nicht gefunden.",
    es: "Solicitud no encontrada.",
  },
  notInitiator: {
    en: "Only the sender can cancel this request.",
    de: "Nur die sendende Person kann diese Anfrage zurückziehen.",
    es: "Solo quien envió la solicitud puede cancelarla.",
  },
  notPending: {
    en: "This request can no longer be canceled.",
    de: "Diese Anfrage kann nicht mehr zurückgezogen werden.",
    es: "Esta solicitud ya no se puede cancelar.",
  },
  deleted: {
    en: "Request canceled.",
    de: "Anfrage wurde zurückgezogen.",
    es: "La solicitud fue cancelada.",
  },

  push: {
    title: {
      en: "Update 💛",
      de: "Update 💛",
      es: "Actualización 💛",
    },
    body: {
      en: (name) => `${name} withdrew the connection request.`,
      de: (name) => `${name} hat die Verbindungsanfrage zurückgezogen.`,
      es: (name) => `${name} retiró la solicitud de conexión.`,
    },
  },
};

/* -------------------- main -------------------- */

exports.cancelRelationshipRequest = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    const callerUid = context.auth?.uid;
    const lang = await getUserLang(callerUid);

    if (!callerUid) {
      return {
        ok: false,
        code: "UNAUTHENTICATED",
        message: TEXT.unauth[lang],
        requestId: "",
      };
    }

    const requestId = String(data?.requestid || data?.requestId || "").trim();
    if (!requestId) {
      return {
        ok: false,
        code: "MISSING_REQUEST_ID",
        message: TEXT.missingId[lang],
        requestId: "",
      };
    }

    const reqRef = db.collection(REQUESTS_COL).doc(requestId);
    const snap = await reqRef.get();
    if (!snap.exists) {
      return {
        ok: false,
        code: "NOT_FOUND",
        message: TEXT.notFound[lang],
        requestId,
      };
    }

    const req = snap.data() || {};
    if (req.initiator_id !== callerUid) {
      return {
        ok: false,
        code: "NOT_INITIATOR",
        message: TEXT.notInitiator[lang],
        requestId,
      };
    }

    if (String(req.status || "") !== "pending") {
      return {
        ok: false,
        code: "NOT_PENDING",
        message: TEXT.notPending[lang],
        requestId,
      };
    }

    const targetUid = String(req.target_id || "").trim();

    // 1) Delete request
    await reqRef.delete().catch(() => null);

    // 2) Push to target (best-effort)
    if (targetUid) {
      const allowed = await canReceiveRelationshipAlerts(targetUid);
      if (allowed) {
        const targetLang = await getUserLang(targetUid);
        const callerPublic = await getPublicUserByUid(callerUid);
        const name = pickDisplayName(callerPublic);

        const title = TEXT.push.title[targetLang] || TEXT.push.title.en;
        const bodyFn = TEXT.push.body[targetLang] || TEXT.push.body.en;
        const body = bodyFn(name);

        await sendPushToUid(targetUid, {
          notification: { title, body },
          data: {
            route: CONNECT_ROUTE,
            type: "relationship_request_withdrawn",
            requestid: requestId,
            actorUid: String(callerUid),
          },
        }).catch(() => null);
      }
    }

    return {
      ok: true,
      code: "DELETED",
      message: TEXT.deleted[lang],
      requestId,
    };
  });
