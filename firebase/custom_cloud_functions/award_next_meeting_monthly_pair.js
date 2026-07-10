const functions = require("firebase-functions");
const admin = require("firebase-admin");
try {
  admin.app();
} catch {
  admin.initializeApp();
}

const REGION = "europe-west3";

const REL_VIEWS_COL = "relationship_views";
const USERS_COL = "Users";
const CAL_EVENTS_COL = "calendar_events";
const LOVE_AWARDS_COL = "love_awards";

const POINTS = 4;
const ROUTE_ON_TAP = "homehome";

// Only award if meeting is at least +2h in the future
const MIN_FUTURE_MS = 2 * 60 * 60 * 1000;

/* ---------------- helpers ---------------- */

function clamp(n, min, max) {
  return Math.max(min, Math.min(max, n));
}

function loveStateFromScore(score) {
  if (score < 30) return "angry";
  if (score < 65) return "sad";
  return "happy";
}

function pad2(n) {
  return n < 10 ? `0${n}` : `${n}`;
}

function utcDayKeyFromMs(ms) {
  const d = new Date(ms);
  return `${d.getUTCFullYear()}${pad2(d.getUTCMonth() + 1)}${pad2(d.getUTCDate())}`; // YYYYMMDD
}

function utcMonthKeyFromMs(ms) {
  const d = new Date(ms);
  return `${d.getUTCFullYear()}-${pad2(d.getUTCMonth() + 1)}`; // YYYY-MM
}

/* ---------------- language + push helpers ---------------- */

function normalizeLang(raw) {
  let lang = String(raw || "en")
    .toLowerCase()
    .trim();
  if (lang.includes("-")) lang = lang.split("-")[0];
  if (lang.includes("_")) lang = lang.split("_")[0];
  return ["de", "en", "es"].includes(lang) ? lang : "en";
}

function t(lang, { en, de, es }) {
  return lang === "de" ? de : lang === "es" ? es : en;
}

async function getUserLang(db, uid) {
  try {
    const snap = await db.collection(USERS_COL).doc(uid).get();
    return normalizeLang(snap.exists ? snap.get("appLanguage") : "en");
  } catch {
    return "en";
  }
}

async function getTokensForUid(db, uid) {
  try {
    const snap = await db
      .collection(USERS_COL)
      .doc(uid)
      .collection("fcm_tokens")
      .get();
    if (snap.empty) return [];
    return snap.docs
      .map((d) => d.get("fcm_token") || d.get("token") || d.id)
      .filter((tok) => typeof tok === "string" && tok.length > 10);
  } catch {
    return [];
  }
}

async function canSendRelationshipAlert(db, uid) {
  try {
    const snap = await db.collection(USERS_COL).doc(uid).get();
    const u = snap.exists ? snap.data() || {} : {};
    if (u.muteAllNotifications === true) return false;
    return u.relationshipAlertsEnabled === true;
  } catch {
    return false;
  }
}

