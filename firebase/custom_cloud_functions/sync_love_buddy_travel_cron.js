const functions = require("firebase-functions");
const admin = require("firebase-admin");

try {
  admin.app();
} catch {
  admin.initializeApp();
}

const db = admin.firestore();

const REGION = "europe-west3";

const TOGETHER_DISTANCE_KM = 1;
const SEPARATED_DISTANCE_KM = 25;
const UPCOMING_WINDOW_MS = 24 * 60 * 60 * 1000;
const TRAVEL_PACK_WINDOW_MS = 12 * 60 * 60 * 1000;

exports.syncLoveBuddyTravelCron = functions
  .region(REGION)
  .pubsub.schedule("every 15 minutes")
  .timeZone("Europe/Berlin")
  .onRun(async () => {
    const relationshipsSnap = await db.collection("relationships").get();

    let checked = 0;
    let updated = 0;
    let skipped = 0;

    for (const relDoc of relationshipsSnap.docs) {
      checked++;

      try {
        const didUpdate = await processTravelStateForRelationship(relDoc.id);
        if (didUpdate) updated++;
      } catch (e) {
        skipped++;
        console.error(
          "[syncLoveBuddyTravelCron] failed for relationship:",
          relDoc.id,
          e,
        );
      }
    }

    console.log(
      `[syncLoveBuddyTravelCron] checked=${checked}, updated=${updated}, skipped=${skipped}`,
    );

    return null;
  });

async function processTravelStateForRelationship(relationshipId) {
  const nowTs = admin.firestore.Timestamp.now();
  const nowMs = nowTs.toMillis();
  const upcomingUntilTs = admin.firestore.Timestamp.fromMillis(
    nowMs + UPCOMING_WINDOW_MS,
  );

  const relRef = db.collection("relationships").doc(relationshipId);
  const relSnap = await relRef.get();

  if (!relSnap.exists) return false;

  const rel = relSnap.data() || {};
  const userAId = rel.userA_id;
  const userBId = rel.userB_id;

  if (!userAId || !userBId) return false;

  const currentDistanceKm =
    typeof rel.love_buddies_current_distance_km === "number"
      ? rel.love_buddies_current_distance_km
      : null;

  let travelActive = rel.love_buddies_travel_active === true;
  let togetherActive = rel.love_buddies_together_active === true;
  let travelUpcomingActive = rel.love_buddies_travel_upcoming_active === true;
  let travelPackActive = rel.love_buddies_travel_pack_active === true;

  const travelAllDay = rel.love_buddies_travel_all_day === true;
  const travelTargetAt = rel.love_buddies_travel_target_at || null;
  const travelerUid = rel.love_buddies_traveler_uid || null;
  const returningUid = rel.love_buddies_returning_uid || null;

  const updates = {
    love_buddies_updated_at: nowTs,
  };

  let hasStateChange = false;

  // 1) Travel Pack beenden
  if (travelPackActive) {
    const startedAt = rel.love_buddies_travel_pack_started_at || null;
    const startedMs =
      startedAt && typeof startedAt.toMillis === "function"
        ? startedAt.toMillis()
        : null;

    const travelPackExpired =
      startedMs !== null && nowMs - startedMs >= TRAVEL_PACK_WINDOW_MS;

    if (travelPackExpired) {
      updates.love_buddies_travel_pack_active = false;
      updates.love_buddies_travel_pack_ended_at = nowTs;
      updates.love_buddies_return_completed_at = nowTs;
      updates.love_buddies_returning_uid = null;

      updates.love_buddies_travel_active = false;
      updates.love_buddies_travel_upcoming_active = false;
      updates.love_buddies_together_active = false;
      updates.love_buddies_traveler_uid = null;
      updates.love_buddies_destination_uid = null;

      travelPackActive = false;
      travelActive = false;
      travelUpcomingActive = false;
      togetherActive = false;
      hasStateChange = true;
    }
  }

  // 2) Together beenden -> Travel Pack starten
  if (togetherActive && !travelPackActive) {
    const targetReached =
      travelAllDay === false &&
      travelTargetAt &&
      typeof travelTargetAt.toMillis === "function" &&
      nowMs >= travelTargetAt.toMillis();

    const separatedAgain =
      travelAllDay === true &&
      currentDistanceKm !== null &&
      currentDistanceKm > SEPARATED_DISTANCE_KM;

    if (targetReached || separatedAgain) {
      const finalReturningUid = travelerUid || returningUid || null;

      updates.love_buddies_together_active = false;
      updates.love_buddies_travel_active = false;
      updates.love_buddies_travel_upcoming_active = false;

      updates.love_buddies_travel_pack_active = true;
      updates.love_buddies_travel_pack_started_at = nowTs;
      updates.love_buddies_travel_pack_ended_at = null;

      updates.love_buddies_returning_uid = finalReturningUid;
      updates.love_buddies_return_started_at = nowTs;
      updates.love_buddies_return_completed_at = null;

      togetherActive = false;
      travelActive = false;
      travelUpcomingActive = false;
      travelPackActive = true;
      hasStateChange = true;
    }
  }

  // 3) Traveling -> Together
  if (
    !travelPackActive &&
    travelActive &&
    currentDistanceKm !== null &&
    currentDistanceKm <= TOGETHER_DISTANCE_KM
  ) {
    updates.love_buddies_travel_active = false;
    updates.love_buddies_travel_upcoming_active = false;
    updates.love_buddies_together_active = true;
    updates.love_buddies_together_started_at = nowTs;

    updates.love_buddies_travel_pack_active = false;
    updates.love_buddies_returning_uid = null;

    travelActive = false;
    travelUpcomingActive = false;
    togetherActive = true;
    travelPackActive = false;
    hasStateChange = true;
  }

  // 4) Upcoming/Travel aus Calendar Events setzen
  if (!travelActive && !togetherActive && !travelPackActive) {
    let chosenEvent = null;
    let shouldStartTravel = false;
    let shouldSetUpcoming = false;

    const activeSnap = await db
      .collection("calendar_events")
      .where("relationship_id", "==", relationshipId)
      .where("category_key", "==", "next_meeting")
      .where("start", "<=", nowTs)
      .orderBy("start", "desc")
      .limit(5)
      .get();

    activeSnap.forEach((doc) => {
      if (chosenEvent) return;

      const e = doc.data() || {};
      const start = e.start;
      const end = e.end;
      const allDay = e.all_day === true;

      if (!start || typeof start.toMillis !== "function") return;

      if (allDay) {
        chosenEvent = { id: doc.id, ...e };
        shouldStartTravel = true;
        return;
      }

      if (
        end &&
        typeof end.toMillis === "function" &&
        nowMs <= end.toMillis()
      ) {
        chosenEvent = { id: doc.id, ...e };
        shouldStartTravel = true;
      }
    });

    if (!chosenEvent) {
      const upcomingSnap = await db
        .collection("calendar_events")
        .where("relationship_id", "==", relationshipId)
        .where("category_key", "==", "next_meeting")
        .where("start", ">", nowTs)
        .where("start", "<=", upcomingUntilTs)
        .orderBy("start", "asc")
        .limit(1)
        .get();

      if (!upcomingSnap.empty) {
        const doc = upcomingSnap.docs[0];
        chosenEvent = { id: doc.id, ...(doc.data() || {}) };
        shouldSetUpcoming = true;
      }
    }

    if (chosenEvent) {
      const finalTravelerUid =
        String(chosenEvent.traveler_uid || "").trim() ||
        String(chosenEvent.created_by || "").trim();

      const destinationUid =
        String(chosenEvent.destination_uid || "").trim() ||
        (finalTravelerUid === userAId ? userBId : userAId);

      if (finalTravelerUid && destinationUid) {
        updates.love_buddies_traveler_uid = finalTravelerUid;
        updates.love_buddies_destination_uid = destinationUid;
        updates.love_buddies_travel_target_at = chosenEvent.end || null;
        updates.love_buddies_travel_all_day = chosenEvent.all_day === true;
        updates.love_buddies_travel_event_id = chosenEvent.id;

        updates.love_buddies_travel_pack_active = false;
        updates.love_buddies_returning_uid = null;

        if (shouldStartTravel) {
          updates.love_buddies_travel_active = true;
          updates.love_buddies_travel_upcoming_active = false;
          updates.love_buddies_together_active = false;
          updates.love_buddies_travel_started_at = nowTs;
          updates.love_buddies_start_distance_km =
            currentDistanceKm !== null
              ? currentDistanceKm
              : rel.love_buddies_start_distance_km || null;

          travelActive = true;
          travelUpcomingActive = false;
          togetherActive = false;
          travelPackActive = false;
          hasStateChange = true;
        } else if (shouldSetUpcoming) {
          updates.love_buddies_travel_active = false;
          updates.love_buddies_travel_upcoming_active = true;
          updates.love_buddies_together_active = false;

          travelActive = false;
          travelUpcomingActive = true;
          togetherActive = false;
          travelPackActive = false;
          hasStateChange = true;
        }
      }
    } else if (travelUpcomingActive) {
      updates.love_buddies_travel_upcoming_active = false;
      travelUpcomingActive = false;
      hasStateChange = true;
    }
  }

  if (!hasStateChange) {
    return false;
  }

  await relRef.set(updates, { merge: true });
  await syncLoveBuddyWidgetStateInternal(relationshipId);

  return true;
}

