const functions = require("firebase-functions");
const admin = require("firebase-admin");
try {
  admin.app();
} catch {
  admin.initializeApp();
}

const db = admin.firestore();

const REGION = "europe-west3";
const HEARTBEAT_SESSIONS_COLLECTION = "heartbeat_sessions";
const HEARTBEAT_ANSWERS_COLLECTION = "heartbeat_answers";
const USERS_COLLECTION = "Users";
const RELATIONSHIPS_COLLECTION = "relationships";

function ghbMakeRequestId() {
  return `${Date.now()}_${Math.random().toString(36).slice(2, 10)}`;
}

function ghbGetTodayKeyUtc(date = new Date()) {
  const y = date.getUTCFullYear();
  const m = String(date.getUTCMonth() + 1).padStart(2, "0");
  const d = String(date.getUTCDate()).padStart(2, "0");
  return `${y}-${m}-${d}`;
}

function ghbMinutesUntil(date) {
  const ms = date.getTime() - Date.now();
  return Math.max(0, Math.ceil(ms / 60000));
}

async function ghbResolveRelationshipIdForUser(uid, explicitRelationshipId) {
  if (explicitRelationshipId) return explicitRelationshipId;

  const userSnap = await db.collection(USERS_COLLECTION).doc(uid).get();
  if (!userSnap.exists) return null;

  const user = userSnap.data() || {};
  return user.relationship_id || user.relationshipId || null;
}

async function ghbResolveRelationshipByIdOrField(relationshipId) {
  const byDocRef = db.collection(RELATIONSHIPS_COLLECTION).doc(relationshipId);
  const byDocSnap = await byDocRef.get();
  if (byDocSnap.exists) {
    return { ref: byDocRef, snap: byDocSnap, data: byDocSnap.data() || {} };
  }

  const q = await db
    .collection(RELATIONSHIPS_COLLECTION)
    .where("relationship_id", "==", relationshipId)
    .limit(1)
    .get();

  if (!q.empty) {
    const doc = q.docs[0];
    return { ref: doc.ref, snap: doc, data: doc.data() || {} };
  }

  return null;
}

function ghbGetRelationshipMembers(rel = {}) {
  const userA = rel.userA_id || rel.userAId || rel.userA || null;
  const userB = rel.userB_id || rel.userBId || rel.userB || null;
  return [userA, userB].filter(Boolean);
}

