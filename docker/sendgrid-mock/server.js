const express = require("express");
const nodemailer = require("nodemailer");

const app = express();
const PORT = 3102;

// Mailpit SMTP (Docker internal network)
const SMTP_HOST = process.env.SMTP_HOST || "mailpit";
const SMTP_PORT = parseInt(process.env.SMTP_PORT || "1025", 10);

app.use(express.json());

// Create reusable SMTP transporter for Mailpit
const transporter = nodemailer.createTransport({
  host: SMTP_HOST,
  port: SMTP_PORT,
  secure: false,
});

// SendGrid v3 Mail Send API mock
// https://docs.sendgrid.com/api-reference/mail-send/mail-send
app.post("/v3/mail/send", async (req, res) => {
  const authHeader = req.headers["authorization"];
  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    console.warn("[SendGrid Mock] WARNING: Missing or invalid Authorization header");
  } else {
    console.log("[SendGrid Mock] Authorization: Bearer <redacted>");
  }

  const body = req.body;

  if (!body || !body.personalizations || !body.from) {
    console.error("[SendGrid Mock] Invalid request body:", JSON.stringify(body));
    return res.status(400).json({
      errors: [
        {
          message: "Invalid request: missing required fields (personalizations, from)",
          field: null,
          help: null,
        },
      ],
    });
  }

  const from = body.from.email || body.from;
  const fromName = body.from.name || "";
  const subject = body.subject || "(no subject)";

  // Collect all recipients from personalizations
  const toAddresses = [];
  for (const p of body.personalizations) {
    if (p.to) {
      for (const recipient of p.to) {
        toAddresses.push(recipient.email || recipient);
      }
    }
  }

  // Extract content
  let textBody = "";
  let htmlBody = "";
  if (body.content) {
    for (const c of body.content) {
      if (c.type === "text/plain") textBody = c.value;
      if (c.type === "text/html") htmlBody = c.value;
    }
  }

  console.log("-------------------------------------------");
  console.log("[SendGrid Mock] Received email:");
  console.log(`  From:    ${fromName ? `${fromName} <${from}>` : from}`);
  console.log(`  To:      ${toAddresses.join(", ")}`);
  console.log(`  Subject: ${subject}`);
  if (textBody) console.log(`  Body (text): ${textBody.substring(0, 200)}${textBody.length > 200 ? "..." : ""}`);
  if (htmlBody) console.log(`  Body (html): ${htmlBody.substring(0, 200)}${htmlBody.length > 200 ? "..." : ""}`);
  console.log("-------------------------------------------");

  // Forward to Mailpit via SMTP
  try {
    const mailOptions = {
      from: fromName ? `"${fromName}" <${from}>` : from,
      to: toAddresses.join(", "),
      subject: subject,
    };
    if (textBody) mailOptions.text = textBody;
    if (htmlBody) mailOptions.html = htmlBody;

    await transporter.sendMail(mailOptions);
    console.log("[SendGrid Mock] Email forwarded to Mailpit successfully");
  } catch (err) {
    console.error("[SendGrid Mock] Failed to forward email to Mailpit:", err.message);
    // Still return 202 to the client (SendGrid-compatible behavior)
    // The mock should not fail even if Mailpit is temporarily unavailable
  }

  // SendGrid returns 202 Accepted on success with empty body
  res.status(202).end();
});

// Health check
app.get("/health", (_req, res) => {
  res.json({ status: "ok", service: "sendgrid-mock" });
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`SendGrid mock server running on port ${PORT}`);
  console.log(`Forwarding emails to Mailpit at ${SMTP_HOST}:${SMTP_PORT}`);
});
