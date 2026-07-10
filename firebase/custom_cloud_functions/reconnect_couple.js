/**
 * Cloud Function: reconnectCouple
 * Region: europe-west3
 *
 * Re-activates a previously disconnected relationship:
 * - sets relationships/<rid>.active = true
 * - sets Users/<a|b>.relationship_id + partnerUID
 * - updates PublicUsers pointers (by uid query)
 */

const functions = require("firebase-functions");
const admin = require("firebase-admin");

// Guard (prevents "DEFAULT app already exists")
try {
  admin.app();
} catch {
  admin.initializeApp();
}

const db = admin.firestore();

const REGION = "europe-west3";
const REL_COL = "relationships";
const USERS_COL = "Users";
const PUBLIC_COL = "PublicUsers";

// ---------- Helpers ----------
async function publicUserDocByUid(uid) {
  if (!uid) return null;
  const snap = await db
    .collection(PUBLIC_COL)
    .where("uid", "==", uid)
    .limit(1)
    .get();
  return snap.empty ? null : snap.docs[0];
}

async function getUserLang(uid) {
  try {
    const snap = await db.collection(USERS_COL).doc(uid).get();
    let lang = (snap.exists ? snap.get("appLanguage") : "")
      .toString()
      .toLowerCase()
      .trim();
    if (lang.includes("_")) lang = lang.split("_")[0];
    if (lang.includes("-")) lang = lang.split("-")[0];
    return ["en", "de", "es"].includes(lang) ? lang : "en";
  } catch {
    return "en";
  }
}

function t(lang, key) {
  const M = {
    en: {
      AUTH: "Please sign in to continue.",
      NOT_MEMBER: "This relationship doesn’t belong to you.",
      NOT_FOUND: "We couldn’t find this relationship.",
      ALREADY: "You’re already connected 💕",
      SUCCESS: "You’re connected again 💕 Welcome back together.",
      ERROR: "Something went wrong. Please try again.",
      MISSING_ID: "Missing relationship id.",
    },
    de: {
      AUTH: "Bitte melde dich an, um fortzufahren.",
      NOT_MEMBER: "Diese Beziehung gehört nicht zu dir.",
      NOT_FOUND: "Diese Beziehung konnten wir nicht finden.",
      ALREADY: "Ihr seid bereits verbunden 💕",
      SUCCESS:
        "Ihr seid wieder verbunden 💕 Schön, dass ihr wieder zusammen seid.",
      ERROR: "Etwas ist schiefgelaufen. Bitte versuche es erneut.",
      MISSING_ID: "Fehlende Relationship-ID.",
    },
    es: {
      AUTH: "Inicia sesión para continuar.",
      NOT_MEMBER: "Esta relación no te pertenece.",
      NOT_FOUND: "No pudimos encontrar esta relación.",
      ALREADY: "Ya están conectados 💕",
      SUCCESS:
        "Están conectados de nuevo 💕 Qué bonito tenerlos juntos otra vez.",
      ERROR: "Algo salió mal. Inténtalo de nuevo.",
      MISSING_ID: "Falta el ID de la relación.",
    },
  };
  return M[lang]?.[key] || M.en[key];
}

exports.reconnectCouple = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    try {
      const uid = context.auth?.uid;
      if (!uid) return { ok: false, message: t("en", "AUTH") };

      const lang = await getUserLang(uid);

      // Accept common variants
      const rid = String(
        data?.relationshipid ??
          data?.relationshipId ??
          data?.relationship_id ??
          "",
      ).trim();

      if (!rid) return { ok: false, message: t(lang, "MISSING_ID") };

      const relRef = db.collection(REL_COL).doc(rid);
      const relSnap = await relRef.get();
      if (!relSnap.exists) return { ok: false, message: t(lang, "NOT_FOUND") };

      const rel = relSnap.data() || {};
      const members = [rel.userA_id, rel.userB_id].filter(Boolean);

      if (!members.includes(uid))
        return { ok: false, message: t(lang, "NOT_MEMBER") };

      if (rel.active === true) {
        return { ok: true, message: t(lang, "ALREADY") };
      }

      const now = admin.firestore.Timestamp.now();
      const [a, b] = members;

      // Update PublicUsers pointers (best effort)
      const [pubA, pubB] = await Promise.all([
        publicUserDocByUid(a),
        publicUserDocByUid(b),
      ]);

      await db.runTransaction(async (tx) => {
        // relationship -> active again
        tx.update(relRef, {
          active: true,
          updated_at: now,
          disconnected_at: admin.firestore.FieldValue.delete(),
          purge_at: admin.firestore.FieldValue.delete(),
        });

        // Users pointers
        if (a && b) {
          tx.set(
            db.collection(USERS_COL).doc(a),
            {
              relationship_id: rid,
              partnerUID: b,
              updated_at: now,
              disconnect_cooldown_until: admin.firestore.FieldValue.delete(),
            },
            { merge: true },
          );

          tx.set(
            db.collection(USERS_COL).doc(b),
            {
              relationship_id: rid,
              partnerUID: a,
              updated_at: now,
              disconnect_cooldown_until: admin.firestore.FieldValue.delete(),
            },
            { merge: true },
          );
        }

        // PublicUsers pointers (if docs found)
        if (pubA && b)
          tx.set(
            pubA.ref,
            { relationship_id: rid, partnerUID: b, updated_at: now },
            { merge: true },
          );
        if (pubB && a)
          tx.set(
            pubB.ref,
            { relationship_id: rid, partnerUID: a, updated_at: now },
            { merge: true },
          );
      });

      return { ok: true, message: t(lang, "SUCCESS") };
    } catch (e) {
      console.error("[reconnectCouple] failed", e);
      return { ok: false, message: t("en", "ERROR") };
    }
  });
