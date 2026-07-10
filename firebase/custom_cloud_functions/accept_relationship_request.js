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
const REL_COL = "relationships";
const USERS_COL = "Users";
const PUBLIC_COL = "PublicUsers";
const REL_VIEWS_COL = "relationship_views";

const ROUTE_ON_TAP = "home";

function nonEmptyString(v) {
  return typeof v === "string" && v.trim().length > 0 ? v.trim() : "";
}

async function getUserLang(uid) {
  try {
    if (!uid) return "en";
    const snap = await db.collection(USERS_COL).doc(uid).get();
    let lang = (snap.exists ? snap.get("appLanguage") || "" : "")
      .toString()
      .trim()
      .toLowerCase();
    if (lang.includes("_")) lang = lang.split("_")[0];
    if (lang.includes("-")) lang = lang.split("-")[0];
    return ["en", "de", "es"].includes(lang) ? lang : "en";
  } catch (_) {
    return "en";
  }
}

function t(lang, { en, de, es }) {
  return lang === "de" ? de : lang === "es" ? es : en;
}

async function getTokensForUid(uid) {
  const snap = await db
    .collection(USERS_COL)
    .doc(uid)
    .collection("fcm_tokens")
    .get();

  if (snap.empty) return [];

  return snap.docs
    .map((d) => d.get("fcm_token") || d.get("token") || d.id)
    .filter((tok) => typeof tok === "string" && tok.length > 10);
}

async function canReceiveRelationshipAlerts(uid) {
  try {
    const snap = await db.collection(USERS_COL).doc(uid).get();
    const u = snap.exists ? snap.data() || {} : {};

    if (u.muteAllNotifications === true) return false;
    if (u.relationshipAlertsEnabled !== true) return false;

    return true;
  } catch {
    return false;
  }
}

async function getPublicName(uid) {
  try {
    const snap = await db.collection(PUBLIC_COL).doc(uid).get();
    const pub = snap.exists ? snap.data() || {} : {};

    const raw =
      pub.display_name ||
      pub.displayName ||
      pub.name ||
      pub.full_name ||
      pub.fullName ||
      "";

    return String(raw).trim() || "";
  } catch {
    return "";
  }
}

async function pushConnectedToUid(targetUid, partnerName, relationshipId) {
  const allowed = await canReceiveRelationshipAlerts(targetUid);
  if (!allowed) return;

  const tokens = await getTokensForUid(targetUid);
  if (!tokens.length) return;

  const lang = await getUserLang(targetUid);

  const title = t(lang, {
    en: "You’re connected 💜",
    de: "Ihr seid verbunden 💜",
    es: "¡Ya están conectados! 💜",
  });

  const body = partnerName
    ? t(lang, {
        en: `You and ${partnerName} are now connected. Say hi 💫`,
        de: `Du und ${partnerName} seid jetzt verbunden. Sag kurz Hallo 💫`,
        es: `Tú y ${partnerName} ya están conectados. Di hola 💫`,
      })
    : t(lang, {
        en: "You’re now connected. Say hi 💫",
        de: "Ihr seid jetzt verbunden. Sag kurz Hallo 💫",
        es: "Ya están conectados. Di hola 💫",
      });

  await messaging.sendEachForMulticast({
    tokens,
    notification: { title, body },
    data: {
      type: "relationship_connected",
      route: ROUTE_ON_TAP,
      relationshipId: String(relationshipId || ""),
    },
  });
}

async function getPublicUserByUid(uid) {
  try {
    if (!uid) return null;

    const direct = await db.collection(PUBLIC_COL).doc(uid).get();
    if (direct.exists) return direct.data() || null;

    const qs = await db
      .collection(PUBLIC_COL)
      .where("uid", "==", uid)
      .limit(1)
      .get();
    if (qs.empty) return null;
    return qs.docs[0].data() || null;
  } catch {
    return null;
  }
}

function toTimestampOrNull(v) {
  try {
    if (!v) return null;

    if (typeof v.toMillis === "function") return v;

    if (v instanceof Date) return admin.firestore.Timestamp.fromDate(v);

    if (typeof v === "number" && Number.isFinite(v)) {
      return admin.firestore.Timestamp.fromMillis(v);
    }

    if (typeof v === "string") {
      const d = new Date(v);
      if (!isNaN(d.getTime())) return admin.firestore.Timestamp.fromDate(d);
    }

    return null;
  } catch {
    return null;
  }
}

function utcDayKeyFromTs(ts) {
  if (!ts || typeof ts.toDate !== "function") return "";
  const d = ts.toDate();
  const y = d.getUTCFullYear();
  const m = String(d.getUTCMonth() + 1).padStart(2, "0");
  const day = String(d.getUTCDate()).padStart(2, "0");
  return `${y}-${m}-${day}`;
}

