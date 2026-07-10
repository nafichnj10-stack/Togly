const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports.syncLoveBuddyWidgetState = functions
  .region("europe-west3")
  .https.onCall(async (data, context) => {
    if (!context.auth || !context.auth.uid) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "You must be signed in.",
      );
    }

    const uid = context.auth.uid;
    const relationshipId = data.relationshipId;

    if (!relationshipId || typeof relationshipId !== "string") {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Missing relationshipId.",
      );
    }

    const db = admin.firestore();

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
    const returningUid = rel.love_buddies_returning_uid || null;

    const travelUpcomingActive =
      rel.love_buddies_travel_upcoming_active === true;
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

    function buildBirthdayKey() {
      const userAHasBirthday = birthdayUserUids.includes(userAId);
      const userBHasBirthday = birthdayUserUids.includes(userBId);

      if (userAHasBirthday && userBHasBirthday) {
        return "both_birthday";
      }

      if (userAHasBirthday) {
        return `${userAPet}_birthday`;
      }

      if (userBHasBirthday) {
        return `${userBPet}_birthday`;
      }

      return "birthday";
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
      widgetBackgroundKey = buildBirthdayKey();
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

    return {
      success: true,
      widget_state: widgetState,
      widget_background_key: widgetBackgroundKey,
      widget_distance_progress: distanceProgress,
      birthday_active: birthdayActive,
      birthday_user_uids: birthdayUserUids,
    };
  });
