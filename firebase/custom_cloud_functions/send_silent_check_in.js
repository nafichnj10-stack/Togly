// ============================
// sendSilentCheckIn (messagesEnabled) + LOVE AWARDS + LOVE BUDDY WIDGET STATE + BIRTHDAY LOVE
// ============================
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
const USERS_COL = "Users";
const REL_VIEWS_COL = "relationship_views";
const LOVE_AWARDS_COL = "love_awards";

const MAX_PER_DAY = 2;
const COOLDOWN_MINUTES = 30;
const SILENT_PAIR_POINTS = 2;
const ROUTE_ON_TAP = "home";

function pad2(n) {
  return n < 10 ? `0${n}` : `${n}`;
}

function utcDayKey(d) {
  return `${d.getUTCFullYear()}${pad2(d.getUTCMonth() + 1)}${pad2(d.getUTCDate())}`;
}

function nonEmptyString(v) {
  return typeof v === "string" && v.trim().length > 0 ? v.trim() : "";
}

function normalizeLang(raw) {
  let lang = String(raw || "en")
    .toLowerCase()
    .trim();
  if (lang.includes("-")) lang = lang.split("-")[0];
  if (lang.includes("_")) lang = lang.split("_")[0];
  return ["en", "de", "es"].includes(lang) ? lang : "en";
}

function t(lang, { en, de, es }) {
  return lang === "de" ? de : lang === "es" ? es : en;
}

function clamp(n, min, max) {
  return Math.max(min, Math.min(max, n));
}

function computeLoveState(score) {
  if (score >= 65) return "happy";
  if (score >= 30) return "sad";
  return "angry";
}

function normalizeLoveSentType(raw) {
  const value = String(raw || "normal")
    .toLowerCase()
    .trim();
  return value === "birthday" ? "birthday" : "normal";
}

async function getUserLang(uid) {
  try {
    if (!uid) return "en";
    const snap = await db.collection(USERS_COL).doc(uid).get();
    const u = snap.exists ? snap.data() || {} : {};
    return normalizeLang(u.appLanguage || "en");
  } catch {
    return "en";
  }
}

