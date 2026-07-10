package com.trinityx.togetherly

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.util.Log
import com.bumptech.glide.Glide
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.firestore.ListenerRegistration
import java.util.concurrent.TimeUnit

// ✅ REAL APP VERSION — কোনো hardcoded test login নেই। মূল Togly অ্যাপে
// ইউজার যে Firebase Auth সেশনে লগইন করে আছে, এই সার্ভিস শুধু সেটাই ব্যবহার
// করে (FirebaseAuth.getInstance().currentUser)। AuthStateListener দিয়ে
// লগইন/লগআউট/অ্যাকাউন্ট-সুইচ — সবকিছু automatically হ্যান্ডল হয়।
//
// এই সার্ভিস চালু হয় MainActivity-এর MethodChannel থেকে ("startWidgetSync"),
// সাধারণত মূল অ্যাপে লগইন সফল হওয়ার পরপরই Flutter সাইড থেকে কল করা হবে।
class LoveBuddyLiveService : Service() {

    private val TAG = "LoveBuddyLiveService"
    private val mainHandler = Handler(Looper.getMainLooper())
    private val db by lazy { FirebaseFirestore.getInstance() }

    private var authListener: FirebaseAuth.AuthStateListener? = null

    // সব Firestore listener registrations — logout/onDestroy-তে একসাথে সব বন্ধ করার জন্য
    private var relViewListener: ListenerRegistration? = null
    private var relDocListener: ListenerRegistration? = null
    private var myUserListener: ListenerRegistration? = null
    private var partnerPublicListener: ListenerRegistration? = null

    private var currentUid: String? = null
    private var currentPartnerUid: String? = null
    private var currentRelationshipId: String? = null

    private val pulseHandler = Handler(Looper.getMainLooper())
    private var pulseStartTime = 0L
    private var bikeFrameCounter = 0
    private val PULSE_CYCLE_MS = 4000L
    private val PULSE_TICK_MS = 120L
    private val pulseRunnable = object : Runnable {
        override fun run() {
            if (!SendLoveAnimator.isPlaying) {
                val elapsed = System.currentTimeMillis() - pulseStartTime
                val phase = (elapsed % PULSE_CYCLE_MS) / PULSE_CYCLE_MS.toFloat()
                bikeFrameCounter++
                refreshWidget(pulsePhase = phase, bikeFrame = bikeFrameCounter)
            }
            pulseHandler.postDelayed(this, PULSE_TICK_MS)
        }
    }

    override fun onCreate() {
        super.onCreate()
        // ⚠️ FirebaseApp আলাদাভাবে init করার দরকার নেই — মূল অ্যাপের
        // google-services.json দিয়ে Flutter (firebase_core প্লাগিন) স্টার্টআপেই
        // default FirebaseApp init করে ফেলে, এই সার্ভিস একই প্রসেসে চলে।
        GlideNetworkSetup.ensureInitialized(applicationContext)
        startForegroundWithNotification()
        startWhenAuthenticated()

        pulseStartTime = System.currentTimeMillis()
        pulseHandler.postDelayed(pulseRunnable, PULSE_TICK_MS)
    }

    // ✅ বর্তমানে লগইন করা থাকলে সাথে সাথে শোনা শুরু করে, আর ভবিষ্যতে
    // লগইন/লগআউট/অ্যাকাউন্ট বদল হলেও এই একই listener সেটা ধরে ফেলবে —
    // তাই Flutter সাইডে বারবার "startWidgetSync" কল করার দরকার নেই,
    // শুধু app শুরুতে একবার কল করলেই যথেষ্ট।
    private fun startWhenAuthenticated() {
        val auth = FirebaseAuth.getInstance()

        auth.currentUser?.let { onUserSignedIn(it.uid) }

        val listener = FirebaseAuth.AuthStateListener { firebaseAuth ->
            val uid = firebaseAuth.currentUser?.uid
            if (uid == null) {
                Log.d(TAG, "User signed out — detaching listeners")
                detachAllListeners()
                currentUid = null
            } else if (uid != currentUid) {
                Log.d(TAG, "User signed in / switched: uid=$uid")
                detachAllListeners()
                onUserSignedIn(uid)
            }
        }
        authListener = listener
        auth.addAuthStateListener(listener)
    }

    private fun onUserSignedIn(uid: String) {
        currentUid = uid
        attachRelationshipViewListener(uid)
        attachMyUserListener(uid)
    }

    // ---------------- relationship_views/{uid} ----------------
    // widget state, distance, love-sent, birthday, tz offset — সবকিছুর মূল উৎস
    private fun attachRelationshipViewListener(uid: String) {
        relViewListener = db.collection("relationship_views").document(uid)
            .addSnapshotListener { snapshot, error ->
                if (error != null) {
                    Log.e(TAG, "relationship_views listen failed: ${error.message}")
                    return@addSnapshotListener
                }
                val data = snapshot?.data ?: return@addSnapshotListener
                handleRelationshipViewUpdate(data)
            }
    }

