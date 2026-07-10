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

// --- Config ---
const REL_COL = "relationships";
const USERS_COL = "Users";
const LOVE_AWARDS_COL = "love_awards";

// Send window: daily check uses UTC day key to dedupe
function pad2(n) {
  return n < 10 ? `0${n}` : `${n}`;
}
function utcDayKey(d) {
  return `${d.getUTCFullYear()}${pad2(d.getUTCMonth() + 1)}${pad2(d.getUTCDate())}`;
}

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

function nonEmptyString(v) {
  return typeof v === "string" && v.trim().length > 0 ? v.trim() : "";
}

async function getUserLang(uid) {
  try {
    const snap = await db.collection(USERS_COL).doc(uid).get();
    return normalizeLang(snap.exists ? snap.get("appLanguage") : "en");
  } catch {
    return "en";
  }
}

async function getTokensForUid(uid) {
  const snap = await db
    .collection(USERS_COL)
    .doc(uid)
    .collection("fcm_tokens")
    .get();
  const tokens = snap.docs
    .map((d) => d.get("fcm_token") || d.get("token") || d.id)
    .filter((tok) => typeof tok === "string" && tok.length > 10);

  if (tokens.length) return tokens;

  const userSnap = await db.collection(USERS_COL).doc(uid).get();
  const fallback = userSnap.exists
    ? String(userSnap.get("fcm_token") || "")
    : "";
  return fallback.length > 10 ? [fallback] : [];
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
    const snap = await db.collection("PublicUsers").doc(uid).get();
    const pub = snap.exists ? snap.data() || {} : {};
    const raw =
      pub.display_name ||
      pub.displayName ||
      pub.name ||
      pub.full_name ||
      pub.fullName ||
      "";
    return String(raw || "").trim();
  } catch {
    return "";
  }
}

function buildFlutterFlowNavData(route, paramsObj) {
  const page = nonEmptyString(route);
  const paramData = JSON.stringify(paramsObj || {});
  return {
    click_action: "FLUTTER_NOTIFICATION_CLICK",
    initial_page_name: page,
    initialPageName: page,
    parameter_data: paramData,
    parameterData: paramData,
  };
}

function toStringMap(obj) {
  const out = {};
  for (const [k, v] of Object.entries(obj || {})) out[String(k)] = String(v);
  return out;
}

// Cron runs daily (UTC). We compare month/day in UTC.
// If you later want "local day", we can extend with timezone per user.
function isYearlyAnniversaryTodayUtc(togetherSince, nowUtc) {
  if (!togetherSince) return { ok: false };
  const ts = togetherSince.toDate ? togetherSince.toDate() : togetherSince;
  if (!(ts instanceof Date)) return { ok: false };

  const start = new Date(
    Date.UTC(ts.getUTCFullYear(), ts.getUTCMonth(), ts.getUTCDate()),
  );
  const today = new Date(
    Date.UTC(
      nowUtc.getUTCFullYear(),
      nowUtc.getUTCMonth(),
      nowUtc.getUTCDate(),
    ),
  );

  if (today.getTime() < start.getTime()) return { ok: false };

  const sameMonth = start.getUTCMonth() === today.getUTCMonth();
  const sameDay = start.getUTCDate() === today.getUTCDate();
  if (!sameMonth || !sameDay) return { ok: false };

  const years = today.getUTCFullYear() - start.getUTCFullYear();
  if (years < 1) return { ok: false };

  return { ok: true, years };
}

exports.sendAnniversaryPushesDaily = functions
  .region(REGION)
  .pubsub.schedule("15 8 * * *") // 08:15 UTC daily (change if you want)
  .timeZone("UTC")
  .onRun(async () => {
    const now = new Date();
    const dayKey = utcDayKey(now);

    // Scan active relationships only
    const relSnap = await db
      .collection(REL_COL)
      .where("active", "==", true)
      .get();
    if (relSnap.empty) return null;

    const tasks = [];

    for (const doc of relSnap.docs) {
      const rel = doc.data() || {};
      const relId = nonEmptyString(rel.relationship_id) || doc.id;

      const aUid = nonEmptyString(rel.userA_id);
      const bUid = nonEmptyString(rel.userB_id);
      if (!aUid || !bUid) continue;

      const togetherSince = rel.together_since;
      const check = isYearlyAnniversaryTodayUtc(togetherSince, now);
      if (!check.ok) continue;

      const years = check.years;

      // Dedup marker in love_awards (one per relationship per day per year-count)
      const awardId = `${relId}_ANNIVERSARY_${years}_${dayKey}`;
      const awardRef = db.collection(LOVE_AWARDS_COL).doc(awardId);

      tasks.push(
        db
          .runTransaction(async (tx) => {
            const awardSnap = await tx.get(awardRef);
            if (awardSnap.exists) return; // already sent today

            tx.set(awardRef, {
              relationship_id: relId,
              type: "ANNIVERSARY_YEARLY",
              points: 0,
              day_key: dayKey,
              week_key: "",

              actor_uid: "system",
              userA_id: aUid,
              userB_id: bUid,

              created_at: admin.firestore.FieldValue.serverTimestamp(),
              meta: {
                years: years,
                together_since: togetherSince || null,
              },
            });
          })
          .then(async () => {
            // Push to both (respect prefs)
            const [nameA, nameB] = await Promise.all([
              getPublicName(aUid),
              getPublicName(bUid),
            ]);

            await Promise.all(
              [aUid, bUid].map(async (targetUid) => {
                if (!(await canReceiveRelationshipAlerts(targetUid))) return;

                const tokens = await getTokensForUid(targetUid);
                if (!tokens.length) return;

                const lang = await getUserLang(targetUid);

                const partnerName =
                  targetUid === aUid
                    ? nameB ||
                      t(lang, {
                        en: "Your partner",
                        de: "Dein Partner",
                        es: "Tu pareja",
                      })
                    : nameA ||
                      t(lang, {
                        en: "Your partner",
                        de: "Dein Partner",
                        es: "Tu pareja",
                      });

                const title = t(lang, {
                  en: `Anniversary ${years} year${years === 1 ? "" : "s"} 👑💜`,
                  de: `Jahrestag ${years} Jahr${years === 1 ? "" : "e"} 👑💜`,
                  es: `Aniversario ${years} año${years === 1 ? "" : "s"} 👑💜`,
                });

                const body = t(lang, {
                  en: `Happy anniversary to you and ${partnerName}. We are celebrating with you. 💜`,
                  de: `Alles Gute zum Jahrestag für dich und ${partnerName}. Wir feiern mit euch. 💜`,
                  es: `Feliz aniversario para ti y ${partnerName}. Lo celebramos con ustedes. 💜`,
                });

                const route = "homehome"; // change if you want a dedicated anniversary page
                const params = {
                  type: "anniversary_yearly",
                  relationshipId: relId,
                  years: String(years),
                };
                const nav = buildFlutterFlowNavData(route, params);

                await messaging.sendEachForMulticast({
                  tokens,
                  notification: { title, body },
                  data: toStringMap({
                    type: "anniversary_yearly",
                    route,
                    relationshipId: relId,
                    years: String(years),
                    ...nav,
                  }),
                });
              }),
            );
          })
          .catch(() => null),
      );
    }

    await Promise.all(tasks);
    return null;
  });
