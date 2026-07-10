package com.trinityx.togetherly

import android.appwidget.AppWidgetManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.functions.FirebaseFunctions

// ✅ Widget-এর "Send Love" / "Birthday Wish" বাটনে ট্যাপ করলে এটা ট্রিগার হয়।
//
// এখন যা হচ্ছে:
//   ১) সাথে সাথে widget-এ হার্ট-উড়ে-যাওয়া animation দেখানো হয় (client-side,
//      নেটওয়ার্ক রেসপন্সের অপেক্ষা না করেই widget সাথে সাথে "জীবন্ত" মনে হয়)।
//   ২) সমান্তরালে আসল ব্যাকএন্ডে existing "sendSilentCheckIn" Cloud Function কল
//      হয় — এটাই Firestore-এ love-send লেখে, love score আপডেট করে, এবং
//      পার্টনারকে push notification পাঠায়। রেসপন্স আসার পর Cloud Function
//      নিজেই relationship_views ডকুমেন্ট আপডেট করে, যেটা LoveBuddyLiveService-এর
//      listener ধরে widget-কে চূড়ান্তভাবে রিফ্রেশ করবে — তাই এখানে ম্যানুয়ালি
//      কোনো prefs লেখার দরকার নেই।
class SendLoveReceiver : BroadcastReceiver() {

    companion object {
        private const val TAG = "SendLoveReceiver"
        private const val REGION = "europe-west3"
    }

    override fun onReceive(context: Context, intent: Intent) {
        val widgetId = intent.getIntExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, -1)
        val pendingResult = goAsync()
        val appContext = context.applicationContext

        // ✅ birthday state হলে (birthday_dog/birthday_cat/birthday_both) সার্ভারে
        // "birthday" টাইপ পাঠানো হয়, নাহলে সাধারণ "normal" love
        val prefs = appContext.getSharedPreferences("togly_prefs", Context.MODE_PRIVATE)
        val widgetState = prefs.getString("widget_state", "normal") ?: "normal"
        val loveType = if (widgetState.startsWith("birthday")) "birthday" else "normal"

        SendLoveAnimator.play(appContext, widgetId) {
            callSendSilentCheckIn(appContext, loveType)
            pendingResult.finish()
        }
    }

    private fun callSendSilentCheckIn(context: Context, loveType: String) {
        if (FirebaseAuth.getInstance().currentUser == null) {
            Log.w(TAG, "No signed-in user — skipping sendSilentCheckIn call")
            return
        }

        val data = hashMapOf(
            "mode" to "send",
            "type" to loveType
        )

        FirebaseFunctions.getInstance(REGION)
            .getHttpsCallable("sendSilentCheckIn")
            .call(data)
            .addOnSuccessListener { result ->
                Log.d(TAG, "sendSilentCheckIn OK: ${result.data}")
            }
            .addOnFailureListener { e ->
                // সাধারণ কারণ: COOLDOWN বা DAILY_LIMIT (দিনে সর্বোচ্চ ২ বার, ৩০ মিনিট cooldown)
                // — এগুলো error না, স্বাভাবিক ব্যবসায়িক নিয়ম, তাই শুধু log করা হচ্ছে
                Log.w(TAG, "sendSilentCheckIn failed/limited: ${e.message}")
            }
    }
}
