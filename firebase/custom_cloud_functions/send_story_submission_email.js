const functions = require("firebase-functions");
const admin = require("firebase-admin");
// In FlutterFlow KEIN admin.initializeApp() aufrufen!
try {
  admin.app();
} catch {
  admin.initializeApp();
}

exports.sendStorySubmissionEmail = functions
  .region("europe-west3")
  .https.onCall(async (data, context) => {
    try {
      const uid = context.auth?.uid;
      const db = admin.firestore();

      // ---- language helpers (lite) ----
      async function getUserLang(userUid) {
        try {
          if (!userUid) return "en";
          const snap = await db.collection("Users").doc(userUid).get();
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

      function t(lang, key) {
        const M = {
          en: {
            LOGIN_REQUIRED: "Please sign in to continue.",
            STORY_ID_REQUIRED: "Please provide a valid story id.",
            STORY_NOT_FOUND: "We couldn’t find your story submission.",
            STAFF_SENT_OK: "Thanks! Your story was sent successfully 💜",
            EMAIL_MISSING:
              "We received your story, but we couldn’t send the email copy (missing email).",
            ERROR: "Something went wrong. Please try again.",
          },
          de: {
            LOGIN_REQUIRED: "Bitte melde dich an, um fortzufahren.",
            STORY_ID_REQUIRED: "Bitte gib eine gültige Story-ID an.",
            STORY_NOT_FOUND: "Wir konnten deine Story-Einsendung nicht finden.",
            STAFF_SENT_OK: "Danke! Deine Story wurde erfolgreich gesendet 💜",
            EMAIL_MISSING:
              "Wir haben deine Story erhalten, aber konnten dir keine E-Mail-Kopie senden (keine E-Mail-Adresse).",
            ERROR: "Etwas ist schiefgelaufen. Bitte versuche es erneut.",
          },
          es: {
            LOGIN_REQUIRED: "Inicia sesión para continuar.",
            STORY_ID_REQUIRED: "Indica un ID de historia válido.",
            STORY_NOT_FOUND: "No pudimos encontrar tu envío de historia.",
            STAFF_SENT_OK: "¡Gracias! Tu historia se envió correctamente 💜",
            EMAIL_MISSING:
              "Recibimos tu historia, pero no pudimos enviarte una copia por email (falta el correo).",
            ERROR: "Algo salió mal. Inténtalo de nuevo.",
          },
        };
        return M[lang] && M[lang][key] ? M[lang][key] : M.en[key] || "Error.";
      }

      // Auth required (CFResult)
      if (!uid) {
        return {
          ok: false,
          code: "UNAUTHENTICATED",
          message: t("en", "LOGIN_REQUIRED"),
        };
      }

      const lang = await getUserLang(uid);

      const { storyDocId, sendCopyToUser = true } = data || {};
      if (!storyDocId || typeof storyDocId !== "string") {
        return {
          ok: false,
          code: "INVALID_ARGUMENT",
          message: t(lang, "STORY_ID_REQUIRED"),
        };
      }

      // Collection: user_stories
      const snap = await db.collection("user_stories").doc(storyDocId).get();
      if (!snap.exists) {
        return {
          ok: false,
          code: "NOT_FOUND",
          message: t(lang, "STORY_NOT_FOUND"),
        };
      }
      const s = snap.data() || {};

      // --- Values (with safe fallbacks) ---
      const displayName = s.display_name || "";
      const email = s.email || "";
      const country = s.country || "";
      const rating = typeof s.rating === "number" ? s.rating : null;
      const allowPublic = !!s.allow_public_use;
      const storyText = s.story_text || "";
      const expText = s.experience_text || "";
      const suggText = s.suggestions_text || "";
      const socialMedia = s.social_media || "";
      const photoUrl = s.photo_url || "";
      const videoUrl = s.video_url || "";

      const createdAt =
        s.created_at && s.created_at.toDate
          ? s.created_at.toDate()
          : new Date();

      // Timestamp localized (nice touch)
      const tsLocale =
        lang === "de" ? "de-DE" : lang === "es" ? "es-ES" : "en-US";
      const receivedAt = createdAt.toLocaleString(tsLocale, {
        timeZoneName: "short",
      });

      const year = new Date().getFullYear();
      const logo =
        "https://firebasestorage.googleapis.com/v0/b/togetherly-39exn5.firebasestorage.app/o/avatars%2F549cafac-a1d0-4fc2-a85c-1167a1fa2a22.png?alt=media&token=f387bf83-a673-42d6-b1de-6f4e7dfe4e77";

      const esc = (t) =>
        String(t || "")
          .replace(/</g, "&lt;")
          .replace(/>/g, "&gt;");

      // ---------- Staff email (EN) ----------
      const staffHtml = `<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="x-apple-disable-message-reformatting">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>New user story submission</title>
<style>
  body{margin:0;padding:0;-webkit-font-smoothing:antialiased;background:#f6f7fb}
  a{color:#6b72ff;text-decoration:none}
  .wrap{width:100%;padding:24px 12px}
  .card{max-width:760px;margin:0 auto;border-radius:14px;box-shadow:0 6px 24px rgba(16,24,40,.08);overflow:hidden;background:#ffffff}
  .header{padding:32px 24px;background:linear-gradient(90deg,#6d3cff 0%, #ff4d67 100%);color:#fff;text-align:center}
  .head-icon{width:36px;height:36px;margin:0 auto 12px;display:block}
  .h1{margin:0;font:700 22px/1.3 Inter,system-ui,Segoe UI,Roboto,Helvetica,Arial}
  .sub{margin:6px 0 0;font:500 13px/1.4 Inter,system-ui;opacity:.95}
  .inner{padding:24px}
  .table{width:100%;border-collapse:separate;border-spacing:0;border:1px solid #eef0f3;border-radius:12px;overflow:hidden}
  .th{width:190px;background:#f7f8fb;color:#475467;font:600 13px/1.2 Inter;padding:14px 16px;border-bottom:1px solid #eef0f3;vertical-align:top}
  .td{font:500 13px/1.55 Inter;color:#101828;padding:14px 16px;border-bottom:1px solid #eef0f3}
  .message{background:#fafbff;border:1px dashed #d9ddee;border-radius:10px;padding:12px;white-space:pre-wrap;word-break:break-word}
  .footer{padding:16px 24px 22px;text-align:center;color:#667085;font:500 12px/1.6 Inter}
</style>
</head>
<body>
  <div class="wrap">
    <div class="card">
      <div class="header">
        <img class="head-icon" src="${logo}" alt="togly">
        <h1 class="h1">New user story submission</h1>
        <div class="sub">Received ${receivedAt}</div>
      </div>
      <div class="inner">
        <table class="table" role="presentation" cellspacing="0" cellpadding="0">
          <tr><td class="th">Name</td><td class="td">${esc(displayName) || "-"}</td></tr>
          <tr><td class="th">Email</td><td class="td">${esc(email) || "-"}</td></tr>
          <tr><td class="th">Country</td><td class="td">${esc(country) || "-"}</td></tr>
          <tr><td class="th">Rating</td><td class="td">${rating ?? "-"}</td></tr>
          <tr><td class="th">Allow public use</td><td class="td">${allowPublic ? "Yes" : "No"}</td></tr>
          <tr><td class="th">Photo</td><td class="td">${photoUrl ? `<a href="${photoUrl}" target="_blank" rel="noopener">Open</a>` : "-"}</td></tr>
          <tr><td class="th">Video</td><td class="td">${videoUrl ? `<a href="${videoUrl}" target="_blank" rel="noopener">Open</a>` : "-"}</td></tr>
          <tr><td class="th">Social media</td><td class="td">${esc(socialMedia) || "-"}</td></tr>
          <tr><td class="th">Story</td><td class="td"><div class="message">${esc(storyText)}</div></td></tr>
          <tr><td class="th">Experience</td><td class="td"><div class="message">${esc(expText)}</div></td></tr>
          <tr><td class="th">Suggestions</td><td class="td"><div class="message">${esc(suggText)}</div></td></tr>
        </table>
      </div>
      <div class="footer">© ${year} Togly</div>
    </div>
  </div>
</body>
</html>`;

      const staffText = `New user story submission
Received: ${receivedAt}

Name: ${displayName}
Email: ${email}
Country: ${country}
Rating: ${rating ?? "-"}
Allow public use: ${allowPublic ? "Yes" : "No"}
Photo: ${photoUrl || "-"}
Video: ${videoUrl || "-"}

Story:
${storyText}

Experience:
${expText}

Suggestions:
${suggText}
`;

      // ---------- Customer email localized ----------
      const C = {
        en: {
          subject: "Thanks for sharing your story 💜",
          h1: "Thanks for sharing your story 💜",
          sub: (dt) => `We received your submission on ${dt}.`,
          hello: (name) => `Hi ${name || "there"},`,
          p1: "Thank you for taking the time to share your story with Togly. Your feedback helps us improve and inspire other couples around the world.",
          p2: "If you need to reach us, simply reply to this email.",
          bye: "Warm regards,<br><b>The Togly Team</b>",
          follow: "Follow us:",
          contact: "Contact:",
        },
        de: {
          subject: "Danke, dass du deine Story teilst 💜",
          h1: "Danke, dass du deine Story teilst 💜",
          sub: (dt) => `Wir haben deine Einsendung am ${dt} erhalten.`,
          hello: (name) => `Hi ${name || "du"},`,
          p1: "Danke, dass du dir Zeit genommen hast, deine Geschichte mit Togly zu teilen. Dein Feedback hilft uns, besser zu werden – und andere Paare zu inspirieren.",
          p2: "Wenn du uns noch etwas mitteilen möchtest, antworte einfach auf diese E-Mail.",
          bye: "Liebe Grüße,<br><b>Dein Togly Team</b>",
          follow: "Folge uns:",
          contact: "Kontakt:",
        },
        es: {
          subject: "Gracias por compartir tu historia 💜",
          h1: "Gracias por compartir tu historia 💜",
          sub: (dt) => `Hemos recibido tu envío el ${dt}.`,
          hello: (name) => `Hola ${name || "¡hola!"},`,
          p1: "Gracias por tomarte el tiempo de compartir tu historia con Togly. Tu feedback nos ayuda a mejorar e inspira a parejas de todo el mundo.",
          p2: "Si necesitas contactarnos, responde simplemente a este correo.",
          bye: "Con cariño,<br><b>El equipo de Togly</b>",
          follow: "Síguenos:",
          contact: "Contacto:",
        },
      }[lang] || {
        subject: "Thanks for sharing your story 💜",
        h1: "Thanks for sharing your story 💜",
        sub: (dt) => `We received your submission on ${dt}.`,
        hello: (name) => `Hi ${name || "there"},`,
        p1: "Thank you for taking the time to share your story with Togly. Your feedback helps us improve and inspire other couples around the world.",
        p2: "If you need to reach us, simply reply to this email.",
        bye: "Warm regards,<br><b>The Togly Team</b>",
        follow: "Follow us:",
        contact: "Contact:",
      };

      const customerHtml = `<!doctype html>
<html lang="${lang}">
<head>
<meta charset="utf-8">
<meta name="x-apple-disable-message-reformatting">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${C.subject}</title>
<style>
  body{margin:0;padding:0;-webkit-font-smoothing:antialiased;background:#f6f7fb}
  a{color:#6b72ff;text-decoration:none}
  .wrap{width:100%;padding:24px 12px}
  .card{max-width:760px;margin:0 auto;border-radius:14px;box-shadow:0 6px 24px rgba(16,24,40,.08);overflow:hidden;background:#ffffff}
  .header{padding:34px 24px;background:linear-gradient(90deg,#6d3cff 0%, #ff4d67 100%);color:#fff;text-align:center}
  .icon{width:36px;height:36px;margin:0 auto 10px;display:block}
  h1{margin:0;font:700 22px/1.25 Inter,system-ui,Segoe UI,Roboto,Helvetica,Arial}
  .sub{margin:8px 0 0;font:500 13px/1.4 Inter;opacity:.95}
  .body{padding:24px;font:500 14px/1.6 Inter,system-ui,Segoe UI,Roboto,Helvetica,Arial;color:#101828}
  .footer{padding:16px 24px 22px;text-align:center;color:#667085;font:500 12px/1.6 Inter}
  .sm a{margin:0 8px}
</style>
</head>
<body>
  <div class="wrap">
    <div class="card">
      <div class="header">
        <img class="icon" src="${logo}" alt="Togly">
        <h1>${C.h1}</h1>
        <div class="sub">${C.sub(receivedAt)}</div>
      </div>
      <div class="body">
        <p>${C.hello(esc(displayName))}</p>
        <p>${C.p1}</p>
        ${photoUrl ? `<p>• Photo: <a href="${photoUrl}" target="_blank" rel="noopener">Open</a></p>` : ``}
        ${videoUrl ? `<p>• Video: <a href="${videoUrl}" target="_blank" rel="noopener">Open</a></p>` : ``}
        <p>${C.p2}</p>
        <p>${C.bye}</p>
      </div>
      <div class="footer">
        <div class="sm">
          ${C.follow}
          <a href="https://www.instagram.com/gettogly" target="_blank" rel="noopener">Instagram</a> ·
          <a href="https://www.tiktok.com/@gettogly" target="_blank" rel="noopener">TikTok</a>
        </div>
        <div style="margin-top:8px">${C.contact} <a href="mailto:support@gettogly.com">support@gettogly.com</a></div>
        <div style="margin-top:4px">© ${year} Togly</div>
      </div>
    </div>
  </div>
</body>
</html>`;

      const customerTextByLang = {
        en: `Thanks for sharing your story

Hi ${displayName || "there"},

We received your submission on ${receivedAt}.
If you need to reach us, simply reply to this email.

Warm regards,
The Togly Team
`,
        de: `Danke, dass du deine Story teilst

Hi ${displayName || "du"},

Wir haben deine Einsendung am ${receivedAt} erhalten.
Wenn du uns noch etwas mitteilen möchtest, antworte einfach auf diese E-Mail.

Liebe Grüße
Dein Togly Team
`,
        es: `Gracias por compartir tu historia

Hola ${displayName || "¡hola!"},

Hemos recibido tu envío el ${receivedAt}.
Si necesitas contactarnos, responde simplemente a este correo.

Con cariño,
El equipo de Togly
`,
      };

      const customerText = customerTextByLang[lang] || customerTextByLang.en;

      // ---------- Send staff email ----------
      await db.collection("mail").add({
        to: ["support@gettogly.com"],
        message: {
          subject: `New user story submission`,
          text: staffText,
          html: staffHtml,
        },
        replyTo: email || undefined,
      });

      // ---------- Send customer confirmation (optional) ----------
      let customerCopySent = false;
      if (sendCopyToUser && email) {
        await db.collection("mail").add({
          to: [email],
          message: {
            subject: C.subject,
            text: customerText,
            html: customerHtml,
          },
        });
        customerCopySent = true;
      }

      // Return for FlutterFlow snackbar
      if (sendCopyToUser && !email) {
        return {
          ok: true,
          code: "OK_NO_EMAIL",
          message: t(lang, "EMAIL_MISSING"),
          customerCopySent,
        };
      }

      return {
        ok: true,
        code: "OK",
        message: t(lang, "STAFF_SENT_OK"),
        customerCopySent,
      };
    } catch (err) {
      console.error("sendStorySubmissionEmail failed:", err);
      // Best effort: no uid here sometimes; fallback EN
      return {
        ok: false,
        code: "ERROR",
        message: "Something went wrong. Please try again.",
        debugMessage: String((err && err.message) || err),
      };
    }
  });
