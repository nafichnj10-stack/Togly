// ============================
// updateProfileSettings (name/together_since only)
// FIX: PublicUsers uses field "name" (NOT display_name)
// - Updates PublicUsers name
// - If together_since provided AND user is in a relationship -> updates relationships/{relationship_id}.together_since
// - Returns localized snackbar text
// ============================

const functions = require("firebase-functions");
const admin = require("firebase-admin");
try {
  admin.app();
} catch {
  admin.initializeApp();
}

const db = admin.firestore();

const REGION = "europe-west3";
const USERS_COL = "Users";
const PUBLIC_COL = "PublicUsers";
const REL_COL = "relationships";

/* ---------------- helpers ---------------- */

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

async function getPublicUserDocRefsByUid(uid) {
  const refs = [];

  try {
    const directRef = db.collection(PUBLIC_COL).doc(uid);
    const directSnap = await directRef.get();
    if (directSnap.exists) refs.push(directRef);
  } catch {}

  try {
    const qs = await db
      .collection(PUBLIC_COL)
      .where("uid", "==", uid)
      .limit(10)
      .get();
    qs.docs.forEach((d) => {
      if (!refs.find((r) => r.path === d.ref.path)) refs.push(d.ref);
    });
  } catch {}

  return refs;
}

function parseTogetherSince(input) {
  if (!input) return null;

  if (typeof input === "object") {
    if (typeof input.toDate === "function") {
      const d = input.toDate();
      return admin.firestore.Timestamp.fromDate(new Date(d.getTime()));
    }
    if (typeof input.seconds === "number") {
      const ms =
        input.seconds * 1000 + Math.floor((input.nanoseconds || 0) / 1e6);
      return admin.firestore.Timestamp.fromMillis(ms);
    }
    if (input instanceof Date) {
      return admin.firestore.Timestamp.fromDate(input);
    }
  }

  if (typeof input === "number" && Number.isFinite(input) && input > 0) {
    return admin.firestore.Timestamp.fromMillis(input);
  }

  if (typeof input === "string") {
    const s = input.trim();
    if (!s) return null;

    const asNum = Number(s);
    if (Number.isFinite(asNum) && asNum > 0) {
      return admin.firestore.Timestamp.fromMillis(asNum);
    }

    const d = new Date(s);
    if (!Number.isNaN(d.getTime())) {
      return admin.firestore.Timestamp.fromDate(d);
    }
  }

  return null;
}

/* ---------------- main ---------------- */

exports.updateProfileSettings = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    const uid = context.auth?.uid;
    if (!uid) {
      return {
        ok: false,
        code: "UNAUTHENTICATED",
        snackText: "Please log in again.",
      };
    }

    const lang = await getUserLang(uid);
    const now = admin.firestore.Timestamp.now();

    const nameRaw = data?.name;
    const togetherSinceRaw =
      data?.togetherSince ?? data?.together_since ?? data?.togetherSinceDate;

    const name = typeof nameRaw === "string" ? nameRaw.trim() : null;

    const wantsNameUpdate = typeof nameRaw === "string";
    const togetherSinceTs = parseTogetherSince(togetherSinceRaw);
    const wantsTogetherUpdate = !!togetherSinceTs;

    try {
      const uSnap = await db.collection(USERS_COL).doc(uid).get();
      const u = uSnap.exists ? uSnap.data() || {} : {};
      const relationshipId = nonEmptyString(u.relationship_id);

      const publicRefs = await getPublicUserDocRefsByUid(uid);

      await db.runTransaction(async (tx) => {
        if (publicRefs.length) {
          const pubPatch = { updated_at: now };

          if (wantsNameUpdate) {
            pubPatch.name = name ?? "";
          }

          if (wantsTogetherUpdate) {
            pubPatch.together_since = togetherSinceTs;
            pubPatch.together_since_set_at = now;
            pubPatch.together_since_source = "profile_update";
          }

          publicRefs.forEach((ref) => tx.set(ref, pubPatch, { merge: true }));
        }

        if (relationshipId && wantsTogetherUpdate) {
          const relRef = db.collection(REL_COL).doc(relationshipId);

          tx.set(
            relRef,
            {
              updated_at: now,
              together_since: togetherSinceTs,
              together_since_set_at: now,
              together_since_source: "profile_update",
              together_since_conflict: false,
            },
            { merge: true },
          );
        }
      });

      return {
        ok: true,
        code: "OK",
        snackText: t(lang, {
          en: "Profile updated",
          de: "Profil aktualisiert",
          es: "Perfil actualizado",
        }),
        updated: {
          name: wantsNameUpdate,
          togetherSince: wantsTogetherUpdate,
        },
      };
    } catch (e) {
      console.error("[updateProfileSettings] failed:", e);
      return {
        ok: false,
        code: "ERROR",
        snackText: t(lang, {
          en: "Something went wrong. Please try again.",
          de: "Etwas ist schiefgelaufen. Bitte versuche es erneut.",
          es: "Algo salió mal. Inténtalo de nuevo.",
        }),
      };
    }
  });
