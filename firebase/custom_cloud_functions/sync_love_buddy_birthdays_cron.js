const functions = require("firebase-functions");
const admin = require("firebase-admin");
// Do not call admin.initializeApp() in FlutterFlow Cloud Functions.
try {
  admin.app();
} catch {
  admin.initializeApp();
}

const db = admin.firestore();
const messaging = admin.messaging();

const ROUTE_ON_TAP = "home";

function isBirthdayToday(value, now) {
  if (!value) return false;

  let date;

  if (typeof value.toDate === "function") {
    date = value.toDate();
  } else {
    date = new Date(value);
  }

  if (!date || isNaN(date.getTime())) return false;

  return date.getMonth() === now.getMonth() && date.getDate() === now.getDate();
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

function dayKey(date) {
  const y = date.getFullYear();
  const m = String(date.getMonth() + 1).padStart(2, "0");
  const d = String(date.getDate()).padStart(2, "0");
  return `${y}${m}${d}`;
}

async function getUserTokens(uid) {
  const snap = await db
    .collection("Users")
    .doc(uid)
    .collection("fcm_tokens")
    .get();

  return snap.docs
    .map((d) => d.get("fcm_token") || d.get("token") || d.id)
    .filter((t) => typeof t === "string" && t.length > 10);
}

async function canReceiveBirthdayPush(uid) {
  try {
    const snap = await db.collection("Users").doc(uid).get();
    const user = snap.exists ? snap.data() || {} : {};

    if (user.muteAllNotifications === true) return false;
    if (user.pushGeneral === false) return false;

    return true;
  } catch {
    return false;
  }
}

async function getUserDisplayName(uid) {
  try {
    const pubSnap = await db.collection("PublicUsers").doc(uid).get();
    const pub = pubSnap.exists ? pubSnap.data() || {} : {};

    const pubName =
      pub.display_name ||
      pub.displayName ||
      pub.name ||
      pub.full_name ||
      pub.fullName ||
      "";

    if (nonEmptyString(pubName)) return nonEmptyString(pubName);

    const userSnap = await db.collection("Users").doc(uid).get();
    const user = userSnap.exists ? userSnap.data() || {} : {};

    return nonEmptyString(
      user.display_name ||
        user.displayName ||
        user.name ||
        user.full_name ||
        user.fullName ||
        "",
    );
  } catch {
    return "";
  }
}

async function getUserLang(uid) {
  try {
    const snap = await db.collection("Users").doc(uid).get();
    const user = snap.exists ? snap.data() || {} : {};
    return normalizeLang(user.appLanguage || user.widget_language || "en");
  } catch {
    return "en";
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

async function sendBirthdayReminderPush({
  receiverUid,
  birthdayUid,
  relationshipId,
  birthdayName,
  bothHaveBirthday,
}) {
  if (!receiverUid) return false;

  const canPush = await canReceiveBirthdayPush(receiverUid);
  if (!canPush) return false;

  const tokens = await getUserTokens(receiverUid);
  if (!tokens.length) return false;

  const lang = await getUserLang(receiverUid);

  let title;
  let body;

  if (bothHaveBirthday) {
    title = t(lang, {
      en: "🎂 Birthday party mode!",
      de: "🎂 Geburtstags-Party-Modus!",
      es: "🎂 ¡Modo fiesta de cumpleaños!",
    });

    body = t(lang, {
      en: "You both have birthday today. Your pets are celebrating you two 🐾💜",
      de: "Ihr habt beide heute Geburtstag. Eure Haustiere feiern euch beide 🐾💜",
      es: "Ambos cumplen años hoy. Sus mascotas están celebrando con ustedes 🐾💜",
    });
  } else {
    const name =
      birthdayName ||
      t(lang, {
        en: "your partner",
        de: "dein Partner",
        es: "tu pareja",
      });

    title = t(lang, {
      en: `🎂 Today is ${name}'s birthday!`,
      de: `🎂 ${name} hat heute Geburtstag!`,
      es: `🎂 ¡Hoy es el cumpleaños de ${name}!`,
    });

    body = t(lang, {
      en: "Send birthday love through your pet widget 🐾💜",
      de: "Sende Geburtstagsliebe über dein Haustier-Widget 🐾💜",
      es: "Envía amor de cumpleaños desde tu widget de mascotas 🐾💜",
    });
  }

  const navParams = {
    type: bothHaveBirthday ? "birthday_both_reminder" : "birthday_reminder",
    birthdayUid: birthdayUid || "",
    receiverUid,
    relationshipId,
    bothHaveBirthday: bothHaveBirthday ? "true" : "false",
  };

  const ffNav = buildFlutterFlowNavData(ROUTE_ON_TAP, navParams);

  await messaging.sendEachForMulticast({
    tokens,
    notification: { title, body },
    data: {
      type: bothHaveBirthday ? "birthday_both_reminder" : "birthday_reminder",
      route: ROUTE_ON_TAP,
      relationshipId,
      birthdayUid: birthdayUid || "",
      receiverUid,
      bothHaveBirthday: bothHaveBirthday ? "true" : "false",
      ...ffNav,
    },
  });

  return true;
}

async function syncBirthdayWidgetStateForRelationship(relRef, rel) {
  const userAId = rel.userA_id;
  const userBId = rel.userB_id;

  if (!userAId || !userBId) return;

  const birthdayActive = rel.love_buddies_birthday_active === true;
  const birthdayUserUids = Array.isArray(rel.love_buddies_birthday_user_uids)
    ? rel.love_buddies_birthday_user_uids
    : [];

  const now = admin.firestore.FieldValue.serverTimestamp();

  const userAViewRef = db.collection("relationship_views").doc(userAId);
  const userBViewRef = db.collection("relationship_views").doc(userBId);

  const batch = db.batch();

  if (birthdayActive) {
    batch.set(
      relRef,
      {
        love_buddies_widget_state: "birthday",
        love_buddies_widget_background_key: "birthday",
        love_buddies_widget_birthday_active: true,
        love_buddies_widget_birthday_user_uids: birthdayUserUids,
        love_buddies_widget_updated_at: now,
      },
      { merge: true },
    );

    batch.set(
      userAViewRef,
      {
        widget_state: "birthday",
        widget_background_key: "birthday",
        widget_birthday_active: true,
        widget_birthday_user_uids: birthdayUserUids,
        widget_updated_at: now,
        updated_at: now,
      },
      { merge: true },
    );

    batch.set(
      userBViewRef,
      {
        widget_state: "birthday",
        widget_background_key: "birthday",
        widget_birthday_active: true,
        widget_birthday_user_uids: birthdayUserUids,
        widget_updated_at: now,
        updated_at: now,
      },
      { merge: true },
    );
  } else {
    batch.set(
      relRef,
      {
        love_buddies_widget_birthday_active: false,
        love_buddies_widget_birthday_user_uids: [],
        love_buddies_widget_updated_at: now,
      },
      { merge: true },
    );

    batch.set(
      userAViewRef,
      {
        widget_birthday_active: false,
        widget_birthday_user_uids: [],
        widget_updated_at: now,
        updated_at: now,
      },
      { merge: true },
    );

    batch.set(
      userBViewRef,
      {
        widget_birthday_active: false,
        widget_birthday_user_uids: [],
        widget_updated_at: now,
        updated_at: now,
      },
      { merge: true },
    );
  }

  await batch.commit();
}

exports.syncLoveBuddyBirthdaysCron = functions
  .region("europe-west3")
  .pubsub.schedule("10 0 * * *")
  .timeZone("Europe/Berlin")
  .onRun(async () => {
    const nowDate = new Date();
    const todayKey = dayKey(nowDate);
    const nowTs = admin.firestore.FieldValue.serverTimestamp();

    const relationshipsSnap = await db.collection("relationships").get();

    let checked = 0;
    let activeBirthdays = 0;
    let birthdayPushesSent = 0;

    for (const relDoc of relationshipsSnap.docs) {
      checked++;

      const relRef = relDoc.ref;
      const rel = relDoc.data() || {};

      const userAId = rel.userA_id;
      const userBId = rel.userB_id;

      if (!userAId || !userBId) continue;

      const [userASnap, userBSnap] = await Promise.all([
        db.collection("Users").doc(userAId).get(),
        db.collection("Users").doc(userBId).get(),
      ]);

      const userA = userASnap.exists ? userASnap.data() || {} : {};
      const userB = userBSnap.exists ? userBSnap.data() || {} : {};

      const birthdayUserUids = [];

      if (isBirthdayToday(userA.birthday, nowDate)) {
        birthdayUserUids.push(userAId);
      }

      if (isBirthdayToday(userB.birthday, nowDate)) {
        birthdayUserUids.push(userBId);
      }

      const birthdayActive = birthdayUserUids.length > 0;
      const bothHaveBirthday =
        birthdayUserUids.includes(userAId) &&
        birthdayUserUids.includes(userBId);

      if (birthdayActive) activeBirthdays++;

      const wasActive = rel.love_buddies_birthday_active === true;

      const updateData = {
        love_buddies_birthday_active: birthdayActive,
        love_buddies_birthday_user_uids: birthdayUserUids,
        love_buddies_updated_at: nowTs,
      };

      if (birthdayActive && !wasActive) {
        updateData.love_buddies_birthday_started_at = nowTs;
        updateData.love_buddies_birthday_ended_at = null;
      }

      if (!birthdayActive && wasActive) {
        updateData.love_buddies_birthday_ended_at = nowTs;
      }

      await relRef.set(updateData, { merge: true });

      const updatedRelSnap = await relRef.get();
      const updatedRel = updatedRelSnap.data() || {};

      await syncBirthdayWidgetStateForRelationship(relRef, updatedRel);

      if (birthdayActive) {
        const lastReminderDayKey =
          typeof rel.love_buddies_birthday_reminder_day_key === "string"
            ? rel.love_buddies_birthday_reminder_day_key
            : "";

        if (lastReminderDayKey !== todayKey) {
          const namesByUid = {
            [userAId]: await getUserDisplayName(userAId),
            [userBId]: await getUserDisplayName(userBId),
          };

          if (bothHaveBirthday) {
            const sentA = await sendBirthdayReminderPush({
              receiverUid: userAId,
              birthdayUid: "",
              relationshipId: relDoc.id,
              birthdayName: "",
              bothHaveBirthday: true,
            });

            const sentB = await sendBirthdayReminderPush({
              receiverUid: userBId,
              birthdayUid: "",
              relationshipId: relDoc.id,
              birthdayName: "",
              bothHaveBirthday: true,
            });

            if (sentA) birthdayPushesSent++;
            if (sentB) birthdayPushesSent++;
          } else {
            for (const birthdayUid of birthdayUserUids) {
              const receiverUid = birthdayUid === userAId ? userBId : userAId;

              const sent = await sendBirthdayReminderPush({
                receiverUid,
                birthdayUid,
                relationshipId: relDoc.id,
                birthdayName: namesByUid[birthdayUid],
                bothHaveBirthday: false,
              });

              if (sent) birthdayPushesSent++;
            }
          }

          await relRef.set(
            {
              love_buddies_birthday_reminder_day_key: todayKey,
              love_buddies_birthday_reminder_sent_at: nowTs,
            },
            { merge: true },
          );
        }
      }
    }

    console.log(
      `[syncLoveBuddyBirthdaysCron] checked=${checked}, activeBirthdays=${activeBirthdays}, birthdayPushesSent=${birthdayPushesSent}`,
    );

    return null;
  });
