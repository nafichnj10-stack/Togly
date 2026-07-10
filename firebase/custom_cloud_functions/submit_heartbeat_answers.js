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

const HEARTBEAT_POINTS = 8;
const REL_VIEWS_COL = "relationship_views";
const LOVE_AWARDS_COL = "love_awards";

// ---------- Heartbeat helpers for submitHeartbeatAnswers ----------

function hbMakeRequestId() {
  return `${Date.now()}_${Math.random().toString(36).slice(2, 10)}`;
}

function hbClampAnswer(value) {
  const n = Number(value);
  if (!Number.isFinite(n)) return null;
  const i = Math.round(n);
  if (i < 1 || i > 5) return null;
  return i;
}

function hbMinutesUntilDate(date) {
  const ms = date.getTime() - Date.now();
  return Math.max(0, Math.ceil(ms / 60000));
}

async function hbLoadQuestionDocsFromRefs(questionRefs = []) {
  const docs = await Promise.all(
    questionRefs.map(async (ref) => {
      try {
        const snap = await ref.get();
        if (!snap.exists) return null;
        return { id: snap.id, ref: snap.ref, ...(snap.data() || {}) };
      } catch {
        return null;
      }
    }),
  );

  return docs.filter(Boolean);
}

function hbWeightedAverage(questionDocs, answers) {
  let weightedSum = 0;
  let totalWeight = 0;

  for (let i = 0; i < questionDocs.length; i++) {
    const q = questionDocs[i] || {};
    const weight =
      typeof q.weight === "number" && q.weight > 0 ? q.weight : 1.0;

    const answer = answers[i];
    weightedSum += answer * weight;
    totalWeight += weight;
  }

  if (totalWeight <= 0) return 0;
  return Number((weightedSum / totalWeight).toFixed(2));
}

function hbPercentFromRaw(raw) {
  const pct = Math.round((raw / 5) * 100);
  return Math.max(1, Math.min(100, pct));
}

function hbConnectionLabelKey(percent) {
  if (percent >= 90) return "deeply_connected";
  if (percent >= 75) return "connected";
  if (percent >= 60) return "gently_needs_closeness";
  return "needs_closeness";
}

function hbInsightTexts(labelKey) {
  switch (labelKey) {
    case "deeply_connected":
      return {
        de: "Ihr fühlt euch heute sehr verbunden und emotional nah.",
        en: "You both feel deeply connected and emotionally close today.",
        es: "Hoy se sienten muy conectados y emocionalmente cercanos.",
      };

    case "connected":
      return {
        de: "Ihr fühlt euch heute emotional nah und gut aufeinander abgestimmt.",
        en: "You both feel emotionally close and well aligned today.",
        es: "Hoy se sienten emocionalmente cercanos y bien conectados.",
      };

    case "gently_needs_closeness":
      return {
        de: "Heute könntet ihr etwas mehr Nähe und bewusste Verbindung gebrauchen.",
        en: "Today you may need a little more closeness and intentional connection.",
        es: "Hoy podrían necesitar un poco más de cercanía y conexión intencional.",
      };

    case "needs_closeness":
    default:
      return {
        de: "Heute wäre ein guter Moment, euch bewusst wieder näherzukommen.",
        en: "Today may be a good moment to intentionally reconnect and feel closer.",
        es: "Hoy puede ser un buen momento para reconectar intencionalmente y sentirse más cerca.",
      };
  }
}

// ---------- LoveBuddy helpers ----------

function hbClamp(val, min, max) {
  return Math.max(min, Math.min(max, val));
}

function hbLoveStateFromScore(score) {
  if (score < 30) return "angry";
  if (score <= 65) return "sad";
  return "happy";
}

// ---------- Push helpers ----------

function hbNonEmptyString(v) {
  return typeof v === "string" && v.trim().length > 0 ? v.trim() : "";
}

