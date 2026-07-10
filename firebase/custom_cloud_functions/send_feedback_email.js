/**
 * Cloud Function: sendFeedbackEmail
 * Region: europe-west3
 * Runtime: firebase-functions v1
 */
const functions = require("firebase-functions");
const admin = require("firebase-admin");
// In FlutterFlow KEIN admin.initializeApp() aufrufen!

exports.sendFeedbackEmail = functions
  .region("europe-west3")
  .https.onCall(async (data, context) => {
    try {
      const db = admin.firestore();

      // ---------------------------
      // Inputs (robust, FF-safe)
      // ---------------------------
      const {
        type = "",
        rating = null, // Double (optional)
        message = "",
        email = "",
        app_version = "",
        platform = "",
        locale = "",
      } = data || {};

      // Accept ALL common FlutterFlow variants
      const user_id =
        (data &&
          (data.user_id ?? data.userId ?? data.uid ?? data.userUID ?? "")) ||
        "";

      const relationship_id =
        (data &&
          (data.relationship_id ??
            data.relationshipId ??
            data.relationshipID ??
            data.relationship ??
            "")) ||
        "";

      // ---------------------------
      // Language helpers (lite)
      // ---------------------------
      async function getUserLang(uid) {
        try {
          if (!uid) return "en";
          const snap = await db.collection("Users").doc(uid).get();
          let lang = (snap.exists ? snap.get("appLanguage") || "" : "")
            .toString()
            .trim()
            .toLowerCase();
          if (lang.includes("_")) lang = lang.split("_")[0];
          if (lang.includes("-")) lang = lang.split("-")[0];
          return lang === "en" || lang === "de" || lang === "es" ? lang : "en";
        } catch (_) {
          return "en";
        }
      }

      const lang = await getUserLang(user_id);

      const MSG = {
        en: "Thanks for your feedback 💜",
        de: "Danke für dein Feedback 💜",
        es: "Gracias por tu feedback 💜",
      };

      // ---------------------------
      // Utils
      // ---------------------------
      const makeFeedbackCode = (len = 8) => {
        const alphabet = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
        let out = "";
        for (let i = 0; i < len; i++) {
          out += alphabet[Math.floor(Math.random() * alphabet.length)];
        }
        return `FB-${out}`;
      };

      const feedbackCode = makeFeedbackCode(6);
      const now = admin.firestore.Timestamp.now();
      const nowDate = now.toDate();
      const receivedAt = nowDate.toLocaleString("de-DE", {
        timeZone: "Europe/Berlin",
      });
      const year = nowDate.getFullYear();

      // ---------------------------
      // Staff Email (HTML)
      // ---------------------------
      const staffEmailHtml = `
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>New feedback received</title>
</head>
<body style="margin:0;background:#f6f7fb;font-family:Inter,system-ui,Arial">
  <div style="padding:24px">
    <div style="max-width:720px;margin:auto;background:#fff;border-radius:14px;box-shadow:0 6px 24px rgba(16,24,40,.08)">
      <div style="padding:32px;text-align:center;background:linear-gradient(90deg,#6d3cff,#ff4d67);color:#fff">
        <h2 style="margin:0">New feedback received</h2>
        <p style="margin:6px 0 0;font-size:13px">Received ${receivedAt}</p>
        <div style="margin-top:10px;font-weight:600">${feedbackCode}</div>
      </div>

      <div style="padding:24px;font-size:14px;color:#101828">
        <p><b>From:</b> ${email || "-"}</p>
        <p><b>Type:</b> ${type || "-"}</p>
        <p><b>Rating:</b> ${rating ?? "-"}</p>
        <p><b>User ID:</b> ${user_id || "-"}</p>
        <p><b>Relationship ID:</b> ${relationship_id || "-"}</p>
        <p><b>App version:</b> ${app_version || "-"}</p>
        <p><b>Platform:</b> ${platform || "-"}</p>
        <p><b>Locale:</b> ${locale || "-"}</p>

        <hr style="margin:20px 0">

        <p><b>Message:</b></p>
        <div style="background:#fafbff;border:1px dashed #d9ddee;border-radius:10px;padding:14px;white-space:pre-wrap">
          ${(message || "").replace(/</g, "&lt;").replace(/>/g, "&gt;")}
        </div>
      </div>

      <div style="padding:16px;text-align:center;font-size:12px;color:#667085">
        © ${year} Togly · support@gettogly.com
      </div>
    </div>
  </div>
</body>
</html>
`;

      // ---------------------------
      // Customer confirmation email (EN only - ok for release)
      // ---------------------------
      const customerEmailHtml = `
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>Thanks for your feedback</title>
</head>
<body style="margin:0;background:#f6f7fb;font-family:Inter,system-ui,Arial">
  <div style="padding:24px">
    <div style="max-width:720px;margin:auto;background:#fff;border-radius:14px;box-shadow:0 6px 24px rgba(16,24,40,.08)">
      <div style="padding:32px;text-align:center;background:linear-gradient(90deg,#6d3cff,#ff4d67);color:#fff">
        <h2 style="margin:0">Thanks for your feedback 💜</h2>
        <p style="margin:6px 0 0;font-size:13px">We really appreciate it</p>
        <div style="margin-top:10px;font-weight:600">${feedbackCode}</div>
      </div>

      <div style="padding:24px;font-size:14px;color:#101828">
        <p>Thanks for taking the time to share your thoughts with us.</p>
        <p>If we need more information, we may reply to this email.</p>
        <p><b>Your feedback type:</b> ${type || "-"}</p>
      </div>

      <div style="padding:16px;text-align:center;font-size:12px;color:#667085">
        © ${year} Togly
      </div>
    </div>
  </div>
</body>
</html>
`;

      // ---------------------------
      // Save feedback to Firestore
      // ---------------------------
      await db.collection("feedback").doc(feedbackCode).set({
        created_at: now,
        last_update_at: now,
        status: "new",
        feedback_code: feedbackCode,
        type,
        rating,
        message,
        email,
        user_id,
        relationship_id,
        app_version,
        platform,
        locale,
      });

      // ---------------------------
      // Send staff email
      // ---------------------------
      await db.collection("mail").add({
        to: ["support@gettogly.com"],
        message: {
          subject: `New feedback • ${type || "General"} • ${feedbackCode}`,
          html: staffEmailHtml,
        },
        replyTo: email || undefined,
      });

      // ---------------------------
      // Send customer confirmation
      // ---------------------------
      if (email) {
        await db.collection("mail").add({
          to: [email],
          message: {
            subject: `Thanks for your feedback • ${feedbackCode}`,
            html: customerEmailHtml,
          },
        });
      }

      // ✅ Return CFResult with localized message (for Snackbar)
      return {
        ok: true,
        feedbackCode,
        message: MSG[lang] || MSG.en,
      };
    } catch (err) {
      console.error("sendFeedbackEmail failed:", err);
      return {
        ok: false,
        error: String((err && err.message) || err),
        message: "Something went wrong. Please try again.",
      };
    }
  });
