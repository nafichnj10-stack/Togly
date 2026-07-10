package com.trinityx.togetherly

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Intent
import android.content.pm.ServiceInfo
import android.location.Location
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationResult
import com.google.android.gms.location.LocationServices
import com.google.android.gms.location.Priority
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.functions.FirebaseFunctions
import java.util.concurrent.TimeUnit

// ✅ এই সার্ভিস অ্যাপ বন্ধ থাকলেও চালু থাকে (foreground service)। প্রতি নির্দিষ্ট
// সময় পরপর GPS লোকেশন নিয়ে existing updateLoveBuddyLiveLocation Cloud Function-কে
// কল করে। Flutter সাইড থেকে MainActivity-এর MethodChannel দিয়ে
// ("startLocationTracking" / "stopLocationTracking") ট্রিপ শুরু/শেষ হওয়ার সময়
// চালু/বন্ধ করা হয় (ব্যাটারি বাঁচাতে) — Cloud Function নিজেই
// TRAVEL_NOT_ACTIVE/NOT_TRAVELER ইত্যাদি কোড রিটার্ন করে যদি ট্রিপ চলমান না থাকে।
class LoveBuddyLocationService : Service() {

    private lateinit var fusedClient: FusedLocationProviderClient
    private var locationCallback: LocationCallback? = null
    private var relationshipId: String? = null
    private val TAG = "LoveBuddyLocationService"

    companion object {
        const val CHANNEL_ID = "love_buddy_location_channel"
        const val NOTIFICATION_ID = 2
        val UPDATE_INTERVAL_MS = TimeUnit.MINUTES.toMillis(10)
        val MIN_UPDATE_INTERVAL_MS = TimeUnit.MINUTES.toMillis(5)
    }

    override fun onCreate() {
        super.onCreate()
        fusedClient = LocationServices.getFusedLocationProviderClient(this)
        startForegroundWithNotification()
        loadRelationshipIdThenStart()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        return START_STICKY
    }

    private fun loadRelationshipIdThenStart() {
        val uid = FirebaseAuth.getInstance().currentUser?.uid
        if (uid == null) {
            Log.w(TAG, "No signed-in user, stopping service")
            stopSelf()
            return
        }

        FirebaseFirestore.getInstance().collection("Users").document(uid).get()
            .addOnSuccessListener { doc ->
                relationshipId = doc.getString("relationship_id")
                if (relationshipId.isNullOrBlank()) {
                    Log.w(TAG, "No relationship_id on user doc, stopping service")
                    stopSelf()
                } else {
                    startLocationUpdates()
                }
            }
            .addOnFailureListener { e ->
                Log.e(TAG, "Failed to load relationship_id: ${e.message}")
                stopSelf()
            }
    }

    private fun startLocationUpdates() {
        val request = LocationRequest.Builder(
            Priority.PRIORITY_BALANCED_POWER_ACCURACY,
            UPDATE_INTERVAL_MS
        )
            .setMinUpdateIntervalMillis(MIN_UPDATE_INTERVAL_MS)
            .build()

        locationCallback = object : LocationCallback() {
            override fun onLocationResult(result: LocationResult) {
                result.lastLocation?.let { sendLocationToCloudFunction(it) }
            }
        }

        try {
            fusedClient.requestLocationUpdates(request, locationCallback!!, mainLooper)
            Log.d(TAG, "Location updates started successfully")
        } catch (e: SecurityException) {
            Log.e(TAG, "Missing location permission: ${e.message}")
            stopSelf()
        }
    }

    private fun sendLocationToCloudFunction(location: Location) {
        val relId = relationshipId ?: return
        val data = hashMapOf(
            "relationshipId" to relId,
            "lat" to location.latitude,
            "lng" to location.longitude,
            "accuracyMeters" to location.accuracy
        )

        FirebaseFunctions.getInstance("europe-west3")
            .getHttpsCallable("updateLoveBuddyLiveLocation")
            .call(data)
            .addOnSuccessListener { result ->
                Log.d(TAG, "Location sent OK: ${result.data}")
            }
            .addOnFailureListener { e ->
                Log.e(TAG, "Location send failed: ${e.message}")
            }
    }

    private fun startForegroundWithNotification() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID, "Love Buddy Live Travel",
                NotificationManager.IMPORTANCE_MIN
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager?.createNotificationChannel(channel)
        }

        val notification = NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("Sharing your live travel location")
            .setContentText("Your partner can see your location")
            .setSmallIcon(android.R.drawable.ic_menu_mylocation)
            .setPriority(NotificationCompat.PRIORITY_MIN)
            .build()

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            startForeground(NOTIFICATION_ID, notification, ServiceInfo.FOREGROUND_SERVICE_TYPE_LOCATION)
        } else {
            startForeground(NOTIFICATION_ID, notification)
        }
    }

    override fun onDestroy() {
        locationCallback?.let { fusedClient.removeLocationUpdates(it) }
        Log.d(TAG, "Service destroyed")
        super.onDestroy()
    }

    override fun onBind(intent: Intent?): IBinder? = null
}