function pickTogetherSince(tsA, tsB) {
  const a = tsA || null;
  const b = tsB || null;

  if (!a && !b) return { togetherSince: null, conflict: false, source: "none" };
  if (a && !b) return { togetherSince: a, conflict: false, source: "single_a" };
  if (!a && b) return { togetherSince: b, conflict: false, source: "single_b" };

  const dayA = utcDayKeyFromTs(a);
  const dayB = utcDayKeyFromTs(b);

  if (dayA && dayB && dayA === dayB) {
    return { togetherSince: a, conflict: false, source: "match_day" };
  }

  const aMs = a.toMillis();
  const bMs = b.toMillis();
  const min = aMs <= bMs ? a : b;

  return { togetherSince: min, conflict: true, source: "min_mismatch" };
}

const TEXT = {
  unauth: {
    en: "Please log in again.",
    de: "Bitte melde dich erneut an.",
    es: "Por favor, inicia sesión de nuevo.",
  },
  missingRequestId: {
    en: "Missing requestId.",
    de: "Anfrage-ID fehlt.",
    es: "Falta el requestId.",
  },
  notFound: {
    en: "Request not found.",
    de: "Anfrage nicht gefunden.",
    es: "Solicitud no encontrada.",
  },
  notPending: {
    en: "This request is no longer pending.",
    de: "Diese Anfrage ist nicht mehr offen.",
    es: "Esta solicitud ya no está pendiente.",
  },
  onlyTarget: {
    en: "Only the invited person can accept this request.",
    de: "Nur die eingeladene Person kann diese Anfrage annehmen.",
    es: "Solo la persona invitada puede aceptar esta solicitud.",
  },
  missingUsers: {
    en: "Something is missing. Please try again.",
    de: "Da fehlt etwas. Bitte versuch es erneut.",
    es: "Falta algo. Por favor, inténtalo de nuevo.",
  },
  alreadyConnected: {
    en: "One of you is already connected.",
    de: "Eine:r von euch ist bereits verbunden.",
    es: "Uno de ustedes ya está conectado.",
  },
  success: {
    en: "You’re connected now 💜",
    de: "Ihr seid jetzt verbunden 💜",
    es: "¡Ya están conectados! 💜",
  },
  errorGeneric: {
    en: "Something went wrong. Please try again.",
    de: "Etwas ist schiefgelaufen. Bitte versuch es erneut.",
    es: "Algo salió mal. Por favor, inténtalo de nuevo.",
  },
};

