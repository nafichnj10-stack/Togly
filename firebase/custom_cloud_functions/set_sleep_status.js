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

// -------------------- small helpers --------------------

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

async function getUserLang(uid) {
  try {
    const snap = await db.collection("Users").doc(uid).get();
    return normalizeLang(snap.exists ? snap.get("appLanguage") : "en");
  } catch {
    return "en";
  }
}

async function getUserTzOffsetMinutes(uid) {
  try {
    const snap = await db.collection("Users").doc(uid).get();
    const v = snap.exists ? snap.get("tz_offset_minutes") : null;
    const n = Number(v);
    return Number.isFinite(n) ? n : 0;
  } catch {
    return 0;
  }
}

function getLocalHour(dateObj, tzOffsetMinutes) {
  const local = new Date(dateObj.getTime() + tzOffsetMinutes * 60 * 1000);
  return local.getHours();
}

function timeBucket(hour) {
  if (hour >= 5 && hour <= 11) return "morning";
  if (hour >= 12 && hour <= 17) return "day";
  if (hour >= 18 && hour <= 21) return "evening";
  return "night";
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

  const userSnap = await db.collection("Users").doc(uid).get();
  const fallback = userSnap.exists
    ? String(userSnap.get("fcm_token") || "")
    : "";
  return fallback.length > 10 ? [fallback] : [];
}

async function canSendSleepPush(targetUid) {
  try {
    const snap = await db.collection("Users").doc(targetUid).get();
    const u = snap.exists ? snap.data() || {} : {};
    if (u.muteAllNotifications === true) return false;
    return u.sharedMomentsEnabled === true;
  } catch {
    return false;
  }
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
    de: "Dein:e Partner:in",
    es: "Tu pareja",
  });
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

function formatLocalHHmm(dateObj, tzOffsetMinutes) {
  const local = new Date(dateObj.getTime() + tzOffsetMinutes * 60 * 1000);
  const hh = String(local.getHours()).padStart(2, "0");
  const mm = String(local.getMinutes()).padStart(2, "0");
  return `${hh}:${mm}`;
}

function formatDurationShortMs(ms) {
  const totalMinutes = Math.max(0, Math.floor(ms / 60000));
  const days = Math.floor(totalMinutes / (60 * 24));
  const remAfterDays = totalMinutes - days * 60 * 24;
  const hours = Math.floor(remAfterDays / 60);
  const minutes = remAfterDays - hours * 60;

  if (days > 0) return `${days}d ${hours}h`;
  if (hours > 0) return `${hours}h ${minutes}m`;
  return `${totalMinutes}m`;
}

function buildSleepUiStrings(
  lang,
  isSleeping,
  startedAtDate,
  nowDate,
  tzOffsetMinutes,
) {
  if (!isSleeping) {
    return {
      title: t(lang, { en: "Awake", de: "Wach", es: "Despierto" }),
      meta: "",
    };
  }

  const title = t(lang, { en: "Sleeping", de: "Schläft", es: "Durmiendo" });
  const localTime = formatLocalHHmm(startedAtDate, tzOffsetMinutes);
  const dur = formatDurationShortMs(
    nowDate.getTime() - startedAtDate.getTime(),
  );
  const meta = `${localTime} • ${dur}`;

  return { title, meta };
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

  const userAViewRef = db.collection("relationship_views").doc(userAId);
  const userBViewRef = db.collection("relationship_views").doc(userBId);

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
  const travelActive = rel.love_buddies_travel_active === true;

  const lastLoveSentByUid = rel.love_buddies_last_love_sent_by_uid || null;
  const lastLoveSentAt = rel.love_buddies_last_love_sent_at || null;

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
    travelActive &&
    startDistanceKm &&
    startDistanceKm > 0 &&
    currentDistanceKm !== null
  ) {
    distanceProgress =
      ((startDistanceKm - currentDistanceKm) / startDistanceKm) * 100;

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

  if (together) {
    widgetState = "together";
    widgetBackgroundKey = "together";
  } else if (travelActive && travelerUid) {
    widgetState = "traveling";
    widgetBackgroundKey = buildDirectionalKey("travel", travelerUid);
  } else if (sleepKey) {
    widgetState = "sleeping";
    widgetBackgroundKey = sleepKey;
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
      widget_last_love_sent_by_uid: lastLoveSentByUid,
      widget_last_love_sent_at: lastLoveSentAt,
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
      widget_last_love_sent_by_uid: lastLoveSentByUid,
      widget_last_love_sent_at: lastLoveSentAt,
      widget_updated_at: now,
      updated_at: now,
    },
    { merge: true },
  );

  await batch.commit();
}

// -------------------- copy --------------------