async function ghbLoadQuestionsByRefs(questionRefs = []) {
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

function ghbMapQuestionForClient(doc, order) {
  return {
    id: doc.id,
    order,
    questionRefPath: doc.ref.path,
    questionKey: doc.question_key || "",
    category: doc.category || "",
    questionTextDe: doc.question_text_de || "",
    questionTextEn: doc.question_text_en || "",
    questionTextEs: doc.question_text_es || "",
    answerType: doc.answer_type || "scale_1_5",
    weight: typeof doc.weight === "number" ? doc.weight : 1.0,
  };
}

async function ghbLoadUserAnswersForSession(sessionId, userId) {
  if (!sessionId || !userId) {
    return {
      answer1: 0,
      answer2: 0,
      answer3: 0,
    };
  }

  const ref1 = db
    .collection(HEARTBEAT_ANSWERS_COLLECTION)
    .doc(`${sessionId}_${userId}_q1`);
  const ref2 = db
    .collection(HEARTBEAT_ANSWERS_COLLECTION)
    .doc(`${sessionId}_${userId}_q2`);
  const ref3 = db
    .collection(HEARTBEAT_ANSWERS_COLLECTION)
    .doc(`${sessionId}_${userId}_q3`);

  const [snap1, snap2, snap3] = await Promise.all([
    ref1.get(),
    ref2.get(),
    ref3.get(),
  ]);

  return {
    answer1: Number(snap1.exists ? snap1.data()?.answer_value || 0 : 0),
    answer2: Number(snap2.exists ? snap2.data()?.answer_value || 0 : 0),
    answer3: Number(snap3.exists ? snap3.data()?.answer_value || 0 : 0),
  };
}

exports.getHeartbeatSession = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    const requestId = ghbMakeRequestId();

    try {
      const uid = context?.auth?.uid;
      if (!uid) {
        return {
          ok: false,
          code: "UNAUTHENTICATED",
          message: "You must be signed in.",
          requestId,

          question1TextEn: "",
          question2TextEn: "",
          question3TextEn: "",
          question1TextDe: "",
          question2TextDe: "",
          question3TextDe: "",
          question1TextEs: "",
          question2TextEs: "",
          question3TextEs: "",

          partnerAnswer1: 0,
          partnerAnswer2: 0,
          partnerAnswer3: 0,
        };
      }

      const explicitRelationshipId =
        data?.relationshipId || data?.relationship_id || null;

      const relationshipId = await ghbResolveRelationshipIdForUser(
        uid,
        explicitRelationshipId,
      );

      if (!relationshipId) {
        return {
          ok: false,
          code: "NO_RELATIONSHIP",
          message: "No active relationship found for this user.",
          requestId,

          question1TextEn: "",
          question2TextEn: "",
          question3TextEn: "",
          question1TextDe: "",
          question2TextDe: "",
          question3TextDe: "",
          question1TextEs: "",
          question2TextEs: "",
          question3TextEs: "",

          partnerAnswer1: 0,
          partnerAnswer2: 0,
          partnerAnswer3: 0,
        };
      }

      const relResolved =
        await ghbResolveRelationshipByIdOrField(relationshipId);
      if (!relResolved) {
        return {
          ok: false,
          code: "RELATIONSHIP_NOT_FOUND",
          message: "Relationship could not be found.",
          requestId,
          relationshipId,

          question1TextEn: "",
          question2TextEn: "",
          question3TextEn: "",
          question1TextDe: "",
          question2TextDe: "",
          question3TextDe: "",
          question1TextEs: "",
          question2TextEs: "",
          question3TextEs: "",

          partnerAnswer1: 0,
          partnerAnswer2: 0,
          partnerAnswer3: 0,
        };
      }

      const rel = relResolved.data || {};
      const members = ghbGetRelationshipMembers(rel);

      if (!members.includes(uid)) {
        return {
          ok: false,
          code: "FORBIDDEN",
          message: "You are not a member of this relationship.",
          requestId,
          relationshipId,

          question1TextEn: "",
          question2TextEn: "",
          question3TextEn: "",
          question1TextDe: "",
          question2TextDe: "",
          question3TextDe: "",
          question1TextEs: "",
          question2TextEs: "",
          question3TextEs: "",

          partnerAnswer1: 0,
          partnerAnswer2: 0,
          partnerAnswer3: 0,
        };
      }

      if (rel.active === false) {
        return {
          ok: false,
          code: "RELATIONSHIP_INACTIVE",
          message: "This relationship is not active.",
          requestId,
          relationshipId,

          question1TextEn: "",
          question2TextEn: "",
          question3TextEn: "",
          question1TextDe: "",
          question2TextDe: "",
          question3TextDe: "",
          question1TextEs: "",
          question2TextEs: "",
          question3TextEs: "",

          partnerAnswer1: 0,
          partnerAnswer2: 0,
          partnerAnswer3: 0,
        };
      }

      const todayKey = ghbGetTodayKeyUtc(new Date());
      const sessionDocId = `${relationshipId}_${todayKey}`;
      const sessionRef = db
        .collection(HEARTBEAT_SESSIONS_COLLECTION)
        .doc(sessionDocId);
      const sessionSnap = await sessionRef.get();

      if (!sessionSnap.exists) {
        return {
          ok: true,
          code: "NO_SESSION_TODAY",
          message: "No heartbeat session exists for today.",
          requestId,
          relationshipId,
          sessionId: "",
          sessionRefPath: "",
          status: "",
          canViewResult: false,
          exists: false,
          currentUserAnswered: false,
          partnerAnswered: false,
          bothAnswered: false,
          partner1Answered: false,
          partner2Answered: false,
          expiresAt: "",
          remainingToday: 0,
          heartbeatScoreRaw: 0,
          heartbeatScorePercent: 0,
          connectionLabelKey: "",
          insightTextDe: "",
          insightTextEn: "",
          insightTextEs: "",
          statusText: "No heartbeat started yet today.",
          snackText: "No heartbeat session for today.",

          question1TextEn: "",
          question2TextEn: "",
          question3TextEn: "",
          question1TextDe: "",
          question2TextDe: "",
          question3TextDe: "",
          question1TextEs: "",
          question2TextEs: "",
          question3TextEs: "",

          partnerAnswer1: 0,
          partnerAnswer2: 0,
          partnerAnswer3: 0,

          questions: [],
        };
      }

      const session = sessionSnap.data() || {};
      const questionRefs = Array.isArray(session.question_refs)
        ? session.question_refs
        : [];
      const questionDocs = await ghbLoadQuestionsByRefs(questionRefs);

      const expiresAtDate = session?.expires_at?.toDate?.() || new Date();

      let status = session.status || "pending";
      const isExpiredByTime = expiresAtDate.getTime() < Date.now();

      if (status !== "completed" && isExpiredByTime) {
        await sessionRef.set(
          {
            status: "expired",
            can_view_result: false,
            updated_at: admin.firestore.FieldValue.serverTimestamp(),
          },
          { merge: true },
        );
        status = "expired";
      }

      const partner1Id = session.partner1_id || "";
      const partner2Id = session.partner2_id || "";
      const partner1Answered = !!session.partner1_answered;
      const partner2Answered = !!session.partner2_answered;

      const currentUserIsPartner1 = uid === partner1Id;
      const currentUserAnswered = currentUserIsPartner1
        ? partner1Answered
        : partner2Answered;
      const partnerAnswered = currentUserIsPartner1
        ? partner2Answered
        : partner1Answered;
      const bothAnswered = partner1Answered && partner2Answered;

      const partnerUid = currentUserIsPartner1 ? partner2Id : partner1Id;
      const partnerAnswers = await ghbLoadUserAnswersForSession(
        sessionRef.id,
        partnerUid,
      );

      const q1 = questionDocs[0] || null;
      const q2 = questionDocs[1] || null;
      const q3 = questionDocs[2] || null;

      return {
        ok: true,
        code: "SESSION_FOUND",
        message: "Heartbeat session loaded.",
        requestId,
        relationshipId,
        sessionId: sessionRef.id,
        sessionRefPath: sessionRef.path,
        status,
        canViewResult:
          status === "completed" ? true : !!session.can_view_result,
        exists: true,
        currentUserAnswered,
        partnerAnswered,
        bothAnswered,
        partner1Answered,
        partner2Answered,
        expiresAt: expiresAtDate.toISOString(),
        remainingToday:
          status === "expired" ? 0 : ghbMinutesUntil(expiresAtDate),
        heartbeatScoreRaw: Number(session.heartbeat_score_raw || 0),
        heartbeatScorePercent: Number(session.heartbeat_score_percent || 0),
        connectionLabelKey: session.connection_label_key || "",
        insightTextDe: session.insight_text_de || "",
        insightTextEn: session.insight_text_en || "",
        insightTextEs: session.insight_text_es || "",
        statusText:
          status === "completed"
            ? "Your heartbeat result is ready."
            : status === "expired"
              ? "Today’s heartbeat is no longer available."
              : currentUserAnswered
                ? "You completed your part. Waiting for your partner."
                : "Your heartbeat is ready to answer.",
        snackText:
          status === "completed"
            ? "Heartbeat result ready."
            : status === "expired"
              ? "Heartbeat expired."
              : currentUserAnswered
                ? "Waiting for your partner."
                : "Heartbeat ready.",

        question1TextEn: q1?.question_text_en || "",
        question2TextEn: q2?.question_text_en || "",
        question3TextEn: q3?.question_text_en || "",
        question1TextDe: q1?.question_text_de || "",
        question2TextDe: q2?.question_text_de || "",
        question3TextDe: q3?.question_text_de || "",
        question1TextEs: q1?.question_text_es || "",
        question2TextEs: q2?.question_text_es || "",
        question3TextEs: q3?.question_text_es || "",

        partnerAnswer1: partnerAnswers.answer1,
        partnerAnswer2: partnerAnswers.answer2,
        partnerAnswer3: partnerAnswers.answer3,

        questions: questionDocs.map((q, index) =>
          ghbMapQuestionForClient(q, index + 1),
        ),
      };
    } catch (e) {
      console.error("getHeartbeatSession error:", e);

      return {
        ok: false,
        code: "INTERNAL",
        message: String(e?.message || e),
        requestId,

        question1TextEn: "",
        question2TextEn: "",
        question3TextEn: "",
        question1TextDe: "",
        question2TextDe: "",
        question3TextDe: "",
        question1TextEs: "",
        question2TextEs: "",
        question3TextEs: "",

        partnerAnswer1: 0,
        partnerAnswer2: 0,
        partnerAnswer3: 0,
      };
    }
  });
