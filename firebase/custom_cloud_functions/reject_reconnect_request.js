const functions = require("firebase-functions");
const admin = require("firebase-admin");
try {
  admin.app();
} catch {
  admin.initializeApp();
}

const db = admin.firestore();
const messaging = admin.messaging();

/* -------------------- Language helpers -------------------- */

async function getUserLang(uid) {
  try {
    const snap = await db.collection("Users").doc(uid).get();
    let lang = (snap.exists ? snap.get("appLanguage") || "" : "")
      .toString()
      .trim()
      .toLowerCase();
    if (lang.includes("_")) lang = lang.split("_")[0];
    if (lang.includes("-")) lang = lang.split("-")[0];
    return lang === "en" || lang === "de" || lang === "es" ? lang : "en";
  } catch (_) {
    return "en";
  }
}

function t(lang, key) {
  const M = {
    en: {
      AUTH: "Please sign in to continue.",
      REQ_ID_REQUIRED: "Please provide a valid request id.",
      REQ_NOT_FOUND: "We couldn’t find this request.",
      ONLY_TARGET: "Only your partner can reject this request.",
      NOT_PENDING: "This request is no longer pending.",
      REJECTED: "Request rejected.",
      ERROR: "Something went wrong. Please try again.",
    },
    de: {
      AUTH: "Bitte melde dich an, um fortzufahren.",
      REQ_ID_REQUIRED: "Bitte gib eine gültige Anfrage-ID an.",
      REQ_NOT_FOUND: "Diese Anfrage konnten wir nicht finden.",
      ONLY_TARGET: "Nur dein:e Partner:in kann diese Anfrage ablehnen.",
      NOT_PENDING: "Diese Anfrage ist nicht mehr offen.",
      REJECTED: "Anfrage wurde abgelehnt.",
      ERROR: "Etwas ist schiefgelaufen. Bitte versuche es erneut.",
    },
    es: {
      AUTH: "Inicia sesión para continuar.",
      REQ_ID_REQUIRED: "Por favor, indica un ID de solicitud válido.",
      REQ_NOT_FOUND: "No pudimos encontrar esta solicitud.",
      ONLY_TARGET: "Solo tu pareja puede rechazar esta solicitud.",
      NOT_PENDING: "Esta solicitud ya no está pendiente.",
      REJECTED: "Solicitud rechazada.",
      ERROR: "Algo salió mal. Inténtalo de nuevo.",
    },
  };
  return M[lang] && M[lang][key] ? M[lang][key] : M.en[key] || "Error.";
}

/* -------------------- Push helpers (minimal) -------------------- */

async function getTokensForUid(uid) {
  const snap = await db
    .collection("Users")
    .doc(uid)
    .collection("fcm_tokens")
    .get();
  const tokens = snap.docs
    .map((d) => d.get("fcm_token") || d.get("token") || d.id)
    .filter((tok) => typeof tok === "string" && tok.length > 10);

  if (tokens.length) return tokens;

  const userSnap = await db.collection("Users").doc(uid).get();
  const fallback = userSnap.exists
    ? String(userSnap.get("fcm_token") || "")
    : "";
  return fallback.length > 10 ? [fallback] : [];
}

async function canSendRelationshipAlert(uid) {
  try {
    const snap = await db.collection("Users").doc(uid).get();
    const u = snap.exists ? snap.data() || {} : {};
    if (u.muteAllNotifications === true) return false;
    return u.relationshipAlertsEnabled === true;
  } catch {
    return false;
  }
}

function ffNav(route, paramsObj) {
  const page = String(route || "").trim();
  const paramData = JSON.stringify(paramsObj || {});
  return {
    click_action: "FLUTTER_NOTIFICATION_CLICK",
    initial_page_name: page,
    initialPageName: page,
    parameter_data: paramData,
    parameterData: paramData,
  };
}

