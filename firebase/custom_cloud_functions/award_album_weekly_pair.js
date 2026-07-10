const functions = require("firebase-functions");
const admin = require("firebase-admin");
try {
  admin.app();
} catch {
  admin.initializeApp();
}

const REGION = "europe-west3";

const REL_VIEWS_COL = "relationship_views";
const LOVE_AWARDS_COL = "love_awards"; // ✅ zentrale Collection
const USERS_COL = "Users";

const WEEKLY_POINTS = 6;
const ROUTE_ON_TAP = "homehome"; // ändere falls du willst

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
  const y = d.getUTCFullYear();
  const m = pad2(d.getUTCMonth() + 1);
  const day = pad2(d.getUTCDate());
  return `${y}${m}${day}`; // YYYYMMDD
}

// ISO week key (UTC), Monday-based: "YYYY-Www"
function utcIsoWeekKeyFromMs(ms) {
  const d = new Date(ms);

  const day = d.getUTCDay(); // 0..6 (Sun..Sat)
  const diffToMonday = (day + 6) % 7; // Monday->0, Sunday->6
  d.setUTCDate(d.getUTCDate() - diffToMonday); // Monday of this week

  // ISO week year is based on Thursday
  const thursday = new Date(d.getTime());
  thursday.setUTCDate(thursday.getUTCDate() + 3);
  const weekYear = thursday.getUTCFullYear();

  // first Monday of ISO year
  const jan4 = new Date(Date.UTC(weekYear, 0, 4));
  const jan4Day = jan4.getUTCDay();
  const jan4DiffToMonday = (jan4Day + 6) % 7;
  const firstMonday = new Date(jan4.getTime());
  firstMonday.setUTCDate(firstMonday.getUTCDate() - jan4DiffToMonday);

  const weekNo =
    Math.floor(
      (d.getTime() - firstMonday.getTime()) / (7 * 24 * 60 * 60 * 1000),
    ) + 1;
  return `${weekYear}-W${String(weekNo).padStart(2, "0")}`;
}

/* ---------------- language helpers ---------------- */

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

/* ---------------- push helpers ---------------- */

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

async function sendAwardPushToUid(
  db,
  messaging,
  targetUid,
  { relationshipId, weekKey, points },
) {
  if (!targetUid) return;
  if (!(await canSendRelationshipAlert(db, targetUid))) return;

  const tokens = await getTokensForUid(db, targetUid);
  if (!tokens.length) return;

  const lang = await getUserLang(db, targetUid);

  const title = t(lang, {
    en: "Shared memories unlocked 📸💜",
    de: "Gemeinsame Erinnerungen 📸💜",
    es: "Recuerdos compartidos 📸💜",
  });

  const body = t(lang, {
    en: `You both uploaded photos this week — +${points} LoveBuddy points!`,
    de: `Ihr habt diese Woche beide Fotos hochgeladen — +${points} LoveBuddy-Punkte!`,
    es: `Ambos subieron fotos esta semana — +${points} puntos de LoveBuddy!`,
  });

  const navParams = {
    type: "album_weekly_pair",
    relationshipId: String(relationshipId || ""),
    weekKey: String(weekKey || ""),
  };

  const ffNav = buildFlutterFlowNavData(ROUTE_ON_TAP, navParams);

  await messaging.sendEachForMulticast({
    tokens,
    notification: { title, body },
    data: {
      type: "love_award",
      route: ROUTE_ON_TAP,
      relationshipId: String(relationshipId || ""),
      weekKey: String(weekKey || ""),
      points: String(points || ""),
      ...ffNav,
    },
  });
}

/* ---------------- main ---------------- */

