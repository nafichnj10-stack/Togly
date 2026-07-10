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
const REL_VIEWS = "relationship_views";
const USERS = "Users";

const ROUTE_ON_TAP = "home";

// decay rule
const DECAY_POINTS = 1; // -1
const DECAY_EVERY_HOURS = 6; // per 6h
const CRON_LIMIT = 200; // batch size per run

// cursor doc (pagination state)
const CRON_STATE_COL = "_cron_state";
const CRON_STATE_DOC = "loveBuddyDecay";

// thresholds
function computeState(score) {
  if (score >= 65) return "happy";
  if (score >= 30) return "sad";
  return "angry";
}

function clamp(val, min, max) {
  return Math.max(min, Math.min(max, val));
}

/* -------------------- language helpers -------------------- */
function normalizeLang(raw) {
  let lang = String(raw || "en")
    .toLowerCase()
    .trim();
  if (lang.includes("-")) lang = lang.split("-")[0];
  if (lang.includes("_")) lang = lang.split("_")[0];
  return ["en", "de", "es"].includes(lang) ? lang : "en";
}

async function getUserLang(uid) {
  try {
    const snap = await db.collection(USERS).doc(uid).get();
    return normalizeLang(snap.exists ? snap.get("appLanguage") : "en");
  } catch {
    return "en";
  }
}

function t(lang, { en, de, es }) {
  return lang === "de" ? de : lang === "es" ? es : en;
}

/* -------------------- push helpers -------------------- */

async function getTokensForUid(uid) {
  const snap = await db
    .collection(USERS)
    .doc(uid)
    .collection("fcm_tokens")
    .get();
  if (snap.empty) return [];
  return snap.docs
    .map((d) => d.get("fcm_token") || d.get("token") || d.id)
    .filter((tok) => typeof tok === "string" && tok.length > 10);
}

async function canSendLoveBuddyPush(uid) {
  try {
    const snap = await db.collection(USERS).doc(uid).get();
    if (!snap.exists) return false;
    const u = snap.data() || {};
    if (u.muteAllNotifications === true) return false;
    // currently tied to shared moments setting
    if (u.sharedMomentsEnabled !== true) return false;
    return true;
  } catch {
    return false;
  }
}

async function pushToUid(uid, { title, body, relationshipId }) {
  if (!(await canSendLoveBuddyPush(uid))) {
    return { ok: true, skipped: true, reason: "DISABLED" };
  }

  const tokens = await getTokensForUid(uid);
  if (!tokens.length) {
    return { ok: true, skipped: true, reason: "NO_TOKENS" };
  }

  const res = await messaging.sendEachForMulticast({
    tokens,
    notification: { title, body },
    data: {
      type: "lovebuddy_decay",
      route: ROUTE_ON_TAP,
      relationshipId: String(relationshipId || ""),
    },
  });

  return {
    ok: true,
    sent: res.successCount || 0,
    failed: res.failureCount || 0,
  };
}

/* -------------------- local time helpers -------------------- */

function localDayKeyByOffset(tsMillis, offsetMinutes) {
  const ms = tsMillis + Number(offsetMinutes || 0) * 60 * 1000;
  const d = new Date(ms);
  const y = d.getUTCFullYear();
  const m = String(d.getUTCMonth() + 1).padStart(2, "0");
  const day = String(d.getUTCDate()).padStart(2, "0");
  return `${y}-${m}-${day}`;
}

function localHourByOffset(tsMillis, offsetMinutes) {
  const ms = tsMillis + Number(offsetMinutes || 0) * 60 * 1000;
  const d = new Date(ms);
  return d.getUTCHours();
}

function canSendAtLocalHour(hour) {
  return hour >= 9 && hour < 22;
}

/* -------------------- main cron -------------------- */