async function sendPushToUid(targetUid, { type, title, body, route, params }) {
  if (!targetUid) return;
  if (!(await canSendRelationshipAlert(targetUid))) return;

  const tokens = await getTokensForUid(targetUid);
  if (!tokens.length) return;

  const nav = ffNav(route, params);

  await messaging.sendEachForMulticast({
    tokens,
    notification: { title, body },
    data: { type: String(type || ""), ...nav },
  });
}

/* -------------------- MAIN -------------------- */

exports.rejectReconnectRequest = functions
  .region("europe-west3")
  .https.onCall(async (data, ctx) => {
    try {
      const uid = ctx.auth?.uid;
      if (!uid) {
        return { ok: false, code: "AUTH_REQUIRED", message: t("en", "AUTH") };
      }

      const lang = await getUserLang(uid);

      const requestId = String(data?.requestId || data?.requestid || "").trim();
      if (!requestId) {
        return {
          ok: false,
          code: "REQUEST_ID_REQUIRED",
          message: t(lang, "REQ_ID_REQUIRED"),
        };
      }

      const reqRef = db.collection("reconnect_requests").doc(requestId);
      const snap = await reqRef.get();
      if (!snap.exists) {
        return {
          ok: false,
          code: "REQUEST_NOT_FOUND",
          message: t(lang, "REQ_NOT_FOUND"),
        };
      }

      const req = snap.data() || {};
      const initiatorId = String(req.initiator_id || "").trim();
      const targetId = String(req.target_id || "").trim();
      const relId = String(req.relationship_id || "").trim();

      if (uid !== targetId) {
        return {
          ok: false,
          code: "ONLY_TARGET_CAN_REJECT",
          message: t(lang, "ONLY_TARGET"),
        };
      }

      const currentStatus = String(req.status || "").toLowerCase();
      if (currentStatus !== "pending") {
        return {
          ok: true,
          code: "ALREADY_RESOLVED",
          message: t(lang, "NOT_PENDING"),
          status: currentStatus,
        };
      }

      const now = admin.firestore.Timestamp.now();

      // ✅ Atomar: Request -> rejected + Users zurücksetzen
      await db.runTransaction(async (tx) => {
        tx.update(reqRef, {
          status: "rejected",
          updated_at: now,
          rejected_at: now,
          rejected_by: uid,
        });

        const patch = {
          restore_required: true,
          restore_state: "ready_to_send",
          restore_request_id: admin.firestore.FieldValue.delete(),
          restore_relationship_id: relId,
          updated_at: now,
        };

        tx.set(db.collection("Users").doc(initiatorId), patch, { merge: true });
        tx.set(db.collection("Users").doc(targetId), patch, { merge: true });
      });

      // ✅ Push an Initiator (rejected)
      try {
        const l = await getUserLang(initiatorId);
        const title =
          l === "de"
            ? "Versöhnungsanfrage abgelehnt 💔"
            : l === "es"
              ? "Reconexión rechazada 💔"
              : "Reconnect declined 💔";

        const body =
          l === "de"
            ? "Dein:e Partner:in hat die Versöhnungsanfrage abgelehnt."
            : l === "es"
              ? "Tu pareja rechazó la solicitud de reconexión."
              : "Your partner declined the reconnect request.";

        await sendPushToUid(initiatorId, {
          type: "reconnect_request_rejected",
          title,
          body,
          route: "restore",
          params: { relationshipId: relId },
        });
      } catch (e) {
        console.log(
          "[rejectReconnectRequest] push failed",
          String(e?.message || e),
        );
      }

      return {
        ok: true,
        code: "REJECTED",
        message: t(lang, "REJECTED"),
        status: "rejected",
        request_id: requestId,
        relationship_id: relId || null,
      };
    } catch (e) {
      return {
        ok: false,
        code: "ERROR",
        message: t("en", "ERROR"),
        debugMessage: e?.message ? String(e.message) : "Unknown error.",
      };
    }
  });
