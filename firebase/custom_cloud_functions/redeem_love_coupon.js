const functions = require("firebase-functions");
const admin = require("firebase-admin");

try {
  admin.app();
} catch (e) {
  admin.initializeApp();
}

const db = admin.firestore();
const REGION = "europe-west3";

function normalizeLang(raw) {
  let lang = String(raw || "en")
    .toLowerCase()
    .trim();
  if (lang.indexOf("-") >= 0) lang = lang.split("-")[0];
  if (lang.indexOf("_") >= 0) lang = lang.split("_")[0];
  return ["en", "de", "es"].includes(lang) ? lang : "en";
}

function getLocalizedRedeemPush(language, redeemerName, couponTitle) {
  const lang = normalizeLang(language);

  if (lang === "de") {
    return {
      title: "💝 Gutschein eingelöst",
      body:
        redeemerName + " hat deinen Gutschein „" + couponTitle + "“ eingelöst.",
    };
  }

  if (lang === "es") {
    return {
      title: "💝 Cupón canjeado",
      body: redeemerName + ' ha canjeado tu cupón "' + couponTitle + '".',
    };
  }

  return {
    title: "💝 Coupon redeemed",
    body: redeemerName + ' redeemed your coupon "' + couponTitle + '".',
  };
}

async function getUserDisplayName(uid) {
  if (!uid) return "Your partner";

  const publicUserSnap = await db.collection("PublicUsers").doc(uid).get();
  const publicData = publicUserSnap.exists ? publicUserSnap.data() || {} : {};

  return (
    String(publicData.display_name || "").trim() ||
    String(publicData.displayName || "").trim() ||
    String(publicData.name || "").trim() ||
    "Your partner"
  );
}

async function canNotifyUser(uid) {
  try {
    const snap = await db.collection("Users").doc(uid).get();
    const u = snap.exists ? snap.data() || {} : {};

    if (u.muteAllNotifications === true) return false;
    if (u.sharedMomentsEnabled !== true) return false;

    return true;
  } catch (e) {
    console.log(
      "[redeemLoveCoupon] canNotifyUser failed:",
      String(e && e.message ? e.message : e),
    );
    return false;
  }
}

async function getTokensForUid(uid) {
  try {
    const snap = await db
      .collection("Users")
      .doc(uid)
      .collection("fcm_tokens")
      .get();

    if (snap.empty) return [];

    return snap.docs
      .map(function (d) {
        return d.get("fcm_token") || d.get("token") || d.id;
      })
      .filter(function (tok) {
        return typeof tok === "string" && tok.trim().length > 10;
      })
      .map(function (tok) {
        return tok.trim();
      });
  } catch (e) {
    console.log(
      "[redeemLoveCoupon] getTokensForUid failed:",
      String(e && e.message ? e.message : e),
    );
    return [];
  }
}

function buildFlutterFlowNavData(route, paramsObj) {
  const page = String(route || "").trim();
  const paramData = JSON.stringify(paramsObj || {});

  return {
    click_action: "FLUTTER_NOTIFICATION_CLICK",
    initial_page_name: page,
    initialPageName: page,
    parameter_data: paramData,
    parameterData: paramData,
  };
}

async function sendPushToUser(uid, title, body, data) {
  const allowed = await canNotifyUser(uid);

  if (!allowed) {
    return {
      sent: 0,
      failed: 0,
      skipped: true,
      reason: "notifications_disabled",
    };
  }

  const tokens = await getTokensForUid(uid);

  if (!tokens.length) {
    return {
      sent: 0,
      failed: 0,
      skipped: true,
      reason: "no_tokens",
    };
  }

  const route = "coupon_wallet";
  const ffNav = buildFlutterFlowNavData(route, data || {});

  const messageData = {
    type: "love_coupon_redeemed",
    route: route,
    click_action: ffNav.click_action,
    initial_page_name: ffNav.initial_page_name,
    initialPageName: ffNav.initialPageName,
    parameter_data: ffNav.parameter_data,
    parameterData: ffNav.parameterData,
    relationshipId: String(
      data && data.relationshipId ? data.relationshipId : "",
    ),
    couponId: String(data && data.couponId ? data.couponId : ""),
  };

  const response = await admin.messaging().sendEachForMulticast({
    tokens: tokens,
    notification: {
      title: title,
      body: body,
    },
    data: messageData,
  });

  return {
    sent: response.successCount || 0,
    failed: response.failureCount || 0,
    skipped: false,
    reason: "",
  };
}

