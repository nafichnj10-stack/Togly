const functions = require("firebase-functions");
const admin = require("firebase-admin");
try {
  admin.app();
} catch {
  admin.initializeApp();
}
const db = admin.firestore();

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
      ONLY_INITIATOR: "Only the person who sent the request can dismiss it.",
      NOT_FOUND: "Nothing to dismiss.",
      BLOCKED: "This request can’t be dismissed right now.",
      DISMISSED: "Dismissed.",
      ERROR: "Something went wrong. Please try again.",
    },
    de: {
      AUTH: "Bitte melde dich an, um fortzufahren.",
      ONLY_INITIATOR:
        "Nur die Person, die die Anfrage gesendet hat, kann sie ausblenden.",
      NOT_FOUND: "Es gibt nichts zum Ausblenden.",
      BLOCKED: "Diese Anfrage kann gerade nicht ausgeblendet werden.",
      DISMISSED: "Ausgeblendet.",
      ERROR: "Etwas ist schiefgelaufen. Bitte versuche es erneut.",
    },
    es: {
      AUTH: "Inicia sesión para continuar.",
      ONLY_INITIATOR: "Solo quien envió la solicitud puede descartarla.",
      NOT_FOUND: "No hay nada que descartar.",
      BLOCKED: "Esta solicitud no se puede descartar ahora.",
      DISMISSED: "Descartado.",
      ERROR: "Algo salió mal. Inténtalo de nuevo.",
    },
  };
  return M[lang] && M[lang][key] ? M[lang][key] : M.en[key] || "Error.";
}

exports.dismissRejectedReconnect = functions
  .region("europe-west3")
  .https.onCall(async (data, ctx) => {
    try {
      const uid = ctx.auth?.uid;
      if (!uid) {
        return { ok: false, code: "AUTH_REQUIRED", message: t("en", "AUTH") };
      }

      const lang = await getUserLang(uid);

      const requestId = data?.requestId || "";
      const relationshipId = data?.relationshipid || "";
      const partnerUid = data?.partnerUid || "";

      let reqRef = null,
        snap = null;

      // 1) Direkte Doc-ID (pairKey) verwenden, falls vorhanden
      if (requestId) {
        const directRef = db.collection("reconnect_requests").doc(requestId);
        const directSnap = await directRef.get();
        if (directSnap.exists) {
          reqRef = directRef;
          snap = directSnap;
        }
      }

      // 2) Aus relationshipId + partnerUid den pairKey ableiten
      if (!snap && relationshipId && partnerUid) {
        const pairKey = `${relationshipId}:${[uid, partnerUid].sort().join(":")}`;
        const pkRef = db.collection("reconnect_requests").doc(pairKey);
        const pkSnap = await pkRef.get();
        if (pkSnap.exists) {
          reqRef = pkRef;
          snap = pkSnap;
        }
      }

      // 3) Fallback: das REJECTED-Dokument des Initiators in dieser Beziehung suchen
      if (!snap && relationshipId) {
        const q = await db
          .collection("reconnect_requests")
          .where("relationship_id", "==", relationshipId)
          .where("initiator_id", "==", uid)
          .where("status", "==", "rejected")
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
          message: t(lang, "NOT_FOUND"),
          status: "not_found",
        };
      }

      const req = snap.data() || {};

      // Nur der Initiator darf die abgelehnte Anfrage "wegklicken"
      if (req.initiator_id !== uid) {
        return {
          ok: false,
          code: "ONLY_INITIATOR",
          message: t(lang, "ONLY_INITIATOR"),
        };
      }

      if ((req.status || "").toLowerCase() !== "rejected") {
        // Safety: nichts löschen, wenn es inzwischen z.B. pending/accepted ist
        return {
          ok: true,
          code: "BLOCKED",
          message: t(lang, "BLOCKED"),
          status: `blocked_${(req.status || "").toLowerCase()}`,
          request_id: reqRef.id,
        };
      }

      await reqRef.delete(); // Hard delete
      return {
        ok: true,
        code: "DELETED",
        message: t(lang, "DISMISSED"),
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
