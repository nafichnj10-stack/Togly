package com.trinityx.togetherly

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import com.google.firebase.FirebaseApp
import com.google.firebase.auth.FirebaseAuth

// ✅ ফোন রিস্টার্ট হলে LoveBuddyLiveService (Firebase live sync) আবার চালু
// করার জন্য এই receiver। আগের ডেমো ভার্সনে একটা ম্যানুয়াল "auto_firebase_enabled"
// flag চেক হতো — এখন সেই ম্যানুয়াল টগল নেই, বরং সরাসরি আসল অথ স্টেট চেক করা হয়:
// শুধু তখনই সার্ভিস চালু হবে যদি Firebase Auth-এ সত্যিকারের লগইন সেশন থাকে।
//
// ⚠️ BroadcastReceiver-এ boot সময়ে Flutter engine এখনো চালু নাও থাকতে পারে,
// তাই FirebaseApp init হয়েছে কিনা নিশ্চিত করতে ছোট একটা fallback init রাখা
// হলো (শুধু google-services.json-এর মূল project info দিয়ে, কোনো hardcoded
// user credential নেই)।
class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action != Intent.ACTION_BOOT_COMPLETED) return

        if (FirebaseApp.getApps(context).isEmpty()) {
            FirebaseApp.initializeApp(context)
        }

        val uid = FirebaseAuth.getInstance().currentUser?.uid
        if (uid == null) return

        val serviceIntent = Intent(context, LoveBuddyLiveService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            context.startForegroundService(serviceIntent)
        } else {
            context.startService(serviceIntent)
        }
    }
}
