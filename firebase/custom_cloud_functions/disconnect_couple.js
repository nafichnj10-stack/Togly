const functions = require("firebase-functions");
const admin = require("firebase-admin");

if (admin.apps.length === 0) {
  try {
    admin.initializeApp();
  } catch (_) {}
}

const db = admin.firestore();

const REGION = "europe-west3";
const REL_COL = "relationships";
const REL_VIEWS_COL = "relationship_views";

// Users updaten
async function upsertUserFieldsFor(uid, data) {
  const ref = db.collection("Users").doc(uid);
  await ref.set(data, { merge: true });
}

// PublicUsers: docId kann != uid sein
async function patchPublicUsersByUid(uid, data) {
  const snap = await db.collection("PublicUsers").where("uid", "==", uid).get();
  if (snap.empty) return;
  await Promise.all(
    snap.docs.map((d) => d.ref.set(data, { merge: true }).catch(() => null)),
  );
}

// ---- Language helpers ----
async function getUserLang(uid) {
  try {
    const snap = await db.collection("Users").doc(uid).get();
    let lang = (snap.exists ? snap.get("appLanguage") : "")
      .toString()
      .toLowerCase();
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
      SUCCESS:
        "You’ve disconnected for now 💔 You can reconnect within 14 days.",
      ALREADY: "You’re already disconnected 💔",
      ERROR: "Something went wrong. Please try again.",
    },
    de: {
      AUTH: "Bitte melde dich an, um fortzufahren.",
      NOT_MEMBER: "Diese Beziehung gehört nicht zu dir.",
      NOT_FOUND: "Diese Beziehung konnten wir nicht finden.",
      SUCCESS:
        "Ihr habt euch vorerst getrennt 💔 Ihr könnt euch innerhalb von 14 Tagen wieder verbinden.",
      ALREADY: "Ihr seid bereits getrennt 💔",
      ERROR: "Etwas ist schiefgelaufen. Bitte versuche es erneut.",
    },
    es: {
      AUTH: "Inicia sesión para continuar.",
      NOT_MEMBER: "Esta relación no te pertenece.",
      NOT_FOUND: "No pudimos encontrar esta relación.",
      SUCCESS:
        "Se han separado por ahora 💔 Pueden volver a conectarse en un plazo de 14 días.",
      ALREADY: "Ya están desconectados 💔",
      ERROR: "Algo salió mal. Inténtalo de nuevo.",
    },
  };
  return M[lang]?.[key] || M.en[key];
}

exports.disconnectCouple = functions
  .region(REGION)
  .https.onCall(async (data, context) => {
    try {
      const callerUid = context.auth?.uid;
      if (!callerUid) {
        return { ok: false, code: "UNAUTHENTICATED", message: t("en", "AUTH") };
      }

      const lang = await getUserLang(callerUid);

      const rid = String(
        data?.relationshipid || data?.relationshipId || "",
      ).trim();
      if (!rid) {
        return { ok: false, code: "NOT_FOUND", message: t(lang, "NOT_FOUND") };
      }

      const relRef = db.collection(REL_COL).doc(rid);
      const relSnap = await relRef.get();
      if (!relSnap.exists) {
        return { ok: false, code: "NOT_FOUND", message: t(lang, "NOT_FOUND") };
      }

      const rel = relSnap.data() || {};
      const members = [rel.userA_id, rel.userB_id].filter(Boolean);

      if (members.length !== 2 || !members.includes(callerUid)) {
        return {
          ok: false,
          code: "NOT_MEMBER",
          message: t(lang, "NOT_MEMBER"),
        };
      }

      // idempotent
      if (rel.active === false && rel.purge_at) {
        return { ok: true, code: "ALREADY", message: t(lang, "ALREADY") };
      }

      const now = admin.firestore.Timestamp.now();
      const purgeAt = admin.firestore.Timestamp.fromMillis(
        now.toMillis() + 14 * 24 * 60 * 60 * 1000,
        // now.toMillis() + 5 * 60 * 1000
      );

      // 1) relationship parken
      await relRef.update({
        active: false,
        status: "disconnect_pending",
        relationship_status: "disconnect_pending",
        disconnected_at: now,
        purge_at: purgeAt,
        updated_at: now,
        notified_7d: false,
        notified_24h: false,
        notified_1h: false,
      });

      // 2) Users cleanup + Restore-State
      const userPatch = {
        relationship_id: admin.firestore.FieldValue.delete(),
        partnerUID: admin.firestore.FieldValue.delete(),
        relationship_status: "disconnect_pending",
        disconnect_cooldown_until: purgeAt,

        // Restore-Flow Flags
        restore_required: true,
        restore_state: "ready_to_send",
        restore_request_id: "",
        restore_relationship_id: rid,

        // legacy / optional
        last_relationship_id: rid,
        last_relationship_ref: relRef,

        // optional: falls du das Celebrate-Flag nutzt, hier sauber resetten
        celebrate_reconnect: false,
        celebrate_reconnect_at: admin.firestore.FieldValue.delete(),

        updated_at: now,
      };

      await Promise.all(
        members.map((uid) => upsertUserFieldsFor(uid, userPatch)),
      );

      // 3) PublicUsers cleanup
      const publicPatch = {
        relationship_id: admin.firestore.FieldValue.delete(),
        partnerUID: admin.firestore.FieldValue.delete(),
        relationship_status: "disconnect_pending",
        updated_at: now,
      };

      await Promise.all(
        members.map((uid) => patchPublicUsersByUid(uid, publicPatch)),
      );

      // 4) relationship_views entkoppeln (nicht löschen!)
      const viewPatch = {
        relationship_id: admin.firestore.FieldValue.delete(),
        partner_uid: admin.firestore.FieldValue.delete(),
        relationship_status: "disconnect_pending",

        restore_required: true,
        restore_relationship_id: rid,

        updated_at: now,
        paused: true,
        paused_at: now,
        purge_at: purgeAt,
        last_relationship_id: rid,
      };

      await Promise.all(
        members.map((uid) =>
          db
            .collection(REL_VIEWS_COL)
            .doc(uid)
            .set(viewPatch, { merge: true })
            .catch(() => null),
        ),
      );

      return {
        ok: true,
        code: "OK",
        message: t(lang, "SUCCESS"),
        relationship_id: rid,
        relationship_status: "disconnect_pending",
        purge_at: purgeAt.toDate().toISOString(),
        disconnected_at: now.toDate().toISOString(),
      };
    } catch (e) {
      console.error("[disconnectCouple] error", e);
      return { ok: false, code: "ERROR", message: t("en", "ERROR") };
    }
  });
