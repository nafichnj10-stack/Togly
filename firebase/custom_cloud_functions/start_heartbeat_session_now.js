const functions = require("firebase-functions");
const admin = require("firebase-admin");
try {
  admin.app();
} catch {
  admin.initializeApp();
}

const db = admin.firestore();

const REGION = "europe-west3";
const HEARTBEAT_QUESTIONS_COLLECTION = "heartbeat_questions";
const HEARTBEAT_SESSIONS_COLLECTION = "heartbeat_sessions";
const RELATIONSHIPS_COLLECTION = "relationships";
const USERS_COLLECTION = "Users";

function makeRequestId() {
  return `${Date.now()}_${Math.random().toString(36).slice(2, 10)}`;
}

function getUtcDateParts(date = new Date()) {
  const y = date.getUTCFullYear();
  const m = String(date.getUTCMonth() + 1).padStart(2, "0");
  const d = String(date.getUTCDate()).padStart(2, "0");
  return { y, m, d };
}

function getTodayKeyUtc(date = new Date()) {
  const { y, m, d } = getUtcDateParts(date);
  return `${y}-${m}-${d}`;
}

function getStartOfDayUtc(date = new Date()) {
  return new Date(
    Date.UTC(
      date.getUTCFullYear(),
      date.getUTCMonth(),
      date.getUTCDate(),
      0,
      0,
      0,
      0,
    ),
  );
}

function getEndOfDayUtc(date = new Date()) {
  return new Date(
    Date.UTC(
      date.getUTCFullYear(),
      date.getUTCMonth(),
      date.getUTCDate(),
      23,
      59,
      59,
      999,
    ),
  );
}

function minutesUntil(date) {
  const ms = date.getTime() - Date.now();
  return Math.max(0, Math.ceil(ms / 60000));
}