const COPY = {
  snackbar: {
    cooldown: {
      en: (s) => `Please wait ${s}s before changing your sleep status again.`,
      de: (s) =>
        `Bitte warte ${s}s, bevor du deinen Schlafstatus erneut änderst.`,
      es: (s) => `Por favor espera ${s}s antes de cambiar tu estado de sueño.`,
    },
    sleep: {
      en: {
        night: "Sleep status updated. Sweet dreams 💤",
        day: "Sleep status updated. Rest well 💤",
      },
      de: {
        night: "Schlafstatus aktualisiert. Süße Träume 💤",
        day: "Schlafstatus aktualisiert. Ruh dich aus 💤",
      },
      es: {
        night: "Estado de sueño actualizado. Dulces sueños 💤",
        day: "Estado de sueño actualizado. Descansa 💤",
      },
    },
    wake: {
      en: {
        morning: "Sleep status updated. Good morning ☀️",
        other: "Sleep status updated. You’re awake ☀️",
      },
      de: {
        morning: "Schlafstatus aktualisiert. Guten Morgen ☀️",
        other: "Schlafstatus aktualisiert. Du bist wach ☀️",
      },
      es: {
        morning: "Estado de sueño actualizado. Buenos días ☀️",
        other: "Estado de sueño actualizado. Estás despierto/a ☀️",
      },
    },
  },

  push: {
    sleep: (l, name) => ({
      title: t(l, {
        en: "Good night 🌙",
        de: "Gute Nacht 🌙",
        es: "Buenas noches 🌙",
      }),
      body: t(l, {
        en: `${name} is going to sleep. Wish them a good night 💛`,
        de: `${name} geht schlafen. Wünsch gute Nacht 💛`,
        es: `${name} se va a dormir. Deséale buenas noches 💛`,
      }),
    }),
    wake: (l, name) => ({
      title: t(l, {
        en: "Good morning ☀️",
        de: "Guten Morgen ☀️",
        es: "Buenos días ☀️",
      }),
      body: t(l, {
        en: `${name} is awake. Ask how they slept ☀️`,
        de: `${name} ist wach. Frag, wie die Nacht war ☀️`,
        es: `${name} ya está despierto. Pregúntale cómo durmió ☀️`,
      }),
    }),
  },
};

// -------------------- main --------------------