    // widget_background_key কে ToglyWidgetProvider-এর চেনা state key-তে ম্যাপ করে
    private fun resolveWidgetStateKey(backgroundKey: String, data: Map<String, Any?>): String {
        if (backgroundKey == "birthday") {
            val myUid = currentUid
            val partnerUid = data["partner_uid"] as? String
            val birthdayUids = (data["widget_birthday_user_uids"] as? List<*>)?.map { it.toString() } ?: emptyList()
            val myBirthday = myUid != null && birthdayUids.contains(myUid)
            val partnerBirthday = partnerUid != null && birthdayUids.contains(partnerUid)
            return when {
                myBirthday && partnerBirthday -> "birthday_both"
                myBirthday -> "birthday_${data["my_love_buddy_pet"] as? String ?: "dog"}"
                partnerBirthday -> "birthday_${data["partner_love_buddy_pet"] as? String ?: "cat"}"
                else -> "normal"
            }
        }
        if (backgroundKey.startsWith("travel_pack_")) {
            return backgroundKey.removePrefix("travel_pack_").let { "travel_$it" }
        }
        return backgroundKey
    }

    private fun handleRelationshipViewUpdate(data: Map<String, Any?>) {
        val prefs = getSharedPreferences("togly_prefs", Context.MODE_PRIVATE)

        val rawBackgroundKey = data["widget_background_key"] as? String ?: "normal"
        val resolvedState = resolveWidgetStateKey(rawBackgroundKey, data)

        val partnerUid = data["partner_uid"] as? String
        val relationshipId = data["relationship_id"] as? String

        prefs.edit().apply {
            putString("widget_state", resolvedState)
            putString("name_left", data["my_love_buddy_name"] as? String ?: data["my_name"] as? String ?: "Me")
            putString("name_right", data["partner_love_buddy_name"] as? String ?: data["partner_name"] as? String ?: "Partner")

            // কে dog, কে cat — ইউজারভেদে বদলাতে পারে, তাই hardcode না করে ডেটা থেকে পড়া
            putString("pet_left", data["my_love_buddy_pet"] as? String ?: "dog")
            putString("pet_right", data["partner_love_buddy_pet"] as? String ?: "cat")

            (data["widget_distance_km"] as? Number)?.let {
                putFloat("current_distance", it.toFloat())
            }
            (data["widget_distance_progress"] as? Number)?.let {
                putInt("distance_progress_pct", it.toInt())
            }

            val myTzOffset = (data["my_tz_offset_minutes"] as? Number)?.toInt()
            val partnerTzOffset = (data["partner_tz_offset_minutes"] as? Number)?.toInt()
            val diffHours = if (myTzOffset != null && partnerTzOffset != null) {
                Math.round(Math.abs(myTzOffset - partnerTzOffset) / 60f)
            } else {
                0
            }
            putInt("tz_diff_hours", diffHours)
            apply()
        }

        // পার্টনার প্রথমবার জানা গেলে (বা বদলে গেলে) তার পাবলিক প্রোফাইল (দেশ) শোনা শুরু করি
        if (!partnerUid.isNullOrBlank() && partnerUid != currentPartnerUid) {
            currentPartnerUid = partnerUid
            attachPartnerPublicListener(partnerUid)
        }

        // relationship_id প্রথমবার জানা গেলে next_meeting_date শোনা শুরু করি (countdown-এর জন্য)
        if (!relationshipId.isNullOrBlank() && relationshipId != currentRelationshipId) {
            currentRelationshipId = relationshipId
            attachRelationshipDocListener(relationshipId)
        }

        val myPhotoUrl = data["my_photo_url"] as? String
        val partnerPhotoUrl = data["partner_photo_url"] as? String
        loadPhotosAndRefresh(myPhotoUrl, partnerPhotoUrl)
    }

    // ---------------- Users/{uid} — নিজের দেশ + অ্যাপের ভাষা সেটিং ----------------
    private fun attachMyUserListener(uid: String) {
        myUserListener = db.collection("Users").document(uid)
            .addSnapshotListener { snapshot, error ->
                if (error != null) {
                    Log.e(TAG, "Users/$uid listen failed: ${error.message}")
                    return@addSnapshotListener
                }
                val data = snapshot?.data ?: return@addSnapshotListener
                val prefs = getSharedPreferences("togly_prefs", Context.MODE_PRIVATE)
                prefs.edit().apply {
                    putString("country_left", data["country_name"] as? String ?: "")
                    putString("flag_left", FlagUtils.countryCodeToFlagEmoji(data["country_code"] as? String))
                    val lang = (data["appLanguage"] as? String)?.lowercase()?.take(2)
                    if (lang == "en" || lang == "de" || lang == "es") {
                        putString("app_language", lang)
                    }
                    apply()
                }
                refreshWidget()
            }
    }