async function syncLoveBuddyWidgetStateInternal(relationshipId) {
  const relRef = db.collection("relationships").doc(relationshipId);
  const relSnap = await relRef.get();
  if (!relSnap.exists) return;

  const rel = relSnap.data() || {};
  const userAId = rel.userA_id;
  const userBId = rel.userB_id;
  if (!userAId || !userBId) return;

  const userAViewRef = db.collection("relationship_views").doc(userAId);
  const userBViewRef = db.collection("relationship_views").doc(userBId);

  const [aSnap, bSnap] = await Promise.all([
    userAViewRef.get(),
    userBViewRef.get(),
  ]);

  const aView = aSnap.exists ? aSnap.data() || {} : {};
  const bView = bSnap.exists ? bSnap.data() || {} : {};

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

  const travelActive = rel.love_buddies_travel_active === true;
  const travelUpcomingActive = rel.love_buddies_travel_upcoming_active === true;
  const travelPackActive = rel.love_buddies_travel_pack_active === true;
  const togetherActive = rel.love_buddies_together_active === true;

  const liveLocationActive = rel.love_buddies_live_location_active === true;
  const liveLocationMode = rel.love_buddies_live_location_mode || "off";

  const lastLoveSentByUid = rel.love_buddies_last_love_sent_by_uid || null;
  const lastLoveSentAt = rel.love_buddies_last_love_sent_at || null;

  const userASleeping = aView.my_sleep_status === true;
  const userBSleeping = bView.my_sleep_status === true;

  const nowMs = Date.now();

  const loveActive =
    lastLoveSentAt &&
    typeof lastLoveSentAt.toMillis === "function" &&
    nowMs - lastLoveSentAt.toMillis() <= 30 * 60 * 1000;

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

  if (togetherActive) {
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

      live_location_active: liveLocationActive,
      live_location_mode: liveLocationMode,

      widget_updated_at: now,
      updated_at: now,
    },
    { merge: true },
  );

  await batch.commit();
}
