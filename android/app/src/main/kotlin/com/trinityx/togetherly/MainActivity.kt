package com.trinityx.togetherly

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Intent
import android.os.Build
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

// ✅ এই চ্যানেলটাই মূল Togly Flutter অ্যাপ আর নেটিভ Home-Screen Widget-এর মধ্যে
// সেতু। Flutter সাইড থেকে (লগইন সফল হলে / লগআউট হলে / GPS ট্র্যাকিং টগল হলে)
// এই মেথডগুলো কল করলেই নেটিভ widget সার্ভিসগুলো চালু/বন্ধ হবে।
//
// Dart সাইডে ব্যবহার (উদাহরণ):
//
//   const _channel = MethodChannel('com.trinityx.togetherly/love_buddy_widget');
//   await _channel.invokeMethod('startWidgetSync');   // লগইন সফল হওয়ার পর কল করুন
//   await _channel.invokeMethod('stopWidgetSync');     // লগআউট হলে কল করুন
//   await _channel.invokeMethod('startLocationTracking'); // ট্রিপ শুরু হলে
//   await _channel.invokeMethod('stopLocationTracking');  // ট্রিপ শেষ/বাতিল হলে
//   await _channel.invokeMethod('requestPinWidget');   // "Add widget to home screen" বাটনে
class MainActivity : FlutterFragmentActivity() {

    private val CHANNEL = "com.trinityx.togetherly/love_buddy_widget"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startWidgetSync" -> {
                    startForegroundServiceCompat(Intent(this, LoveBuddyLiveService::class.java))
                    result.success(true)
                }
                "stopWidgetSync" -> {
                    stopService(Intent(this, LoveBuddyLiveService::class.java))
                    result.success(true)
                }
                "startLocationTracking" -> {
                    startForegroundServiceCompat(Intent(this, LoveBuddyLocationService::class.java))
                    result.success(true)
                }
                "stopLocationTracking" -> {
                    stopService(Intent(this, LoveBuddyLocationService::class.java))
                    result.success(true)
                }
                "requestPinWidget" -> {
                    result.success(requestPinWidget())
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun startForegroundServiceCompat(intent: Intent) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(intent)
        } else {
            startService(intent)
        }
    }

    // ✅ ইউজারকে সিস্টেম ডায়ালগ দেখিয়ে হোমস্ক্রিনে widget pin করার অনুরোধ পাঠায়।
    // সব ডিভাইস/লঞ্চার এটা সাপোর্ট করে না, তাই boolean রিটার্ন করা হচ্ছে।
    private fun requestPinWidget(): Boolean {
        val appWidgetManager = AppWidgetManager.getInstance(this)
        val provider = ComponentName(this, ToglyWidgetProvider::class.java)
        return if (appWidgetManager.isRequestPinAppWidgetSupported) {
            appWidgetManager.requestPinAppWidget(provider, null, null)
            true
        } else {
            false
        }
    }
}