    // ---------------- PublicUsers/{partnerUid} — পার্টনারের দেশ ----------------
    private fun attachPartnerPublicListener(partnerUid: String) {
        partnerPublicListener?.remove()
        partnerPublicListener = db.collection("PublicUsers").document(partnerUid)
            .addSnapshotListener { snapshot, error ->
                if (error != null) {
                    Log.e(TAG, "PublicUsers/$partnerUid listen failed: ${error.message}")
                    return@addSnapshotListener
                }
                val data = snapshot?.data ?: return@addSnapshotListener
                val prefs = getSharedPreferences("togly_prefs", Context.MODE_PRIVATE)
                prefs.edit().apply {
                    putString("country_right", data["country_name"] as? String ?: "")
                    putString("flag_right", FlagUtils.countryCodeToFlagEmoji(data["country_code"] as? String))
                    apply()
                }
                refreshWidget()
            }
    }

    // ---------------- relationships/{relationshipId} — পরবর্তী দেখার countdown ----------------
    private fun attachRelationshipDocListener(relationshipId: String) {
        relDocListener?.remove()
        relDocListener = db.collection("relationships").document(relationshipId)
            .addSnapshotListener { snapshot, error ->
                if (error != null) {
                    Log.e(TAG, "relationships/$relationshipId listen failed: ${error.message}")
                    return@addSnapshotListener
                }
                val nextMeeting = snapshot?.getTimestamp("next_meeting_date") ?: return@addSnapshotListener
                val diffMs = nextMeeting.toDate().time - System.currentTimeMillis()
                val days = TimeUnit.MILLISECONDS.toDays(diffMs).toInt().coerceAtLeast(0)
                val prefs = getSharedPreferences("togly_prefs", Context.MODE_PRIVATE)
                prefs.edit().putInt("countdown_days", days).apply()
                refreshWidget()
            }
    }

    private fun detachAllListeners() {
        relViewListener?.remove(); relViewListener = null
        relDocListener?.remove(); relDocListener = null
        myUserListener?.remove(); myUserListener = null
        partnerPublicListener?.remove(); partnerPublicListener = null
        currentPartnerUid = null
        currentRelationshipId = null
    }

    // ছবি ডাউনলোড network কল, তাই main thread-এ না করে background থ্রেডে করা হচ্ছে
    private fun loadPhotosAndRefresh(myPhotoUrl: String?, partnerPhotoUrl: String?) {
        Thread {
            val leftBitmap = tryLoadBitmap(myPhotoUrl, "MY")
            val rightBitmap = tryLoadBitmap(partnerPhotoUrl, "PARTNER")
            refreshWidget(leftBitmap, rightBitmap)
        }.start()
    }

    private fun tryLoadBitmap(url: String?, label: String): Bitmap? {
        if (url.isNullOrBlank()) return null
        return try {
            val bitmap = Glide.with(applicationContext)
                .asBitmap()
                .load(url)
                .submit(150, 150)
                .get(15, TimeUnit.SECONDS)

            if (label == "MY") PhotoCache.saveLeft(applicationContext, bitmap)
            if (label == "PARTNER") PhotoCache.saveRight(applicationContext, bitmap)
            bitmap
        } catch (e: Exception) {
            Log.e(TAG, "$label photo failed to load ($url): ${e.message}")
            null
        }
    }

    private fun refreshWidget(leftPhoto: Bitmap? = null, rightPhoto: Bitmap? = null, pulsePhase: Float = 0f, bikeFrame: Int = 0) {
        val appWidgetManager = AppWidgetManager.getInstance(this)
        val componentName = ComponentName(this, ToglyWidgetProvider::class.java)
        val widgetIds = appWidgetManager.getAppWidgetIds(componentName)
        for (widgetId in widgetIds) {
            ToglyWidgetProvider.updateWidget(
                context = this,
                appWidgetManager = appWidgetManager,
                widgetId = widgetId,
                leftPhoto = leftPhoto,
                rightPhoto = rightPhoto,
                pulsePhase = pulsePhase,
                bikeFrame = bikeFrame
            )
        }
    }

    private fun startForegroundWithNotification() {
        val channelId = "love_buddy_live_channel"
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                channelId, "Love Buddy Live Sync",
                NotificationManager.IMPORTANCE_MIN
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager?.createNotificationChannel(channel)
        }

        val notification: Notification = androidx.core.app.NotificationCompat.Builder(this, channelId)
            .setContentTitle("Love Buddy widget active")
            .setSmallIcon(android.R.drawable.ic_dialog_info)
            .setPriority(androidx.core.app.NotificationCompat.PRIORITY_MIN)
            .build()

        startForeground(1, notification)
    }

    override fun onDestroy() {
        authListener?.let { FirebaseAuth.getInstance().removeAuthStateListener(it) }
        detachAllListeners()
        pulseHandler.removeCallbacksAndMessages(null)
        mainHandler.removeCallbacksAndMessages(null)
        super.onDestroy()
    }

    override fun onBind(intent: Intent?): IBinder? = null
}
