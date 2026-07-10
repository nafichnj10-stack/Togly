/**
 * Cloud Function: sendSupportEmail
 * Region: europe-west3
 * Runtime: firebase-functions v1
 */
const functions = require("firebase-functions");
const admin = require("firebase-admin");
// In FlutterFlow KEIN admin.initializeApp() aufrufen!

exports.sendSupportEmail = functions
  .region("europe-west3")
  .https.onCall(async (data, context) => {
    try {
      const db = admin.firestore();

      const {
        fullName = "",
        email = "",
        subject = "",
        message = "",
        priority = "normal",
        userId = "", // optional
      } = data || {};

      // ---- language (lite) ----
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

      const lang = await getUserLang(userId);

      // --- Utils ---
      const makeTicketCode = (len = 8) => {
        const alphabet = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
        let out = "";
        for (let i = 0; i < len; i++)
          out += alphabet[Math.floor(Math.random() * alphabet.length)];
        return out;
      };

      const ticketCode = makeTicketCode(8);
      const now = admin.firestore.Timestamp.now();
      const nowDate = now.toDate();
      const receivedAt = nowDate.toLocaleString("de-DE", {
        timeZone: "Europe/Berlin",
      });
      const year = nowDate.getFullYear();

      // --- Staff Mail HTML (unchanged) ---
      const staffEmailHtml = `
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="x-apple-disable-message-reformatting">
    <meta name="color-scheme" content="light dark">
    <meta name="supported-color-schemes" content="light dark">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>New support ticket</title>
    <style>
      body{margin:0;padding:0;-webkit-font-smoothing:antialiased;word-break:break-word;background:#f6f7fb}
      a{color:#6b72ff;text-decoration:none}
      img{border:none;outline:none;text-decoration:none}
      .wrap{width:100%;padding:24px 12px}
      .card{max-width:720px;margin:0 auto;border-radius:14px;box-shadow:0 6px 24px rgba(16,24,40,.08);overflow:hidden;background:#ffffff}
      .header{padding:32px 24px;background:linear-gradient(90deg,#6d3cff 0%, #ff4d67 100%);color:#fff;text-align:center}
      .head-icon{width:36px;height:36px;margin:0 auto 12px;display:block}
      .h1{margin:0;font:700 22px/1.3 Inter,system-ui,Segoe UI,Roboto,Helvetica,Arial}
      .sub{margin:6px 0 0;font:500 13px/1.4 Inter,system-ui,Segoe UI,Roboto,Helvetica,Arial;opacity:.95}
      .badge{display:inline-block;margin-top:10px;padding:6px 12px;border-radius:999px;background:rgba(255,255,255,.18);border:1px solid rgba(255,255,255,.35);font:600 12px/1 Inter,system-ui;letter-spacing:.3px;color:#fff}
      .inner{padding:24px}
      .table{width:100%;border-collapse:separate;border-spacing:0;border:1px solid #eef0f3;border-radius:12px;overflow:hidden}
      .th{width:160px;background:#f7f8fb;color:#475467;font:600 13px/1.2 Inter;padding:14px 16px;border-bottom:1px solid #eef0f3}
      .td{font:500 13px/1.5 Inter;color:#101828;padding:14px 16px;border-bottom:1px solid #eef0f3}
      .last .th,.last .td{border-bottom:none}
      .message{background:#fafbff;border:1px dashed #d9ddee;border-radius:10px;padding:14px;font:500 13px/1.55 Inter;color:#101828;white-space:pre-wrap;word-break:break-word}
      .footer{padding:16px 24px 22px;text-align:center;color:#667085;font:500 12px/1.6 Inter}
      .sm a{margin:0 8px}
      @media (max-width:520px){ .th{width:38%} .badge{display:block;margin:10px auto 0} }
    </style>
  </head>
  <body>
    <div class="wrap">
      <div class="card">
        <div class="header">
          <img class="head-icon" src="https://firebasestorage.googleapis.com/v0/b/togetherly-39exn5.firebasestorage.app/o/avatars%2F549cafac-a1d0-4fc2-a85c-1167a1fa2a22.png?alt=media&token=f387bf83-a673-42d6-b1de-6f4e7dfe4e77" alt="togly">
          <h1 class="h1">New support ticket</h1>
          <div class="sub">Received ${receivedAt}</div>
          <div class="badge">Ticket: ${ticketCode}</div>
        </div>

        <div class="inner">
          <table class="table" role="presentation" cellspacing="0" cellpadding="0">
            <tr>
              <td class="th">From</td>
              <td class="td">${fullName} &lt;${email}&gt;</td>
            </tr>
            <tr>
              <td class="th">Subject</td>
              <td class="td">${subject || "-"}</td>
            </tr>
            <tr>
              <td class="th">Priority</td>
              <td class="td">${priority}</td>
            </tr>
            <tr class="last">
              <td class="th">Message</td>
              <td class="td"><div class="message">${(message || "").replace(/</g, "&lt;").replace(/>/g, "&gt;")}</div></td>
            </tr>
          </table>
        </div>

        <div class="footer">
          <div class="sm">Follow us:
            <a href="https://www.instagram.com/gettogly" target="_blank" rel="noopener">Instagram</a> ·
            <a href="https://www.tiktok.com/@gettogly" target="_blank" rel="noopener">TikTok</a>
          </div>
          <div style="margin-top:8px;">
            Support hours: Mon–Fri 9:00–17:00 CET · Contact:
            <a href="mailto:support@gettogly.com">support@gettogly.com"</a>
          </div>
          <div style="margin-top:4px;">© ${year} Togly</div>
        </div>
      </div>
    </div>
  </body>
</html>
      `;

      // -------- Customer mail strings by language --------
      const STR = {
        en: {
          title: "Thanks for contacting Togly 💜",
          sub: "We received your message and will get back to you soon.",
          hi: (name) => `Hi ${name || "there"},`,
          p1: "Thanks for reaching out to us. Your request has been logged in our system. We typically reply within <b>1–2 business days</b>.",
          subjectLabel: "Subject",
          priorityLabel: "Priority",
          messageLabel: "Message",
          p2: (code) =>
            `If you have additional details, simply reply to this email and reference ticket <b>${code}</b>.`,
          bye: "Warm regards,<br><b>The Togly Team</b>",
          mailSubject: (code) => `We’ve received your request • ${code}`,
          textTitle: "Thanks for contacting Togly",
          textP1: (code) =>
            `We received your message and logged it under ticket ${code}.\nWe typically reply within 1–2 business days.`,
          textBye: "Warm regards,\nThe Togly Team",
        },
        de: {
          title: "Danke, dass du Togly kontaktierst 💜",
          sub: "Wir haben deine Nachricht erhalten und melden uns bald bei dir.",
          hi: (name) => `Hi ${name || "du"},`,
          p1: "Danke für deine Nachricht. Wir haben dein Anliegen gespeichert und melden uns in der Regel innerhalb von <b>1–2 Werktagen</b>.",
          subjectLabel: "Betreff",
          priorityLabel: "Priorität",
          messageLabel: "Nachricht",
          p2: (code) =>
            `Wenn du noch Details ergänzen möchtest, antworte einfach auf diese E-Mail und nenne Ticket <b>${code}</b>.`,
          bye: "Liebe Grüße,<br><b>Dein Togly Team</b>",
          mailSubject: (code) => `Wir haben deine Anfrage erhalten • ${code}`,
          textTitle: "Danke, dass du Togly kontaktierst",
          textP1: (code) =>
            `Wir haben deine Nachricht erhalten und unter Ticket ${code} gespeichert.\nWir antworten in der Regel innerhalb von 1–2 Werktagen.`,
          textBye: "Liebe Grüße,\nDein Togly Team",
        },
        es: {
          title: "Gracias por contactar con Togly 💜",
          sub: "Hemos recibido tu mensaje y te responderemos pronto.",
          hi: (name) => `Hola ${name || "¡hola!"},`,
          p1: "Gracias por escribirnos. Hemos registrado tu solicitud y normalmente respondemos en <b>1–2 días hábiles</b>.",
          subjectLabel: "Asunto",
          priorityLabel: "Prioridad",
          messageLabel: "Mensaje",
          p2: (code) =>
            `Si quieres añadir más detalles, responde a este correo e indica el ticket <b>${code}</b>.`,
          bye: "Con cariño,<br><b>El equipo de Togly</b>",
          mailSubject: (code) => `Hemos recibido tu solicitud • ${code}`,
          textTitle: "Gracias por contactar con Togly",
          textP1: (code) =>
            `Hemos recibido tu mensaje y lo registramos con el ticket ${code}.\nNormalmente respondemos en 1–2 días hábiles.`,
          textBye: "Con cariño,\nEl equipo de Togly",
        },
      };

      const S = STR[lang] || STR.en;

      const customerEmailHtml = `
<!doctype html>
<html lang="${lang}">
  <head>
    <meta charset="utf-8">
    <meta name="x-apple-disable-message-reformatting">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${S.title}</title>
    <style>
      body{margin:0;padding:0;-webkit-font-smoothing:antialiased;background:#f6f7fb}
      a{color:#6b72ff;text-decoration:none}
      .wrap{width:100%;padding:24px 12px}
      .card{max-width:720px;margin:0 auto;border-radius:14px;box-shadow:0 6px 24px rgba(16,24,40,.08);overflow:hidden;background:#ffffff}
      .header{padding:34px 24px;background:linear-gradient(90deg,#6d3cff 0%, #ff4d67 100%);color:#fff;text-align:center}
      .icon{width:32px;height:32px;margin:0 auto 10px;display:block}
      h1{margin:0;font:700 22px/1.25 Inter,system-ui,Segoe UI,Roboto,Helvetica,Arial}
      .sub{margin:8px 0 0;font:500 13px/1.4 Inter;opacity:.95}
      .badge{display:inline-block;margin-top:10px;padding:6px 12px;border-radius:999px;background:rgba(255,255,255,.18);border:1px solid rgba(255,255,255,.35);font:600 12px/1 Inter;letter-spacing:.3px;color:#fff}
      .body{padding:24px;font:500 14px/1.6 Inter,system-ui,Segoe UI,Roboto,Helvetica,Arial;color:#101828}
      .hello{margin:0 0 14px}
      .table{width:100%;border-collapse:separate;border-spacing:0;border:1px solid #eef0f3;border-radius:12px;overflow:hidden;margin-top:10px}
      .th{width:160px;background:#f7f8fb;color:#475467;font:600 13px/1.2 Inter;padding:14px 16px;border-bottom:1px solid #eef0f3}
      .td{font:500 13px/1.5 Inter;color:#101828;padding:14px 16px;border-bottom:1px solid #eef0f3}
      .last .th,.last .td{border-bottom:none}
      .message{background:#fafbff;border:1px dashed #d9ddee;border-radius:10px;padding:14px;font:500 13px/1.55 Inter;color:#101828;white-space:pre-wrap;word-break:break-word}
      .footer{padding:16px 24px 22px;text-align:center;color:#667085;font:500 12px/1.6 Inter}
      .sm a{margin:0 8px}
      @media (max-width:520px){ .th{width:38%} .badge{display:block;margin:10px auto 0} }
    </style>
  </head>
  <body>
    <div class="wrap">
      <div class="card">
        <div class="header">
          <img class="icon" src="https://firebasestorage.googleapis.com/v0/b/togetherly-39exn5.firebasestorage.app/o/avatars%2F549cafac-a1d0-4fc2-a85c-1167a1fa2a22.png?alt=media&token=f387bf83-a673-42d6-b1de-6f4e7dfe4e77" alt="togly">
          <h1>${S.title}</h1>
          <div class="sub">${S.sub}</div>
          <div class="badge">Ticket: ${ticketCode}</div>
        </div>

        <div class="body">
          <p class="hello">${S.hi(fullName)}</p>
          <p>${S.p1}</p>

          <table class="table" role="presentation" cellspacing="0" cellpadding="0">
            <tr>
              <td class="th">${S.subjectLabel}</td>
              <td class="td">${subject || "-"}</td>
            </tr>
            <tr>
              <td class="th">${S.priorityLabel}</td>
              <td class="td">${priority}</td>
            </tr>
            <tr class="last">
              <td class="th">${S.messageLabel}</td>
              <td class="td"><div class="message">${(message || "").replace(/</g, "&lt;").replace(/>/g, "&gt;")}</div></td>
            </tr>
          </table>

          <p style="margin-top:18px;">${S.p2(ticketCode)}</p>
          <p>${S.bye}</p>
        </div>

        <div class="footer">
          <div class="sm">Follow us:
            <a href="https://www.instagram.com/gettogly" target="_blank" rel="noopener">Instagram</a> ·
            <a href="https://www.tiktok.com/@gettogly" target="_blank" rel="noopener">TikTok</a>
          </div>
          <div style="margin-top:8px;">Support hours: Mon–Fri 9:00–17:00 CET · Contact:
            <a href="mailto:support@gettogly.com">support@gettogly.com</a>
          </div>
          <div style="margin-top:4px;">© ${year} Togly</div>
        </div>
      </div>
    </div>
  </body>
</html>
      `;

      const staffText = `New support ticket
Ticket: ${ticketCode}
Received: ${receivedAt}

From: ${fullName} <${email}>
Subject: ${subject || "-"}
Priority: ${priority}

Message:
${message}
`;

      const customerText = `${S.textTitle}

${S.hi(fullName).replace(/<[^>]*>/g, "")}

${S.textP1(ticketCode)}

${S.subjectLabel}: ${subject || "-"}
${S.priorityLabel}: ${priority}

${S.messageLabel}:
${message}

${S.textBye}
`;

      // --- Ticket speichern ---
      await db.collection("support_tickets").doc(ticketCode).set({
        created_at: now,
        last_update_at: now,
        status: "open",
        user_id: userId,
        full_name: fullName,
        email,
        subject,
        message,
        priority,
        ticket_code: ticketCode,
      });

      // --- Staff-Mail ---
      await db.collection("mail").add({
        to: ["support@gettogly.com"],
        message: {
          subject: `New support ticket • ${subject || "No subject"} • ${ticketCode}`,
          text: staffText,
          html: staffEmailHtml,
        },
        replyTo: email || undefined,
      });

      // --- Kunden-Bestätigung (localized) ---
      await db.collection("mail").add({
        to: [email],
        message: {
          subject: S.mailSubject(ticketCode),
          text: customerText,
          html: customerEmailHtml,
        },
      });

      return { ok: true, ticketCode };
    } catch (err) {
      console.error("sendSupportEmail failed:", err);
      return { ok: false, error: String((err && err.message) || err) };
    }
  });
