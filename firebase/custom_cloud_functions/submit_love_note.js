const functions = require("firebase-functions");
const admin = require("firebase-admin");
// Do NOT call admin.initializeApp() in FlutterFlow Cloud Functions

const REGION = "europe-west3";

const USERS_COL = "Users";
const REL_VIEWS_COL = "relationship_views";
const LOVE_NOTES_COL = "love_notes";
const LOVE_AWARDS_COL = "love_awards"; // ✅ unified marker collection

/* -------------------- helpers -------------------- */

function nonEmptyString(v) {
  return typeof v === "string" && v.trim().length > 0 ? v.trim() : "";
}

function clamp(n, min, max) {
  return Math.max(min, Math.min(max, n));
}

function pad2(n) {
  return n < 10 ? `0${n}` : `${n}`;
}

// Local-day key by offset minutes (sender local day)
function dayKeyByOffsetMinutes(nowMs, offsetMinutes) {
  const ms = nowMs + Number(offsetMinutes || 0) * 60 * 1000;
  const d = new Date(ms);
  const y = d.getUTCFullYear();
  const m = pad2(d.getUTCMonth() + 1);
  const dd = pad2(d.getUTCDate());
  return `${y}-${m}-${dd}`; // YYYY-MM-DD
}

// LoveBuddy state thresholds
function loveStateFromScore(score) {
  if (score < 30) return "angry";
  if (score < 65) return "sad";
  return "happy";
}

// ---------- Push helpers ----------
async function getTokensForUid(db, uid) {
  const snap = await db
    .collection(USERS_COL)
    .doc(uid)
    .collection("fcm_tokens")
    .get();
  if (snap.empty) return [];
  return snap.docs
    .map((d) => d.get("fcm_token") || d.get("token") || d.id)
    .filter((t) => typeof t === "string" && t.length > 10);
}

async function canSendMessagePush(db, uid) {
  try {
    const snap = await db.collection(USERS_COL).doc(uid).get();
    const u = snap.exists ? snap.data() || {} : {};
    if (u.muteAllNotifications === true) return false;
    if (u.messagesEnabled === false) return false;
    return true;
  } catch {
    return false;
  }
}

function normalizeLang(raw) {
  let lang = String(raw || "en")
    .toLowerCase()
    .trim();
  if (lang.includes("-")) lang = lang.split("-")[0];
  if (lang.includes("_")) lang = lang.split("_")[0];
  return ["de", "en", "es"].includes(lang) ? lang : "en";
}

async function getUserLang(db, uid) {
  try {
    const snap = await db.collection(USERS_COL).doc(uid).get();
    return normalizeLang(snap.exists ? snap.get("appLanguage") : "en");
  } catch {
    return "en";
  }
}

function t(lang, { en, de, es }) {
  return lang === "de" ? de : lang === "es" ? es : en;
}

async function sendLoveNotePush(
  db,
  messaging,
  targetUid,
  senderName,
  relationshipId,
) {
  if (!(await canSendMessagePush(db, targetUid))) return;

  const tokens = await getTokensForUid(db, targetUid);
  if (!tokens.length) return;

  const lang = await getUserLang(db, targetUid);

  const title = t(lang, {
    en: "New Love Note 💌",
    de: "Neue Love Note 💌",
    es: "Nueva nota 💌",
  });

  const body = senderName
    ? t(lang, {
        en: `${senderName} sent you a love note. Tap to read it 💜`,
        de: `${senderName} hat dir eine Love Note gesendet. Tippe zum Lesen 💜`,
        es: `${senderName} te envió una nota. Toca para leerla 💜`,
      })
    : t(lang, {
        en: `Your partner sent you a love note. Tap to read it 💜`,
        de: `Dein:e Partner:in hat dir eine Love Note gesendet. Tippe zum Lesen 💜`,
        es: `Tu pareja te envió una nota. Toca para leerla 💜`,
      });

  await messaging.sendEachForMulticast({
    tokens,
    notification: { title, body },
    data: {
      type: "love_note",
      route: "loveNotePage",
      relationshipId: String(relationshipId || ""),
    },
  });
}