exports.loveBuddyDecayCron = functions
  .region(REGION)
  .pubsub.schedule("every 30 minutes")
  .timeZone("Europe/Berlin")
  .onRun(async () => {
    const now = admin.firestore.Timestamp.now();
    const nowMs = now.toMillis();

    // ---- load cursor ----
    const stateRef = db.collection(CRON_STATE_COL).doc(CRON_STATE_DOC);
    const stateSnap = await stateRef.get();
    const state = stateSnap.exists ? stateSnap.data() || {} : {};
    const lastRelId = String(state.lastRelationshipId || "");
    const lastDocId = String(state.lastDocId || "");

    // ---- query with pagination ----
    let q = db
      .collection(REL_VIEWS)
      .where("relationship_id", "!=", null)
      .orderBy("relationship_id")
      .orderBy(admin.firestore.FieldPath.documentId())
      .limit(CRON_LIMIT);

    if (lastRelId && lastDocId) {
      q = q.startAfter(lastRelId, lastDocId);
    }

    const snap = await q.get();

    // if end reached, reset cursor and exit
    if (snap.empty) {
      await stateRef.set(
        {
          lastRelationshipId: "",
          lastDocId: "",
          updated_at: now,
        },
        { merge: true },
      );
      return { ok: true, processed: 0, resetCursor: true };
    }

    const updates = [];
    const pushJobs = [];

    for (const doc of snap.docs) {
      const v = doc.data() || {};

      // Freeze: skip if paused OR missing relationship_id
      if (v.paused === true) continue;

      const rid = String(v.relationship_id || "").trim();
      if (!rid) continue;

      const lastUpdate = v.love_last_update;
      const lastMs = lastUpdate?.toMillis ? lastUpdate.toMillis() : null;

      const currentScore = Number(v.love_score ?? 65);
      const currentState = String(v.love_state || computeState(currentScore));

      // Reset today points when local day changes (based on my_tz_offset_minutes)
      const tzOffset = Number(v.my_tz_offset_minutes || 0);
      const lastKey =
        v.love_today_key ||
        (lastMs ? localDayKeyByOffset(lastMs, tzOffset) : null);
      const nowKey = localDayKeyByOffset(nowMs, tzOffset);
      const shouldResetToday = lastKey && nowKey && lastKey !== nowKey;

      // Decay only if we have a last timestamp and 6h passed
      let newScore = currentScore;
      let appliedSteps = 0;

      if (lastMs) {
        const diffHours = (nowMs - lastMs) / (1000 * 60 * 60);
        if (diffHours >= DECAY_EVERY_HOURS) {
          appliedSteps = Math.floor(diffHours / DECAY_EVERY_HOURS);
          const decay = appliedSteps * DECAY_POINTS;
          newScore = clamp(currentScore - decay, 0, 100);
        }
      }

      const newState = computeState(newScore);

      // Push throttle
      const lastPushAt = v.love_last_push_at?.toMillis
        ? v.love_last_push_at.toMillis()
        : 0;
      const pushCooldownMin = 180; // 3h
      const canPushNow = nowMs - lastPushAt >= pushCooldownMin * 60 * 1000;

      const stateChanged = newState !== currentState;
      const nearSad = newScore <= 67 && newScore > 65;
      const nearAngry = newScore <= 32 && newScore > 30;

      const shouldPush = canPushNow && (stateChanged || nearSad || nearAngry);

      const willUpdate =
        shouldResetToday ||
        appliedSteps > 0 ||
        currentState !== newState ||
        Number(v.love_percent || 0) !== newScore / 100;

      if (willUpdate) {
        const patch = {
          love_score: newScore,
          love_percent: newScore / 100,
          love_state: newState,
          updated_at: now,
        };

        if (appliedSteps > 0) patch.love_last_update = now;

        if (shouldResetToday) {
          patch.love_today_points = 0;
          patch.love_today_key = nowKey;
        } else {
          patch.love_today_key = nowKey;
        }

        // only mark push timestamp when we actually queue a push
        const targetUid = String(v.uid || doc.id).trim();
        const localHour = localHourByOffset(nowMs, tzOffset);
        const withinAllowedHours = canSendAtLocalHour(localHour);
        const shouldActuallyPush =
          shouldPush && !!targetUid && withinAllowedHours;

        if (shouldActuallyPush) {
          patch.love_last_push_at = now;
        }

        updates.push({ ref: doc.ref, patch });

        if (shouldActuallyPush) {
          pushJobs.push(
            (async () => {
              const lang = await getUserLang(targetUid);

              let title = "";
              let body = "";

              if (stateChanged) {
                if (newState === "sad") {
                  title = t(lang, {
                    en: "Companions are getting sad 💔",
                    de: "Eure Begleiter werden traurig 💔",
                    es: "Sus compañeros se están poniendo tristes 💔",
                  });
                  body = t(lang, {
                    en: "Interact together to keep the love alive.",
                    de: "Interagiert zusammen, damit die Liebe bleibt.",
                    es: "Interactúen juntos para mantener el amor.",
                  });
                } else if (newState === "angry") {
                  title = t(lang, {
                    en: "Companions are angry 😤",
                    de: "Eure Begleiter sind wütend! 😤",
                    es: "¡Sus compañeros están enfadados! 😤",
                  });
                  body = t(lang, {
                    en: "Your love needs attention. Do something together today.",
                    de: "Eure Liebe braucht Aufmerksamkeit. Macht heute etwas zusammen.",
                    es: "Su amor necesita atención. Hagan algo juntos hoy.",
                  });
                } else {
                  title = t(lang, {
                    en: "Your Companions are feeling better 💜",
                    de: "Eure Begleiter fühlen sich besser 💜",
                    es: "Sus compañeros se sienten mejor 💜",
                  });
                  body = t(lang, {
                    en: "Nice! Keep interacting together.",
                    de: "Nice! Interagiert weiter zusammen.",
                    es: "¡Bien! Sigan interactuando juntos.",
                  });
                }
              } else if (nearAngry) {
                title = t(lang, {
                  en: "Your Companions are close to getting angry. ⚠️",
                  de: "Eure Begleiter sind kurz davor, wütend zu werden. ⚠️",
                  es: "Sus compañeros están a punto de enfadarse. ⚠️",
                });
                body = t(lang, {
                  en: "Do a small interaction to prevent it dropping further.",
                  de: "Macht eine kleine Interaktion, bevor es weiter fällt.",
                  es: "Hagan una pequeña interacción para evitar que baje más.",
                });
              } else if (nearSad) {
                title = t(lang, {
                  en: "Your Companions are close to getting sad. ⚠️",
                  de: "Eure Begleiter sind kurz davor, traurig zu werden. ⚠️",
                  es: "Sus compañeros están a punto de entristecerse. ⚠️",
                });
                body = t(lang, {
                  en: "A quick action together will help.",
                  de: "Eine kurze Aktion zusammen hilft.",
                  es: "Una acción rápida juntos ayudará.",
                });
              } else {
                title = t(lang, {
                  en: "Your Companions need love. 💜",
                  de: "Eure Begleiter brauchen Liebe. 💜",
                  es: "Sus compañeros necesitan amor. 💜",
                });
                body = t(lang, {
                  en: "Interact together today.",
                  de: "Interagiert heute zusammen.",
                  es: "Interactúen hoy juntos.",
                });
              }

              return pushToUid(targetUid, {
                title,
                body,
                relationshipId: rid,
              }).catch((err) => {
                console.error("loveBuddyDecayCron push error:", err);
                return null;
              });
            })(),
          );
        }
      }
    }

    // commit updates in batches of 450
    let committed = 0;
    for (let i = 0; i < updates.length; i += 450) {
      const batch = db.batch();
      updates.slice(i, i + 450).forEach((u) => batch.update(u.ref, u.patch));
      await batch.commit();
      committed += Math.min(450, updates.length - i);
    }

    await Promise.allSettled(pushJobs);

    // ---- update cursor to last doc we fetched (even if we skipped some) ----
    const lastDoc = snap.docs[snap.docs.length - 1];
    const last = lastDoc.data() || {};
    await stateRef.set(
      {
        lastRelationshipId: String(last.relationship_id || ""),
        lastDocId: lastDoc.id,
        updated_at: now,
      },
      { merge: true },
    );

    return {
      ok: true,
      fetched: snap.size,
      updatedDocs: committed,
      pushes: pushJobs.length,
    };
  });
