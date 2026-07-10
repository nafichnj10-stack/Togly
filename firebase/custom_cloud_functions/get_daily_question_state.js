const functions = require("firebase-functions");
const admin = require("firebase-admin");
// Do NOT call admin.initializeApp() in FlutterFlow Cloud Functions

function pad2(n) {
  return n < 10 ? `0${n}` : `${n}`;
}

function utcDayKey(date) {
  const y = date.getUTCFullYear();
  const m = pad2(date.getUTCMonth() + 1);
  const d = pad2(date.getUTCDate());
  return `${y}${m}${d}`; // yyyyMMdd
}

function startOfTodayUtc(now) {
  return new Date(
    Date.UTC(
      now.getUTCFullYear(),
      now.getUTCMonth(),
      now.getUTCDate(),
      0,
      0,
      0,
    ),
  );
}

function startOfTomorrowUtc(now) {
  const t = startOfTodayUtc(now);
  t.setUTCDate(t.getUTCDate() + 1);
  return t;
}

// canonical A/B ordering to avoid flip-flop between users
function canonicalPair(uid1, uid2) {
  if (!uid1 || !uid2) return { userA: uid1, userB: uid2 };
  return uid1 < uid2
    ? { userA: uid1, userB: uid2 }
    : { userA: uid2, userB: uid1 };
}

exports.getDailyQuestionState = functions
  .region("europe-west3")
  .https.onCall(async (data, context) => {
    try {
      if (!context.auth) {
        return {
          ok: false,
          code: "UNAUTHENTICATED",
          message: "User not authenticated.",
          state: "ERROR",
        };
      }

      const uid = context.auth.uid;
      const db = admin.firestore();

      // ---- relationship_views (source of truth) ----
      const relViewSnap = await db
        .collection("relationship_views")
        .doc(uid)
        .get();
      if (!relViewSnap.exists) {
        return {
          ok: false,
          code: "NO_RELATIONSHIP",
          message: "No active relationship found.",
          state: "NO_RELATIONSHIP",
        };
      }

      const relView = relViewSnap.data() || {};
      const relationshipId = (relView.relationship_id || "").toString();
      const partnerUid = (relView.partner_uid || "").toString();

      if (!relationshipId || !partnerUid) {
        return {
          ok: false,
          code: "NO_RELATIONSHIP",
          message: "Relationship view is incomplete.",
          state: "NO_RELATIONSHIP",
        };
      }

      // ---- today question (UTC day window) ----
      const now = new Date();
      const todayStart = startOfTodayUtc(now);
      const tomorrowStart = startOfTomorrowUtc(now);
      const dayKey = utcDayKey(now);

      // NOTE: this requires a composite index if you add more filters.
      // Keep it minimal: date range + orderBy date.
      const qSnap = await db
        .collection("daily_questions")
        .where("date", ">=", admin.firestore.Timestamp.fromDate(todayStart))
        .where("date", "<", admin.firestore.Timestamp.fromDate(tomorrowStart))
        .orderBy("date", "asc")
        .limit(1)
        .get();

      if (qSnap.empty) {
        return {
          ok: false,
          code: "NO_QUESTION",
          message: "No daily question found for today.",
          state: "NO_QUESTION",
          relationshipId,
          dayKey,
        };
      }

      const qDoc = qSnap.docs[0];
      const questionId = qDoc.id;
      const questionText = (qDoc.get("question_text") || "").toString();

      // ---- deterministic answer doc id ----
      const answerDocId = `${relationshipId}_${dayKey}`;
      const answerRef = db.collection("answers").doc(answerDocId);

      const pair = canonicalPair(uid, partnerUid);

      const stateResult = await db.runTransaction(async (tx) => {
        const aSnap = await tx.get(answerRef);

        if (!aSnap.exists) {
          // create the doc shell so submitDailyAnswer always finds it
          tx.set(answerRef, {
            relationship_id: relationshipId,
            day_key: dayKey,
            question_id: questionId,
            question_text: questionText,
            userA_id: pair.userA,
            userB_id: pair.userB,
            userA_answered: false,
            userB_answered: false,
            timestamp: admin.firestore.FieldValue.serverTimestamp(),
          });

          return { answered: false };
        }

        const a = aSnap.data() || {};

        const userAId = (a.userA_id || "").toString();
        const userBId = (a.userB_id || "").toString();

        // if doc has empty participants, set canonical once
        if (!userAId && !userBId) {
          tx.update(answerRef, { userA_id: pair.userA, userB_id: pair.userB });
        }

        const isA = uid === (userAId || pair.userA);
        const isB = uid === (userBId || pair.userB);

        if (!isA && !isB) {
          throw new functions.https.HttpsError(
            "permission-denied",
            "You are not a participant of this answer document.",
          );
        }

        const userAAnswered = !!a.userA_answered;
        const userBAnswered = !!a.userB_answered;

        const answered = (isA && userAAnswered) || (isB && userBAnswered);
        return { answered };
      });

      const finalState = stateResult.answered ? "ANSWERED" : "NEEDS_ANSWER";

      return {
        ok: true,
        code: "OK",
        message: "State resolved.",
        state: finalState,
        relationshipId,
        dayKey,
        questionId,
        questionText,
        answerDocPath: answerRef.path, // <-- IMPORTANT for FlutterFlow docRefFromPath()
        answerDocId: answerRef.id,
      };
    } catch (e) {
      const msg = e && e.message ? e.message : "Unknown error.";
      return {
        ok: false,
        code: "ERROR",
        message: msg,
        state: "ERROR",
      };
    }
  });
