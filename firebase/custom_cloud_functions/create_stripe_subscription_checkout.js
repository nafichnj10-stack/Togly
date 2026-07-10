const functions = require("firebase-functions");
const admin = require("firebase-admin");
// KEIN admin.initializeApp() hier – das macht FlutterFlow selbst.

// Stripe mit deinem TEST Secret Key
// 👉 Ersetze HIER den Platzhalter durch deinen sk_test Schlüssel aus Stripe!
const stripe = require("stripe")("");

exports.createStripeSubscriptionCheckout = functions
  .region("europe-west3")
  .https.onCall(async (data, context) => {
    // Nur eingeloggte Nutzer erlauben
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Authentication required.",
      );
    }

    const uid = context.auth.uid;

    const priceId = data.priceId; // z.B. "price_1JzWqLAX5x0a14y0eKtnDGR"
    const successUrl = data.successUrl; // URL nach Erfolg
    const cancelUrl = data.cancelUrl; // URL nach Abbruch

    if (!priceId || typeof priceId !== "string") {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "priceId (string) is required.",
      );
    }

    if (
      !successUrl ||
      typeof successUrl !== "string" ||
      !cancelUrl ||
      typeof cancelUrl !== "string"
    ) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "successUrl and cancelUrl (string) are required.",
      );
    }

    // E-Mail holen (aus Parameter oder Auth-Token)
    let customerEmail = null;
    if (data.email && typeof data.email === "string") {
      customerEmail = data.email;
    } else if (context.auth.token && context.auth.token.email) {
      customerEmail = context.auth.token.email;
    }

    try {
      const session = await stripe.checkout.sessions.create({
        mode: "subscription",
        line_items: [
          {
            price: priceId,
            quantity: 1,
          },
        ],
        success_url: successUrl,
        cancel_url: cancelUrl,
        customer_email: customerEmail || undefined,
        metadata: {
          uid: uid,
          product: "togly_support_subscription",
        },
      });

      // URL an die App zurückgeben
      return { url: session.url };
    } catch (err) {
      console.error("Stripe error", err);
      throw new functions.https.HttpsError(
        "internal",
        err.message || "Stripe error",
      );
    }
  });
