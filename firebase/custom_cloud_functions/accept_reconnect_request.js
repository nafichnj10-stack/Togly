const functions = require("firebase-functions");
const admin = require("firebase-admin");
try {
  admin.app();
} catch {
  admin.initializeApp();
}

const db = admin.firestore();

async function publicUserDocsByUid(uid) {
  const snap = await db
    .collection("PublicUsers")
    .where("uid", "==", uid)
    .limit(10)
    .get();
  return snap.docs;
}

function normalizeLang(raw) {
  let lang = String(raw || "en")
    .toLowerCase()
    .trim();
  if (lang.includes("-")) lang = lang.split("-")[0];
  if (lang.includes("_")) lang = lang.split("_")[0];
  return ["de", "en", "es"].includes(lang) ? lang : "en";
}

async function getUserLang(uid) {
  try {
    const snap = await db.collection("Users").doc(uid).get();
    return normalizeLang(snap.exists ? snap.get("appLanguage") : "en");
  } catch {
    return "en";
  }
}

function t(lang, key) {
  const M = {
    en: {
      AUTH: "Please sign in to continue.",
      REQ_ID_REQUIRED: "Please provide a valid request id.",
      REQ_NOT_FOUND: "We couldn’t find this request.",
      ONLY_TARGET: "Only your partner can accept this request.",
      REQ_MISSING_REL: "This request is missing the relationship data.",
      REL_MISSING: "We couldn’t find the relationship for this request.",
      WINDOW_EXPIRED: "The reconnect window has expired.",
      REL_NEEDS_TWO: "This relationship must have two members.",
      ALREADY_DONE: "This request is no longer pending.",
      SUCCESS: "You’re connected again 💕",
      ERROR: "Something went wrong. Please try again.",
    },
    de: {
      AUTH: "Bitte melde dich an, um fortzufahren.",
      REQ_ID_REQUIRED: "Bitte gib eine gültige Anfrage-ID an.",
      REQ_NOT_FOUND: "Diese Anfrage konnten wir nicht finden.",
      ONLY_TARGET: "Nur dein:e Partner:in kann diese Anfrage annehmen.",
      REQ_MISSING_REL: "Bei dieser Anfrage fehlen Beziehungsdaten.",
      REL_MISSING: "Die Beziehung zu dieser Anfrage konnten wir nicht finden.",
      WINDOW_EXPIRED: "Das Zeitfenster zum Wiederverbinden ist abgelaufen.",
      REL_NEEDS_TWO: "Diese Beziehung muss aus zwei Personen bestehen.",
      ALREADY_DONE: "Diese Anfrage ist nicht mehr offen.",
      SUCCESS: "Ihr seid wieder verbunden 💕",
      ERROR: "Etwas ist schiefgelaufen. Bitte versuche es erneut.",
    },
    es: {
      AUTH: "Inicia sesión para continuar.",
      REQ_ID_REQUIRED: "Por favor, indica un ID de solicitud válido.",
      REQ_NOT_FOUND: "No pudimos encontrar esta solicitud.",
      ONLY_TARGET: "Solo tu pareja puede aceptar esta solicitud.",
      REQ_MISSING_REL: "A esta solicitud le faltan datos de la relación.",
      REL_MISSING: "No pudimos encontrar la relación de esta solicitud.",
      WINDOW_EXPIRED: "El plazo para reconectar ha expirado.",
      REL_NEEDS_TWO: "Esta relación debe tener dos miembros.",
      ALREADY_DONE: "Esta solicitud ya no está pendiente.",
      SUCCESS: "Están conectados de nuevo 💕",
      ERROR: "Algo salió mal. Inténtalo de nuevo.",
    },
  };
  return M[lang]?.[key] || M.en[key];
}

function clamp(n, min, max) {
  return Math.max(min, Math.min(max, n));
}

function loveStateFromScore(score) {
  if (score >= 65) return "happy";
  if (score >= 30) return "sad";
  return "angry";
}

