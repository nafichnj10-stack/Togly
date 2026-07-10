const functions = require("firebase-functions");
const admin = require("firebase-admin");
try {
  admin.app();
} catch {
  admin.initializeApp();
}

const db = admin.firestore();
const REGION = "europe-west3";

function nonEmptyString(v) {
  return typeof v === "string" && v.trim().length > 0 ? v.trim() : "";
}

function pickNonEmpty(obj, keys) {
  for (const k of keys) {
    const v = obj?.[k];
    const s = nonEmptyString(v);
    if (s) return s;
  }
  return "";
}

function pickNumber(obj, keys) {
  for (const k of keys) {
    const v = obj?.[k];
    const n = Number(v);
    if (Number.isFinite(n)) return n;
  }
  return null;
}

function profileFromPublic(pub) {
  return {
    name: pickNonEmpty(pub, ["name", "display_name", "displayName"]),
    city: pickNonEmpty(pub, ["city", "City"]),
    country_name: pickNonEmpty(pub, ["country_name", "countryName"]),
    country_code: pickNonEmpty(pub, ["country_code", "countryCode"]),
    home_lat: pickNumber(pub, ["home_lat", "homeLat"]),
    home_lng: pickNumber(pub, ["home_lng", "homeLng"]),
    photo_url: pickNonEmpty(pub, ["photo_url", "photoUrl", "photoURL"]),
    love_code: pickNonEmpty(pub, ["love_code", "loveCode"]),
  };
}

exports.syncRelationshipViewProfile = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Authentication required.",
      );
    }

    const uid = context.auth.uid;

    const userRef = db.collection("Users").doc(uid);
    const myViewRef = db.collection("relationship_views").doc(uid);
    const myPubRef = db.collection("PublicUsers").doc(uid);

    const [userSnap, myViewSnap, myPubSnap] = await Promise.all([
      userRef.get(),
      myViewRef.get(),
      myPubRef.get(),
    ]);

    const user = userSnap.exists ? userSnap.data() || {} : {};
    const myView = myViewSnap.exists ? myViewSnap.data() || {} : {};
    const myPub = myPubSnap.exists ? myPubSnap.data() || {} : {};

    const relationshipId =
      nonEmptyString(myView.relationship_id) ||
      nonEmptyString(user.relationship_id);

    const partnerUid = nonEmptyString(myView.partner_uid);

    if (!relationshipId) {
      return {
        ok: false,
        code: "NO_RELATIONSHIP_ID",
        uid,
        relationshipId: "",
        partnerUid: "",
      };
    }

    if (!partnerUid) {
      return {
        ok: false,
        code: "NO_PARTNER_UID",
        uid,
        relationshipId,
        partnerUid: "",
      };
    }

    if (!myPubSnap.exists) {
      return {
        ok: false,
        code: "NO_PUBLIC_USER",
        uid,
        relationshipId,
        partnerUid,
      };
    }

    const me = profileFromPublic(myPub);
    const now = admin.firestore.FieldValue.serverTimestamp();

    const setIfNonEmpty = (obj, key, value) => {
      if (nonEmptyString(value)) obj[key] = value;
    };

    const setIfNumber = (obj, key, value) => {
      const n = Number(value);
      if (Number.isFinite(n)) obj[key] = n;
    };

    const myUpdate = {
      updated_at: now,
      profile_synced_at: now,
      relationship_status: "active",
    };

    setIfNonEmpty(myUpdate, "my_name", me.name);
    setIfNonEmpty(myUpdate, "my_city", me.city);
    setIfNonEmpty(myUpdate, "my_country_name", me.country_name);
    setIfNonEmpty(myUpdate, "my_country_code", me.country_code);
    setIfNumber(myUpdate, "my_home_lat", me.home_lat);
    setIfNumber(myUpdate, "my_home_lng", me.home_lng);
    setIfNonEmpty(myUpdate, "my_photo_url", me.photo_url);
    setIfNonEmpty(myUpdate, "my_love_code", me.love_code);

    const partnerUpdate = {
      updated_at: now,
      profile_synced_at: now,
      relationship_status: "active",
    };

    setIfNonEmpty(partnerUpdate, "partner_name", me.name);
    setIfNonEmpty(partnerUpdate, "partner_city", me.city);
    setIfNonEmpty(partnerUpdate, "partner_country_name", me.country_name);
    setIfNonEmpty(partnerUpdate, "partner_country_code", me.country_code);
    setIfNumber(partnerUpdate, "partner_home_lat", me.home_lat);
    setIfNumber(partnerUpdate, "partner_home_lng", me.home_lng);
    setIfNonEmpty(partnerUpdate, "partner_photo_url", me.photo_url);
    setIfNonEmpty(partnerUpdate, "partner_love_code", me.love_code);

    const partnerViewRef = db.collection("relationship_views").doc(partnerUid);

    const batch = db.batch();

    batch.set(myViewRef, myUpdate, { merge: true });
    batch.set(partnerViewRef, partnerUpdate, { merge: true });

    batch.set(
      userRef,
      {
        updated_at: now,
      },
      { merge: true },
    );

    await batch.commit();

    return {
      ok: true,
      code: "OK",
      uid,
      relationshipId,
      partnerUid,
    };
  });