exports.redeemLoveCoupon = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    try {
      const uid = context && context.auth ? context.auth.uid : null;

      if (!uid) {
        throw new functions.https.HttpsError(
          "unauthenticated",
          "User must be logged in.",
        );
      }

      const relationshipId =
        data && data.relationshipId ? String(data.relationshipId).trim() : "";

      const couponId =
        data && data.couponId ? String(data.couponId).trim() : "";

      if (!relationshipId || !couponId) {
        throw new functions.https.HttpsError(
          "invalid-argument",
          "Missing relationshipId or couponId.",
        );
      }

      const relationshipRef = db
        .collection("relationships")
        .doc(relationshipId);
      const couponRef = relationshipRef
        .collection("love_coupons")
        .doc(couponId);

      const result = await db.runTransaction(async (tx) => {
        const relationshipSnap = await tx.get(relationshipRef);
        const couponSnap = await tx.get(couponRef);

        if (!relationshipSnap.exists) {
          throw new functions.https.HttpsError(
            "not-found",
            "Relationship not found.",
          );
        }

        if (!couponSnap.exists) {
          throw new functions.https.HttpsError(
            "not-found",
            "Coupon not found.",
          );
        }

        const coupon = couponSnap.data() || {};

        const createdForUserId = String(
          coupon.created_for_user_id || "",
        ).trim();
        const createdByUserId = String(coupon.created_by_user_id || "").trim();
        const status = String(coupon.status || "").trim();

        if (createdForUserId !== uid) {
          throw new functions.https.HttpsError(
            "permission-denied",
            "Only the receiver can redeem this coupon.",
          );
        }

        if (status !== "active") {
          throw new functions.https.HttpsError(
            "failed-precondition",
            "Coupon is not active.",
          );
        }

        if (!createdByUserId) {
          throw new functions.https.HttpsError(
            "failed-precondition",
            "Coupon creator is missing.",
          );
        }

        tx.update(couponRef, {
          status: "redeemed",
          is_redeemed: true,
          redeemed_at: admin.firestore.FieldValue.serverTimestamp(),
          redeemed_by_user_id: uid,
          updated_at: admin.firestore.FieldValue.serverTimestamp(),
        });

        return {
          couponTitle:
            String(coupon.title || "Love Coupon").trim() || "Love Coupon",
          creatorUid: createdByUserId,
        };
      });

      const creatorUserSnap = await db
        .collection("Users")
        .doc(result.creatorUid)
        .get();

      const creatorData = creatorUserSnap.exists
        ? creatorUserSnap.data() || {}
        : {};

      const creatorLanguage = creatorData.appLanguage || "en";
      const redeemerName = await getUserDisplayName(uid);

      const pushText = getLocalizedRedeemPush(
        creatorLanguage,
        redeemerName,
        result.couponTitle,
      );

      const pushResult = await sendPushToUser(
        result.creatorUid,
        pushText.title,
        pushText.body,
        {
          relationshipId: relationshipId,
          couponId: couponId,
        },
      );

      return {
        ok: true,
        code: "OK",
        message: "Coupon redeemed successfully.",
        couponId: couponId,
        relationshipId: relationshipId,
        status: "redeemed",
        pushSent: pushResult.sent,
        pushFailed: pushResult.failed,
        pushSkipped: pushResult.skipped || false,
        pushReason: pushResult.reason || "",
      };
    } catch (error) {
      console.error("redeemLoveCoupon error:", error);

      if (error instanceof functions.https.HttpsError) {
        throw error;
      }

      throw new functions.https.HttpsError(
        "internal",
        error && error.message
          ? error.message
          : "Unknown error in redeemLoveCoupon.",
      );
    }
  });
