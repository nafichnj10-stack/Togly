const functions = require("firebase-functions");
const admin = require("firebase-admin");
// Do not call admin.initializeApp() in FlutterFlow Cloud Functions.

const REGION = "europe-west3";

const TOGETHER_DISTANCE_KM = 1;
const SEPARATED_DISTANCE_KM = 25;
const UPCOMING_WINDOW_MS = 400 * 24 * 60 * 60 * 1000;
const TRAVEL_PACK_WINDOW_MS = 12 * 60 * 60 * 1000;

function tsToMs(v) {
  return v && typeof v.toMillis === "function" ? v.toMillis() : null;
}

function updatedMs(e) {
  return tsToMs(e.updated_at) || tsToMs(e.created_at) || 0;
}

function sortMeetingCandidates(a, b) {
  const aStart = tsToMs(a.start) || 0;
  const bStart = tsToMs(b.start) || 0;

  if (aStart !== bStart) return aStart - bStart;

  const aAllDay = a.all_day === true;
  const bAllDay = b.all_day === true;
  if (aAllDay !== bAllDay) return aAllDay ? 1 : -1;

  const aUpdated = updatedMs(a);
  const bUpdated = updatedMs(b);
  if (aUpdated !== bUpdated) return bUpdated - aUpdated;

  return String(a.id || "").localeCompare(String(b.id || ""));
}

async function findBestNextMeeting(
  db,
  relationshipId,
  nowTs,
  nowMs,
  upcomingUntilTs,
) {
  const activeSnap = await db
    .collection("calendar_events")
    .where("relationship_id", "==", relationshipId)
    .where("category_key", "==", "next_meeting")
    .where("start", "<=", nowTs)
    .orderBy("start", "desc")
    .limit(20)
    .get();

  const activeCandidates = [];

  activeSnap.forEach((doc) => {
    const e = doc.data() || {};
    const startMs = tsToMs(e.start);
    const endMs = tsToMs(e.end);
    const allDay = e.all_day === true;

    if (!startMs) return;

    if (allDay) {
      activeCandidates.push({ id: doc.id, ...e });
      return;
    }

    if (endMs && nowMs <= endMs) {
      activeCandidates.push({ id: doc.id, ...e });
    }
  });

  if (activeCandidates.length > 0) {
    activeCandidates.sort(sortMeetingCandidates);
    return {
      event: activeCandidates[0],
      shouldStartTravel: true,
      shouldSetUpcoming: false,
    };
  }

  const upcomingSnap = await db
    .collection("calendar_events")
    .where("relationship_id", "==", relationshipId)
    .where("category_key", "==", "next_meeting")
    .where("start", ">", nowTs)
    .where("start", "<=", upcomingUntilTs)
    .orderBy("start", "asc")
    .limit(20)
    .get();

  if (!upcomingSnap.empty) {
    const upcomingCandidates = upcomingSnap.docs.map((doc) => ({
      id: doc.id,
      ...(doc.data() || {}),
    }));

    upcomingCandidates.sort(sortMeetingCandidates);

    return {
      event: upcomingCandidates[0],
      shouldStartTravel: false,
      shouldSetUpcoming: true,
    };
  }

  return null;
}