exports.awardAlbumWeeklyPair = functions
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

      const lang = await getUserLang(db, uid);

      // optional meta
      const galleryId =
        typeof data?.galleryId === "string" ? data.galleryId.trim() : "";
      const albumId =
        typeof data?.albumId === "string" ? data.albumId.trim() : "";

      const myViewRef = db.collection(REL_VIEWS_COL).doc(uid);

      const nowMs = Date.now();
      const dayKey = utcDayKeyFromMs(nowMs);
      const weekKey = utcIsoWeekKeyFromMs(nowMs);

      // We'll return partnerUid + awarded info so we can push after tx
      const txRes = await db.runTransaction(async (tx) => {
        const myViewSnap = await tx.get(myViewRef);
        if (!myViewSnap.exists) {
          return { ok: false, code: "NO_RELATIONSHIP" };
        }

        const myView = myViewSnap.data() || {};
        const relationshipId = String(myView.relationship_id || "").trim();
        const partnerUid = String(myView.partner_uid || "").trim();

        if (!relationshipId || !partnerUid) {
          return { ok: false, code: "NO_RELATIONSHIP" };
        }

        const partnerViewRef = db.collection(REL_VIEWS_COL).doc(partnerUid);

        const [userA, userB] = [uid, partnerUid].sort();

        // markers
        const myMarkId = `${relationshipId}_ALBUM_WEEKLY_MARK_${weekKey}_${uid}`;
        const partnerMarkId = `${relationshipId}_ALBUM_WEEKLY_MARK_${weekKey}_${partnerUid}`;
        const myMarkRef = db.collection(LOVE_AWARDS_COL).doc(myMarkId);
        const partnerMarkRef = db
          .collection(LOVE_AWARDS_COL)
          .doc(partnerMarkId);

        // pair award
        const pairAwardId = `${relationshipId}_ALBUM_WEEKLY_PAIR_${weekKey}_${userA}_${userB}`;
        const pairAwardRef = db.collection(LOVE_AWARDS_COL).doc(pairAwardId);

        const [myMarkSnap, partnerMarkSnap, pairAwardSnap, partnerViewSnap] =
          await Promise.all([
            tx.get(myMarkRef),
            tx.get(partnerMarkRef),
            tx.get(pairAwardRef),
            tx.get(partnerViewRef),
          ]);

        // create my marker (idempotent)
        if (!myMarkSnap.exists) {
          tx.set(myMarkRef, {
            relationship_id: relationshipId,
            type: "ALBUM_WEEKLY_MARK",
            points: 0,
            day_key: dayKey,
            week_key: weekKey,
            actor_uid: uid,
            userA_id: userA,
            userB_id: userB,
            created_at: admin.firestore.FieldValue.serverTimestamp(),
            meta: {
              source: "gallery_upload",
              galleryId: galleryId || null,
              albumId: albumId || null,
            },
          });
        }

        // already awarded
        if (pairAwardSnap.exists) {
          return {
            ok: true,
            code: "OK",
            status: "ALREADY_AWARDED",
            relationshipId,
            partnerUid,
            weekKey,
            awarded: false,
          };
        }

        // partner hasn't contributed yet
        if (!partnerMarkSnap.exists) {
          return {
            ok: true,
            code: "OK",
            status: "MARKED_ONLY",
            relationshipId,
            partnerUid,
            weekKey,
            awarded: false,
          };
        }

        // award now
        const partnerView = partnerViewSnap.exists
          ? partnerViewSnap.data() || {}
          : {};

        const myCur = Number(myView.love_score ?? 65);
        const pCur = Number(partnerView.love_score ?? 65);

        const myNew = clamp(myCur + WEEKLY_POINTS, 0, 100);
        const pNew = clamp(pCur + WEEKLY_POINTS, 0, 100);

        tx.set(pairAwardRef, {
          relationship_id: relationshipId,
          type: "ALBUM_WEEKLY_PAIR",
          points: WEEKLY_POINTS,
          day_key: dayKey,
          week_key: weekKey,
          actor_uid: uid, // who triggered the award
          userA_id: userA,
          userB_id: userB,
          created_at: admin.firestore.FieldValue.serverTimestamp(),
          meta: {
            source: "weekly_pair_award",
            triggeredBy: uid,
          },
        });

        tx.set(
          myViewRef,
          {
            love_score: myNew,
            love_percent: myNew / 100,
            love_state: loveStateFromScore(myNew),
            love_last_update: admin.firestore.FieldValue.serverTimestamp(),
            love_today_points:
              admin.firestore.FieldValue.increment(WEEKLY_POINTS),
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
            love_today_points:
              admin.firestore.FieldValue.increment(WEEKLY_POINTS),
            updated_at: admin.firestore.FieldValue.serverTimestamp(),
          },
          { merge: true },
        );

        return {
          ok: true,
          code: "OK",
          status: "AWARDED",
          relationshipId,
          partnerUid,
          weekKey,
          awarded: true,
          points: WEEKLY_POINTS,
        };
      });

      if (txRes?.ok !== true) {
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

      // ✅ push AFTER transaction (best-effort)
      if (txRes.status === "AWARDED") {
        const relationshipId = txRes.relationshipId;
        const partnerUid = txRes.partnerUid;
        const weekKey = txRes.weekKey;

        await Promise.allSettled([
          sendAwardPushToUid(db, messaging, uid, {
            relationshipId,
            weekKey,
            points: WEEKLY_POINTS,
          }),
          sendAwardPushToUid(db, messaging, partnerUid, {
            relationshipId,
            weekKey,
            points: WEEKLY_POINTS,
          }),
        ]);
      }

      const msg =
        txRes.status === "AWARDED"
          ? t(lang, {
              en: `Shared memories unlocked! +${WEEKLY_POINTS} 💜`,
              de: `Gemeinsame Erinnerungen! +${WEEKLY_POINTS} 💜`,
              es: `¡Recuerdos compartidos! +${WEEKLY_POINTS} 💜`,
            })
          : t(lang, {
              en: "Photo saved 💜",
              de: "Foto gespeichert 💜",
              es: "Foto guardado 💜",
            });

      return { ...txRes, message: msg };
    } catch (e) {
      console.error("[awardAlbumWeeklyPair] failed:", e);
      return {
        ok: false,
        code: "ERROR",
        message: "Something went wrong. Please try again.",
      };
    }
  });
