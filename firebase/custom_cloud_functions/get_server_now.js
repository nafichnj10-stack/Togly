const functions = require("firebase-functions");
const admin = require("firebase-admin");
try {
  admin.app();
} catch {
  admin.initializeApp();
}

exports.getServerNow = functions
  .region("europe-west3")
  .https.onCall(async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Authentication required.",
      );
    }

    // server time in UTC millis
    return {
      ok: true,
      nowUtcMillis: Date.now(),
    };
  });
