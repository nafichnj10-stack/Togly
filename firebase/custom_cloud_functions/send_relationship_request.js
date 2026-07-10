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
const CONNECT_ROUTE = "connectV2";

/* -------------------- helpers -------------------- */

function nonEmptyString(v) {
  return typeof v === "string" && v.trim().length > 0 ? v.trim() : "";
}

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

async function canReceiveRelationshipAlerts(uid) {
  try {
    const snap = await db.collection("Users").doc(uid).get();
    const u = snap.exists ? snap.data() || {} : {};
    if (u.muteAllNotifications === true) return false;
    // relationshipAlertsEnabled must be true to receive these
    if (u.relationshipAlertsEnabled !== true) return false;
    return true;
  } catch {
    return false;
  }
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

function normalizeLoveCode(input) {
  return String(input || "")
    .trim()
    .toUpperCase()
    .replace(/\s+/g, "");
}

/* -------------------- copy -------------------- */

const TEXT = {
  push: {
    title: {
      en: "Connection request 💜",
      de: "Verbindungsanfrage 💜",
      es: "Solicitud de conexión 💜",
    },
    body: {
      en: (senderName) =>
        `${senderName} wants to connect with you. Tap to take a look.`,
      de: (senderName) =>
        `${senderName} möchte sich mit dir verbinden. Tippe, um es anzusehen.`,
      es: (senderName) =>
        `${senderName} quiere conectar contigo. Toca para verla.`,
    },
  },
  response: {
    sent: {
      en: "Request sent 💜",
      de: "Anfrage gesendet 💜",
      es: "Solicitud enviada 💜",
    },
    unauth: {
      en: "Please log in again.",
      de: "Bitte melde dich erneut an.",
      es: "Por favor, inicia sesión de nuevo.",
    },
    missingCode: {
      en: "Please enter a valid love code.",
      de: "Bitte gib einen gültigen Love Code ein.",
      es: "Por favor, introduce un Love Code válido.",
    },
    notFound: {
      en: "This love code does not exist.",
      de: "Dieser Love Code existiert nicht.",
      es: "Este Love Code no existe.",
    },
    self: {
      en: "You can't send a request to yourself.",
      de: "Du kannst dir selbst keine Anfrage senden.",
      es: "No puedes enviarte una solicitud a ti mismo.",
    },
    alreadyConnected: {
      en: "You are already connected to someone.",
      de: "Du bist bereits mit jemandem verbunden.",
      es: "Ya estás verbunden con alguien.",
    },
    targetConnected: {
      en: "This user is already connected.",
      de: "Diese Person ist bereits verbunden.",
      es: "Esta persona ya está conectada.",
    },
    outgoingPending: {
      en: "You already have a pending request.",
      de: "Du hast bereits eine offene Anfrage.",
      es: "Ya tienes una solicitud pendiente.",
    },
    pairPending: {
      en: "There is already a pending request between you two.",
      de: "Zwischen euch besteht bereits eine offene Anfrage.",
      es: "Ya existe una solicitud pendiente entre ustedes.",
    },
  },
};

/* -------------------- main -------------------- */

exports.sendRelationshipRequest = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    const callerUid = context.auth?.uid;

    // language for caller response (best-effort)
    const callerLang = await getUserLang(callerUid);

    if (!callerUid) {
      return {
        ok: false,
        code: "UNAUTHENTICATED",
        message: TEXT.response.unauth[callerLang],
        requestid: "",
      };
    }

    const lovecode = normalizeLoveCode(data?.lovecode);
    if (!lovecode) {
      return {
        ok: false,
        code: "MISSING_LOVECODE",
        message: TEXT.response.missingCode[callerLang],
        requestid: "",
      };
    }

    // target via PublicUsers.love_code
    const qs = await db
      .collection("PublicUsers")
      .where("love_code", "==", lovecode)
      .limit(1)
      .get();
    if (qs.empty) {
      return {
        ok: false,
        code: "LOVECODE_NOT_FOUND",
        message: TEXT.response.notFound[callerLang],
        requestid: "",
      };
    }

    const targetUid = String(qs.docs[0].get("uid") || "").trim();
    if (!targetUid) {
      return {
        ok: false,
        code: "TARGET_UID_MISSING",
        message: TEXT.response.notFound[callerLang],
        requestid: "",
      };
    }

    if (targetUid === callerUid) {
      return {
        ok: false,
        code: "SELF_REQUEST",
        message: TEXT.response.self[callerLang],
        requestid: "",
      };
    }

    // Users-only checks
    const [callerSnap, targetSnap] = await Promise.all([
      db.collection("Users").doc(callerUid).get(),
      db.collection("Users").doc(targetUid).get(),
    ]);

    if (callerSnap.exists && callerSnap.data()?.relationship_id) {
      return {
        ok: false,
        code: "ALREADY_CONNECTED",
        message: TEXT.response.alreadyConnected[callerLang],
        requestid: "",
      };
    }

    if (targetSnap.exists && targetSnap.data()?.relationship_id) {
      return {
        ok: false,
        code: "TARGET_ALREADY_CONNECTED",
        message: TEXT.response.targetConnected[callerLang],
        requestid: "",
      };
    }

    // Outgoing pending?
    const existingOut = await db
      .collection("relationship_requests")
      .where("initiator_id", "==", callerUid)
      .where("status", "==", "pending")
      .limit(1)
      .get();

    if (!existingOut.empty) {
      return {
        ok: false,
        code: "OUTGOING_PENDING_EXISTS",
        message: TEXT.response.outgoingPending[callerLang],
        requestid: "",
      };
    }

    // Pair pending?
    const pairKeyA = `${callerUid}__${targetUid}`;
    const pairKeyB = `${targetUid}__${callerUid}`;

    const existingPair = await db
      .collection("relationship_requests")
      .where("pair_key", "in", [pairKeyA, pairKeyB])
      .where("status", "==", "pending")
      .limit(1)
      .get();

    if (!existingPair.empty) {
      return {
        ok: false,
        code: "PAIR_ALREADY_PENDING",
        message: TEXT.response.pairPending[callerLang],
        requestid: "",
      };
    }

    // Create request
    const now = admin.firestore.FieldValue.serverTimestamp();
    const requestRef = db.collection("relationship_requests").doc();
    await requestRef.set({
      initiator_id: callerUid,
      target_id: targetUid,
      status: "pending",
      created_at: now,
      updated_at: now,
      pair_key: pairKeyA,
    });

    // Push to target (respect toggles)
    const allowed = await canReceiveRelationshipAlerts(targetUid);
    if (allowed) {
      const callerPublic = await getPublicUserByUid(callerUid);
      const senderName = pickDisplayName(callerPublic);

      const targetLang = await getUserLang(targetUid);
      const pushTitle = TEXT.push.title[targetLang] || TEXT.push.title.en;
      const pushBodyFn = TEXT.push.body[targetLang] || TEXT.push.body.en;
      const pushBody = pushBodyFn(senderName);

      await sendPushToUid(targetUid, {
        notification: { title: pushTitle, body: pushBody },
        data: {
          route: CONNECT_ROUTE,
          type: "relationship_request_received",
          requestid: requestRef.id,
          actorUid: String(callerUid),
        },
      }).catch(() => null);
    }

    return {
      ok: true,
      code: "OK",
      message: TEXT.response.sent[callerLang],
      requestid: requestRef.id,
    };
  });