function hbNormalizeLang(raw) {
  let lang = String(raw || "en")
    .toLowerCase()
    .trim();
  if (lang.includes("-")) lang = lang.split("-")[0];
  if (lang.includes("_")) lang = lang.split("_")[0];
  return ["de", "en", "es"].includes(lang) ? lang : "en";
}

function hbT(lang, { en, de, es }) {
  return lang === "de" ? de : lang === "es" ? es : en;
}

function hbToStringMap(obj) {
  const out = {};
  for (const [k, v] of Object.entries(obj || {})) out[String(k)] = String(v);
  return out;
}

async function hbGetUserDoc(uid) {
  try {
    const snap = await db.collection("Users").doc(uid).get();
    return snap.exists ? snap.data() || {} : {};
  } catch {
    return {};
  }
}

async function hbGetUserLang(uid) {
  try {
    const user = await hbGetUserDoc(uid);
    return hbNormalizeLang(user.appLanguage || "en");
  } catch {
    return "en";
  }
}

async function hbGetTokensForUid(uid) {
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

async function hbGetPublicUser(uid) {
  try {
    const snap = await db.collection("PublicUsers").doc(uid).get();
    return snap.exists ? snap.data() || null : null;
  } catch {
    return null;
  }
}

function hbPickSenderName(lang, pub) {
  const raw =
    pub?.display_name ||
    pub?.displayName ||
    pub?.name ||
    pub?.full_name ||
    pub?.fullName ||
    "";

  const name = String(raw).trim();
  if (name) return name;

  return hbT(lang, {
    en: "Your partner",
    de: "Dein Partner",
    es: "Tu pareja",
  });
}

async function hbIsHeartbeatPushAllowed(targetUid) {
  const u = await hbGetUserDoc(targetUid);

  if (u.muteAllNotifications === true) return false;
  if (u.relationshipAlertsEnabled !== true) return false;

  return true;
}

function hbBuildFlutterFlowNavData(route, paramsObj) {
  const page = hbNonEmptyString(route);
  const paramData = JSON.stringify(paramsObj || {});
  return {
    click_action: "FLUTTER_NOTIFICATION_CLICK",
    initial_page_name: page,
    initialPageName: page,
    parameter_data: paramData,
    parameterData: paramData,
  };
}

function hbHeartbeatAnsweredCopy(lang, senderName) {
  return {
    title: hbT(lang, {
      en: "Heartbeat ❤️",
      de: "Heartbeat ❤️",
      es: "Heartbeat ❤️",
    }),
    body: hbT(lang, {
      en: `${senderName} completed today’s Heartbeat. Now it’s your turn 💜`,
      de: `${senderName} hat den heutigen Heartbeat abgeschlossen. Jetzt bist du dran 💜`,
      es: `${senderName} completó el Heartbeat de hoy. Ahora te toca a ti 💜`,
    }),
  };
}

function hbHeartbeatResultReadyCopy(lang, senderName) {
  return {
    title: hbT(lang, {
      en: "Heartbeat Result 💜",
      de: "Heartbeat-Ergebnis 💜",
      es: "Resultado del Heartbeat 💜",
    }),
    body: hbT(lang, {
      en: `${senderName} also completed today’s Heartbeat. Your result is ready ✨`,
      de: `${senderName} hat den heutigen Heartbeat jetzt auch abgeschlossen. Euer Ergebnis ist jetzt bereit ✨`,
      es: `${senderName} también completó el Heartbeat de hoy. Su resultado ya está listo ✨`,
    }),
  };
}

async function hbSendHeartbeatPush({
  actorUid,
  targetUid,
  sessionId,
  relationshipId,
  kind, // 'answered' | 'result_ready'
}) {
  try {
    if (!actorUid || !targetUid) {
      return { ok: false, reason: "MISSING_UID" };
    }

    const allowed = await hbIsHeartbeatPushAllowed(targetUid);
    if (!allowed) {
      return { ok: false, reason: "DISABLED_BY_PREFS" };
    }

    const tokens = await hbGetTokensForUid(targetUid);
    if (!tokens.length) {
      return { ok: false, reason: "NO_TOKENS" };
    }

    const lang = await hbGetUserLang(targetUid);
    const actorPub = await hbGetPublicUser(actorUid);
    const senderName = hbPickSenderName(lang, actorPub);

    const copy =
      kind === "result_ready"
        ? hbHeartbeatResultReadyCopy(lang, senderName)
        : hbHeartbeatAnsweredCopy(lang, senderName);

    const route = "Heartbeat";
    const type =
      kind === "result_ready"
        ? "heartbeat_result_ready"
        : "heartbeat_completed";

    const ffNav = hbBuildFlutterFlowNavData(route, {
      type,
      sessionId: sessionId || "",
      relationshipId: relationshipId || "",
      actorUid,
      targetUid,
    });

    const res = await messaging.sendEachForMulticast({
      tokens,
      notification: {
        title: copy.title,
        body: copy.body,
      },
      data: hbToStringMap({
        type,
        route,
        sessionId: sessionId || "",
        relationshipId: relationshipId || "",
        actorUid,
        targetUid,
        ...ffNav,
      }),
    });

    return {
      ok: true,
      sent: res.successCount || 0,
      failed: res.failureCount || 0,
    };
  } catch (e) {
    console.error("hbSendHeartbeatPush error:", e);
    return {
      ok: false,
      reason: "PUSH_ERROR",
      message: String(e?.message || e),
    };
  }
}

// ---------- submitHeartbeatAnswers ----------

exports.submitHeartbeatAnswers = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    const requestId = hbMakeRequestId();

    try {
      const uid = context?.auth?.uid;
      if (!uid) {
        return {
          ok: false,
          code: "UNAUTHENTICATED",
          message: "You must be signed in.",
          requestId,
          partnerAnswer1: 0,
          partnerAnswer2: 0,
          partnerAnswer3: 0,
        };
      }

      const sessionId = String(data?.sessionId || "").trim();
      const answer1 = hbClampAnswer(data?.answer1);
      const answer2 = hbClampAnswer(data?.answer2);
      const answer3 = hbClampAnswer(data?.answer3);

      if (!sessionId) {
        return {
          ok: false,
          code: "MISSING_SESSION_ID",
          message: "sessionId is required.",
          requestId,
          partnerAnswer1: 0,
          partnerAnswer2: 0,
          partnerAnswer3: 0,
        };
      }

      if ([answer1, answer2, answer3].some((v) => v === null)) {
        return {
          ok: false,
          code: "INVALID_ANSWERS",
          message: "All answers must be integers between 1 and 5.",
          requestId,
          sessionId,
          partnerAnswer1: 0,
          partnerAnswer2: 0,
          partnerAnswer3: 0,
        };
      }

      const sessionRef = db.collection("heartbeat_sessions").doc(sessionId);
      const sessionSnap = await sessionRef.get();

      if (!sessionSnap.exists) {
        return {
          ok: false,
          code: "SESSION_NOT_FOUND",
          message: "Heartbeat session not found.",
          requestId,
          sessionId,
          partnerAnswer1: 0,
          partnerAnswer2: 0,
          partnerAnswer3: 0,
        };
      }

      const session = sessionSnap.data() || {};
      const relationshipId = session.relationship_id || "";
      const partner1Id = session.partner1_id || "";
      const partner2Id = session.partner2_id || "";

      if (uid !== partner1Id && uid !== partner2Id) {
        return {
          ok: false,
          code: "FORBIDDEN",
          message: "You are not part of this heartbeat session.",
          requestId,
          relationshipId,
          sessionId,
          partnerAnswer1: 0,
          partnerAnswer2: 0,
          partnerAnswer3: 0,
        };
      }

      const isPartner1 = uid === partner1Id;
      const alreadyAnswered = isPartner1
        ? session.partner1_answered === true
        : session.partner2_answered === true;

      const expiresAtDate = session?.expires_at?.toDate?.() || new Date();

      if (
        session.status === "expired" ||
        expiresAtDate.getTime() < Date.now()
      ) {
        await sessionRef.set(
          {
            status: "expired",
            can_view_result: false,
            updated_at: admin.firestore.FieldValue.serverTimestamp(),
          },
          { merge: true },
        );

        return {
          ok: false,
          code: "SESSION_EXPIRED",
          message: "This heartbeat session has expired.",
          requestId,
          relationshipId,
          sessionId,
          status: "expired",
          canViewResult: false,
          partnerAnswered: false,
          bothAnswered: false,
          partner1Answered: !!session.partner1_answered,
          partner2Answered: !!session.partner2_answered,
          expiresAt: expiresAtDate.toISOString(),
          remainingToday: 0,
          heartbeatScoreRaw: Number(session.heartbeat_score_raw || 0),
          heartbeatScorePercent: Number(session.heartbeat_score_percent || 0),
          connectionLabelKey: session.connection_label_key || "",
          insightTextDe: session.insight_text_de || "",
          insightTextEn: session.insight_text_en || "",
          insightTextEs: session.insight_text_es || "",
          statusText: "Today’s heartbeat is no longer available.",
          snackText: "Heartbeat expired.",
          waitMinutes: 0,
          partnerAnswer1: 0,
          partnerAnswer2: 0,
          partnerAnswer3: 0,
        };
      }

      if (session.status === "completed") {
        return {
          ok: true,
          code: "ALREADY_COMPLETED",
          message: "This heartbeat session is already completed.",
          requestId,
          relationshipId,
          sessionId,
          status: "completed",
          canViewResult: true,
          partnerAnswered: true,
          bothAnswered: true,
          partner1Answered: !!session.partner1_answered,
          partner2Answered: !!session.partner2_answered,
          expiresAt: expiresAtDate.toISOString(),
          remainingToday: hbMinutesUntilDate(expiresAtDate),
          heartbeatScoreRaw: Number(session.heartbeat_score_raw || 0),
          heartbeatScorePercent: Number(session.heartbeat_score_percent || 0),
          connectionLabelKey: session.connection_label_key || "",
          insightTextDe: session.insight_text_de || "",
          insightTextEn: session.insight_text_en || "",
          insightTextEs: session.insight_text_es || "",
          statusText: "Your heartbeat result is ready.",
          snackText: "Heartbeat already completed.",
          waitMinutes: 0,
          partnerAnswer1: 0,
          partnerAnswer2: 0,
          partnerAnswer3: 0,
        };
      }

      if (alreadyAnswered) {
        return {
          ok: true,
          code: "ALREADY_ANSWERED",
          message: "You already submitted your answers for today.",
          requestId,
          relationshipId,
          sessionId,
          status: session.status || "pending",
          canViewResult: !!session.can_view_result,
          partnerAnswered: true,
          bothAnswered: !!(
            session.partner1_answered && session.partner2_answered
          ),
          partner1Answered: !!session.partner1_answered,
          partner2Answered: !!session.partner2_answered,
          expiresAt: expiresAtDate.toISOString(),
          remainingToday: hbMinutesUntilDate(expiresAtDate),
          heartbeatScoreRaw: Number(session.heartbeat_score_raw || 0),
          heartbeatScorePercent: Number(session.heartbeat_score_percent || 0),
          connectionLabelKey: session.connection_label_key || "",
          insightTextDe: session.insight_text_de || "",
          insightTextEn: session.insight_text_en || "",
          insightTextEs: session.insight_text_es || "",
          statusText: "You already completed your part today.",
          snackText: "You already answered today’s heartbeat.",
          waitMinutes: hbMinutesUntilDate(expiresAtDate),
          partnerAnswer1: 0,
          partnerAnswer2: 0,
          partnerAnswer3: 0,
        };
      }

      const questionRefs = Array.isArray(session.question_refs)
        ? session.question_refs
        : [];

      if (questionRefs.length !== 3) {
        return {
          ok: false,
          code: "INVALID_SESSION_QUESTIONS",
          message:
            "This heartbeat session does not contain exactly 3 questions.",
          requestId,
          relationshipId,
          sessionId,
          partnerAnswer1: 0,
          partnerAnswer2: 0,
          partnerAnswer3: 0,
        };
      }

      const questionDocs = await hbLoadQuestionDocsFromRefs(questionRefs);

      if (questionDocs.length !== 3) {
        return {
          ok: false,
          code: "QUESTION_LOAD_FAILED",
          message: "Could not load all heartbeat questions for this session.",
          requestId,
          relationshipId,
          sessionId,
          partnerAnswer1: 0,
          partnerAnswer2: 0,
          partnerAnswer3: 0,
        };
      }

      const answers = [answer1, answer2, answer3];
      const userAverage = hbWeightedAverage(questionDocs, answers);

      const txResult = await db.runTransaction(async (tx) => {
        const freshSessionSnap = await tx.get(sessionRef);
        if (!freshSessionSnap.exists) {
          throw new Error("Heartbeat session disappeared during transaction.");
        }

        const fresh = freshSessionSnap.data() || {};

        const freshAlreadyAnswered = isPartner1
          ? fresh.partner1_answered === true
          : fresh.partner2_answered === true;

        const freshExpiresAt = fresh?.expires_at?.toDate?.() || new Date();

        if (
          fresh.status === "expired" ||
          freshExpiresAt.getTime() < Date.now()
        ) {
          tx.set(
            sessionRef,
            {
              status: "expired",
              can_view_result: false,
              updated_at: admin.firestore.FieldValue.serverTimestamp(),
            },
            { merge: true },
          );

          return {
            ok: false,
            code: "SESSION_EXPIRED",
            message: "This heartbeat session has expired.",
            requestId,
            relationshipId,
            sessionId,
            status: "expired",
            canViewResult: false,
            partnerAnswered: false,
            bothAnswered: false,
            partner1Answered: !!fresh.partner1_answered,
            partner2Answered: !!fresh.partner2_answered,
            expiresAt: freshExpiresAt.toISOString(),
            remainingToday: 0,
            heartbeatScoreRaw: Number(fresh.heartbeat_score_raw || 0),
            heartbeatScorePercent: Number(fresh.heartbeat_score_percent || 0),
            connectionLabelKey: fresh.connection_label_key || "",
            insightTextDe: fresh.insight_text_de || "",
            insightTextEn: fresh.insight_text_en || "",
            insightTextEs: fresh.insight_text_es || "",
            statusText: "Today’s heartbeat is no longer available.",
            snackText: "Heartbeat expired.",
            waitMinutes: 0,
            partnerAnswer1: 0,
            partnerAnswer2: 0,
            partnerAnswer3: 0,
          };
        }

        if (fresh.status === "completed") {
          return {
            ok: true,
            code: "ALREADY_COMPLETED",
            message: "This heartbeat session is already completed.",
            requestId,
            relationshipId,
            sessionId,
            status: "completed",
            canViewResult: true,
            partnerAnswered: true,
            bothAnswered: true,
            partner1Answered: !!fresh.partner1_answered,
            partner2Answered: !!fresh.partner2_answered,
            expiresAt: freshExpiresAt.toISOString(),
            remainingToday: hbMinutesUntilDate(freshExpiresAt),
            heartbeatScoreRaw: Number(fresh.heartbeat_score_raw || 0),
            heartbeatScorePercent: Number(fresh.heartbeat_score_percent || 0),
            connectionLabelKey: fresh.connection_label_key || "",
            insightTextDe: fresh.insight_text_de || "",
            insightTextEn: fresh.insight_text_en || "",
            insightTextEs: fresh.insight_text_es || "",
            statusText: "Your heartbeat result is ready.",
            snackText: "Heartbeat already completed.",
            waitMinutes: 0,
            partnerAnswer1: 0,
            partnerAnswer2: 0,
            partnerAnswer3: 0,
          };
        }

        if (freshAlreadyAnswered) {
          return {
            ok: true,
            code: "ALREADY_ANSWERED",
            message: "You already submitted your answers for today.",
            requestId,
            relationshipId,
            sessionId,
            status: fresh.status || "pending",
            canViewResult: !!fresh.can_view_result,
            partnerAnswered: true,
            bothAnswered: !!(
              fresh.partner1_answered && fresh.partner2_answered
            ),
            partner1Answered: !!fresh.partner1_answered,
            partner2Answered: !!fresh.partner2_answered,
            expiresAt: freshExpiresAt.toISOString(),
            remainingToday: hbMinutesUntilDate(freshExpiresAt),
            heartbeatScoreRaw: Number(fresh.heartbeat_score_raw || 0),
            heartbeatScorePercent: Number(fresh.heartbeat_score_percent || 0),
            connectionLabelKey: fresh.connection_label_key || "",
            insightTextDe: fresh.insight_text_de || "",
            insightTextEn: fresh.insight_text_en || "",
            insightTextEs: fresh.insight_text_es || "",
            statusText: "You already completed your part today.",
            snackText: "You already answered today’s heartbeat.",
            waitMinutes: hbMinutesUntilDate(freshExpiresAt),
            partnerAnswer1: 0,
            partnerAnswer2: 0,
            partnerAnswer3: 0,
          };
        }

        const partnerUid = isPartner1 ? partner2Id : partner1Id;

        // ---------- ALL READS FIRST ----------
        const partnerAnswerRef1 = db
          .collection("heartbeat_answers")
          .doc(`${sessionId}_${partnerUid}_q1`);
        const partnerAnswerRef2 = db
          .collection("heartbeat_answers")
          .doc(`${sessionId}_${partnerUid}_q2`);
        const partnerAnswerRef3 = db
          .collection("heartbeat_answers")
          .doc(`${sessionId}_${partnerUid}_q3`);

        const dayKey = String(fresh.session_date_key || "");
        const sortedUids = [partner1Id, partner2Id].filter(Boolean).sort();
        const awardUserA = sortedUids[0] || "";
        const awardUserB = sortedUids[1] || "";
        const awardId = `${relationshipId}_HEARTBEAT_PAIR_${dayKey}_${awardUserA}_${awardUserB}`;
        const awardRef = db.collection(LOVE_AWARDS_COL).doc(awardId);

        const relViewARef = db.collection(REL_VIEWS_COL).doc(partner1Id);
        const relViewBRef = db.collection(REL_VIEWS_COL).doc(partner2Id);

        const [
          partnerSnap1,
          partnerSnap2,
          partnerSnap3,
          awardSnap,
          relViewASnap,
          relViewBSnap,
        ] = await Promise.all([
          tx.get(partnerAnswerRef1),
          tx.get(partnerAnswerRef2),
          tx.get(partnerAnswerRef3),
          tx.get(awardRef),
          tx.get(relViewARef),
          tx.get(relViewBRef),
        ]);

        const partnerAnswer1 = Number(
          partnerSnap1.exists ? partnerSnap1.data()?.answer_value || 0 : 0,
        );
        const partnerAnswer2 = Number(
          partnerSnap2.exists ? partnerSnap2.data()?.answer_value || 0 : 0,
        );
        const partnerAnswer3 = Number(
          partnerSnap3.exists ? partnerSnap3.data()?.answer_value || 0 : 0,
        );

        // ---------- COMPUTE ----------
        const nextPartner1Answered = isPartner1
          ? true
          : !!fresh.partner1_answered;
        const nextPartner2Answered = isPartner1
          ? !!fresh.partner2_answered
          : true;

        const nextPartner1Average = isPartner1
          ? userAverage
          : Number(fresh.partner1_average || 0);

        const nextPartner2Average = isPartner1
          ? Number(fresh.partner2_average || 0)
          : userAverage;

        const bothAnswered = nextPartner1Answered && nextPartner2Answered;

        let awardedInThisCall = false;
        let nextHeartbeatRaw = 0;
        let nextHeartbeatPercent = 0;
        let nextLabelKey = "";
        let nextInsights = { de: "", en: "", es: "" };

        if (bothAnswered) {
          nextHeartbeatRaw = Number(
            ((nextPartner1Average + nextPartner2Average) / 2).toFixed(2),
          );
          nextHeartbeatPercent = hbPercentFromRaw(nextHeartbeatRaw);
          nextLabelKey = hbConnectionLabelKey(nextHeartbeatPercent);
          nextInsights = hbInsightTexts(nextLabelKey);
        }

        // ---------- WRITES START HERE ----------

        for (let i = 0; i < questionDocs.length; i++) {
          const order = i + 1;
          const q = questionDocs[i];
          const answerRef = db
            .collection("heartbeat_answers")
            .doc(`${sessionId}_${uid}_q${order}`);

          tx.set(
            answerRef,
            {
              relationship_id: relationshipId,
              session_ref: sessionRef,
              user_id: uid,
              question_ref: q.ref,
              question_key: q.question_key || `question_${order}`,
              answer_value: answers[i],
              question_order: order,
              created_at: admin.firestore.FieldValue.serverTimestamp(),
            },
            { merge: true },
          );
        }

        if (!bothAnswered) {
          tx.set(
            sessionRef,
            {
              partner1_answered: nextPartner1Answered,
              partner2_answered: nextPartner2Answered,
              partner1_average: nextPartner1Average,
              partner2_average: nextPartner2Average,
              status: "pending",
              can_view_result: false,
              updated_at: admin.firestore.FieldValue.serverTimestamp(),
            },
            { merge: true },
          );

          return {
            ok: true,
            code: "ANSWERS_SAVED_PENDING",
            message:
              "Your heartbeat answers were saved. Waiting for your partner.",
            requestId,
            relationshipId,
            sessionId,
            status: "pending",
            canViewResult: false,
            partnerAnswered: true,
            bothAnswered: false,
            partner1Answered: nextPartner1Answered,
            partner2Answered: nextPartner2Answered,
            expiresAt: freshExpiresAt.toISOString(),
            remainingToday: hbMinutesUntilDate(freshExpiresAt),
            heartbeatScoreRaw: 0,
            heartbeatScorePercent: 0,
            connectionLabelKey: "",
            insightTextDe: "",
            insightTextEn: "",
            insightTextEs: "",
            statusText:
              "You completed your part. Now it’s your partner’s turn.",
            snackText: "Heartbeat saved. Waiting for your partner.",
            waitMinutes: hbMinutesUntilDate(freshExpiresAt),
            partnerAnswer1: 0,
            partnerAnswer2: 0,
            partnerAnswer3: 0,
            pushTargetUid: partnerUid,
            pushKind: "answered",
            shouldSendPartnerPush: true,
            awarded: false,
            points: 0,
          };
        }

        if (!awardSnap.exists && partner1Id && partner2Id && dayKey) {
          awardedInThisCall = true;

          const vA = relViewASnap.exists ? relViewASnap.data() || {} : {};
          const vB = relViewBSnap.exists ? relViewBSnap.data() || {} : {};

          const aScore = hbClamp(
            Number(vA.love_score ?? 65) + HEARTBEAT_POINTS,
            0,
            100,
          );
          const bScore = hbClamp(
            Number(vB.love_score ?? 65) + HEARTBEAT_POINTS,
            0,
            100,
          );

          tx.set(awardRef, {
            relationship_id: relationshipId,
            type: "HEARTBEAT_PAIR",
            points: HEARTBEAT_POINTS,
            day_key: dayKey,
            week_key: "",
            actor_uid: uid,
            userA_id: awardUserA,
            userB_id: awardUserB,
            created_at: admin.firestore.FieldValue.serverTimestamp(),
            meta: {
              session_id: sessionId,
            },
          });

          tx.set(
            relViewARef,
            {
              love_score: aScore,
              love_percent: aScore / 100,
              love_state: hbLoveStateFromScore(aScore),
              love_last_update: admin.firestore.FieldValue.serverTimestamp(),
              love_today_points:
                admin.firestore.FieldValue.increment(HEARTBEAT_POINTS),
              updated_at: admin.firestore.FieldValue.serverTimestamp(),
            },
            { merge: true },
          );

          tx.set(
            relViewBRef,
            {
              love_score: bScore,
              love_percent: bScore / 100,
              love_state: hbLoveStateFromScore(bScore),
              love_last_update: admin.firestore.FieldValue.serverTimestamp(),
              love_today_points:
                admin.firestore.FieldValue.increment(HEARTBEAT_POINTS),
              updated_at: admin.firestore.FieldValue.serverTimestamp(),
            },
            { merge: true },
          );
        }

        tx.set(
          sessionRef,
          {
            partner1_answered: nextPartner1Answered,
            partner2_answered: nextPartner2Answered,
            partner1_average: nextPartner1Average,
            partner2_average: nextPartner2Average,
            heartbeat_score_raw: nextHeartbeatRaw,
            heartbeat_score_percent: nextHeartbeatPercent,
            connection_label_key: nextLabelKey,
            insight_text_de: nextInsights.de,
            insight_text_en: nextInsights.en,
            insight_text_es: nextInsights.es,
            status: "completed",
            can_view_result: true,
            updated_at: admin.firestore.FieldValue.serverTimestamp(),
          },
          { merge: true },
        );

        return {
          ok: true,
          code: "SESSION_COMPLETED",
          message: "Heartbeat completed successfully.",
          requestId,
          relationshipId,
          sessionId,
          status: "completed",
          canViewResult: true,
          partnerAnswered: true,
          bothAnswered: true,
          partner1Answered: nextPartner1Answered,
          partner2Answered: nextPartner2Answered,
          expiresAt: freshExpiresAt.toISOString(),
          remainingToday: hbMinutesUntilDate(freshExpiresAt),
          heartbeatScoreRaw: nextHeartbeatRaw,
          heartbeatScorePercent: nextHeartbeatPercent,
          connectionLabelKey: nextLabelKey,
          insightTextDe: nextInsights.de,
          insightTextEn: nextInsights.en,
          insightTextEs: nextInsights.es,
          statusText: "Your heartbeat result is ready.",
          snackText: "Heartbeat completed.",
          waitMinutes: 0,
          partnerAnswer1,
          partnerAnswer2,
          partnerAnswer3,
          shouldSendPartnerPush: true,
          pushTargetUid: partnerUid,
          pushKind: "result_ready",
          awarded: awardedInThisCall,
          points: awardedInThisCall ? HEARTBEAT_POINTS : 0,
        };
      });

      if (
        txResult?.ok === true &&
        txResult?.shouldSendPartnerPush === true &&
        hbNonEmptyString(txResult?.pushTargetUid)
      ) {
        await hbSendHeartbeatPush({
          actorUid: uid,
          targetUid: txResult.pushTargetUid,
          sessionId,
          relationshipId,
          kind: txResult.pushKind || "answered",
        });
      }

      if (txResult && typeof txResult === "object") {
        delete txResult.shouldSendPartnerPush;
        delete txResult.pushTargetUid;
        delete txResult.pushKind;
      }

      return txResult;
    } catch (e) {
      console.error("submitHeartbeatAnswers error:", e);

      return {
        ok: false,
        code: "INTERNAL",
        message: String(e?.message || e),
        requestId,
        partnerAnswer1: 0,
        partnerAnswer2: 0,
        partnerAnswer3: 0,
      };
    }
  });
