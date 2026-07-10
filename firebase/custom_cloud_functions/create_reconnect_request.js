const functions = require("firebase-functions");
const admin = require("firebase-admin");
try {
  admin.app();
} catch {
  admin.initializeApp();
}

const db = admin.firestore();
const messaging = admin.messaging();

/* -------------------- Push helpers (standalone) -------------------- */

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

async function getPublicName(uid, lang) {
  try {
    // Falls PublicUsers bei dir NICHT docId==uid ist, musst du das auf where('uid','==',uid) umbauen.
    const pub = await db.collection("PublicUsers").doc(uid).get();
    const d = pub.exists ? pub.data() || {} : {};
    const name = String(
      d.display_name ||
        d.displayName ||
        d.name ||
        d.full_name ||
        d.fullName ||
        "",
    ).trim();
    if (name) return name;
  } catch {}

  return lang === "de"
    ? "Dein Partner"
    : lang === "es"
      ? "Tu pareja"
      : "Your partner";
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

async function sendReconnectPush(
  targetUid,
  { type, title, body, route, params },
) {
  if (!targetUid) return { ok: false, reason: "NO_TARGET" };
  if (!(await canSendRelationshipAlert(targetUid)))
    return { ok: false, reason: "DISABLED_BY_PREFS" };

  const tokens = await getTokensForUid(targetUid);
  if (!tokens.length) return { ok: false, reason: "NO_TOKENS" };

  const nav = ffNav(route, params);

  const res = await messaging.sendEachForMulticast({
    tokens,
    notification: { title, body },
    data: {
      type: String(type || ""),
      ...nav,
      ...Object.fromEntries(
        Object.entries(params || {}).map(([k, v]) => [String(k), String(v)]),
      ),
    },
  });

  return {
    ok: true,
    sent: res.successCount || 0,
    failed: res.failureCount || 0,
  };
}

/* -------------------- Language strings -------------------- */

function t(lang, key) {
  const M = {
    en: {
      AUTH: "Please sign in to continue.",
      REL_ID_REQUIRED: "Please provide a valid relationship id.",
      REL_NOT_FOUND: "We couldn’t find this relationship.",
      REL_NEEDS_TWO: "This relationship must have two members.",
      NOT_MEMBER: "This relationship doesn’t belong to you.",
      WINDOW_EXPIRED: "The reconnect window has expired.",
      ALREADY_ACTIVE: "You’re already connected 💕",
      PENDING: "Reconnect request sent 💕",
      ERROR: "Something went wrong. Please try again.",
    },
    de: {
      AUTH: "Bitte melde dich an, um fortzufahren.",
      REL_ID_REQUIRED: "Bitte gib eine gültige Beziehungs-ID an.",
      REL_NOT_FOUND: "Diese Beziehung konnten wir nicht finden.",
      REL_NEEDS_TWO: "Diese Beziehung muss aus zwei Personen bestehen.",
      NOT_MEMBER: "Diese Beziehung gehört nicht zu dir.",
      WINDOW_EXPIRED: "Das Zeitfenster zum Wiederverbinden ist abgelaufen.",
      ALREADY_ACTIVE: "Ihr seid bereits verbunden 💕",
      PENDING: "Versöhnungsanfrage wurde gesendet 💕",
      ERROR: "Etwas ist schiefgelaufen. Bitte versuche es erneut.",
    },
    es: {
      AUTH: "Inicia sesión para continuar.",
      REL_ID_REQUIRED: "Por favor, indica un ID de relación válido.",
      REL_NOT_FOUND: "No pudimos encontrar esta relación.",
      REL_NEEDS_TWO: "Esta relación debe tener dos miembros.",
      NOT_MEMBER: "Esta relación no te pertenece.",
      WINDOW_EXPIRED: "El plazo para reconectar ha expirado.",
      ALREADY_ACTIVE: "Ya están conectados 💕",
      PENDING: "Solicitud de reconexión enviada 💕",
      ERROR: "Algo salió mal. Inténtalo de nuevo.",
    },
  };
  return M[lang] && M[lang][key] ? M[lang][key] : M.en[key] || "Error.";
}

exports.createReconnectRequest = functions
  .region("europe-west3")
  .https.onCall(async (data, ctx) => {
    try {
      const initiator = ctx.auth?.uid;
      if (!initiator) {
        return { ok: false, code: "AUTH_REQUIRED", message: t("en", "AUTH") };
      }

      const lang = await getUserLang(initiator);

      const rid = String(
        data?.relationshipid || data?.relationshipId || "",
      ).trim();
      if (!rid) {
        return {
          ok: false,
          code: "RELATIONSHIP_ID_REQUIRED",
          message: t(lang, "REL_ID_REQUIRED"),
        };
      }

      const relRef = db.collection("relationships").doc(rid);
      const relSnap = await relRef.get();
      if (!relSnap.exists) {
        return {
          ok: false,
          code: "RELATIONSHIP_NOT_FOUND",
          message: t(lang, "REL_NOT_FOUND"),
        };
      }

      const rel = relSnap.data() || {};
      const members = [rel.userA_id, rel.userB_id].filter(Boolean);

      if (members.length !== 2) {
        return {
          ok: false,
          code: "RELATIONSHIP_NEEDS_TWO_MEMBERS",
          message: t(lang, "REL_NEEDS_TWO"),
        };
      }
      if (!members.includes(initiator)) {
        return {
          ok: false,
          code: "NOT_MEMBER",
          message: t(lang, "NOT_MEMBER"),
        };
      }

      if (rel.active === true) {
        return {
          ok: true,
          code: "ALREADY_ACTIVE",
          message: t(lang, "ALREADY_ACTIVE"),
          status: "already_active",
          requestId: "",
          relationshipId: rid,
          expiresAt: null,
          request_id: "",
          relationship_id: rid,
          expires_at: null,
        };
      }

      const now = admin.firestore.Timestamp.now();
      if (!rel.purge_at || now.toMillis() > rel.purge_at.toMillis()) {
        return {
          ok: false,
          code: "RESTORE_WINDOW_EXPIRED",
          message: t(lang, "WINDOW_EXPIRED"),
        };
      }

      const targetId = members.find((u) => u !== initiator);

      // stabiler requestId
      const pairKey = `${rid}:${members.slice().sort().join(":")}`;
      const reqRef = db.collection("reconnect_requests").doc(pairKey);

      await db.runTransaction(async (tx) => {
        const exSnap = await tx.get(reqRef);

        tx.set(
          reqRef,
          {
            relationship_id: rid,
            pair_key: pairKey,
            initiator_id: initiator,
            target_id: targetId,
            status: "pending",
            created_at: exSnap.exists
              ? (exSnap.data()?.created_at ?? now)
              : now,
            updated_at: now,
            expires_at: rel.purge_at,
          },
          { merge: true },
        );

        // Users-States
        tx.set(
          db.collection("Users").doc(initiator),
          {
            restore_required: true,
            restore_state: "outgoing_pending",
            restore_request_id: pairKey,
            restore_relationship_id: rid,
            updated_at: now,
          },
          { merge: true },
        );

        tx.set(
          db.collection("Users").doc(targetId),
          {
            restore_required: true,
            restore_state: "incoming_pending",
            restore_request_id: pairKey,
            restore_relationship_id: rid,
            updated_at: now,
          },
          { merge: true },
        );
      });

      // ✅ Push an Target (restore)
      try {
        const targetLang = await getUserLang(targetId);
        const senderName = await getPublicName(initiator, targetLang);

        const title =
          targetLang === "de"
            ? "Versöhnungsanfrage 💜"
            : targetLang === "es"
              ? "Solicitud de reconexión 💜"
              : "Reconnect request 💜";

        const body =
          targetLang === "de"
            ? `${senderName} möchte sich wieder verbinden. Tippe zum Entscheiden 💫`
            : targetLang === "es"
              ? `${senderName} quiere reconectar. Toca para decidir 💫`
              : `${senderName} wants to reconnect. Tap to decide 💫`;

        await sendReconnectPush(targetId, {
          type: "reconnect_request_received",
          title,
          body,
          route: "restore",
          params: { requestId: pairKey, relationshipId: rid },
        });
      } catch (e) {
        console.log(
          "[createReconnectRequest] push failed",
          String(e?.message || e),
        );
      }

      return {
        ok: true,
        code: "PENDING",
        message: t(lang, "PENDING"),
        status: "pending",
        requestId: pairKey,
        relationshipId: rid,
        expiresAt: rel.purge_at.toDate().toISOString(),
        request_id: pairKey,
        relationship_id: rid,
        expires_at: rel.purge_at.toDate().toISOString(),
      };
    } catch (e) {
      console.error("[createReconnectRequest]", e);
      return {
        ok: false,
        code: "ERROR",
        message: t("en", "ERROR"),
        debugMessage: e?.message ? String(e.message) : "Unknown error.",
      };
    }
  });
