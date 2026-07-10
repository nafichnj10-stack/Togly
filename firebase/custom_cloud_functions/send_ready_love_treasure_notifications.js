const functions = require("firebase-functions");
const admin = require("firebase-admin");

if (!admin.apps.length) {
  admin.initializeApp();
}

const db = admin.firestore();
const messaging = admin.messaging();

const REGION = "europe-west3";

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
  for (const [k, v] of Object.entries(obj || {})) {
    out[String(k)] = String(v);
  }
  return out;
}

async function getUser(uid) {
  const snap = await db.collection("Users").doc(uid).get();
  return snap.exists ? snap.data() || {} : {};
}

async function getUserLang(uid) {
  const user = await getUser(uid);
  return normalizeLang(user.appLanguage || "en");
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

async function isAllowedLoveTreasureReady(uid) {
  const user = await getUser(uid);

  if (user.muteAllNotifications === true) return false;
  if (user.sharedMomentsEnabled !== true) return false;

  return true;
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

function getReadyCopy(lang) {
  return {
    title: t(lang, {
      en: "Your Love Treasure is ready ✨",
      de: "Eure Liebestruhe ist bereit ✨",
      es: "Su tesoro de amor está listo ✨",
    }),
    body: t(lang, {
      en: "Open it together and discover your surprises 💕",
      de: "Öffnet sie gemeinsam und entdeckt eure Überraschungen 💕",
      es: "Ábranlo juntos y descubran sus sorpresas 💕",
    }),
  };
}

exports.sendReadyLoveTreasureNotifications = functions
  .region(REGION)
  .pubsub.schedule("every 5 minutes")
  .timeZone("Europe/Berlin")
  .onRun(async () => {
    const now = admin.firestore.Timestamp.now();

    const snap = await db
      .collection("love_treasures")
      .where("status", "==", "active")
      .where("unlockAt", "<=", now)
      .limit(20)
      .get();

    if (snap.empty) {
      console.log("No ready Love Treasures found.");
      return null;
    }

    const results = [];

    for (const doc of snap.docs) {
      const treasure = doc.data() || {};
      const treasureRef = doc.ref;

      if (treasure.readyNotificationSent === true) {
        continue;
      }

      const createdByUid = String(treasure.createdByUid || "").trim();
      const partnerUid = String(treasure.partnerUid || "").trim();
      const relationshipId = String(treasure.relationship_id || "").trim();

      const recipientUids = Array.from(
        new Set([createdByUid, partnerUid].filter((uid) => uid.length > 0)),
      );

      const notifiedUids = [];

      for (const targetUid of recipientUids) {
        const allowed = await isAllowedLoveTreasureReady(targetUid);

        if (!allowed) {
          results.push({
            treasureId: doc.id,
            targetUid,
            skipped: true,
            reason: "DISABLED_BY_PREFS",
          });
          continue;
        }

        const tokens = await getTokensForUid(targetUid);

        if (!tokens.length) {
          results.push({
            treasureId: doc.id,
            targetUid,
            skipped: true,
            reason: "NO_TOKENS",
          });
          continue;
        }

        const lang = await getUserLang(targetUid);
        const copy = getReadyCopy(lang);

        const route = "love_treasure_page_two";

        const navParams = {
          treasureId: doc.id,
          relationshipId,
          type: "love_treasure_ready",
        };

        const ffNav = buildFlutterFlowNavData(route, navParams);

        const res = await messaging.sendEachForMulticast({
          tokens,
          notification: {
            title: copy.title,
            body: copy.body,
          },
          data: toStringMap({
            type: "love_treasure_ready",
            route,
            treasureId: doc.id,
            relationshipId,
            ...ffNav,
          }),
        });

        notifiedUids.push(targetUid);

        results.push({
          treasureId: doc.id,
          targetUid,
          sent: res.successCount || 0,
          failed: res.failureCount || 0,
        });
      }

      await treasureRef.update({
        status: "ready",
        readyNotificationSent: true,
        readyNotificationSentAt: admin.firestore.FieldValue.serverTimestamp(),
        readyNotifiedUserUids: notifiedUids,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }

    console.log("sendReadyLoveTreasureNotifications results:", results);
    return null;
  });