exports.acceptRelationshipRequest = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    const callerUid = context.auth?.uid;
    const lang = await getUserLang(callerUid);

    const requestId = nonEmptyString(
      data?.requestId ?? data?.requestid ?? data?.request_id ?? "",
    );

    if (!callerUid) {
      return {
        ok: false,
        code: "UNAUTHENTICATED",
        message: TEXT.unauth[lang],
        relationshipId: "",
      };
    }

    if (!requestId) {
      return {
        ok: false,
        code: "MISSING_REQUEST_ID",
        message: TEXT.missingRequestId[lang],
        relationshipId: "",
      };
    }

    try {
      const reqRef = db.collection(REQUESTS_COL).doc(requestId);
      const reqSnap = await reqRef.get();

      if (!reqSnap.exists) {
        return {
          ok: false,
          code: "NOT_FOUND",
          message: TEXT.notFound[lang],
          relationshipId: "",
        };
      }

      const req = reqSnap.data() || {};

      if (req.status !== "pending") {
        return {
          ok: false,
          code: "NOT_PENDING",
          message: TEXT.notPending[lang],
          relationshipId: "",
        };
      }

      if (req.target_id !== callerUid) {
        return {
          ok: false,
          code: "NOT_TARGET",
          message: TEXT.onlyTarget[lang],
          relationshipId: "",
        };
      }

      const initiatorUid = nonEmptyString(req.initiator_id);
      const targetUid = nonEmptyString(req.target_id);

      if (!initiatorUid || !targetUid) {
        return {
          ok: false,
          code: "MISSING_USERS",
          message: TEXT.missingUsers[lang],
          relationshipId: "",
        };
      }

      const [aUserSnap, bUserSnap] = await Promise.all([
        db.collection(USERS_COL).doc(initiatorUid).get(),
        db.collection(USERS_COL).doc(targetUid).get(),
      ]);

      const aRel = aUserSnap.exists
        ? nonEmptyString(aUserSnap.get("relationship_id"))
        : "";

      const bRel = bUserSnap.exists
        ? nonEmptyString(bUserSnap.get("relationship_id"))
        : "";

      if (aRel || bRel) {
        return {
          ok: false,
          code: "ALREADY_CONNECTED",
          message: TEXT.alreadyConnected[lang],
          relationshipId: "",
        };
      }

      const [pubA, pubB] = await Promise.all([
        getPublicUserByUid(initiatorUid),
        getPublicUserByUid(targetUid),
      ]);

      const tsA = toTimestampOrNull(pubA?.together_since);
      const tsB = toTimestampOrNull(pubB?.together_since);

      const togetherPick = pickTogetherSince(tsA, tsB);
      const togetherSince = togetherPick.togetherSince;
      const togetherConflict = togetherPick.conflict === true;
      const togetherSource = togetherPick.source || "none";

      const nowTs = admin.firestore.Timestamp.now();
      const relRef = db.collection(REL_COL).doc();
      const relationshipId = relRef.id;

      await db.runTransaction(async (tx) => {
        const relPayload = {
          relationship_id: relationshipId,
          userA_id: initiatorUid,
          userB_id: targetUid,
          active: true,
          status: "active",
          relationship_status: "active",
          created_at: nowTs,
          updated_at: nowTs,
          started_at: nowTs,
        };

        if (togetherSince) {
          relPayload.together_since = togetherSince;
          relPayload.together_since_set_at = nowTs;
          relPayload.together_since_conflict = togetherConflict;
          relPayload.together_since_source = togetherSource;
        }

        tx.set(relRef, relPayload);

        tx.set(
          db.collection(USERS_COL).doc(initiatorUid),
          {
            relationship_id: relationshipId,
            partnerUID: targetUid,
            relationship_status: "active",
            updated_at: nowTs,
          },
          { merge: true },
        );

        tx.set(
          db.collection(USERS_COL).doc(targetUid),
          {
            relationship_id: relationshipId,
            partnerUID: initiatorUid,
            relationship_status: "active",
            updated_at: nowTs,
          },
          { merge: true },
        );

        tx.set(
          db.collection(PUBLIC_COL).doc(initiatorUid),
          {
            relationship_id: relationshipId,
            partnerUID: targetUid,
            relationship_status: "active",
            updated_at: nowTs,
          },
          { merge: true },
        );

        tx.set(
          db.collection(PUBLIC_COL).doc(targetUid),
          {
            relationship_id: relationshipId,
            partnerUID: initiatorUid,
            relationship_status: "active",
            updated_at: nowTs,
          },
          { merge: true },
        );

        tx.update(reqRef, {
          status: "accepted",
          relationship_id: relationshipId,
          relationship_status: "active",
          updated_at: nowTs,
        });

        const baseInit = {
          updated_at: nowTs,
          relationship_status: "active",

          love_score: 65,
          love_percent: 0.65,
          love_state: "happy",
          love_last_update: nowTs,
          love_today_points: 0,

          my_mood: "",
          my_mood_updated_at: nowTs,
          partner_mood: "",
          partner_mood_updated_at: nowTs,

          my_sleep_status: false,
          my_sleep_status_updated_at: nowTs,
          my_sleep_started_at: null,
          my_sleep_ended_at: null,
          my_sleep_checkin_12h_sent: false,

          partner_sleep_status: false,
          partner_sleep_status_updated_at: nowTs,
          partner_sleep_started_at: null,
          partner_sleep_ended_at: null,
          partner_sleep_checkin_12h_sent: false,
        };

        tx.set(
          db.collection(REL_VIEWS_COL).doc(initiatorUid),
          {
            uid: initiatorUid,
            relationship_id: relationshipId,
            partner_uid: targetUid,
            ...baseInit,
          },
          { merge: true },
        );

        tx.set(
          db.collection(REL_VIEWS_COL).doc(targetUid),
          {
            uid: targetUid,
            relationship_id: relationshipId,
            partner_uid: initiatorUid,
            ...baseInit,
          },
          { merge: true },
        );
      });

      const [initName, targName] = await Promise.all([
        getPublicName(initiatorUid),
        getPublicName(targetUid),
      ]);

      await Promise.all([
        pushConnectedToUid(initiatorUid, targName, relationshipId).catch(
          () => null,
        ),
        pushConnectedToUid(targetUid, initName, relationshipId).catch(
          () => null,
        ),
      ]);

      return {
        ok: true,
        code: "OK",
        message: TEXT.success[lang],
        relationshipId,
        relationship_status: "active",
        together_since_conflict: togetherConflict,
      };
    } catch (e) {
      console.error("[acceptRelationshipRequest] failed:", e);

      return {
        ok: false,
        code: "ERROR",
        message: TEXT.errorGeneric[lang],
        relationshipId: "",
      };
    }
  });