/* -------------------- main -------------------- */

exports.submitLoveNote = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    const db = admin.firestore();
    const messaging = admin.messaging();

    try {
      // ----- Auth -----
      const uid = context.auth?.uid;
      if (!uid) {
        return {
          ok: false,
          code: "UNAUTHENTICATED",
          message: "Please sign in again.",
        };
      }

      // ----- Input -----
      const text = nonEmptyString(data?.text);
      if (!text) {
        const lang = await getUserLang(db, uid);
        return {
          ok: false,
          code: "INVALID_ARGUMENT",
          message: t(lang, {
            en: "Your love note can’t be empty.",
            de: "Deine Love Note darf nicht leer sein.",
            es: "Tu nota no puede estar vacía.",
          }),
        };
      }

      // ----- Relationship view -----
      const myViewSnap = await db.collection(REL_VIEWS_COL).doc(uid).get();
      if (!myViewSnap.exists) {
        const lang = await getUserLang(db, uid);
        return {
          ok: false,
          code: "NO_RELATIONSHIP",
          message: t(lang, {
            en: "You’re not connected with a partner right now.",
            de: "Du bist aktuell mit niemandem verbunden.",
            es: "No estás conectado/a con una pareja ahora mismo.",
          }),
        };
      }

      const myView = myViewSnap.data() || {};
      const relationshipId = String(myView.relationship_id || "").trim();
      const partnerUid = String(myView.partner_uid || "").trim();
      const myOffset = Number(myView.my_tz_offset_minutes || 0);
      const partnerOffset = Number(myView.partner_tz_offset_minutes || 0);

      if (!relationshipId || !partnerUid) {
        const lang = await getUserLang(db, uid);
        return {
          ok: false,
          code: "NO_RELATIONSHIP",
          message: t(lang, {
            en: "You’re not connected with a partner right now.",
            de: "Du bist aktuell mit niemandem verbunden.",
            es: "No estás conectado/a con una pareja jetzt.",
          }),
        };
      }

      const nowMs = Date.now();
      const senderDayKey = dayKeyByOffsetMinutes(nowMs, myOffset);
      const partnerDayKey = dayKeyByOffsetMinutes(nowMs, partnerOffset);

      // deterministic doc ids (1 per sender per local day)
      const myNoteId = `${relationshipId}_${uid}_${senderDayKey}`;
      const partnerNoteId = `${relationshipId}_${partnerUid}_${partnerDayKey}`;

      const myNoteRef = db.collection(LOVE_NOTES_COL).doc(myNoteId);
      const partnerNoteRef = db.collection(LOVE_NOTES_COL).doc(partnerNoteId);

      // Award marker id: stable for this "both sent" situation
      const [aUid, bUid] = [uid, partnerUid].sort();
      const aDay = aUid === uid ? senderDayKey : partnerDayKey;
      const bDay = bUid === partnerUid ? partnerDayKey : senderDayKey;

      // ✅ unified award id + type
      const awardId = `${relationshipId}_LOVE_NOTE_PAIR_${aDay}_${aUid}_${bDay}_${bUid}`;
      const awardRef = db.collection(LOVE_AWARDS_COL).doc(awardId);

      const BOTH_POINTS = 6;

      // ----- Transaction -----
      const txResult = await db.runTransaction(async (tx) => {
        // ✅ ALL READS FIRST
        const [mySnap, partnerSnap, awardSnap, aViewSnap, bViewSnap] =
          await Promise.all([
            tx.get(myNoteRef),
            tx.get(partnerNoteRef),
            tx.get(awardRef),
            tx.get(db.collection(REL_VIEWS_COL).doc(uid)),
            tx.get(db.collection(REL_VIEWS_COL).doc(partnerUid)),
          ]);

        // ----- Write/Update my note (edit allowed) -----
        tx.set(
          myNoteRef,
          {
            relationship_id: relationshipId,
            from_user_id: uid,
            to_user_id: partnerUid,
            text,
            day_key: senderDayKey,
            sender_tz_offset_minutes: myOffset,
            updated_at: admin.firestore.FieldValue.serverTimestamp(),
            // keep original timestamp on edits
            timestamp: mySnap.exists
              ? mySnap.get("timestamp") ||
                admin.firestore.FieldValue.serverTimestamp()
              : admin.firestore.FieldValue.serverTimestamp(),
            edited: mySnap.exists ? true : false,
          },
          { merge: true },
        );

        // ----- Award points ONLY if partner already has a note AND not awarded yet -----
        let awarded = false;
        if (partnerSnap.exists && !awardSnap.exists) {
          awarded = true;

          // ✅ write unified award marker
          tx.set(awardRef, {
            relationship_id: relationshipId,
            type: "LOVE_NOTE_PAIR",
            points: BOTH_POINTS,
            day_key: `${aDay}|${bDay}`,
            week_key: "",
            actor_uid: uid,
            userA_id: aUid,
            userB_id: bUid,
            created_at: admin.firestore.FieldValue.serverTimestamp(),
            meta: null,
          });

          const aCur = Number(
            (aViewSnap.exists ? (aViewSnap.data() || {}).love_score : 0) || 0,
          );
          const bCur = Number(
            (bViewSnap.exists ? (bViewSnap.data() || {}).love_score : 0) || 0,
          );

          const aNew = clamp(aCur + BOTH_POINTS, 0, 100);
          const bNew = clamp(bCur + BOTH_POINTS, 0, 100);

          tx.set(
            db.collection(REL_VIEWS_COL).doc(uid),
            {
              love_score: aNew,
              love_percent: aNew / 100,
              love_state: loveStateFromScore(aNew),
              love_last_update: admin.firestore.FieldValue.serverTimestamp(),
              love_today_points:
                admin.firestore.FieldValue.increment(BOTH_POINTS),
              updated_at: admin.firestore.FieldValue.serverTimestamp(),
            },
            { merge: true },
          );

          tx.set(
            db.collection(REL_VIEWS_COL).doc(partnerUid),
            {
              love_score: bNew,
              love_percent: bNew / 100,
              love_state: loveStateFromScore(bNew),
              love_last_update: admin.firestore.FieldValue.serverTimestamp(),
              love_today_points:
                admin.firestore.FieldValue.increment(BOTH_POINTS),
              updated_at: admin.firestore.FieldValue.serverTimestamp(),
            },
            { merge: true },
          );
        }

        return { awarded, myNoteId, senderDayKey, partnerDayKey };
      });

      // ----- Push to partner (best-effort, after tx) -----
      await sendLoveNotePush(
        db,
        messaging,
        partnerUid,
        "",
        relationshipId,
      ).catch(() => null);

      const lang = await getUserLang(db, uid);
      return {
        ok: true,
        code: "OK",
        message: t(lang, {
          en: txResult.awarded
            ? "Love note saved and you both earned points 💜"
            : "Love note saved 💜",
          de: txResult.awarded
            ? "Love Note gespeichert und ihr habt Punkte verdient 💜"
            : "Love Note gespeichert 💜",
          es: txResult.awarded
            ? "Nota guardada y ganaron puntos 💜"
            : "Nota guardada 💜",
        }),
        status: txResult.awarded ? "SAVED_AND_AWARDED" : "SAVED",
        relationshipId,
        myNoteId: txResult.myNoteId,
        dayKey: txResult.senderDayKey,
      };
    } catch (e) {
      console.error("[submitLoveNote] failed:", e);
      return {
        ok: false,
        code: "ERROR",
        message: "Something went wrong. Please try again.",
      };
    }
  });
