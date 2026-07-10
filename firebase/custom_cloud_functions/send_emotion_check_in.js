// ============================
// sendEmotionCheckIn (messagesEnabled)
// ============================
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

const USERS_COL = "Users";
const REL_VIEWS_COL = "relationship_views";
const EMO_COL = "relationship_emotion_checkins";

const COOLDOWN_HOURS = 24;

function pad2(n) {
  return n < 10 ? `0${n}` : `${n}`;
}
function utcDayKey(d) {
  return `${d.getUTCFullYear()}${pad2(d.getUTCMonth() + 1)}${pad2(d.getUTCDate())}`;
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

async function getUserLang(uid) {
  try {
    const snap = await db.collection(USERS_COL).doc(uid).get();
    const u = snap.exists ? snap.data() || {} : {};
    return normalizeLang(u.appLanguage || "en");
  } catch {
    return "en";
  }
}

async function getTokensForUid(uid) {
  try {
    const snap = await db
      .collection(USERS_COL)
      .doc(uid)
      .collection("fcm_tokens")
      .get();
    if (snap.empty) return [];
    return snap.docs
      .map((d) => d.get("fcm_token") || d.get("token") || d.id)
      .filter((tok) => typeof tok === "string" && tok.length > 10);
  } catch {
    return [];
  }
}

// ✅ NOW uses messagesEnabled (and still respects muteAllNotifications)
async function canNotifyEmotion(uid) {
  try {
    const snap = await db.collection(USERS_COL).doc(uid).get();
    const u = snap.exists ? snap.data() || {} : {};
    if (u.muteAllNotifications === true) return false;
    if (u.messagesEnabled !== true) return false;
    return true;
  } catch {
    return false;
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

const ROUTE_ON_TAP = "homehome";

const CHOICES = [
  "CONNECTED",
  "CALM",
  "MISSING_YOU",
  "A_BIT_DISTANT",
  "EMOTIONALLY_CLOSE",
  "UNCERTAIN_BUT_HOPEFUL",
];

function utcEndOfDayMs(nowMs) {
  const d = new Date(nowMs);
  return Date.UTC(
    d.getUTCFullYear(),
    d.getUTCMonth(),
    d.getUTCDate(),
    23,
    59,
    59,
    999,
  );
}

function normText(s) {
  return String(s || "")
    .toLowerCase()
    .trim()
    .replace(/\s+/g, " ");
}

function mapLabelToKey(raw) {
  const s = normText(raw);
  if (!s) return "";

  const upper = String(raw || "")
    .trim()
    .toUpperCase();
  if (CHOICES.includes(upper)) return upper;

  const map = {
    connected: "CONNECTED",
    verbunden: "CONNECTED",
    conectado: "CONNECTED",
    conectada: "CONNECTED",
    conectados: "CONNECTED",
    conectadas: "CONNECTED",

    calm: "CALM",
    gelassen: "CALM",
    ruhig: "CALM",
    tranquilo: "CALM",
    tranquila: "CALM",
    tranquilos: "CALM",
    tranquilas: "CALM",

    "missing you": "MISSING_YOU",
    "miss you": "MISSING_YOU",
    "vermisse dich": "MISSING_YOU",
    "ich vermisse dich": "MISSING_YOU",
    "te extraño": "MISSING_YOU",
    "te extrano": "MISSING_YOU",
    "los extraño": "MISSING_YOU",
    "los extrano": "MISSING_YOU",
    "os extraño": "MISSING_YOU",
    "os extrano": "MISSING_YOU",

    "a bit distant": "A_BIT_DISTANT",
    "bit distant": "A_BIT_DISTANT",
    "etwas distanziert": "A_BIT_DISTANT",
    "ein bisschen distanziert": "A_BIT_DISTANT",
    "un poco distante": "A_BIT_DISTANT",

    "emotionally close": "EMOTIONALLY_CLOSE",
    "emotional nah": "EMOTIONALLY_CLOSE",
    "emotional nahe": "EMOTIONALLY_CLOSE",
    "emocionalmente cercano": "EMOTIONALLY_CLOSE",
    "emocionalmente cercana": "EMOTIONALLY_CLOSE",
    "emocionalmente cerca": "EMOTIONALLY_CLOSE",

    "uncertain but hopeful": "UNCERTAIN_BUT_HOPEFUL",
    "unsicher, aber hoffnungsvoll": "UNCERTAIN_BUT_HOPEFUL",
    "unsicher aber hoffnungsvoll": "UNCERTAIN_BUT_HOPEFUL",
    "incierto, pero esperanzado": "UNCERTAIN_BUT_HOPEFUL",
    "incierto pero esperanzado": "UNCERTAIN_BUT_HOPEFUL",
    "incierta, pero esperanzada": "UNCERTAIN_BUT_HOPEFUL",
    "incierta pero esperanzada": "UNCERTAIN_BUT_HOPEFUL",
  };

  return map[s] || "";
}

function feelingNoun(lang, key) {
  switch (key) {
    case "CONNECTED":
      return t(lang, { en: "connection", de: "Verbundenheit", es: "conexión" });
    case "CALM":
      return t(lang, { en: "calm", de: "Gelassenheit", es: "calma" });
    case "MISSING_YOU":
      return t(lang, { en: "longing", de: "Sehnsucht", es: "añoranza" });
    case "A_BIT_DISTANT":
      return t(lang, { en: "distance", de: "Distanz", es: "distancia" });
    case "EMOTIONALLY_CLOSE":
      return t(lang, {
        en: "emotional closeness",
        de: "emotionale Nähe",
        es: "cercanía emocional",
      });
    case "UNCERTAIN_BUT_HOPEFUL":
      return t(lang, {
        en: "uncertainty and hope",
        de: "Unsicherheit und Hoffnung",
        es: "incertidumbre y esperanza",
      });
    default:
      return key;
  }
}

function randomPick(arr, seed) {
  if (!arr || !arr.length) return "";
  if (typeof seed === "number" && isFinite(seed)) {
    return arr[Math.abs(seed) % arr.length];
  }
  return arr[Math.floor(Math.random() * arr.length)];
}

function buildSummary(lang, aKey, bKey, templateId) {
  const a = feelingNoun(lang, aKey);
  const b = feelingNoun(lang, bKey);

  const pair = [aKey, bKey].sort().join("|");
  const seed = (Number(templateId || 0) + pair.length) | 0;

  const variants = [
    t(lang, {
      en: `Today there is both ${a} and ${b} between you. Thank you for sharing that.`,
      de: `Heute ist bei euch sowohl ${a} als auch ${b} da. Danke, dass ihr das teilt.`,
      es: `Hoy hay tanto ${a} como ${b} entre ustedes. Gracias por compartirlo.`,
    }),
    t(lang, {
      en: `Right now you are holding two things at once: ${a} and ${b}.`,
      de: `Gerade sind zwei Dinge gleichzeitig da: ${a} und ${b}.`,
      es: `Ahora mismo están presentes dos cosas a la vez: ${a} y ${b}.`,
    }),
    t(lang, {
      en: `Your answers show ${a} alongside ${b}. Both can be true at the same time.`,
      de: `Eure Antworten zeigen ${a} zusammen mit ${b}. Beides kann gleichzeitig stimmen.`,
      es: `Sus respuestas muestran ${a} junto con ${b}. Ambas cosas pueden ser verdad a la vez.`,
    }),
    t(lang, {
      en: `There is room for ${a} and also for ${b} today.`,
      de: `Heute ist Platz für ${a} und auch für ${b}.`,
      es: `Hoy hay espacio para ${a} y también para ${b}.`,
    }),
    t(lang, {
      en: `Today you are feeling ${a} in some ways, and ${b} in others.`,
      de: `Heute fühlt ihr euch in mancher Hinsicht von ${a} getragen, und in anderer von ${b}.`,
      es: `Hoy sienten ${a} en algunos aspectos, y ${b} en otros.`,
    }),
  ];

  return String(randomPick(variants, seed) || "").trim();
}

function formatRemaining(lang, ms) {
  const totalMin = Math.max(0, Math.ceil(ms / 60000));
  const h = Math.floor(totalMin / 60);
  const m = totalMin % 60;

  if (lang === "de") {
    if (h <= 0) return `in ${m} Min.`;
    if (m === 0) return `in ${h} Std.`;
    return `in ${h} Std. ${m} Min.`;
  }
  if (lang === "es") {
    if (h <= 0) return `en ${m} min`;
    if (m === 0) return `en ${h} h`;
    return `en ${h} h ${m} min`;
  }
  if (h <= 0) return `in ${m} min`;
  if (m === 0) return `in ${h} h`;
  return `in ${h} h ${m} min`;
}

function buildStatusTexts(lang, state, ctx) {
  const who = nonEmptyString(ctx?.who);
  const cooldownUntilMs = Number(ctx?.cooldownUntilMs || 0);
  const nowMs = Number(ctx?.nowMs || 0);

  if (state === "READY") {
    return {
      statusText: t(lang, { en: "Ready", de: "Bereit", es: "Listo" }),
      snackText: "",
    };
  }

  if (state === "WAITING") {
    if (who === "ME_WAITING") {
      return {
        statusText: t(lang, {
          en: "Waiting for your partner…",
          de: "Warte auf deinen Partner…",
          es: "Esperando a tu pareja…",
        }),
        snackText: t(lang, {
          en: "Sent. Waiting for your partner 💜",
          de: "Gesendet. Warte auf deinen Partner 💜",
          es: "Enviado. Esperando a tu pareja 💜",
        }),
      };
    }
    if (who === "PARTNER_WAITING") {
      return {
        statusText: t(lang, {
          en: "Your partner answered. It’s your turn.",
          de: "Dein Partner hat geantwortet, jetzt bist du dran.",
          es: "Tu pareja respondió. Ahora te toca a ti.",
        }),
        snackText: "",
      };
    }
    return {
      statusText: t(lang, { en: "Waiting…", de: "Warte…", es: "Esperando…" }),
      snackText: "",
    };
  }

  if (state === "DONE") {
    return {
      statusText: t(lang, {
        en: "You can share again in 24 hours.",
        de: "In 24 Stunden könnt ihr eure Gefühle wieder teilen.",
        es: "Podrán compartir de nuevo en 24 horas.",
      }),
      snackText: t(lang, {
        en: "Thank you both 💜",
        de: "Danke euch beiden 💜",
        es: "Gracias a los dos 💜",
      }),
    };
  }

  if (state === "COOLDOWN") {
    const remaining = Math.max(0, cooldownUntilMs - nowMs);
    const when = formatRemaining(lang, remaining);
    return {
      statusText: t(lang, {
        en: `You can share again ${when}.`,
        de: `Ihr könnt eure Gefühle wieder teilen ${when}.`,
        es: `Podrán compartir de nuevo ${when}.`,
      }),
      snackText: "",
    };
  }

  return {
    statusText: t(lang, {
      en: "Something went wrong.",
      de: "Etwas ist schiefgelaufen.",
      es: "Algo salió mal.",
    }),
    snackText: "",
  };
}

exports.sendEmotionCheckIn = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    const uid = context.auth?.uid;
    if (!uid) {
      return {
        ok: false,
        code: "UNAUTHENTICATED",
        state: "ERROR",
        statusText: "Please log in again.",
        snackText: "Please log in again.",
      };
    }

    const mode = nonEmptyString(data?.mode) || "status"; // "status" | "choose"
    const rawChoice = nonEmptyString(data?.choice);
    const choiceKey = mapLabelToKey(rawChoice);

    const now = admin.firestore.Timestamp.now();
    const nowMs = now.toMillis();
    const dayKey = utcDayKey(new Date(nowMs));

    const myRelRef = db.collection(REL_VIEWS_COL).doc(uid);

    try {
      const txResult = await db.runTransaction(async (tx) => {
        const mySnap = await tx.get(myRelRef);
        if (!mySnap.exists)
          return { ok: false, code: "NO_REL_VIEW", state: "ERROR" };

        const my = mySnap.data() || {};
        const partnerUid = nonEmptyString(my.partner_uid);
        const relationshipId = nonEmptyString(my.relationship_id);
        if (!partnerUid || !relationshipId)
          return { ok: false, code: "NO_REL_CONTEXT", state: "ERROR" };

        const docId = `${relationshipId}_${dayKey}`;
        const emoRef = db.collection(EMO_COL).doc(docId);
        const emoSnap = await tx.get(emoRef);
        const emo = emoSnap.exists ? emoSnap.data() || {} : {};

        const existingA = nonEmptyString(emo.a_uid);
        const existingB = nonEmptyString(emo.b_uid);

        const aUid = existingA || uid;
        const bUid = existingB || partnerUid;

        const iAmA = uid === aUid;
        const myChoiceField = iAmA ? "a_choice" : "b_choice";
        const partnerChoiceField = iAmA ? "b_choice" : "a_choice";
        const myChoiceAtField = iAmA ? "a_choice_at_ms" : "b_choice_at_ms";

        const myChoice = nonEmptyString(emo[myChoiceField]);
        const partnerChoice = nonEmptyString(emo[partnerChoiceField]);

        const expiresAtMs = Number(emo.expires_at_ms || 0);
        const cooldownUntilMs = Number(emo.cooldown_until_ms || 0);

        const waitingExpired =
          expiresAtMs > 0 &&
          expiresAtMs <= nowMs &&
          !(myChoice && partnerChoice);

        if (mode === "status") {
          if (myChoice && partnerChoice && !waitingExpired) {
            const waitMinutes =
              cooldownUntilMs > nowMs
                ? Math.max(1, Math.ceil((cooldownUntilMs - nowMs) / 60000))
                : 0;
            return {
              ok: true,
              code: "DONE",
              state: "DONE",
              partnerUid,
              relationshipId,
              docId,
              myChoice,
              partnerChoice,
              expiresAtMs: expiresAtMs || 0,
              cooldownUntilMs: cooldownUntilMs || 0,
              waitMinutes,
              templateId: Number(emo.template_id || 0),
              iAmA,
            };
          }

          if (cooldownUntilMs > nowMs && !waitingExpired) {
            const waitMinutes = Math.max(
              1,
              Math.ceil((cooldownUntilMs - nowMs) / 60000),
            );
            return {
              ok: true,
              code: "COOLDOWN",
              state: "COOLDOWN",
              partnerUid,
              relationshipId,
              docId,
              myChoice: myChoice || "",
              partnerChoice: partnerChoice || "",
              expiresAtMs: expiresAtMs || 0,
              cooldownUntilMs,
              waitMinutes,
              templateId: Number(emo.template_id || 0),
              iAmA,
            };
          }

          if ((myChoice || partnerChoice) && !waitingExpired) {
            return {
              ok: true,
              code: "WAITING",
              state: "WAITING",
              partnerUid,
              relationshipId,
              docId,
              myChoice: myChoice || "",
              partnerChoice: partnerChoice || "",
              expiresAtMs: expiresAtMs || 0,
              cooldownUntilMs: cooldownUntilMs || 0,
              waitMinutes: 0,
              templateId: Number(emo.template_id || 0),
              iAmA,
            };
          }

          return {
            ok: true,
            code: "READY",
            state: "READY",
            partnerUid,
            relationshipId,
            docId,
            myChoice: "",
            partnerChoice: "",
            expiresAtMs: 0,
            cooldownUntilMs: 0,
            waitMinutes: 0,
            templateId: Number(emo.template_id || 0),
            iAmA,
          };
        }

        if (mode !== "choose")
          return { ok: false, code: "BAD_MODE", state: "ERROR" };
        if (!choiceKey || !CHOICES.includes(choiceKey))
          return { ok: false, code: "BAD_CHOICE", state: "ERROR" };

        if (!waitingExpired) {
          if (cooldownUntilMs > nowMs) {
            const waitMinutes = Math.max(
              1,
              Math.ceil((cooldownUntilMs - nowMs) / 60000),
            );
            return {
              ok: false,
              code: "COOLDOWN",
              state: "COOLDOWN",
              partnerUid,
              relationshipId,
              docId,
              cooldownUntilMs,
              waitMinutes,
            };
          }
          if (myChoice) {
            return {
              ok: false,
              code: "ALREADY_CHOSEN",
              state: "WAITING",
              partnerUid,
              relationshipId,
              docId,
              myChoice,
              partnerChoice: partnerChoice || "",
            };
          }
        }

        const newExpiresAtMs = utcEndOfDayMs(nowMs);

        const base = {
          relationship_id: relationshipId,
          a_uid: aUid,
          b_uid: bUid,
          cycle_day_key: dayKey,
          expires_at_ms: newExpiresAtMs,
          state: "WAITING",
        };

        const patch = {};
        patch[myChoiceField] = choiceKey;
        patch[myChoiceAtField] = nowMs;

        if (waitingExpired) {
          patch["a_choice"] = iAmA ? choiceKey : "";
          patch["b_choice"] = iAmA ? "" : choiceKey;
          patch["a_choice_at_ms"] = iAmA ? nowMs : 0;
          patch["b_choice_at_ms"] = iAmA ? 0 : nowMs;
          patch["cooldown_until_ms"] = 0;
        }

        tx.set(emoRef, { ...base, ...patch }, { merge: true });

        const afterMyChoice = choiceKey;
        const afterPartnerChoice = waitingExpired ? "" : partnerChoice;

        let templateId = Number(emo.template_id || 0);
        let newCooldownUntilMs = 0;

        const bothChosen = !!afterMyChoice && !!afterPartnerChoice;

        if (bothChosen) {
          templateId = (templateId + 1) % 1000000;
          newCooldownUntilMs = nowMs + COOLDOWN_HOURS * 60 * 60 * 1000;

          tx.set(
            emoRef,
            {
              state: "DONE",
              cooldown_until_ms: newCooldownUntilMs,
              template_id: templateId,
            },
            { merge: true },
          );
        } else {
          tx.set(
            emoRef,
            { state: "WAITING", template_id: templateId },
            { merge: true },
          );
        }

        return {
          ok: true,
          code: bothChosen ? "DONE" : "WAITING",
          state: bothChosen ? "DONE" : "WAITING",
          partnerUid,
          relationshipId,
          docId,
          myChoice: afterMyChoice,
          partnerChoice: afterPartnerChoice || "",
          expiresAtMs: newExpiresAtMs,
          cooldownUntilMs: newCooldownUntilMs || 0,
          waitMinutes:
            newCooldownUntilMs > nowMs
              ? Math.max(1, Math.ceil((newCooldownUntilMs - nowMs) / 60000))
              : 0,
          templateId,
          iAmA,
        };
      });

      const langMe = await getUserLang(uid);

      if (!txResult || txResult.ok !== true) {
        const msgDefault = t(langMe, {
          en: "Something went wrong. Please try again.",
          de: "Etwas ist schiefgelaufen. Bitte versuche es erneut.",
          es: "Algo salió mal. Inténtalo de nuevo.",
        });

        let msg = msgDefault;
        if (txResult?.code === "BAD_CHOICE")
          msg = t(langMe, {
            en: "Invalid choice.",
            de: "Ungültige Auswahl.",
            es: "Selección inválida.",
          });
        if (txResult?.code === "ALREADY_CHOSEN") {
          msg = t(langMe, {
            en: "You already shared today.",
            de: "Du hast heute schon geteilt, wie du dich fühlst.",
            es: "Ya compartiste cómo te sientes hoy.",
          });
        }

        return { ...(txResult || {}), statusText: msg, snackText: msg };
      }

      let waitingWho = "";
      if (txResult.state === "WAITING") {
        if (
          nonEmptyString(txResult.myChoice) &&
          !nonEmptyString(txResult.partnerChoice)
        )
          waitingWho = "ME_WAITING";
        else if (
          !nonEmptyString(txResult.myChoice) &&
          nonEmptyString(txResult.partnerChoice)
        )
          waitingWho = "PARTNER_WAITING";
      }

      let summaryForMe = "";
      if (txResult.state === "DONE") {
        const aKey = txResult.iAmA ? txResult.myChoice : txResult.partnerChoice;
        const bKey = txResult.iAmA ? txResult.partnerChoice : txResult.myChoice;
        summaryForMe = buildSummary(langMe, aKey, bKey, txResult.templateId);
      }

      const statusPack = buildStatusTexts(langMe, txResult.state, {
        who: waitingWho,
        cooldownUntilMs: txResult.cooldownUntilMs || 0,
        nowMs,
      });

      const partnerUid = txResult.partnerUid;

      if (txResult.code === "WAITING") {
        try {
          if (partnerUid && (await canNotifyEmotion(partnerUid))) {
            const tokens = await getTokensForUid(partnerUid);
            if (tokens.length) {
              const langPartner = await getUserLang(partnerUid);

              const title = t(langPartner, {
                en: "Feelings",
                de: "Gefühle",
                es: "Sentimientos",
              });
              const body = t(langPartner, {
                en: "Your partner shared how they feel. Want to answer?",
                de: "Dein Partner hat geteilt, wie er oder sie sich fühlt. Möchtest du antworten?",
                es: "Tu pareja compartió cómo se siente. ¿Quieres responder?",
              });

              const ffNav = buildFlutterFlowNavData(ROUTE_ON_TAP, {
                type: "emotion_checkin",
              });

              await messaging.sendEachForMulticast({
                tokens,
                notification: { title, body },
                data: {
                  type: "emotion_checkin",
                  route: ROUTE_ON_TAP,
                  ...ffNav,
                },
              });
            }
          }
        } catch (e) {
          console.log(
            "[sendEmotionCheckIn] waiting push failed",
            String(e?.message || e),
          );
        }
      }

      if (txResult.code === "DONE") {
        try {
          if (partnerUid && (await canNotifyEmotion(partnerUid))) {
            const tokens = await getTokensForUid(partnerUid);
            if (tokens.length) {
              const langPartner = await getUserLang(partnerUid);

              const title = t(langPartner, {
                en: "Feelings",
                de: "Gefühle",
                es: "Sentimientos",
              });
              const body = t(langPartner, {
                en: "You both shared how you feel 💜",
                de: "Ihr habt beide eure Gefühle geteilt 💜",
                es: "Ambos compartieron cómo se sienten 💜",
              });

              const ffNav = buildFlutterFlowNavData(ROUTE_ON_TAP, {
                type: "emotion_checkin",
              });

              await messaging.sendEachForMulticast({
                tokens,
                notification: { title, body },
                data: {
                  type: "emotion_checkin",
                  route: ROUTE_ON_TAP,
                  ...ffNav,
                },
              });
            }
          }
        } catch (e) {
          console.log(
            "[sendEmotionCheckIn] done push failed",
            String(e?.message || e),
          );
        }
      }

      return {
        ok: true,
        code: txResult.code,
        state: txResult.state,
        myChoice: txResult.myChoice || "",
        partnerChoice: txResult.partnerChoice || "",
        summaryText: summaryForMe || "",
        statusText: statusPack.statusText || "",
        snackText: statusPack.snackText || "",
        expiresAtMs: txResult.expiresAtMs || 0,
        cooldownUntilMs: txResult.cooldownUntilMs || 0,
        waitMinutes: txResult.waitMinutes || 0,
      };
    } catch (e) {
      console.error("[sendEmotionCheckIn] failed:", e);
      const lang = await getUserLang(uid);
      const msg = t(lang, {
        en: "Something went wrong. Please try again.",
        de: "Etwas ist schiefgelaufen. Bitte versuche es erneut.",
        es: "Algo salió mal. Inténtalo de nuevo.",
      });
      return {
        ok: false,
        code: "ERROR",
        state: "ERROR",
        statusText: msg,
        snackText: msg,
      };
    }
  });
