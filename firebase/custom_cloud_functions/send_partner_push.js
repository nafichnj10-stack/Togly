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

/* -------------------- helpers -------------------- */

function nonEmptyString(v) {
  return typeof v === "string" && v.trim().length > 0 ? v.trim() : "";
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

function toStringMap(obj) {
  const out = {};
  for (const [k, v] of Object.entries(obj || {})) out[String(k)] = String(v);
  return out;
}

async function getUserLang(uid) {
  try {
    const snap = await db.collection("Users").doc(uid).get();
    return normalizeLang(snap.exists ? snap.get("appLanguage") : "en");
  } catch {
    return "en";
  }
}

async function getTokensForUid(uid) {
  const snap = await db
    .collection("Users")
    .doc(uid)
    .collection("fcm_tokens")
    .get();

  const tokens = snap.docs
    .map((d) => d.get("fcm_token") || d.get("token") || d.id)
    .filter((tok) => typeof tok === "string" && tok.length > 10);

  if (tokens.length) return tokens;

  // optional fallback: token also stored on Users doc
  const userSnap = await db.collection("Users").doc(uid).get();
  const fallback = userSnap.exists
    ? String(userSnap.get("fcm_token") || "")
    : "";
  return fallback.length > 10 ? [fallback] : [];
}

async function getPublicUser(uid) {
  try {
    const snap = await db.collection("PublicUsers").doc(uid).get();
    return snap.exists ? snap.data() || null : null;
  } catch {
    return null;
  }
}

function pickSenderName(lang, pub) {
  const raw =
    pub?.display_name ||
    pub?.displayName ||
    pub?.name ||
    pub?.full_name ||
    pub?.fullName ||
    "";

  const name = String(raw).trim();
  if (name) return name;

  return t(lang, {
    en: "Your partner",
    de: "Dein Partner",
    es: "Tu pareja",
  });
}

/**
 * Partner UID only available when relationship_views has partner_uid.
 * (Reconnect flow must NOT rely on this function.)
 */
async function getPartnerUid(uid) {
  const snap = await db.collection("relationship_views").doc(uid).get();
  return snap.exists ? nonEmptyString(snap.get("partner_uid")) : "";
}

async function isAllowed(targetUid, type) {
  const uSnap = await db.collection("Users").doc(targetUid).get();
  const u = uSnap.exists ? uSnap.data() || {} : {};

  // master mute
  if (u.muteAllNotifications === true) return false;

  const map = {
    shared: new Set([
      "album_created",
      "album_photo_added",
      "goal_created",
      "goal_updated",
      "goal_completed",
      "wish_created",
      "wish_completed",
      "calendar_event_created",
      // ❌ sleep_status removed (handled by setSleepStatus directly)
      "mood_changed",
    ]),
    messages: new Set(["love_note_sent"]),
    relationship: new Set([
      // ✅ active-relationship alerts
      "partner_broke_up",
      // ✅ NEW: yearly anniversary push (used by cron or manual trigger)
      "anniversary_yearly",
    ]),
    dailyPartner: new Set(["daily_question_partner_answered"]),
  };

  if (map.shared.has(type)) return u.sharedMomentsEnabled === true;
  if (map.messages.has(type)) return u.messagesEnabled === true;
  if (map.relationship.has(type)) return u.relationshipAlertsEnabled === true;
  if (map.dailyPartner.has(type))
    return u.dailyQuestionPartnerAlertsEnabled === true;

  // safer default
  return false;
}

/**
 * FlutterFlow tap navigation keys
 */
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

/* -------------------- COPY (Name-based) -------------------- */

const COPY = {
  album_created: (l, name) => ({
    title: t(l, {
      en: "A new memory 📸",
      de: "Eine neue Erinnerung 📸",
      es: "Un nuevo recuerdo 📸",
    }),
    body: t(l, {
      en: `${name} created a new album. Take a quick look 💜`,
      de: `${name} hat ein neues Album erstellt. Schau kurz rein 💜`,
      es: `${name} creó un nuevo álbum. Échale un vistazo 💜`,
    }),
  }),

  album_photo_added: (l, name) => ({
    title: t(l, {
      en: "A sweet moment ✨",
      de: "Ein schöner Moment ✨",
      es: "Un bonito momento ✨",
    }),
    body: t(l, {
      en: `${name} added a new photo. A little memory is waiting 💛`,
      de: `${name} hat ein neues Foto hinzugefügt. Eine kleine Erinnerung wartet 💛`,
      es: `${name} añadió una nueva foto. Te espera un recuerdo 💛`,
    }),
  }),

  goal_created: (l, name) => ({
    title: t(l, {
      en: "New goal 🎯",
      de: "Neues Ziel 🎯",
      es: "Nueva meta 🎯",
    }),
    body: t(l, {
      en: `${name} set a new goal. Cheer your partner on 💪`,
      de: `${name} hat ein neues Ziel gesetzt. Unterstütze deinen Partner 💪`,
      es: `${name} creó una nueva meta. Apoya a tu pareja 💪`,
    }),
  }),

  goal_updated: (l, name) => ({
    title: t(l, {
      en: "Goal updated 📝",
      de: "Ziel aktualisiert 📝",
      es: "Meta actualizada 📝",
    }),
    body: t(l, {
      en: `${name} updated a goal. Want to check it together? 💬`,
      de: `${name} hat ein Ziel angepasst. Schaut es euch gemeinsam an 💬`,
      es: `${name} actualizó una meta. ¿La miran juntos? 💬`,
    }),
  }),

  goal_completed: (l, name) => ({
    title: t(l, {
      en: "Goal achieved 🎉",
      de: "Ziel erreicht 🎉",
      es: "Meta alcanzada 🎉",
    }),
    body: t(l, {
      en: `${name} completed a goal. Celebrate together 💜`,
      de: `${name} hat ein Ziel erreicht. Feiert das gemeinsam 💜`,
      es: `${name} completó una meta. Celébrenlo juntos 💜`,
    }),
  }),

  wish_created: (l, name) => ({
    title: t(l, {
      en: "A new wish ✨",
      de: "Ein neuer Wunsch ✨",
      es: "Un nuevo deseo ✨",
    }),
    body: t(l, {
      en: `${name} shared a new wish. Maybe you can make it happen 💛`,
      de: `${name} hat einen neuen Wunsch geteilt. Vielleicht kannst du ihn erfüllen 💛`,
      es: `${name} compartió un nuevo deseo. Quizás puedas hacerlo realidad 💛`,
    }),
  }),

  wish_completed: (l, name) => ({
    title: t(l, {
      en: "Wish fulfilled 🌟",
      de: "Wunsch erfüllt 🌟",
      es: "Deseo cumplido 🌟",
    }),
    body: t(l, {
      en: `${name} completed a wish. Small wins matter 💜`,
      de: `${name} hat einen Wunsch erledigt. Kleine Erfolge zählen 💜`,
      es: `${name} completó un deseo. Los pequeños logros importan 💜`,
    }),
  }),

  calendar_event_created: (l, name) => ({
    title: t(l, {
      en: "Something to look forward to 🗓️",
      de: "Etwas zum Freuen 🗓️",
      es: "Algo que esperar 🗓️",
    }),
    body: t(l, {
      en: `${name} added a new plan. Save the date 💫`,
      de: `${name} hat einen neuen Termin hinzugefügt. Merk ihn dir 💫`,
      es: `${name} añadió un nuevo plan. Guárdalo 💫`,
    }),
  }),

  mood_changed: (l, name) => ({
    title: t(l, {
      en: "Mood update 💬",
      de: "Stimmungs-Update 💬",
      es: "Estado de ánimo 💬",
    }),
    body: t(l, {
      en: `${name} changed their mood. Maybe check in with your partner 💛`,
      de: `${name} hat die Stimmung geändert. Vielleicht magst du kurz nachfragen 💛`,
      es: `${name} cambió su estado de ánimo. Quizás quieras preguntar 💛`,
    }),
  }),

  love_note_sent: (l, name) => ({
    title: t(l, {
      en: "A love note 💌",
      de: "Eine Liebesnachricht 💌",
      es: "Una nota de amor 💌",
    }),
    body: t(l, {
      en: `${name} sent you something sweet. Open it 💜`,
      de: `${name} hat dir etwas Liebevolles geschickt. Öffne es 💜`,
      es: `${name} te envió algo bonito. Ábrelo 💜`,
    }),
  }),

  partner_broke_up: (l, name) => ({
    title: t(l, {
      en: "Relationship update 💔",
      de: "Beziehungs-Update 💔",
      es: "Actualización 💔",
    }),
    body: t(l, {
      en: `${name} disconnected. We hope you both find together again 💛`,
      de: `${name} hat die Verbindung getrennt. Wir hoffen, dass ihr wieder zueinander findet 💛`,
      es: `${name} se desconectó. Tómate tu tiempo. Estamos aquí. 💛`,
    }),
  }),

  daily_question_partner_answered: (l, name) => ({
    title: t(l, {
      en: "Daily question ✍️",
      de: "Tagesfrage ✍️",
      es: "Pregunta diaria ✍️",
    }),
    body: t(l, {
      en: `${name} answered today’s question. Now it’s your turn 💜`,
      de: `${name} hat die Tagesfrage beantwortet. Jetzt bist du dran 💜`,
      es: `${name} respondió la pregunta de hoy. Ahora te toca 💜`,
    }),
  }),

  // ✅ NEW: yearly anniversary (Crown design)
  anniversary_yearly: (l, name) => ({
    title: t(l, {
      en: "Anniversary 👑💜",
      de: "Jahrestag 👑💜",
      es: "Aniversario 👑💜",
    }),
    body: t(l, {
      en: `Happy anniversary to you and ${name}. We are celebrating with you. 💜`,
      de: `Alles Gute zum Jahrestag für dich und ${name}. Wir feiern mit euch. 💜`,
      es: `Feliz aniversario para ti y ${name}. Lo celebramos con ustedes. 💜`,
    }),
  }),
};

/* -------------------- main -------------------- */

exports.sendPartnerPush = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    const actorUid = context.auth?.uid;
    if (!actorUid)
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Login required.",
      );

    const type = nonEmptyString(data?.type);
    if (!type)
      throw new functions.https.HttpsError("invalid-argument", "type required");

    // ❌ sleep_status is handled in setSleepStatus now
    if (type === "sleep_status") {
      return { ok: false, reason: "SLEEP_PUSH_MOVED_TO_SET_SLEEP_STATUS" };
    }

    const audience = nonEmptyString(data?.audience).toLowerCase() || "partner";
    const route = nonEmptyString(data?.route);
    const entityId = nonEmptyString(data?.entityId);

    // IMPORTANT: for this function we still default to relationship_views for partner
    // (Reconnect flow will not use this function anymore)
    let partnerUid = nonEmptyString(data?.targetUid);
    if (!partnerUid) partnerUid = await getPartnerUid(actorUid);

    // recipients (dedup)
    const set = new Set();
    if (audience === "self") set.add(actorUid);
    else if (audience === "both") {
      set.add(actorUid);
      if (partnerUid) set.add(partnerUid);
    } else {
      if (partnerUid) set.add(partnerUid);
    }

    const recipients = Array.from(set);

    if ((audience === "partner" || audience === "both") && !partnerUid) {
      return { ok: false, reason: "NO_PARTNER" };
    }

    const actorPub = await getPublicUser(actorUid);

    const results = [];
    for (const targetUid of recipients) {
      if (!(await isAllowed(targetUid, type))) {
        results.push({
          targetUid,
          skipped: true,
          reason: "DISABLED_BY_PREFS_OR_UNKNOWN_TYPE",
        });
        continue;
      }

      const lang = await getUserLang(targetUid);
      const senderName = pickSenderName(lang, actorPub);

      const fn = COPY[type];
      const copy = typeof fn === "function" ? fn(lang, senderName) : null;

      if (!copy) {
        results.push({ targetUid, ok: false, reason: "UNKNOWN_TYPE" });
        continue;
      }

      const tokens = await getTokensForUid(targetUid);
      if (!tokens.length) {
        results.push({ targetUid, skipped: true, reason: "NO_TOKENS" });
        continue;
      }

      // Tap navigation for FlutterFlow
      const navParams = { type, entityId, actorUid, targetUid };
      const ffNav = buildFlutterFlowNavData(route, navParams);

      const res = await messaging.sendEachForMulticast({
        tokens,
        notification: { title: copy.title, body: copy.body },
        data: toStringMap({
          type,
          route: route || "",
          entityId: entityId || "",
          actorUid,
          targetUid,
          ...ffNav,
        }),
      });

      results.push({
        targetUid,
        sent: res.successCount || 0,
        failed: res.failureCount || 0,
      });
    }

    return {
      ok: true,
      audience,
      type,
      route: route || "",
      entityId: entityId || "",
      results,
    };
  });