async function getTokensForUid(uid) {
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

async function canNotifySilentCheckIn(uid) {
  try {
    const snap = await db.collection(USERS_COL).doc(uid).get();
    const u = snap.exists ? snap.data() || {} : {};
    if (u.muteAllNotifications === true) return false;
    if (u.messagesEnabled !== true) return false;
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

function buildTexts(lang, statusCode, waitMinutes) {
  const wm = Number.isFinite(waitMinutes) ? waitMinutes : 0;

  const statusTextByCode = {
    READY: t(lang, { en: "Ready", de: "Bereit", es: "Listo" }),
    COOLDOWN: t(lang, {
      en: `Cooldown: ${wm} min`,
      de: `Abklingzeit: ${wm} min`,
      es: `Enfriamiento: ${wm} min`,
    }),
    DAILY_LIMIT: t(lang, {
      en: "Limit reached today",
      de: "Limit heute erreicht",
      es: "Límite alcanzado hoy",
    }),
    ERROR: t(lang, {
      en: "Unavailable",
      de: "Nicht verfügbar",
      es: "No disponible",
    }),
    SENT: t(lang, { en: "Sent", de: "Gesendet", es: "Enviado" }),
  };

  const snackTextByCode = {
    SENT: t(lang, { en: "Sent 💜", de: "Gesendet 💜", es: "Enviado 💜" }),
    COOLDOWN: t(lang, {
      en: "Please wait 30 minutes 💜",
      de: "Bitte warte 30 Minuten 💜",
      es: "Por favor, espera 30 minutos 💜",
    }),
    DAILY_LIMIT: t(lang, {
      en: "Limit reached today 💜",
      de: "Limit heute erreicht 💜",
      es: "Límite alcanzado hoy 💜",
    }),
    ERROR: t(lang, {
      en: "Something went wrong 💜",
      de: "Etwas ist schiefgelaufen 💜",
      es: "Algo salió mal 💜",
    }),
    READY: "",
  };

  return {
    statusText: statusTextByCode[statusCode] || statusTextByCode.ERROR,
    snackText: snackTextByCode[statusCode] || snackTextByCode.ERROR,
  };
}

// -------------------- Love Buddy Widget State Sync --------------------

async function syncLoveBuddyWidgetStateInternal(relationshipId) {
  if (!relationshipId) return;

  const relRef = db.collection("relationships").doc(relationshipId);
  const relSnap = await relRef.get();
  if (!relSnap.exists) return;

  const rel = relSnap.data() || {};

  const userAId = rel.userA_id;
  const userBId = rel.userB_id;
  if (!userAId || !userBId) return;

  const userAViewRef = db.collection(REL_VIEWS_COL).doc(userAId);
  const userBViewRef = db.collection(REL_VIEWS_COL).doc(userBId);

  const [userAViewSnap, userBViewSnap] = await Promise.all([
    userAViewRef.get(),
    userBViewRef.get(),
  ]);

  const userAView = userAViewSnap.exists ? userAViewSnap.data() || {} : {};
  const userBView = userBViewSnap.exists ? userBViewSnap.data() || {} : {};

  const userAPet = rel.love_buddies_user_a_pet || "dog";
  const userBPet = rel.love_buddies_user_b_pet || "cat";

  const userAName = rel.love_buddies_user_a_name || "Bam";
  const userBName = rel.love_buddies_user_b_name || "Mimi";

  const currentDistanceKm =
    typeof rel.love_buddies_current_distance_km === "number"
      ? rel.love_buddies_current_distance_km
      : null;

  const startDistanceKm =
    typeof rel.love_buddies_start_distance_km === "number"
      ? rel.love_buddies_start_distance_km
      : currentDistanceKm;

  const travelerUid = rel.love_buddies_traveler_uid || null;
  const returningUid = rel.love_buddies_returning_uid || null;

  const travelUpcomingActive = rel.love_buddies_travel_upcoming_active === true;
  const travelActive = rel.love_buddies_travel_active === true;
  const travelPackActive = rel.love_buddies_travel_pack_active === true;

  const birthdayActive = rel.love_buddies_birthday_active === true;
  const birthdayUserUids = Array.isArray(rel.love_buddies_birthday_user_uids)
    ? rel.love_buddies_birthday_user_uids
    : [];

  const liveLocationActive = rel.love_buddies_live_location_active === true;
  const liveLocationMode = rel.love_buddies_live_location_mode || "off";

  const lastLoveSentByUid = rel.love_buddies_last_love_sent_by_uid || null;
  const lastLoveSentAt = rel.love_buddies_last_love_sent_at || null;
  const lastLoveSentType = rel.love_buddies_last_love_sent_type || "normal";

  const userASleeping = userAView.my_sleep_status === true;
  const userBSleeping = userBView.my_sleep_status === true;

  const nowMs = Date.now();

  const loveActive =
    lastLoveSentAt &&
    typeof lastLoveSentAt.toMillis === "function" &&
    nowMs - lastLoveSentAt.toMillis() <= 30 * 60 * 1000;

  const together = currentDistanceKm !== null && currentDistanceKm <= 1;

  let distanceProgress = 0;

  if (
    (travelActive || travelPackActive) &&
    startDistanceKm &&
    startDistanceKm > 0 &&
    currentDistanceKm !== null
  ) {
    if (travelPackActive) {
      distanceProgress = (currentDistanceKm / startDistanceKm) * 100;
    } else {
      distanceProgress =
        ((startDistanceKm - currentDistanceKm) / startDistanceKm) * 100;
    }

    if (distanceProgress < 0) distanceProgress = 0;
    if (distanceProgress > 100) distanceProgress = 100;

    distanceProgress = Math.round(distanceProgress);
  }

  function getPetByUid(targetUid) {
    if (targetUid === userAId) return userAPet;
    if (targetUid === userBId) return userBPet;
    return null;
  }

  function getPartnerPetByUid(targetUid) {
    if (targetUid === userAId) return userBPet;
    if (targetUid === userBId) return userAPet;
    return null;
  }

  function buildDirectionalKey(prefix, actorUid) {
    const actorPet = getPetByUid(actorUid);
    const partnerPet = getPartnerPetByUid(actorUid);

    if (!actorPet || !partnerPet) return `${prefix}_dog_to_cat`;

    return `${prefix}_${actorPet}_to_${partnerPet}`;
  }

  function buildSleepKey() {
    if (userASleeping && userBSleeping) return "sleep_both";
    if (userASleeping) return `sleep_${userAPet}`;
    if (userBSleeping) return `sleep_${userBPet}`;
    return null;
  }

  let widgetState = "normal";
  let widgetBackgroundKey = "normal";

  const sleepKey = buildSleepKey();

  // Priority:
  // 1. birthday
  // 2. together
  // 3. sleeping
  // 4. travel_pack
  // 5. traveling
  // 6. travel_upcoming
  // 7. love_sent
  // 8. normal

  if (birthdayActive) {
    widgetState = "birthday";
    widgetBackgroundKey = "birthday";
  } else if (together) {
    widgetState = "together";
    widgetBackgroundKey = "together";
  } else if (sleepKey) {
    widgetState = "sleeping";
    widgetBackgroundKey = sleepKey;
  } else if (travelPackActive && returningUid) {
    widgetState = "travel_pack";
    widgetBackgroundKey = buildDirectionalKey("travel_pack", returningUid);
  } else if (travelActive && travelerUid) {
    widgetState = "traveling";
    widgetBackgroundKey = buildDirectionalKey("travel", travelerUid);
  } else if (travelUpcomingActive && travelerUid) {
    widgetState = "travel_upcoming";
    widgetBackgroundKey = buildDirectionalKey("travel_upcoming", travelerUid);
  } else if (loveActive && lastLoveSentByUid) {
    widgetState = "love_sent";
    widgetBackgroundKey = buildDirectionalKey("love", lastLoveSentByUid);
  }

  const now = admin.firestore.FieldValue.serverTimestamp();
  const batch = db.batch();

  batch.set(
    relRef,
    {
      love_buddies_widget_state: widgetState,
      love_buddies_widget_background_key: widgetBackgroundKey,
      love_buddies_widget_distance_progress: distanceProgress,
      love_buddies_widget_returning_uid: returningUid,
      love_buddies_widget_birthday_active: birthdayActive,
      love_buddies_widget_birthday_user_uids: birthdayUserUids,
      love_buddies_widget_updated_at: now,
    },
    { merge: true },
  );

  batch.set(
    userAViewRef,
    {
      my_love_buddy_pet: userAPet,
      my_love_buddy_name: userAName,
      partner_love_buddy_pet: userBPet,
      partner_love_buddy_name: userBName,

      widget_state: widgetState,
      widget_background_key: widgetBackgroundKey,
      widget_distance_km: currentDistanceKm,
      widget_distance_progress: distanceProgress,
      widget_traveler_uid: travelerUid,
      widget_returning_uid: returningUid,
      widget_last_love_sent_by_uid: lastLoveSentByUid,
      widget_last_love_sent_at: lastLoveSentAt,
      widget_last_love_sent_type: lastLoveSentType,

      widget_birthday_active: birthdayActive,
      widget_birthday_user_uids: birthdayUserUids,

      live_location_active: liveLocationActive,
      live_location_mode: liveLocationMode,

      widget_updated_at: now,
      updated_at: now,
    },
    { merge: true },
  );

  batch.set(
    userBViewRef,
    {
      my_love_buddy_pet: userBPet,
      my_love_buddy_name: userBName,
      partner_love_buddy_pet: userAPet,
      partner_love_buddy_name: userAName,

      widget_state: widgetState,
      widget_background_key: widgetBackgroundKey,
      widget_distance_km: currentDistanceKm,
      widget_distance_progress: distanceProgress,
      widget_traveler_uid: travelerUid,
      widget_returning_uid: returningUid,
      widget_last_love_sent_by_uid: lastLoveSentByUid,
      widget_last_love_sent_at: lastLoveSentAt,
      widget_last_love_sent_type: lastLoveSentType,

      widget_birthday_active: birthdayActive,
      widget_birthday_user_uids: birthdayUserUids,

      live_location_active: liveLocationActive,
      live_location_mode: liveLocationMode,

      widget_updated_at: now,
      updated_at: now,
    },
    { merge: true },
  );

  await batch.commit();
}

// ---------------- main ----------------

exports.sendSilentCheckIn = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    const uid = context.auth?.uid;
    if (!uid) {
      return {
        ok: false,
        code: "UNAUTHENTICATED",
        status: "ERROR",
        message: "Please log in again.",
      };
    }

    const modeRaw = data && typeof data.mode === "string" ? data.mode : "";
    const mode = modeRaw.toLowerCase().trim() || "send";

    const requestedLoveSentType = normalizeLoveSentType(data && data.type);

    const lang = await getUserLang(uid);

    const now = admin.firestore.Timestamp.now();
    const nowDate = now.toDate();
    const dayKey = utcDayKey(nowDate);

    const myRef = db.collection(REL_VIEWS_COL).doc(uid);

    function buildResult({
      ok,
      code,
      status,
      message,
      partnerUid,
      relationshipId,
      countToday,
      remainingToday,
      cooldownUntilMs,
      waitMinutes,
      lastAtMs,
      loveSentType,
    }) {
      const resolvedOk = !!ok;
      const resolvedCode = code || (resolvedOk ? "OK" : "ERROR");
      const resolvedStatus = status || (resolvedOk ? "READY" : "ERROR");

      const texts = buildTexts(lang, resolvedStatus, waitMinutes);

      let statusText = texts.statusText;
      let snackText = texts.snackText;

      if (resolvedOk && resolvedCode === "SENT") {
        if (loveSentType === "birthday") {
          snackText = t(lang, {
            en: "Birthday love sent 🎂💜",
            de: "Geburtstagsliebe gesendet 🎂💜",
            es: "Amor de cumpleaños enviado 🎂💜",
          });
        } else {
          snackText = t(lang, {
            en: "Sent. Your partner has been notified 💜",
            de: "Gesendet. Dein Partner wurde benachrichtigt 💜",
            es: "Enviado. Tu pareja ha sido notificada 💜",
          });
        }
      }

      return {
        ok: resolvedOk,
        code: resolvedCode,
        status: resolvedStatus,
        message: message || "",
        partnerUid: partnerUid || "",
        relationshipId: relationshipId || "",
        dayKey,
        countToday: Number.isFinite(countToday) ? countToday : 0,
        remainingToday: Number.isFinite(remainingToday) ? remainingToday : 0,
        cooldownUntilMs: Number.isFinite(cooldownUntilMs) ? cooldownUntilMs : 0,
        waitMinutes: Number.isFinite(waitMinutes) ? waitMinutes : 0,
        lastAtMs: Number.isFinite(lastAtMs) ? lastAtMs : 0,
        loveSentType: loveSentType || "normal",
        statusText,
        snackText,
      };
    }

    try {
      if (mode === "status") {
        const snap = await myRef.get();
        if (!snap.exists) {
          return buildResult({
            ok: false,
            code: "NO_REL_VIEW",
            status: "ERROR",
            message: "Relationship view not found.",
          });
        }

        const my = snap.data() || {};
        const partnerUid = nonEmptyString(my.partner_uid);
        const relationshipId = nonEmptyString(my.relationship_id);

        if (!partnerUid || !relationshipId) {
          return buildResult({
            ok: false,
            code: "NO_REL_CONTEXT",
            status: "ERROR",
            message: "Relationship context missing.",
            partnerUid,
            relationshipId,
          });
        }

        const prevDay = nonEmptyString(my.silent_checkin_day_key);
        let countToday = Number(my.silent_checkin_count_today || 0);
        if (prevDay !== dayKey) countToday = 0;

        const cooldownUntil = my.silent_checkin_cooldown_until;
        const cooldownUntilMs = cooldownUntil?.toMillis?.() || 0;
        const nowMs = now.toMillis();

        if (cooldownUntilMs > nowMs) {
          const waitMinutes = Math.ceil((cooldownUntilMs - nowMs) / 60000);
          return buildResult({
            ok: false,
            code: "COOLDOWN",
            status: "COOLDOWN",
            message: "Cooldown active.",
            partnerUid,
            relationshipId,
            countToday,
            remainingToday: Math.max(0, MAX_PER_DAY - countToday),
            cooldownUntilMs,
            waitMinutes,
          });
        }

        if (countToday >= MAX_PER_DAY) {
          return buildResult({
            ok: false,
            code: "DAILY_LIMIT",
            status: "DAILY_LIMIT",
            message: "Daily limit reached.",
            partnerUid,
            relationshipId,
            countToday,
            remainingToday: 0,
          });
        }

        return buildResult({
          ok: true,
          code: "OK",
          status: "READY",
          message: "Ready.",
          partnerUid,
          relationshipId,
          countToday,
          remainingToday: Math.max(0, MAX_PER_DAY - countToday),
        });
      }

      const result = await db.runTransaction(async (tx) => {
        const mySnap = await tx.get(myRef);
        if (!mySnap.exists) {
          return buildResult({
            ok: false,
            code: "NO_REL_VIEW",
            status: "ERROR",
            message: "Relationship view not found.",
          });
        }

        const my = mySnap.data() || {};
        const partnerUid = nonEmptyString(my.partner_uid);
        const relationshipId = nonEmptyString(my.relationship_id);

        if (!partnerUid || !relationshipId) {
          return buildResult({
            ok: false,
            code: "NO_REL_CONTEXT",
            status: "ERROR",
            message: "Relationship context missing.",
            partnerUid,
            relationshipId,
          });
        }

        const partnerRef = db.collection(REL_VIEWS_COL).doc(partnerUid);
        const partnerSnap = await tx.get(partnerRef);

        if (!partnerSnap.exists) {
          return buildResult({
            ok: false,
            code: "NO_PARTNER_VIEW",
            status: "ERROR",
            message: "Partner view not found.",
            partnerUid,
            relationshipId,
          });
        }

        const p = partnerSnap.data() || {};

        const birthdayIsActive =
          my.widget_birthday_active === true ||
          p.widget_birthday_active === true;

        const finalLoveSentType =
          requestedLoveSentType === "birthday" && birthdayIsActive
            ? "birthday"
            : "normal";

        const [aUid, bUid] = [uid, partnerUid].sort();
        const awardId = `${relationshipId}_SILENT_CHECKIN_PAIR_${dayKey}_${aUid}_${bUid}`;
        const awardRef = db.collection(LOVE_AWARDS_COL).doc(awardId);
        const awardSnap = await tx.get(awardRef);

        const prevDay = nonEmptyString(my.silent_checkin_day_key);
        let countToday = Number(my.silent_checkin_count_today || 0);
        if (prevDay !== dayKey) countToday = 0;

        const cooldownUntil = my.silent_checkin_cooldown_until;
        const cooldownUntilMs = cooldownUntil?.toMillis?.() || 0;
        const nowMs = now.toMillis();

        if (cooldownUntilMs > nowMs) {
          const waitMinutes = Math.ceil((cooldownUntilMs - nowMs) / 60000);
          return buildResult({
            ok: false,
            code: "COOLDOWN",
            status: "COOLDOWN",
            message: "Cooldown active.",
            partnerUid,
            relationshipId,
            countToday,
            remainingToday: Math.max(0, MAX_PER_DAY - countToday),
            cooldownUntilMs,
            waitMinutes,
          });
        }

        if (countToday >= MAX_PER_DAY) {
          return buildResult({
            ok: false,
            code: "DAILY_LIMIT",
            status: "DAILY_LIMIT",
            message: "Daily limit reached.",
            partnerUid,
            relationshipId,
            countToday,
            remainingToday: 0,
          });
        }

        const partnerOutDay = nonEmptyString(p.silent_checkin_day_key);
        const partnerOutCount = Number(p.silent_checkin_count_today || 0);
        const partnerAlreadySentToday =
          partnerOutDay === dayKey && partnerOutCount >= 1;
        const shouldAward = partnerAlreadySentToday && !awardSnap.exists;

        const newCount = countToday + 1;
        const cooldownMs = COOLDOWN_MINUTES * 60 * 1000;
        const newCooldownUntil = admin.firestore.Timestamp.fromMillis(
          nowMs + cooldownMs,
        );

        tx.set(
          myRef,
          {
            updated_at: now,
            silent_checkin_last_at: now,
            silent_checkin_day_key: dayKey,
            silent_checkin_count_today: newCount,
            silent_checkin_cooldown_until: newCooldownUntil,
          },
          { merge: true },
        );

        const pPrevDay = nonEmptyString(p.partner_silent_checkin_day_key);
        let pCountToday = Number(p.partner_silent_checkin_count_today || 0);
        if (pPrevDay !== dayKey) pCountToday = 0;
        const pNewCount = pCountToday + 1;

        tx.set(
          partnerRef,
          {
            updated_at: now,
            partner_silent_checkin_last_at: now,
            partner_silent_checkin_day_key: dayKey,
            partner_silent_checkin_count_today: pNewCount,
            partner_silent_checkin_cooldown_until: newCooldownUntil,
          },
          { merge: true },
        );

        tx.set(
          db.collection("relationships").doc(relationshipId),
          {
            love_buddies_last_love_sent_by_uid: uid,
            love_buddies_last_love_sent_at: now,
            love_buddies_last_love_sent_type: finalLoveSentType,
            love_buddies_updated_at: now,
          },
          { merge: true },
        );

        if (shouldAward) {
          tx.set(awardRef, {
            relationship_id: relationshipId,
            type: "SILENT_CHECKIN_PAIR",
            points: SILENT_PAIR_POINTS,
            day_key: dayKey,
            week_key: "",
            actor_uid: uid,
            userA_id: aUid,
            userB_id: bUid,
            created_at: admin.firestore.FieldValue.serverTimestamp(),
            meta: null,
          });

          const myCur = Number(my.love_score ?? 65);
          const pCur = Number(p.love_score ?? 65);

          const myNew = clamp(myCur + SILENT_PAIR_POINTS, 0, 100);
          const pNew = clamp(pCur + SILENT_PAIR_POINTS, 0, 100);

          tx.set(
            myRef,
            {
              love_score: myNew,
              love_percent: myNew / 100,
              love_state: computeLoveState(myNew),
              love_last_update: now,
              love_today_points:
                admin.firestore.FieldValue.increment(SILENT_PAIR_POINTS),
              updated_at: now,
            },
            { merge: true },
          );

          tx.set(
            partnerRef,
            {
              love_score: pNew,
              love_percent: pNew / 100,
              love_state: computeLoveState(pNew),
              love_last_update: now,
              love_today_points:
                admin.firestore.FieldValue.increment(SILENT_PAIR_POINTS),
              updated_at: now,
            },
            { merge: true },
          );
        }

        const waitMinutes = Math.ceil(
          (newCooldownUntil.toMillis() - nowMs) / 60000,
        );

        return buildResult({
          ok: true,
          code: "SENT",
          status: "COOLDOWN",
          message: "Sent.",
          partnerUid,
          relationshipId,
          countToday: newCount,
          remainingToday: Math.max(0, MAX_PER_DAY - newCount),
          cooldownUntilMs: newCooldownUntil.toMillis(),
          waitMinutes,
          lastAtMs: nowMs,
          loveSentType: finalLoveSentType,
        });
      });

      if (
        result?.ok === true &&
        result.code === "SENT" &&
        result.relationshipId
      ) {
        try {
          await syncLoveBuddyWidgetStateInternal(result.relationshipId);
        } catch (e) {
          console.log(
            "[sendSilentCheckIn] widget state sync failed",
            String(e?.message || e),
          );
        }
      }

      if (result?.ok === true && result.code === "SENT") {
        const partnerUid = result.partnerUid;

        try {
          if (partnerUid && (await canNotifySilentCheckIn(partnerUid))) {
            const tokens = await getTokensForUid(partnerUid);
            if (tokens.length) {
              const partnerLang = await getUserLang(partnerUid);

              const actorNameRaw = await getPublicName(uid);
              const actorName =
                actorNameRaw ||
                t(partnerLang, {
                  en: "Your partner",
                  de: "Dein Partner",
                  es: "Tu pareja",
                });

              const isBirthdayLove = result.loveSentType === "birthday";

              const title = isBirthdayLove
                ? t(partnerLang, {
                    en: "Birthday love 🎂",
                    de: "Geburtstagsliebe 🎂",
                    es: "Amor de cumpleaños 🎂",
                  })
                : t(partnerLang, {
                    en: "Silent attention",
                    de: "Stille Aufmerksamkeit",
                    es: "Atención silenciosa",
                  });

              const body = isBirthdayLove
                ? t(partnerLang, {
                    en: `${actorName} sent you birthday love 🎂💜`,
                    de: `${actorName} hat dir Geburtstagsliebe gesendet 🎂💜`,
                    es: `${actorName} te envió amor de cumpleaños 🎂💜`,
                  })
                : t(partnerLang, {
                    en: `${actorName} is thinking of you 💜`,
                    de: `${actorName} denkt gerade an dich 💜`,
                    es: `${actorName} está pensando en ti 💜`,
                  });

              const navParams = {
                type: isBirthdayLove ? "birthday_love" : "silent_checkin",
                actorUid: uid,
                targetUid: partnerUid,
                relationshipId: result.relationshipId,
              };

              const ffNav = buildFlutterFlowNavData(ROUTE_ON_TAP, navParams);

              await messaging.sendEachForMulticast({
                tokens,
                notification: { title, body },
                data: {
                  type: isBirthdayLove ? "birthday_love" : "silent_checkin",
                  route: ROUTE_ON_TAP,
                  ...ffNav,
                },
              });
            }
          }
        } catch (e) {
          console.log(
            "[sendSilentCheckIn] push failed",
            String(e?.message || e),
          );
        }
      }

      return result;
    } catch (e) {
      console.error("[sendSilentCheckIn] failed:", e);
      const texts = buildTexts(lang, "ERROR", 0);
      return {
        ok: false,
        code: "ERROR",
        status: "ERROR",
        message: "Something went wrong. Please try again.",
        statusText: texts.statusText,
        snackText: texts.snackText,
        waitMinutes: 0,
        cooldownUntilMs: 0,
      };
    }
  });