exports.setSleepStatus = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    const uid = context.auth?.uid;
    if (!uid) {
      return {
        ok: false,
        code: "UNAUTHENTICATED",
        message: "Authentication required.",
      };
    }

    const route = nonEmptyString(data?.route);

    const now = admin.firestore.Timestamp.now();
    const nowDate = now.toDate();

    const myViewRef = db.collection("relationship_views").doc(uid);

    const desiredSleeping =
      typeof data?.sleeping === "boolean" ? data.sleeping : null;

    const result = await db.runTransaction(async (tx) => {
      const mySnap = await tx.get(myViewRef);
      if (!mySnap.exists) {
        return {
          ok: false,
          code: "NO_RELATIONSHIP_VIEW",
          message: "Relationship view not found.",
        };
      }

      const myView = mySnap.data() || {};
      const partnerUid = String(myView.partner_uid || "").trim();
      const relationshipId = String(myView.relationship_id || "").trim();

      if (!partnerUid || !relationshipId) {
        return {
          ok: false,
          code: "MISSING_CONTEXT",
          message: "Relationship context missing.",
        };
      }

      const partnerViewRef = db
        .collection("relationship_views")
        .doc(partnerUid);

      const currentSleeping = Boolean(myView.my_sleep_status);
      const newSleeping =
        desiredSleeping === null ? !currentSleeping : Boolean(desiredSleeping);

      if (newSleeping === currentSleeping) {
        return {
          ok: true,
          code: "NO_CHANGE",
          sleeping: currentSleeping,
          relationshipId,
          partnerUid,
          should_push: false,
        };
      }

      const hasEverUsedSleep =
        currentSleeping === true ||
        !!myView.my_sleep_started_at ||
        !!myView.my_sleep_ended_at;

      if (hasEverUsedSleep) {
        const lastUpdatedMs =
          myView.my_sleep_status_updated_at?.toMillis?.() || 0;
        const nowMs = now.toMillis();
        const secondsSince = (nowMs - lastUpdatedMs) / 1000;

        const COOLDOWN_SECONDS = 60;
        if (secondsSince >= 0 && secondsSince < COOLDOWN_SECONDS) {
          const wait = Math.ceil(COOLDOWN_SECONDS - secondsSince);
          return {
            ok: false,
            code: "COOLDOWN",
            wait,
            sleeping: currentSleeping,
            relationshipId,
            partnerUid,
            should_push: false,
          };
        }
      }

      const lastStatus = myView.sleep_push_last_status;
      const lastAt = myView.sleep_push_last_at;

      const updatesMine = {
        my_sleep_status: newSleeping,
        my_sleep_status_updated_at: now,
        updated_at: now,
      };

      const updatesPartner = {
        partner_sleep_status: newSleeping,
        partner_sleep_status_updated_at: now,
        updated_at: now,
      };

      if (newSleeping) {
        updatesMine.my_sleep_started_at = now;
        updatesPartner.partner_sleep_started_at = now;

        updatesMine.my_sleep_ended_at = null;
        updatesPartner.partner_sleep_ended_at = null;

        updatesMine.my_sleep_checkin_12h_sent = false;
        updatesPartner.partner_sleep_checkin_12h_sent = false;
      } else {
        updatesMine.my_sleep_ended_at = now;
        updatesPartner.partner_sleep_ended_at = now;

        updatesMine.my_sleep_started_at = null;
        updatesPartner.partner_sleep_started_at = null;
      }

      updatesMine.sleep_push_last_status = newSleeping;
      updatesMine.sleep_push_last_at = now;

      tx.set(myViewRef, updatesMine, { merge: true });
      tx.set(partnerViewRef, updatesPartner, { merge: true });

      let shouldPush = true;
      if (
        typeof lastStatus === "boolean" &&
        lastStatus === newSleeping &&
        lastAt?.toMillis
      ) {
        const diffMs = now.toMillis() - lastAt.toMillis();
        if (diffMs < 30 * 1000) shouldPush = false;
      }

      return {
        ok: true,
        code: "OK",
        sleeping: newSleeping,
        relationshipId,
        partnerUid,
        should_push: shouldPush,
      };
    });

    if (result?.code === "COOLDOWN") {
      const lang = await getUserLang(uid);
      return { ...result, message: COPY.snackbar.cooldown[lang](result.wait) };
    }

    if (result?.ok) {
      const myLang = await getUserLang(uid);
      const myOffset = await getUserTzOffsetMinutes(uid);
      const myHour = getLocalHour(nowDate, myOffset);
      const bucket = timeBucket(myHour);

      if (result.code === "NO_CHANGE") {
        result.message =
          myLang === "de"
            ? "Schlafstatus unverändert."
            : myLang === "es"
              ? "Estado de sueño sin cambios."
              : "Sleep status unchanged.";
      } else if (result.sleeping) {
        const key = bucket === "night" ? "night" : "day";
        result.message = COPY.snackbar.sleep[myLang][key];
      } else {
        const key = bucket === "morning" ? "morning" : "other";
        result.message = COPY.snackbar.wake[myLang][key];
      }
    }

    try {
      if (result?.ok && (result.code === "OK" || result.code === "NO_CHANGE")) {
        const partnerUid = result.partnerUid;
        if (partnerUid) {
          const [myLang, partnerLang] = await Promise.all([
            getUserLang(uid),
            getUserLang(partnerUid),
          ]);

          const [myOffset, partnerOffset] = await Promise.all([
            getUserTzOffsetMinutes(uid),
            getUserTzOffsetMinutes(partnerUid),
          ]);

          const startedAtDate = nowDate;

          const myUi = buildSleepUiStrings(
            myLang,
            Boolean(result.sleeping),
            startedAtDate,
            nowDate,
            myOffset,
          );
          const partnerUi = buildSleepUiStrings(
            partnerLang,
            Boolean(result.sleeping),
            startedAtDate,
            nowDate,
            partnerOffset,
          );

          await Promise.all([
            db.collection("relationship_views").doc(uid).set(
              {
                my_sleep_ui_title: myUi.title,
                my_sleep_ui_meta: myUi.meta,
              },
              { merge: true },
            ),

            db.collection("relationship_views").doc(partnerUid).set(
              {
                partner_sleep_ui_title: partnerUi.title,
                partner_sleep_ui_meta: partnerUi.meta,
              },
              { merge: true },
            ),
          ]);
        }
      }
    } catch (e) {
      console.log(
        "[setSleepStatus] ui copy write failed",
        String(e?.message || e),
      );
    }

    try {
      if (
        result?.ok &&
        (result.code === "OK" || result.code === "NO_CHANGE") &&
        result.relationshipId
      ) {
        await syncLoveBuddyWidgetStateInternal(result.relationshipId);
      }
    } catch (e) {
      console.log(
        "[setSleepStatus] widget state sync failed",
        String(e?.message || e),
      );
    }

    if (result?.ok && result.code === "OK" && result.should_push === true) {
      const partnerUid = result.partnerUid;
      try {
        if (partnerUid && (await canSendSleepPush(partnerUid))) {
          const partnerLang = await getUserLang(partnerUid);

          const actorPub = await getPublicUser(uid);
          const senderName = pickSenderName(partnerLang, actorPub);

          const copy = result.sleeping
            ? COPY.push.sleep(partnerLang, senderName)
            : COPY.push.wake(partnerLang, senderName);

          const tokens = await getTokensForUid(partnerUid);
          if (tokens.length) {
            const navParams = {
              type: "sleep_status",
              relationshipId: result.relationshipId,
              actorUid: uid,
              targetUid: partnerUid,
              sleeping: String(result.sleeping),
            };
            const ffNav = buildFlutterFlowNavData(route, navParams);

            await messaging.sendEachForMulticast({
              tokens,
              notification: { title: copy.title, body: copy.body },
              data: {
                type: "sleep_status",
                ...ffNav,
              },
            });
          }
        }
      } catch (e) {
        console.log("[setSleepStatus] push failed", String(e?.message || e));
      }
    }

    return result;
  });
