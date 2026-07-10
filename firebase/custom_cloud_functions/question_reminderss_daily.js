const functions = require("firebase-functions");
const admin = require("firebase-admin");

if (!admin.apps.length) {
  admin.initializeApp();
}

const db = admin.firestore();
const messaging = admin.messaging();

function normalizeLang(raw) {
  let lang = String(raw || "en")
    .toLowerCase()
    .trim();
  if (lang.includes("-")) lang = lang.split("-")[0];
  if (lang.includes("_")) lang = lang.split("_")[0];
  if (!["en", "de", "es"].includes(lang)) lang = "en";
  return lang;
}

// yyyyMMdd based on USER local date (computed via tz offset)
function localDayKey(nowUtcDate, tzOffsetMin) {
  const local = new Date(nowUtcDate.getTime() + tzOffsetMin * 60 * 1000);
  const y = local.getUTCFullYear();
  const m = String(local.getUTCMonth() + 1).padStart(2, "0");
  const d = String(local.getUTCDate()).padStart(2, "0");
  return `${y}${m}${d}`;
}

/* -------------------- NEW: relationship gate (no singles) -------------------- */

function nonEmptyString(v) {
  return typeof v === "string" && v.trim().length > 0 ? v.trim() : "";
}

// small in-run caches to reduce Firestore reads a bit
const _relViewCache = new Map(); // uid -> { ok, relationshipId, partnerUid }
const _relationshipCache = new Map(); // relationshipId -> { ok, active, userA, userB }

async function getRelationshipContext(uid) {
  if (_relViewCache.has(uid)) return _relViewCache.get(uid);

  try {
    const snap = await db.collection("relationship_views").doc(uid).get();
    if (!snap.exists) {
      const v = { ok: false, reason: "NO_REL_VIEW" };
      _relViewCache.set(uid, v);
      return v;
    }

    const relationshipId = nonEmptyString(snap.get("relationship_id"));
    const partnerUid = nonEmptyString(snap.get("partner_uid"));

    if (!relationshipId || !partnerUid) {
      const v = { ok: false, reason: "MISSING_REL_CONTEXT" };
      _relViewCache.set(uid, v);
      return v;
    }

    const v = { ok: true, relationshipId, partnerUid };
    _relViewCache.set(uid, v);
    return v;
  } catch {
    const v = { ok: false, reason: "REL_VIEW_READ_ERROR" };
    _relViewCache.set(uid, v);
    return v;
  }
}

async function getRelationshipDoc(relationshipId) {
  if (_relationshipCache.has(relationshipId))
    return _relationshipCache.get(relationshipId);

  try {
    const snap = await db.collection("relationships").doc(relationshipId).get();
    if (!snap.exists) {
      const v = { ok: false, reason: "REL_DOC_MISSING" };
      _relationshipCache.set(relationshipId, v);
      return v;
    }
    const rel = snap.data() || {};
    const v = {
      ok: true,
      active: rel.active === true,
      userA: nonEmptyString(rel.userA_id),
      userB: nonEmptyString(rel.userB_id),
    };
    _relationshipCache.set(relationshipId, v);
    return v;
  } catch {
    const v = { ok: false, reason: "REL_DOC_READ_ERROR" };
    _relationshipCache.set(relationshipId, v);
    return v;
  }
}

async function isUserInActiveRelationship(uid) {
  const ctx = await getRelationshipContext(uid);
  if (!ctx.ok) return false;

  const rel = await getRelationshipDoc(ctx.relationshipId);
  if (!rel.ok) return false;

  // must be active
  if (rel.active !== true) return false;

  // optional safety: if relationship doc has participants, uid must match one of them
  if (rel.userA || rel.userB) {
    if (uid !== rel.userA && uid !== rel.userB) return false;
  }

  return true;
}

/* -------------------- main -------------------- */

