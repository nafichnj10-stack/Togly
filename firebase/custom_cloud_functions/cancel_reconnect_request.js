const functions = require("firebase-functions");
const admin = require("firebase-admin");
try {
  admin.app();
} catch {
  admin.initializeApp();
}

const db = admin.firestore();
const messaging = admin.messaging();

// ---- Language helpers ----
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
      NEED_ID: "Please provide either a request id or a relationship id.",
      NO_PENDING: "No pending reconnect request was found.",
      ONLY_INITIATOR: "Only the person who sent the request can cancel it.",
      ALREADY_RESOLVED: "This request is no longer pending.",
      CANCELED: "Reconnect request canceled.",
      ERROR: "Something went wrong. Please try again.",
    },
    de: {
      AUTH: "Bitte melde dich an, um fortzufahren.",
      NEED_ID: "Bitte gib entweder eine Anfrage-ID oder eine Beziehungs-ID an.",
      NO_PENDING: "Es wurde keine offene Reconnect-Anfrage gefunden.",
      ONLY_INITIATOR:
        "Nur die Person, die die Anfrage gesendet hat, kann sie abbrechen.",
      ALREADY_RESOLVED: "Diese Anfrage ist nicht mehr offen.",
      CANCELED: "Versöhnungsanfrage wurde abgebrochen.",
      ERROR: "Etwas ist schiefgelaufen. Bitte versuche es erneut.",
    },
    es: {
      AUTH: "Inicia sesión para continuar.",
      NEED_ID: "Indica un ID de solicitud o un ID de relación.",
      NO_PENDING: "No se encontró ninguna solicitud de reconexión pendiente.",
      ONLY_INITIATOR: "Solo quien envió la solicitud puede cancelarla.",
      ALREADY_RESOLVED: "Esta solicitud ya no está pendiente.",
      CANCELED: "Solicitud de reconexión cancelada.",
      ERROR: "Algo salió mal. Inténtalo de nuevo.",
    },
  };
  return M[lang] && M[lang][key] ? M[lang][key] : M.en[key] || "Error.";
}

/* ---------- Push helpers (minimal) ---------- */

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

/* ---------- MAIN ---------- */

exports.cancelReconnectRequest = functions
  .region("europe-west3")
  .https.onCall(async (data, context) => {
    try {
      const uid = context.auth?.uid;
      if (!uid) {
        return { ok: false, code: "AUTH_REQUIRED", message: t("en", "AUTH") };
      }

      const lang = await getUserLang(uid);

      const requestId = String(data?.requestId || "").trim();
      const relationshipId = String(
        data?.relationshipid || data?.relationshipId || "",
      ).trim();

      // 1) request finden
      let reqRef = null;
      let snap = null;

      if (requestId) {
        const directRef = db.collection("reconnect_requests").doc(requestId);
        const directSnap = await directRef.get();
        if (directSnap.exists) {
          reqRef = directRef;
          snap = directSnap;
        }
      }

      if (!snap) {
        if (!relationshipId) {
          return {
            ok: false,
            code: "ID_REQUIRED",
            message: t(lang, "NEED_ID"),
          };
        }

        const q = await db
          .collection("reconnect_requests")
          .where("relationship_id", "==", relationshipId)
          .where("initiator_id", "==", uid)
          .where("status", "==", "pending")
          .limit(1)
          .get();

        if (!q.empty) {
          reqRef = q.docs[0].ref;
          snap = q.docs[0];
        }
      }

      if (!snap) {
        return {
          ok: false,
          code: "NOT_FOUND",
          message: t(lang, "NO_PENDING"),
          status: "not_found",
        };
      }

      const req = snap.data() || {};
      const initiatorId = String(req.initiator_id || "").trim();
      const targetId = String(req.target_id || "").trim();
      const relId = String(req.relationship_id || relationshipId || "").trim();
      const currentStatus = String(req.status || "").toLowerCase();

      if (initiatorId !== uid) {
        return {
          ok: false,
          code: "ONLY_INITIATOR",
          message: t(lang, "ONLY_INITIATOR"),
        };
      }

      if (currentStatus !== "pending") {
        return {
          ok: true,
          code: "ALREADY_RESOLVED",
          message: t(lang, "ALREADY_RESOLVED"),
          status: `already_${currentStatus}`,
        };
      }

      const now = admin.firestore.Timestamp.now();

      // ✅ 2) Atomar: Request löschen + Users zurücksetzen
      await db.runTransaction(async (tx) => {
        tx.delete(reqRef);

        const patch = {
          restore_required: true,
          restore_state: "ready_to_send",
          restore_request_id: admin.firestore.FieldValue.delete(),
          restore_relationship_id: relId,
          updated_at: now,
        };

        // Initiator & Target zurücksetzen
        tx.set(db.collection("Users").doc(initiatorId), patch, { merge: true });
        tx.set(db.collection("Users").doc(targetId), patch, { merge: true });
      });

      // ✅ 3) Push an Target (withdrawn)
      try {
        const l = await getUserLang(targetId);
        const title =
          l === "de"
            ? "Versöhnungsanfrage zurückgezogen"
            : l === "es"
              ? "Solicitud retirada"
              : "Reconnect withdrawn";

        const body =
          l === "de"
            ? "Dein:e Partner:in hat die Versöhnungsanfrage zurückgezogen."
            : l === "es"
              ? "Tu pareja retiró la solicitud de reconexión."
              : "Your partner withdrew the reconnect request.";

        await sendPushToUid(targetId, {
          type: "reconnect_request_withdrawn",
          title,
          body,
          route: "restore",
          params: { relationshipId: relId },
        });
      } catch (e) {
        console.log(
          "[cancelReconnectRequest] push failed",
          String(e?.message || e),
        );
      }

      return {
        ok: true,
        code: "DELETED",
        message: t(lang, "CANCELED"),
        status: "deleted",
        request_id: reqRef.id,
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