exports.syncLoveBuddyTravelState = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    if (!context.auth?.uid) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "You must be signed in.",
      );
    }

    const uid = context.auth.uid;
    const relationshipId = String(data.relationshipId || "").trim();

    if (!relationshipId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Missing relationshipId.",
      );
    }

    const db = admin.firestore();
    const nowTs = admin.firestore.Timestamp.now();
    const nowMs = nowTs.toMillis();
    const upcomingUntilTs = admin.firestore.Timestamp.fromMillis(
      nowMs + UPCOMING_WINDOW_MS,
    );

    const relRef = db.collection("relationships").doc(relationshipId);
    const relSnap = await relRef.get();

    if (!relSnap.exists) {
      throw new functions.https.HttpsError(
        "not-found",
        "Relationship not found.",
      );
    }

    const rel = relSnap.data() || {};
    const userAId = rel.userA_id;
    const userBId = rel.userB_id;

    if (!userAId || !userBId) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Relationship is missing userA_id or userB_id.",
      );
    }

    if (uid !== userAId && uid !== userBId) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "You are not a member of this relationship.",
      );
    }

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

    if (travelPackActive) {
      const startedMs = tsToMs(rel.love_buddies_travel_pack_started_at);
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
        updates.love_buddies_travel_event_id = null;

        travelPackActive = false;
        travelActive = false;
        travelUpcomingActive = false;
        togetherActive = false;
      }
    }

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
      }
    }

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
    }

    if (!travelActive && !togetherActive && !travelPackActive) {
      const chosen = await findBestNextMeeting(
        db,
        relationshipId,
        nowTs,
        nowMs,
        upcomingUntilTs,
      );

      if (chosen && chosen.event) {
        const chosenEvent = chosen.event;

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

          if (chosen.shouldStartTravel) {
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
          } else if (chosen.shouldSetUpcoming) {
            updates.love_buddies_travel_active = false;
            updates.love_buddies_travel_upcoming_active = true;
            updates.love_buddies_together_active = false;

            travelActive = false;
            travelUpcomingActive = true;
            togetherActive = false;
            travelPackActive = false;
          }
        }
      } else {
        updates.love_buddies_travel_active = false;
        updates.love_buddies_travel_upcoming_active = false;
        updates.love_buddies_together_active = false;
        updates.love_buddies_travel_pack_active = false;

        updates.love_buddies_travel_event_id = null;
        updates.love_buddies_traveler_uid = null;
        updates.love_buddies_destination_uid = null;
        updates.love_buddies_travel_target_at = null;
        updates.love_buddies_travel_all_day = false;
        updates.love_buddies_returning_uid = null;

        travelActive = false;
        travelUpcomingActive = false;
        togetherActive = false;
        travelPackActive = false;
      }
    }

    await relRef.set(updates, { merge: true });

    await syncLoveBuddyWidgetStateInternal(db, relationshipId);

    return {
      success: true,
      travel_active: travelActive,
      travel_upcoming_active: travelUpcomingActive,
      together_active: togetherActive,
      travel_pack_active: travelPackActive,
    };
  });

async function syncLoveBuddyWidgetStateInternal(db, relationshipId) {
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

  const currentTravelEventId =
    typeof rel.love_buddies_travel_event_id === "string"
      ? rel.love_buddies_travel_event_id
      : "";

  const userAEventChanged =
    String(aView.widget_travel_event_id || "") !== currentTravelEventId;

  const userBEventChanged =
    String(bView.widget_travel_event_id || "") !== currentTravelEventId;

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

  const userAUpdate = {
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
    widget_travel_event_id: currentTravelEventId,
    widget_last_love_sent_by_uid: lastLoveSentByUid,
    widget_last_love_sent_at: lastLoveSentAt,

    live_location_active: liveLocationActive,
    live_location_mode: liveLocationMode,

    widget_updated_at: now,
    updated_at: now,
  };

  if (userAEventChanged) {
    userAUpdate.live_travel_tracking_enabled = false;
    userAUpdate.live_travel_tracking_prompt_event_id = "";
  }

  const userBUpdate = {
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
    widget_travel_event_id: currentTravelEventId,
    widget_last_love_sent_by_uid: lastLoveSentByUid,
    widget_last_love_sent_at: lastLoveSentAt,

    live_location_active: liveLocationActive,
    live_location_mode: liveLocationMode,

    widget_updated_at: now,
    updated_at: now,
  };

  if (userBEventChanged) {
    userBUpdate.live_travel_tracking_enabled = false;
    userBUpdate.live_travel_tracking_prompt_event_id = "";
  }

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

  batch.set(userAViewRef, userAUpdate, { merge: true });
  batch.set(userBViewRef, userBUpdate, { merge: true });

  await batch.commit();
}
