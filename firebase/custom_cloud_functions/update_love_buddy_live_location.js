const functions = require("firebase-functions");
const admin = require("firebase-admin");
// Do not call admin.initializeApp() in FlutterFlow Cloud Functions.

const REGION = "europe-west3";
const USERS_COL = "Users";
const REL_COL = "relationships";
const VIEWS_COL = "relationship_views";

const TOGETHER_DISTANCE_KM = 1;
const MAX_ACCEPTED_ACCURACY_METERS = 5000;

function toNumber(v) {
  const n = Number(v);
  return Number.isFinite(n) ? n : null;
}

function haversineKm(lat1, lng1, lat2, lng2) {
  const R = 6371;
  const dLat = ((lat2 - lat1) * Math.PI) / 180;
  const dLng = ((lng2 - lng1) * Math.PI) / 180;

  const a =
    Math.sin(dLat / 2) ** 2 +
    Math.cos((lat1 * Math.PI) / 180) *
      Math.cos((lat2 * Math.PI) / 180) *
      Math.sin(dLng / 2) ** 2;

  return R * (2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a)));
}

exports.updateLoveBuddyLiveLocation = functions
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

    const lat = toNumber(data.lat);
    const lng = toNumber(data.lng);
    const accuracyMeters = toNumber(data.accuracyMeters);

    if (!relationshipId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Missing relationshipId.",
      );
    }

    if (
      lat === null ||
      lng === null ||
      lat < -90 ||
      lat > 90 ||
      lng < -180 ||
      lng > 180
    ) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Invalid lat/lng.",
      );
    }

    if (
      accuracyMeters !== null &&
      accuracyMeters > MAX_ACCEPTED_ACCURACY_METERS
    ) {
      return { success: false, code: "LOW_ACCURACY" };
    }

    const db = admin.firestore();
    const now = admin.firestore.FieldValue.serverTimestamp();
    const nowTs = admin.firestore.Timestamp.now();

    const userRef = db.collection(USERS_COL).doc(uid);
    const relRef = db.collection(REL_COL).doc(relationshipId);
    const myViewRef = db.collection(VIEWS_COL).doc(uid);

    const [userSnap, relSnap, myViewSnap] = await Promise.all([
      userRef.get(),
      relRef.get(),
      myViewRef.get(),
    ]);

    if (!relSnap.exists) {
      throw new functions.https.HttpsError(
        "not-found",
        "Relationship not found.",
      );
    }

    if (!myViewSnap.exists) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Relationship view not found.",
      );
    }

    const user = userSnap.exists ? userSnap.data() || {} : {};
    const rel = relSnap.data() || {};
    const myView = myViewSnap.data() || {};

    const userAId = rel.userA_id;
    const userBId = rel.userB_id;

    if (uid !== userAId && uid !== userBId) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "You are not a member.",
      );
    }

    if (user.liveTravelTrackingEnabled === false) {
      return { success: false, code: "USER_DISABLED_LIVE_TRACKING" };
    }

    if (myView.live_travel_tracking_enabled !== true) {
      return { success: false, code: "TRIP_NOT_APPROVED" };
    }

    const travelActive = rel.love_buddies_travel_active === true;
    const travelerUid = String(rel.love_buddies_traveler_uid || "").trim();
    const destinationUid = String(
      rel.love_buddies_destination_uid || "",
    ).trim();

    if (!travelActive) return { success: false, code: "TRAVEL_NOT_ACTIVE" };
    if (uid !== travelerUid) return { success: false, code: "NOT_TRAVELER" };
    if (!destinationUid) return { success: false, code: "NO_DESTINATION_UID" };

    const destinationViewSnap = await db
      .collection(VIEWS_COL)
      .doc(destinationUid)
      .get();

    if (!destinationViewSnap.exists) {
      return { success: false, code: "NO_DESTINATION_VIEW" };
    }

    const destinationView = destinationViewSnap.data() || {};

    const destinationLat =
      toNumber(destinationView.my_home_lat) ??
      toNumber(myView.partner_home_lat);

    const destinationLng =
      toNumber(destinationView.my_home_lng) ??
      toNumber(myView.partner_home_lng);

    if (destinationLat === null || destinationLng === null) {
      return { success: false, code: "NO_DESTINATION_LOCATION" };
    }

    const distanceKm = Math.max(
      0,
      Math.round(haversineKm(lat, lng, destinationLat, destinationLng)),
    );

    const startDistanceKm =
      typeof rel.love_buddies_start_distance_km === "number"
        ? rel.love_buddies_start_distance_km
        : typeof rel.love_buddies_current_distance_km === "number"
          ? rel.love_buddies_current_distance_km
          : distanceKm;

    let distanceProgress = 0;

    if (startDistanceKm && startDistanceKm > 0) {
      distanceProgress =
        ((startDistanceKm - distanceKm) / startDistanceKm) * 100;
      if (distanceProgress < 0) distanceProgress = 0;
      if (distanceProgress > 100) distanceProgress = 100;
      distanceProgress = Math.round(distanceProgress);
    }

    const arrived = distanceKm <= TOGETHER_DISTANCE_KM;

    const relUpdate = {
      love_buddies_live_location_active: true,
      love_buddies_live_location_mode: arrived
        ? "together_check"
        : "travel_to_partner",

      love_buddies_live_traveler_uid: uid,
      love_buddies_live_lat: lat,
      love_buddies_live_lng: lng,
      love_buddies_live_accuracy_meters: accuracyMeters,
      love_buddies_live_distance_km: distanceKm,
      love_buddies_live_location_updated_at: now,

      love_buddies_current_distance_km: distanceKm,
      love_buddies_distance_updated_at: now,
      love_buddies_widget_distance_progress: distanceProgress,
      love_buddies_updated_at: now,
    };

    if (typeof rel.love_buddies_start_distance_km !== "number") {
      relUpdate.love_buddies_start_distance_km = startDistanceKm;
    }

    if (arrived) {
      relUpdate.love_buddies_travel_active = false;
      relUpdate.love_buddies_travel_upcoming_active = false;
      relUpdate.love_buddies_together_active = true;
      relUpdate.love_buddies_together_started_at = now;
      relUpdate.love_buddies_travel_pack_active = false;
      relUpdate.love_buddies_returning_uid = null;
    }

    const myViewUpdate = {
      my_live_lat: lat,
      my_live_lng: lng,
      my_live_accuracy_meters: accuracyMeters,
      my_live_location_updated_at: now,

      live_location_active: true,
      live_location_mode: arrived ? "together_check" : "travel_to_partner",

      widget_distance_km: distanceKm,
      widget_distance_progress: distanceProgress,

      updated_at: now,
    };

    await Promise.all([
      relRef.set(relUpdate, { merge: true }),
      myViewRef.set(myViewUpdate, { merge: true }),
    ]);

    await syncLoveBuddyWidgetStateInternal(db, relationshipId);

    return {
      success: true,
      code: "OK",
      relationshipId,
      distanceKm,
      distanceProgress,
      arrived,
      liveLocationMode: arrived ? "together_check" : "travel_to_partner",
      updatedAt: nowTs.toMillis(),
    };
  });

async function syncLoveBuddyWidgetStateInternal(db, relationshipId) {
  const relRef = db.collection(REL_COL).doc(relationshipId);
  const relSnap = await relRef.get();
  if (!relSnap.exists) return;

  const rel = relSnap.data() || {};
  const userAId = rel.userA_id;
  const userBId = rel.userB_id;
  if (!userAId || !userBId) return;

  const userAViewRef = db.collection(VIEWS_COL).doc(userAId);
  const userBViewRef = db.collection(VIEWS_COL).doc(userBId);

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
    if (aView.my_sleep_status === true && bView.my_sleep_status === true) {
      return "sleep_both";
    }
    if (aView.my_sleep_status === true) return `sleep_${userAPet}`;
    if (bView.my_sleep_status === true) return `sleep_${userBPet}`;
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
      widget_travel_event_id: rel.love_buddies_travel_event_id || "",

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
      widget_travel_event_id: rel.love_buddies_travel_event_id || "",

      live_location_active: liveLocationActive,
      live_location_mode: liveLocationMode,

      widget_updated_at: now,
      updated_at: now,
    },
    { merge: true },
  );

  await batch.commit();
}