exports.acceptReconnectRequest = functions
  .region("europe-west3")
  .https.onCall(async (data, ctx) => {
    try {
      const uid = ctx.auth?.uid;
      if (!uid) {
        return { ok: false, code: "AUTH_REQUIRED", message: t("en", "AUTH") };
      }

      const lang = await getUserLang(uid);
      const requestId = String(data?.requestId || "").trim();

      if (!requestId) {
        return {
          ok: false,
          code: "REQUEST_ID_REQUIRED",
          message: t(lang, "REQ_ID_REQUIRED"),
        };
      }

      const reqRef = db.collection("reconnect_requests").doc(requestId);
      const reqSnap = await reqRef.get();

      if (!reqSnap.exists) {
        return {
          ok: false,
          code: "REQUEST_NOT_FOUND",
          message: t(lang, "REQ_NOT_FOUND"),
        };
      }

      const req = reqSnap.data() || {};

      if (uid !== req.target_id) {
        return {
          ok: false,
          code: "ONLY_TARGET",
          message: t(lang, "ONLY_TARGET"),
        };
      }

      if (req.status && req.status !== "pending") {
        return {
          ok: true,
          code: "ALREADY_RESOLVED",
          message: t(lang, "ALREADY_DONE"),
          status: req.status,
        };
      }

      const relId = String(req.relationship_id || "").trim();

      if (!relId) {
        return {
          ok: false,
          code: "REQ_MISSING_REL",
          message: t(lang, "REQ_MISSING_REL"),
        };
      }

      const relRef = db.collection("relationships").doc(relId);
      const relSnap = await relRef.get();

      if (!relSnap.exists) {
        return {
          ok: false,
          code: "REL_MISSING",
          message: t(lang, "REL_MISSING"),
        };
      }

      const rel = relSnap.data() || {};
      const now = admin.firestore.Timestamp.now();

      if (!rel.purge_at || now.toMillis() > rel.purge_at.toMillis()) {
        await reqRef
          .update({
            status: "expired",
            relationship_status: "expired",
            updated_at: now,
          })
          .catch(() => null);

        return {
          ok: false,
          code: "WINDOW_EXPIRED",
          message: t(lang, "WINDOW_EXPIRED"),
        };
      }

      const aUid = String(rel.userA_id || "").trim();
      const bUid = String(rel.userB_id || "").trim();

      if (!aUid || !bUid) {
        return {
          ok: false,
          code: "REL_NEEDS_TWO",
          message: t(lang, "REL_NEEDS_TWO"),
        };
      }

      const [rvASnap, rvBSnap] = await Promise.all([
        db.collection("relationship_views").doc(aUid).get(),
        db.collection("relationship_views").doc(bUid).get(),
      ]);

      const rvA = rvASnap.exists ? rvASnap.data() || {} : {};
      const rvB = rvBSnap.exists ? rvBSnap.data() || {} : {};

      const scoreA = clamp(Number(rvA.love_score ?? 65), 0, 100);
      const scoreB = clamp(Number(rvB.love_score ?? 65), 0, 100);

      const [pubA, pubB] = await Promise.all([
        publicUserDocsByUid(aUid),
        publicUserDocsByUid(bUid),
      ]);

      await db.runTransaction(async (tx) => {
        tx.update(relRef, {
          active: true,
          status: "active",
          relationship_status: "active",
          updated_at: now,
          disconnected_at: admin.firestore.FieldValue.delete(),
          purge_at: admin.firestore.FieldValue.delete(),
          notified_7d: admin.firestore.FieldValue.delete(),
          notified_24h: admin.firestore.FieldValue.delete(),
          notified_1h: admin.firestore.FieldValue.delete(),
        });

        tx.set(
          db.collection("Users").doc(aUid),
          {
            relationship_id: relId,
            partnerUID: bUid,
            relationship_status: "active",

            celebrate_reconnect: true,
            celebrate_reconnect_at: now,

            restore_required: false,
            restore_state: admin.firestore.FieldValue.delete(),
            restore_request_id: admin.firestore.FieldValue.delete(),
            restore_relationship_id: admin.firestore.FieldValue.delete(),
            disconnect_cooldown_until: admin.firestore.FieldValue.delete(),
            updated_at: now,
          },
          { merge: true },
        );

        tx.set(
          db.collection("Users").doc(bUid),
          {
            relationship_id: relId,
            partnerUID: aUid,
            relationship_status: "active",

            celebrate_reconnect: true,
            celebrate_reconnect_at: now,

            restore_required: false,
            restore_state: admin.firestore.FieldValue.delete(),
            restore_request_id: admin.firestore.FieldValue.delete(),
            restore_relationship_id: admin.firestore.FieldValue.delete(),
            disconnect_cooldown_until: admin.firestore.FieldValue.delete(),
            updated_at: now,
          },
          { merge: true },
        );

        pubA.forEach((d) =>
          tx.set(
            d.ref,
            {
              relationship_id: relId,
              partnerUID: bUid,
              relationship_status: "active",
              updated_at: now,
            },
            { merge: true },
          ),
        );

        pubB.forEach((d) =>
          tx.set(
            d.ref,
            {
              relationship_id: relId,
              partnerUID: aUid,
              relationship_status: "active",
              updated_at: now,
            },
            { merge: true },
          ),
        );

        tx.set(
          db.collection("relationship_views").doc(aUid),
          {
            uid: aUid,
            relationship_id: relId,
            partner_uid: bUid,
            relationship_status: "active",

            paused: admin.firestore.FieldValue.delete(),
            paused_at: admin.firestore.FieldValue.delete(),
            purge_at: admin.firestore.FieldValue.delete(),
            last_relationship_id: admin.firestore.FieldValue.delete(),
            restore_required: admin.firestore.FieldValue.delete(),
            restore_relationship_id: admin.firestore.FieldValue.delete(),

            love_score: scoreA,
            love_percent: scoreA / 100,
            love_state: loveStateFromScore(scoreA),
            love_last_update: now,
            love_today_points: admin.firestore.FieldValue.increment(0),
            updated_at: now,
          },
          { merge: true },
        );

        tx.set(
          db.collection("relationship_views").doc(bUid),
          {
            uid: bUid,
            relationship_id: relId,
            partner_uid: aUid,
            relationship_status: "active",

            paused: admin.firestore.FieldValue.delete(),
            paused_at: admin.firestore.FieldValue.delete(),
            purge_at: admin.firestore.FieldValue.delete(),
            last_relationship_id: admin.firestore.FieldValue.delete(),
            restore_required: admin.firestore.FieldValue.delete(),
            restore_relationship_id: admin.firestore.FieldValue.delete(),

            love_score: scoreB,
            love_percent: scoreB / 100,
            love_state: loveStateFromScore(scoreB),
            love_last_update: now,
            love_today_points: admin.firestore.FieldValue.increment(0),
            updated_at: now,
          },
          { merge: true },
        );

        tx.update(reqRef, {
          status: "accepted",
          relationship_status: "active",
          accepted_at: now,
          updated_at: now,
        });
      });

      return {
        ok: true,
        code: "RESTORED",
        message: t(lang, "SUCCESS"),
        relationship_id: relId,
        relationship_status: "active",
        celebrate_reconnect: true,
      };
    } catch (e) {
      console.error("[acceptReconnectRequest]", e);
      return { ok: false, code: "ERROR", message: t("en", "ERROR") };
    }
  });
