const functions = require("firebase-functions");
const admin = require("firebase-admin");

if (!admin.apps.length) admin.initializeApp();

const db = admin.firestore();
const messaging = admin.messaging();

function normalizeLang(raw) {
  let lang = String(raw || "en")
    .toLowerCase()
    .trim();
  if (lang.includes("-")) lang = lang.split("-")[0];
  if (!["en", "de", "es"].includes(lang)) lang = "en";
  return lang;
}

// stable local day key using offset minutes
function localDayKey(dateUtc, offsetMin) {
  const d = new Date(dateUtc.getTime() + offsetMin * 60000);
  const y = d.getUTCFullYear();
  const m = String(d.getUTCMonth() + 1).padStart(2, "0");
  const day = String(d.getUTCDate()).padStart(2, "0");
  return `${y}${m}${day}`;
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

exports.stayConnectedReminder = functions
  .region("europe-west3")
  .pubsub.schedule("every 15 minutes")
  .timeZone("Europe/Berlin")
  .onRun(async () => {
    const now = new Date(); // server time
    const TARGET_HOUR = 18;

    const PUSH_TEXT = {
      en: {
        title: "Stay connected 💫",
        body: "A small moment together can mean a lot.",
      },
      de: {
        title: "Bleibt verbunden 💫",
        body: "Ein kleiner Moment zusammen kann viel bedeuten.",
      },
      es: {
        title: "Manténganse conectados 💫",
        body: "Un pequeño momento juntos puede significar mucho.",
      },
    };

    // ✅ only users who enabled it
    const usersSnap = await db
      .collection("Users")
      .where("stayConnectedRemindersEnabled", "==", true)
      .limit(2000) // safety; increase later with pagination if needed
      .get();

    let eligible = 0;
    let sentUsers = 0;

    for (const userDoc of usersSnap.docs) {
      const user = userDoc.data() || {};
      const uid = userDoc.id;

      if (user.muteAllNotifications === true) continue;

      // ✅ FIX: only if user is in an ACTIVE relationship (no singles)
      const inActiveRel = await isUserInActiveRelationship(uid);
      if (!inActiveRel) continue;

      const tzOffsetMin = Number(user.tz_offset_minutes);
      if (!Number.isFinite(tzOffsetMin)) continue;

      const userLocal = new Date(now.getTime() + tzOffsetMin * 60000);
      if (userLocal.getHours() !== TARGET_HOUR) continue;

      // ✅ once per local day
      const todayKey = localDayKey(now, tzOffsetMin);
      const lastKey = String(user.lastStayConnectedReminderDayKey || "");
      if (lastKey === todayKey) continue;

      eligible++;

      // tokens
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
        notification: { title: text.title, body: text.body },
        data: { type: "stay_connected", route: "homeHome" }, // <- route ggf. anpassen
      });

      if ((res.successCount || 0) > 0) {
        await userDoc.ref.set(
          {
            lastStayConnectedReminderAt:
              admin.firestore.FieldValue.serverTimestamp(),
            lastStayConnectedReminderDayKey: todayKey,
          },
          { merge: true },
        );
        sentUsers++;
      }

      console.log(
        `[SC] user=${uid} lang=${lang} success=${res.successCount} fail=${res.failureCount}`,
      );
    }

    console.log(
      `[SC] DONE scanned=${usersSnap.size} eligible=${eligible} sentUsers=${sentUsers}`,
    );
    return null;
  });