function buildFlutterFlowNavData(route, paramsObj) {
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

async function sendNextMeetingPush(
  db,
  messaging,
  targetUid,
  { relationshipId, eventId, points },
) {
  if (!targetUid) return;
  if (!(await canSendRelationshipAlert(db, targetUid))) return;

  const tokens = await getTokensForUid(db, targetUid);
  if (!tokens.length) return;

  const lang = await getUserLang(db, targetUid);

  const title = t(lang, {
    en: "Next meeting planned 💜",
    de: "Nächstes Treffen geplant 💜",
    es: "Próximo encuentro planeado 💜",
  });

  const body = t(lang, {
    en: `LoveBuddy is happy for you — +${points} points! Have an amazing meeting ✨`,
    de: `LoveBuddy freut sich für euch — +${points} Punkte! Viel Spaß beim Treffen ✨`,
    es: `LoveBuddy se alegra por ustedes — +${points} puntos! Que lo pasen genial ✨`,
  });

  const navParams = {
    type: "next_meeting",
    relationshipId: String(relationshipId || ""),
    eventId: String(eventId || ""),
  };

  const ffNav = buildFlutterFlowNavData(ROUTE_ON_TAP, navParams);

  await messaging.sendEachForMulticast({
    tokens,
    notification: { title, body },
    data: {
      type: "love_award",
      route: ROUTE_ON_TAP,
      relationshipId: String(relationshipId || ""),
      eventId: String(eventId || ""),
      points: String(points || ""),
      ...ffNav,
    },
  });
}

/* ---------------- main ---------------- */

exports.awardNextMeetingMonthlyPair = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    const db = admin.firestore();
    const messaging = admin.messaging();

    try {
      const uid = context.auth?.uid;
      if (!uid) {
        return {
          ok: false,
          code: "UNAUTHENTICATED",
          message: "Please sign in again.",
        };
      }

      const eventId = String(data?.eventId || "").trim();
      if (!eventId) {
        const lang = await getUserLang(db, uid);
        return {
          ok: false,
          code: "INVALID_ARGUMENT",
          message: t(lang, {
            en: "Missing eventId.",
            de: "eventId fehlt.",
            es: "Falta eventId.",
          }),
        };
      }

      const nowMs = Date.now();
      const dayKey = utcDayKeyFromMs(nowMs);
      const monthKey = utcMonthKeyFromMs(nowMs);

      const myViewRef = db.collection(REL_VIEWS_COL).doc(uid);
      const eventRef = db.collection(CAL_EVENTS_COL).doc(eventId);

      const txRes = await db.runTransaction(async (tx) => {
        // ✅ Reads first
        const [myViewSnap, eventSnap] = await Promise.all([
          tx.get(myViewRef),
          tx.get(eventRef),
        ]);

        if (!myViewSnap.exists) return { ok: false, code: "NO_RELATIONSHIP" };
        if (!eventSnap.exists) return { ok: false, code: "EVENT_NOT_FOUND" };

        const myView = myViewSnap.data() || {};
        const relationshipId = String(myView.relationship_id || "").trim();
        const partnerUid = String(myView.partner_uid || "").trim();
        if (!relationshipId || !partnerUid)
          return { ok: false, code: "NO_RELATIONSHIP" };

        const ev = eventSnap.data() || {};

        // must belong to this relationship
        const evRel = String(ev.relationship_id || "").trim();
        if (!evRel || evRel !== relationshipId)
          return { ok: false, code: "FORBIDDEN" };

        // only category_key == next_meeting
        const key = String(ev.category_key || "").trim();
        if (key !== "next_meeting") {
          return {
            ok: true,
            status: "IGNORED_NOT_NEXT_MEETING",
            relationshipId,
            partnerUid,
            awarded: false,
          };
        }

        // must be in the future (+2h)
        const startTs = ev.start;
        const startMs = startTs?.toMillis ? startTs.toMillis() : null;
        if (!startMs || startMs < nowMs + MIN_FUTURE_MS) {
          return {
            ok: true,
            status: "IGNORED_NOT_FUTURE",
            relationshipId,
            partnerUid,
            awarded: false,
          };
        }

        const partnerViewRef = db.collection(REL_VIEWS_COL).doc(partnerUid);

        // Award once per month per relationship
        const [aUid, bUid] = [uid, partnerUid].sort();
        const awardId = `${relationshipId}_NEXT_MEETING_MONTHLY_${monthKey}_${aUid}_${bUid}`;
        const awardRef = db.collection(LOVE_AWARDS_COL).doc(awardId);

        const [awardSnap, partnerViewSnap] = await Promise.all([
          tx.get(awardRef),
          tx.get(partnerViewRef),
        ]);

        if (awardSnap.exists) {
          return {
            ok: true,
            status: "ALREADY_AWARDED",
            relationshipId,
            partnerUid,
            awarded: false,
          };
        }

        const partnerView = partnerViewSnap.exists
          ? partnerViewSnap.data() || {}
          : {};

        // create award
        tx.set(awardRef, {
          relationship_id: relationshipId,
          type: "NEXT_MEETING_MONTHLY_PAIR",
          points: POINTS,
          day_key: dayKey,
          week_key: "", // optional; keep empty
          actor_uid: uid,
          userA_id: aUid,
          userB_id: bUid,
          created_at: admin.firestore.FieldValue.serverTimestamp(),
          meta: {
            eventId,
            month_key: monthKey,
            category_key: "next_meeting",
            start_ms: startMs,
          },
        });

        const myCur = Number(myView.love_score ?? 65);
        const pCur = Number(partnerView.love_score ?? 65);

        const myNew = clamp(myCur + POINTS, 0, 100);
        const pNew = clamp(pCur + POINTS, 0, 100);

        tx.set(
          myViewRef,
          {
            love_score: myNew,
            love_percent: myNew / 100,
            love_state: loveStateFromScore(myNew),
            love_last_update: admin.firestore.FieldValue.serverTimestamp(),
            love_today_points: admin.firestore.FieldValue.increment(POINTS),
            updated_at: admin.firestore.FieldValue.serverTimestamp(),
          },
          { merge: true },
        );

        tx.set(
          partnerViewRef,
          {
            love_score: pNew,
            love_percent: pNew / 100,
            love_state: loveStateFromScore(pNew),
            love_last_update: admin.firestore.FieldValue.serverTimestamp(),
            love_today_points: admin.firestore.FieldValue.increment(POINTS),
            updated_at: admin.firestore.FieldValue.serverTimestamp(),
          },
          { merge: true },
        );

        return {
          ok: true,
          status: "AWARDED",
          relationshipId,
          partnerUid,
          awarded: true,
        };
      });

      if (txRes?.ok !== true) {
        const lang = await getUserLang(db, uid);
        return {
          ok: false,
          code: txRes?.code || "ERROR",
          message: t(lang, {
            en: "Something went wrong. Please try again.",
            de: "Etwas ist schiefgelaufen. Bitte versuche es erneut.",
            es: "Algo salió mal. Inténtalo de nuevo.",
          }),
        };
      }

      // ✅ push after tx (best-effort)
      if (txRes.status === "AWARDED") {
        await Promise.allSettled([
          sendNextMeetingPush(db, messaging, uid, {
            relationshipId: txRes.relationshipId,
            eventId,
            points: POINTS,
          }),
          sendNextMeetingPush(db, messaging, txRes.partnerUid, {
            relationshipId: txRes.relationshipId,
            eventId,
            points: POINTS,
          }),
        ]);
      }

      const lang = await getUserLang(db, uid);
      const message =
        txRes.status === "AWARDED"
          ? t(lang, {
              en: `Next meeting saved — +${POINTS} 💜`,
              de: `Nächstes Treffen gespeichert — +${POINTS} 💜`,
              es: `Próximo encuentro guardado — +${POINTS} 💜`,
            })
          : t(lang, {
              en: "Event saved 💜",
              de: "Termin gespeichert 💜",
              es: "Evento guardado 💜",
            });

      return { ...txRes, message, monthKey };
    } catch (e) {
      console.error("[awardNextMeetingMonthlyPair] failed:", e);
      return {
        ok: false,
        code: "ERROR",
        message: "Something went wrong. Please try again.",
      };
    }
  });