exports.questionReminderssDaily = functions
  .region("europe-west3")
  .pubsub.schedule("every 15 minutes")
  .timeZone("Europe/Berlin")
  .onRun(async () => {
    const now = new Date();

    // ✅ Daily Question Reminder: 10:00–10:59 (User local time)
    const TARGET_HOUR = 10;
    const WINDOW_START_MIN = 0;
    const WINDOW_END_MIN = 59;

    console.log(
      `[DQ] Run ${now.toISOString()} targetHour=${TARGET_HOUR} window=${WINDOW_START_MIN}-${WINDOW_END_MIN}`,
    );

    // ✅ only users who enabled it (cheaper than scanning all)
    const usersSnap = await db
      .collection("Users")
      .where("dailyQuestionRemindersEnabled", "==", true)
      .limit(3000) // safety; paginate later if ever needed
      .get();

    console.log(`[DQ] Users scanned (filtered): ${usersSnap.size}`);

    let eligible = 0;
    let sentUsers = 0;

    const PUSH_TEXT = {
      en: {
        title: "Your daily question is ready 💜",
        body: "Take a minute and answer today’s question",
      },
      de: {
        title: "Deine Tagesfrage ist da 💜",
        body: "Nimm dir kurz Zeit und beantworte die Tagesfrage",
      },
      es: {
        title: "Tu pregunta diaria está lista 💜",
        body: "Tómate un minuto y responde la pregunta de hoy",
      },
    };

    for (const userDoc of usersSnap.docs) {
      const user = userDoc.data() || {};
      const uid = userDoc.id;

      // Master mute
      if (user.muteAllNotifications === true) continue;

      // ✅ FIX: only if user is in an ACTIVE relationship (no singles)
      const inActiveRel = await isUserInActiveRelationship(uid);
      if (!inActiveRel) continue;

      // TZ offset needed
      const tzOffsetMin = Number(user.tz_offset_minutes);
      if (!Number.isFinite(tzOffsetMin)) continue;

      // Compute local time and check window
      const userLocalTime = new Date(now.getTime() + tzOffsetMin * 60 * 1000);
      if (userLocalTime.getHours() !== TARGET_HOUR) continue;

      const mm = userLocalTime.getMinutes();
      if (mm < WINDOW_START_MIN || mm > WINDOW_END_MIN) continue;

      // ✅ once per LOCAL day (stable)
      const todayKey = localDayKey(now, tzOffsetMin);
      const lastKey = String(user.lastDailyQuestionReminderDayKey || "");
      if (lastKey === todayKey) continue;

      eligible++;

      // Tokens (subcollection)
      const tokensSnap = await userDoc.ref.collection("fcm_tokens").get();
      if (tokensSnap.empty) continue;

      const tokens = tokensSnap.docs
        .map((d) => d.get("fcm_token") || d.get("token") || d.id)
        .filter((t) => typeof t === "string" && t.length > 10);

      if (!tokens.length) continue;

      const lang = normalizeLang(user.appLanguage);
      const text = PUSH_TEXT[lang] || PUSH_TEXT.en;

      const res = await messaging.sendEachForMulticast({
        tokens,
        notification: {
          title: text.title,
          body: text.body,
        },
        data: {
          type: "daily_question_reminder",
          route: "dailyQuestionPagee", // ⚠️ ändere hier, falls deine Route anders heißt
        },
      });

      console.log(
        `[DQ] user=${uid} lang=${lang} tokens=${tokens.length} success=${res.successCount} fail=${res.failureCount}`,
      );

      // Mark as reminded today if at least 1 succeeded
      if ((res.successCount || 0) > 0) {
        await userDoc.ref.set(
          {
            lastDailyQuestionReminderAt:
              admin.firestore.FieldValue.serverTimestamp(),
            lastDailyQuestionReminderDayKey: todayKey,
          },
          { merge: true },
        );
        sentUsers++;
      }

      // Optional: invalid tokens log (no crash if missing)
      if (res.responses && Array.isArray(res.responses)) {
        res.responses.forEach((r, idx) => {
          if (!r.success) {
            console.log(
              `[DQ] tokenFail user=${uid} idx=${idx} err=${r.error?.message || "unknown"}`,
            );
          }
        });
      }
    }

    console.log(`[DQ] DONE eligible=${eligible} sentUsers=${sentUsers}`);
    return null;
  });