function shuffle(arr) {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

async function resolveRelationshipByIdOrField(relationshipId) {
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

function getRelationshipMembers(rel = {}) {
  const userA = rel.userA_id || rel.userAId || rel.userA || null;

  const userB = rel.userB_id || rel.userBId || rel.userB || null;

  return [userA, userB].filter(Boolean);
}

async function resolveRelationshipIdForUser(uid, explicitRelationshipId) {
  if (explicitRelationshipId) return explicitRelationshipId;

  const userSnap = await db.collection(USERS_COLLECTION).doc(uid).get();
  if (!userSnap.exists) return null;

  const user = userSnap.data() || {};
  return user.relationship_id || user.relationshipId || null;
}

async function getRandomActiveQuestions(limit = 3) {
  const snap = await db
    .collection(HEARTBEAT_QUESTIONS_COLLECTION)
    .where("is_active", "==", true)
    .get();

  if (snap.empty || snap.size < limit) {
    throw new Error(
      `Not enough active heartbeat questions. Need at least ${limit}.`,
    );
  }

  const shuffled = shuffle(snap.docs);
  return shuffled.slice(0, limit);
}

async function loadQuestionsByRefs(questionRefs = []) {
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

function mapQuestionForClient(doc, order) {
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

exports.startHeartbeatSessionNow = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    const requestId = makeRequestId();

    try {
      const uid = context?.auth?.uid;
      if (!uid) {
        return {
          ok: false,
          code: "UNAUTHENTICATED",
          message: "You must be signed in.",
          requestId,
          questionCount: 0,
          debugQuestion0En: "",
          debugQuestion0De: "",
          debugQuestion0Es: "",
          question1TextEn: "",
          question2TextEn: "",
          question3TextEn: "",
          question1TextDe: "",
          question2TextDe: "",
          question3TextDe: "",
          question1TextEs: "",
          question2TextEs: "",
          question3TextEs: "",
        };
      }

      const explicitRelationshipId =
        data?.relationshipId || data?.relationship_id || null;

      const relationshipId = await resolveRelationshipIdForUser(
        uid,
        explicitRelationshipId,
      );

      if (!relationshipId) {
        return {
          ok: false,
          code: "NO_RELATIONSHIP",
          message: "No active relationship found for this user.",
          requestId,
          questionCount: 0,
          debugQuestion0En: "",
          debugQuestion0De: "",
          debugQuestion0Es: "",
          question1TextEn: "",
          question2TextEn: "",
          question3TextEn: "",
          question1TextDe: "",
          question2TextDe: "",
          question3TextDe: "",
          question1TextEs: "",
          question2TextEs: "",
          question3TextEs: "",
        };
      }

      const relResolved = await resolveRelationshipByIdOrField(relationshipId);
      if (!relResolved) {
        return {
          ok: false,
          code: "RELATIONSHIP_NOT_FOUND",
          message: "Relationship could not be found.",
          requestId,
          relationshipId,
          questionCount: 0,
          debugQuestion0En: "",
          debugQuestion0De: "",
          debugQuestion0Es: "",
          question1TextEn: "",
          question2TextEn: "",
          question3TextEn: "",
          question1TextDe: "",
          question2TextDe: "",
          question3TextDe: "",
          question1TextEs: "",
          question2TextEs: "",
          question3TextEs: "",
        };
      }

      const rel = relResolved.data || {};
      const members = getRelationshipMembers(rel);

      if (!members.includes(uid)) {
        return {
          ok: false,
          code: "FORBIDDEN",
          message: "You are not a member of this relationship.",
          requestId,
          relationshipId,
          questionCount: 0,
          debugQuestion0En: "",
          debugQuestion0De: "",
          debugQuestion0Es: "",
          question1TextEn: "",
          question2TextEn: "",
          question3TextEn: "",
          question1TextDe: "",
          question2TextDe: "",
          question3TextDe: "",
          question1TextEs: "",
          question2TextEs: "",
          question3TextEs: "",
        };
      }

      if (rel.active === false) {
        return {
          ok: false,
          code: "RELATIONSHIP_INACTIVE",
          message: "This relationship is not active.",
          requestId,
          relationshipId,
          questionCount: 0,
          debugQuestion0En: "",
          debugQuestion0De: "",
          debugQuestion0Es: "",
          question1TextEn: "",
          question2TextEn: "",
          question3TextEn: "",
          question1TextDe: "",
          question2TextDe: "",
          question3TextDe: "",
          question1TextEs: "",
          question2TextEs: "",
          question3TextEs: "",
        };
      }

      const now = new Date();
      const todayKey = getTodayKeyUtc(now);
      const startOfDay = getStartOfDayUtc(now);
      const endOfDay = getEndOfDayUtc(now);

      const sessionDocId = `${relationshipId}_${todayKey}`;
      const sessionRef = db
        .collection(HEARTBEAT_SESSIONS_COLLECTION)
        .doc(sessionDocId);

      let created = false;
      let sessionData = null;
      let questionDocs = [];

      await db.runTransaction(async (tx) => {
        const existingSnap = await tx.get(sessionRef);

        if (existingSnap.exists) {
          sessionData = existingSnap.data() || {};
          return;
        }

        const pickedQuestions = await getRandomActiveQuestions(3);
        questionDocs = pickedQuestions.map((d) => ({
          id: d.id,
          ref: d.ref,
          ...(d.data() || {}),
        }));

        const partner1Id = members[0] || "";
        const partner2Id = members[1] || "";

        sessionData = {
          session_id: sessionDocId,

          relationship_id: relationshipId,
          partner1_id: partner1Id,
          partner2_id: partner2Id,

          session_date: admin.firestore.Timestamp.fromDate(startOfDay),
          session_date_key: todayKey,

          question_refs: pickedQuestions.map((q) => q.ref),

          partner1_answered: false,
          partner2_answered: false,

          partner1_average: 0,
          partner2_average: 0,

          heartbeat_score_raw: 0,
          heartbeat_score_percent: 0,

          connection_label_key: "",
          insight_text_de: "",
          insight_text_en: "",
          insight_text_es: "",

          status: "pending",
          can_view_result: false,

          expires_at: admin.firestore.Timestamp.fromDate(endOfDay),
          created_at: admin.firestore.FieldValue.serverTimestamp(),
          updated_at: admin.firestore.FieldValue.serverTimestamp(),
        };

        tx.set(sessionRef, sessionData);
        created = true;
      });

      if (!created) {
        const refs = Array.isArray(sessionData?.question_refs)
          ? sessionData.question_refs
          : [];
        questionDocs = await loadQuestionsByRefs(refs);
      }

      const expiresAtDate = sessionData?.expires_at?.toDate?.() || endOfDay;

      const q0 = questionDocs[0] || null;
      const q1 = questionDocs[1] || null;
      const q2 = questionDocs[2] || null;

      return {
        ok: true,
        code: created ? "SESSION_CREATED" : "SESSION_READY",
        message: created
          ? "Heartbeat session created."
          : "Today’s heartbeat session already exists.",
        requestId,

        relationshipId,
        sessionId: sessionRef.id,
        sessionRefPath: sessionRef.path,

        status: sessionData?.status || "pending",
        expiresAt: expiresAtDate.toISOString(),
        remainingToday: minutesUntil(expiresAtDate),

        created,
        statusText: created
          ? "Your heartbeat is ready."
          : "Today’s heartbeat is already ready.",
        snackText: created
          ? "Heartbeat session started."
          : "You already have a heartbeat session for today.",
        waitMinutes: 0,

        questionCount: questionDocs.length,
        debugQuestion0En: q0?.question_text_en || "",
        debugQuestion0De: q0?.question_text_de || "",
        debugQuestion0Es: q0?.question_text_es || "",

        question1TextEn: q0?.question_text_en || "",
        question2TextEn: q1?.question_text_en || "",
        question3TextEn: q2?.question_text_en || "",

        question1TextDe: q0?.question_text_de || "",
        question2TextDe: q1?.question_text_de || "",
        question3TextDe: q2?.question_text_de || "",

        question1TextEs: q0?.question_text_es || "",
        question2TextEs: q1?.question_text_es || "",
        question3TextEs: q2?.question_text_es || "",

        questions: questionDocs.map((q, index) =>
          mapQuestionForClient(q, index + 1),
        ),
      };
    } catch (e) {
      console.error("startHeartbeatSessionNow error:", e);

      return {
        ok: false,
        code: "INTERNAL",
        message: String(e?.message || e),
        requestId,
        questionCount: 0,
        debugQuestion0En: "",
        debugQuestion0De: "",
        debugQuestion0Es: "",
        question1TextEn: "",
        question2TextEn: "",
        question3TextEn: "",
        question1TextDe: "",
        question2TextDe: "",
        question3TextDe: "",
        question1TextEs: "",
        question2TextEs: "",
        question3TextEs: "",
      };
    }
  });
