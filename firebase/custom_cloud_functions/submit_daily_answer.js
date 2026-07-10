const functions = require("firebase-functions");
const admin = require("firebase-admin");
// ❗️KEIN initializeApp in FlutterFlow Cloud Functions

const DAILY_QUESTION_POINTS = 8; // <- hier Punkte einstellen

const REGION = "europe-west3";
const USERS_COL = "Users";
const REL_VIEWS_COL = "relationship_views";
const ANSWERS_COL = "answers";
const LOVE_AWARDS_COL = "love_awards";

/* ---------------- helpers ---------------- */

function pad2(n) {
  return n < 10 ? `0${n}` : `${n}`;
}

function utcDayKey(date) {
  // YYYYMMDD (UTC) - keep as you currently use
  return `${date.getUTCFullYear()}${pad2(date.getUTCMonth() + 1)}${pad2(date.getUTCDate())}`;
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

async function getUserLang(db, uid) {
  try {
    const snap = await db.collection(USERS_COL).doc(uid).get();
    let lang = String(
      snap.exists ? snap.data()?.appLanguage : "en",
    ).toLowerCase();
    if (lang.includes("-")) lang = lang.split("-")[0];
    if (lang.includes("_")) lang = lang.split("_")[0];
    return ["de", "en", "es"].includes(lang) ? lang : "en";
  } catch {
    return "en";
  }
}

function clamp(n, min, max) {
  return Math.max(min, Math.min(max, n));
}

// sad wenn <= 65, angry wenn < 30
function stateFromScore(score) {
  if (score < 30) return "angry";
  if (score <= 65) return "sad";
  return "happy";
}

/* ---------------- localized copy ---------------- */

const COPY = {
  OK: {
    de: "💜 Antwort gespeichert.",
    en: "💜 Answer saved.",
    es: "💜 Respuesta guardada.",
  },
  INVALID_ARGUMENT: {
    de: "Deine Antwort darf nicht leer sein.",
    en: "Your answer can’t be empty.",
    es: "Tu respuesta no puede estar vacía.",
  },
  NO_RELATIONSHIP: {
    de: "Du bist aktuell mit niemandem verbunden.",
    en: "You’re not connected with a partner right now.",
    es: "Actualmente no estás conectado/a con una pareja.",
  },
  NO_QUESTION: {
    de: "Für heute gibt es noch keine Tagesfrage.",
    en: "There’s no daily question available today.",
    es: "No hay una pregunta diaria disponible hoy.",
  },
  ALREADY_ANSWERED: {
    de: "Du hast die heutige Frage bereits beantwortet 😊",
    en: "You’ve already answered today’s question 😊",
    es: "Ya respondiste la pregunta de hoy 😊",
  },
  UNAUTHENTICATED: {
    de: "Bitte melde dich erneut an.",
    en: "Please sign in again.",
    es: "Por favor, inicia sesión de nuevo.",
  },
  ERROR: {
    de: "Etwas ist schiefgelaufen. Bitte versuche es erneut.",
    en: "Something went wrong. Please try again.",
    es: "Algo salió mal. Inténtalo de nuevo.",
  },
};

/* ---------------- main ---------------- */

exports.submitDailyAnswer = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    const db = admin.firestore();
    let lang = "en";

    try {
      /* ---------- Auth ---------- */
      if (!context.auth) {
        return {
          ok: false,
          code: "UNAUTHENTICATED",
          message: COPY.UNAUTHENTICATED.en,
        };
      }

      const uid = context.auth.uid;
      lang = await getUserLang(db, uid);

      const answerText = String(data?.answerText || "").trim();
      if (!answerText) {
        return {
          ok: false,
          code: "INVALID_ARGUMENT",
          message: COPY.INVALID_ARGUMENT[lang],
        };
      }

      /* ---------- relationship_views ---------- */
      const relViewSnap = await db.collection(REL_VIEWS_COL).doc(uid).get();
      if (!relViewSnap.exists) {
        return {
          ok: false,
          code: "NO_RELATIONSHIP",
          message: COPY.NO_RELATIONSHIP[lang],
        };
      }

      const relView = relViewSnap.data() || {};
      const relationshipId = String(relView.relationship_id || "").trim();
      const partnerUid = String(relView.partner_uid || "").trim();

      if (!relationshipId || !partnerUid) {
        return {
          ok: false,
          code: "NO_RELATIONSHIP",
          message: COPY.NO_RELATIONSHIP[lang],
        };
      }

      /* ---------- daily question (UTC) ---------- */
      const now = new Date();
      const dayKey = utcDayKey(now);

      const todayStart = startOfTodayUtc(now);
      const tomorrowStart = startOfTomorrowUtc(now);

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
          message: COPY.NO_QUESTION[lang],
        };
      }

      const qDoc = qSnap.docs[0];
      const questionId = qDoc.id;

      const qData = qDoc.data() || {};
      const questionText = String(qData.question_text || "");
      const questionTextEn = String(
        qData.question_text_en || qData.question_text || "",
      );
      const questionTextDe = String(
        qData.question_text_de || qData.question_text || "",
      );
      const questionTextEs = String(
        qData.question_text_es || qData.question_text || "",
      );

      /* ---------- deterministic answer doc ---------- */
      const answerDocId = `${relationshipId}_${dayKey}`;
      const answerRef = db.collection(ANSWERS_COL).doc(answerDocId);

      const relViewARef = db.collection(REL_VIEWS_COL).doc(uid);
      const relViewBRef = db.collection(REL_VIEWS_COL).doc(partnerUid);

      // ✅ deterministic award id for this day + pair
      const [aUid, bUid] = [uid, partnerUid].sort();
      const awardId = `${relationshipId}_DAILY_QUESTION_PAIR_${dayKey}_${aUid}_${bUid}`;
      const awardRef = db.collection(LOVE_AWARDS_COL).doc(awardId);

      let awardedInThisCall = false;

      await db.runTransaction(async (tx) => {
        // ✅ READS FIRST
        const [aSnap, awardSnap, vASnap, vBSnap] = await Promise.all([
          tx.get(answerRef),
          tx.get(awardRef),
          tx.get(relViewARef),
          tx.get(relViewBRef),
        ]);

        const doc = aSnap.exists ? aSnap.data() || {} : {};
        const vA = vASnap.exists ? vASnap.data() || {} : {};
        const vB = vBSnap.exists ? vBSnap.data() || {} : {};

        // participants (keep if already set)
        let userA_id = String(doc.userA_id || "").trim();
        let userB_id = String(doc.userB_id || "").trim();
        if (!userA_id || !userB_id) {
          const pair = [uid, partnerUid].sort();
          userA_id = pair[0];
          userB_id = pair[1];
        }

        const isA = uid === userA_id;
        const alreadyAnswered = isA
          ? doc.userA_answered === true
          : doc.userB_answered === true;

        if (alreadyAnswered) {
          throw new functions.https.HttpsError(
            "failed-precondition",
            "ALREADY_ANSWERED",
            "ALREADY_ANSWERED",
          );
        }

        // compute new answered flags (after this submit)
        const prevA = doc.userA_answered === true;
        const prevB = doc.userB_answered === true;
        const newA = isA ? true : prevA;
        const newB = isA ? prevB : true;
        const bothAnswered = newA && newB;

        // ✅ award points once: both answered + award marker not exists
        const shouldAward = bothAnswered && !awardSnap.exists;

        // ✅ write answer
        const update = {
          relationship_id: relationshipId,
          day_key: dayKey,
          question_id: questionId,

          question_text: questionText,
          question_text_en: questionTextEn,
          question_text_de: questionTextDe,
          question_text_es: questionTextEs,

          userA_id,
          userB_id,

          userA_answered: newA,
          userB_answered: newB,

          timestamp: admin.firestore.FieldValue.serverTimestamp(),
          updated_at: admin.firestore.FieldValue.serverTimestamp(),
        };

        if (isA) {
          update.userA_answer = answerText;
        } else {
          update.userB_answer = answerText;
        }

        tx.set(answerRef, update, { merge: true });

        if (shouldAward) {
          awardedInThisCall = true;

          // ✅ unified award marker
          tx.set(awardRef, {
            relationship_id: relationshipId,
            type: "DAILY_QUESTION_PAIR",
            points: DAILY_QUESTION_POINTS,
            day_key: dayKey,
            week_key: "",
            actor_uid: uid,
            userA_id: userA_id,
            userB_id: userB_id,
            created_at: admin.firestore.FieldValue.serverTimestamp(),
            meta: null,
          });

          const aScore = clamp(
            Number(vA.love_score ?? 65) + DAILY_QUESTION_POINTS,
            0,
            100,
          );
          const bScore = clamp(
            Number(vB.love_score ?? 65) + DAILY_QUESTION_POINTS,
            0,
            100,
          );

          tx.set(
            relViewARef,
            {
              love_score: aScore,
              love_percent: aScore / 100,
              love_state: stateFromScore(aScore),
              love_last_update: admin.firestore.FieldValue.serverTimestamp(),
              love_today_points: admin.firestore.FieldValue.increment(
                DAILY_QUESTION_POINTS,
              ),
              updated_at: admin.firestore.FieldValue.serverTimestamp(),
            },
            { merge: true },
          );

          tx.set(
            relViewBRef,
            {
              love_score: bScore,
              love_percent: bScore / 100,
              love_state: stateFromScore(bScore),
              love_last_update: admin.firestore.FieldValue.serverTimestamp(),
              love_today_points: admin.firestore.FieldValue.increment(
                DAILY_QUESTION_POINTS,
              ),
              updated_at: admin.firestore.FieldValue.serverTimestamp(),
            },
            { merge: true },
          );
        }
      });

      return {
        ok: true,
        code: "OK",
        message: COPY.OK[lang],
        state: awardedInThisCall ? "ANSWERED_AND_AWARDED" : "ANSWERED",
        relationshipId,
        dayKey,
        questionId,
        questionText,
        answerDocPath: answerRef.path,
        answerDocId: answerRef.id,
        awarded: awardedInThisCall,
        points: awardedInThisCall ? DAILY_QUESTION_POINTS : 0,
      };
    } catch (e) {
      const msg = String(e?.message || "");
      const details = String(e?.details || "");

      const code =
        msg === "ALREADY_ANSWERED" || details === "ALREADY_ANSWERED"
          ? "ALREADY_ANSWERED"
          : "ERROR";

      return {
        ok: false,
        code,
        message: COPY[code]?.[lang] || COPY.ERROR[lang] || COPY.ERROR.en,
      };
    }
  });
