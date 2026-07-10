const functions = require("firebase-functions");
const admin = require("firebase-admin");

try {
  admin.app();
} catch {
  admin.initializeApp();
}

const REGION = "europe-west3";

const REL_VIEWS_COL = "relationship_views";
const LOVE_TREASURES_COL = "love_treasures";
const LOVE_AWARDS_COL = "love_awards";
const USERS_COL = "Users";

const POINTS = 6;

/* ---------------- helpers ---------------- */

function clamp(n, min, max) {
  return Math.max(min, Math.min(max, n));
}

function loveStateFromScore(score) {
  if (score < 30) return "angry";
  if (score < 65) return "sad";
  return "happy";
}

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

async function getUserLang(db, uid) {
  try {
    const snap = await db.collection(USERS_COL).doc(uid).get();
    return normalizeLang(snap.exists ? snap.get("appLanguage") : "en");
  } catch {
    return "en";
  }
}

/* ---------------- main ---------------- */

exports.awardLoveTreasureOpened = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    const db = admin.firestore();

    try {
      const uid = context.auth?.uid;
      if (!uid) {
        return {
          ok: false,
          code: "UNAUTHENTICATED",
          message: "Please sign in again.",
          status: "",
          points: 0,
        };
      }

      const lang = await getUserLang(db, uid);

      const treasureId = String(data?.treasureId || "").trim();
      if (!treasureId) {
        return {
          ok: false,
          code: "INVALID_ARGUMENT",
          message: t(lang, {
            en: "Missing treasureId.",
            de: "treasureId fehlt.",
            es: "Falta treasureId.",
          }),
          status: "",
          points: 0,
        };
      }

      const myViewRef = db.collection(REL_VIEWS_COL).doc(uid);
      const treasureRef = db.collection(LOVE_TREASURES_COL).doc(treasureId);

      const txRes = await db.runTransaction(async (tx) => {
        const [myViewSnap, treasureSnap] = await Promise.all([
          tx.get(myViewRef),
          tx.get(treasureRef),
        ]);

        if (!myViewSnap.exists) {
          return { ok: false, code: "NO_RELATIONSHIP" };
        }

        if (!treasureSnap.exists) {
          return { ok: false, code: "TREASURE_NOT_FOUND" };
        }

        const myView = myViewSnap.data() || {};
        const treasure = treasureSnap.data() || {};

        const relationshipId = String(myView.relationship_id || "").trim();
        const partnerUid = String(myView.partner_uid || "").trim();

        if (!relationshipId || !partnerUid) {
          return { ok: false, code: "NO_RELATIONSHIP" };
        }

        const treasureRelationshipId = String(
          treasure.relationship_id || "",
        ).trim();

        if (
          !treasureRelationshipId ||
          treasureRelationshipId !== relationshipId
        ) {
          return { ok: false, code: "FORBIDDEN" };
        }

        const treasureStatus = String(treasure.status || "").trim();

        if (!["ready", "opened"].includes(treasureStatus)) {
          return {
            ok: true,
            code: "OK",
            status: "IGNORED_NOT_OPENED",
            awarded: false,
            relationshipId,
            partnerUid,
            points: 0,
          };
        }

        const partnerViewRef = db.collection(REL_VIEWS_COL).doc(partnerUid);

        const [aUid, bUid] = [uid, partnerUid].sort();

        const awardId = `${relationshipId}_LOVE_TREASURE_OPENED_${treasureId}`;
        const awardRef = db.collection(LOVE_AWARDS_COL).doc(awardId);

        const [awardSnap, partnerViewSnap] = await Promise.all([
          tx.get(awardRef),
          tx.get(partnerViewRef),
        ]);

        if (awardSnap.exists) {
          return {
            ok: true,
            code: "OK",
            status: "ALREADY_AWARDED",
            awarded: false,
            relationshipId,
            partnerUid,
            points: 0,
          };
        }

        const partnerView = partnerViewSnap.exists
          ? partnerViewSnap.data() || {}
          : {};

        const myCur = Number(myView.love_score ?? 65);
        const pCur = Number(partnerView.love_score ?? 65);

        const myNew = clamp(myCur + POINTS, 0, 100);
        const pNew = clamp(pCur + POINTS, 0, 100);

        tx.set(awardRef, {
          relationship_id: relationshipId,
          type: "LOVE_TREASURE_OPENED",
          points: POINTS,
          treasure_id: treasureId,
          actor_uid: uid,
          userA_id: aUid,
          userB_id: bUid,
          created_at: admin.firestore.FieldValue.serverTimestamp(),
          meta: {
            source: "love_treasure",
            status_at_award: treasureStatus,
          },
        });

        tx.set(
          myViewRef,
          {
            love_score: myNew,
            love_percent: myNew / 100,
            love_state: loveStateFromScore(myNew),
            love_last_update: admin.firestore.FieldValue.serverTimestamp(),
            love_today_points: admin.firestore.FieldValue.increment(POINTS),
            updated_at: admin.firestore.FieldValue.serverTimestamp(),
          },
          { merge: true },
        );

        tx.set(
          partnerViewRef,
          {
            love_score: pNew,
            love_percent: pNew / 100,
            love_state: loveStateFromScore(pNew),
            love_last_update: admin.firestore.FieldValue.serverTimestamp(),
            love_today_points: admin.firestore.FieldValue.increment(POINTS),
            updated_at: admin.firestore.FieldValue.serverTimestamp(),
          },
          { merge: true },
        );

        tx.set(
          treasureRef,
          {
            loveBuddyRewardGranted: true,
            loveBuddyRewardGrantedAt:
              admin.firestore.FieldValue.serverTimestamp(),
            loveBuddyRewardPoints: POINTS,
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          },
          { merge: true },
        );

        return {
          ok: true,
          code: "OK",
          status: "AWARDED",
          awarded: true,
          relationshipId,
          partnerUid,
          points: POINTS,
        };
      });

      if (txRes?.ok !== true) {
        return {
          ok: false,
          code: txRes?.code || "ERROR",
          message: t(lang, {
            en: "Something went wrong. Please try again.",
            de: "Etwas ist schiefgelaufen. Bitte versuche es erneut.",
            es: "Algo salió mal. Inténtalo de nuevo.",
          }),
          status: "",
          points: 0,
        };
      }

      const message =
        txRes.status === "AWARDED"
          ? t(lang, {
              en: `Love Treasure opened — +${POINTS} LoveBuddy points 💜`,
              de: `Liebestruhe geöffnet — +${POINTS} LoveBuddy-Punkte 💜`,
              es: `Tesoro de amor abierto — +${POINTS} puntos de LoveBuddy 💜`,
            })
          : t(lang, {
              en: "Love Treasure opened 💜",
              de: "Liebestruhe geöffnet 💜",
              es: "Tesoro de amor abierto 💜",
            });

      return {
        ...txRes,
        message,
      };
    } catch (e) {
      console.error("[awardLoveTreasureOpened] failed:", e);

      return {
        ok: false,
        code: "ERROR",
        message: "Something went wrong. Please try again.",
        status: "",
        points: 0,
      };
    }
  });
