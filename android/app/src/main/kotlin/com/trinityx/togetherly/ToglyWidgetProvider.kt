package com.trinityx.togetherly

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.view.View
import android.widget.RemoteViews

class ToglyWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (widgetId in appWidgetIds) {
            updateWidget(context, appWidgetManager, widgetId)
        }
    }

    companion object {

        fun updateWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            widgetId: Int,
            leftPhoto: Bitmap? = null,
            rightPhoto: Bitmap? = null,
            heartFlightProgress: Float = -1f,
            pulsePhase: Float = 0f,
            bikeFrame: Int = 0
        ) {
            val actualLeftPhoto = leftPhoto ?: PhotoCache.loadLeft(context)
            val actualRightPhoto = rightPhoto ?: PhotoCache.loadRight(context)

            val lc = LocaleHelper.localizedContext(context)
            val res = lc.resources

            val prefs = context.getSharedPreferences("togly_prefs", Context.MODE_PRIVATE)
            val state = prefs.getString("widget_state", "normal") ?: "normal"
            val currentDistance = prefs.getFloat("current_distance", 4356f)
            val nameLeft = prefs.getString("name_left", "Bam") ?: "Bam"
            val nameRight = prefs.getString("name_right", "Mimi") ?: "Mimi"
            val flagLeft = prefs.getString("flag_left", "🇩🇪") ?: "🇩🇪"
            val flagRight = prefs.getString("flag_right", "🇹🇭") ?: "🇹🇭"
            val countryLeft = prefs.getString("country_left", "Germany") ?: "Germany"
            val countryRight = prefs.getString("country_right", "Thailand") ?: "Thailand"
            val tzDiffHours = prefs.getInt("tz_diff_hours", 1)
            val countdownDays = prefs.getInt("countdown_days", 43)

            val views = RemoteViews(context.packageName, R.layout.widget_layout)

            val intent = Intent(context, MainActivity::class.java)
            val pendingIntent = PendingIntent.getActivity(
                context, 0, intent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            views.setOnClickPendingIntent(R.id.widget_bg, pendingIntent)

            views.setTextViewText(R.id.tv_name_left, "🐾 $nameLeft")
            views.setTextViewText(R.id.tv_flag_left, "$flagLeft $countryLeft")
            views.setTextViewText(R.id.tv_name_right, "🐾 $nameRight")
            views.setTextViewText(R.id.tv_flag_right, "$flagRight $countryRight")

            if (tzDiffHours == 0) {
                views.setViewVisibility(R.id.card_time_diff, View.GONE)
            } else {
                views.setViewVisibility(R.id.card_time_diff, View.VISIBLE)
                val timeDiffText = res.getQuantityString(R.plurals.time_diff_hours, tzDiffHours, tzDiffHours)
                views.setTextViewText(R.id.tv_time_diff, timeDiffText)
            }

            val distKm = currentDistance.toInt()
            val progress = (prefs.getInt("distance_progress_pct", 0) / 100f).coerceIn(0f, 1f)

            val isBirthdayState = state == "birthday_dog" || state == "birthday_cat" || state == "birthday_both"

            views.setViewVisibility(R.id.btn_send_love, View.VISIBLE)
            views.setTextViewText(
                R.id.tv_send_love_label,
                if (isBirthdayState) lc.getString(R.string.birthday_wish_button) else lc.getString(R.string.send_love_button)
            )

            val sendLoveIntent = Intent(context, SendLoveReceiver::class.java).apply {
                putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)
            }
            val sendLovePendingIntent = PendingIntent.getBroadcast(
                context, widgetId, sendLoveIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            views.setOnClickPendingIntent(R.id.btn_send_love, sendLovePendingIntent)

            val distanceText = lc.getString(R.string.distance_km_apart, distKm)
            val togetherText = lc.getString(R.string.distance_together_label)

            when (state) {
                "normal" -> {
                    views.setImageViewResource(R.id.widget_bg, R.drawable.normal_mode)
                    views.setTextViewText(R.id.tv_status_icon, "📅")
                    views.setTextViewText(R.id.tv_status_line1, lc.getString(R.string.status_next_reunion))
                    views.setTextViewText(R.id.tv_status_line2, lc.getString(R.string.status_days_pattern, countdownDays))
                    views.setTextViewText(R.id.tv_status_line3, "")
                    WidgetBitmapHelper.drawProfileBar(context, views, distKm, 0f, true, actualLeftPhoto, actualRightPhoto, distanceText, togetherText, heartFlightProgress, pulsePhase)
                }
                "love_dog_to_cat" -> {
                    views.setImageViewResource(R.id.widget_bg, R.drawable.love_sent_dog)
                    views.setTextViewText(R.id.tv_status_icon, "❤️")
                    views.setTextViewText(R.id.tv_status_line1, lc.getString(R.string.status_love_line1, nameLeft))
                    views.setTextViewText(R.id.tv_status_line2, lc.getString(R.string.status_love_line2))
                    views.setTextViewText(R.id.tv_status_line3, "")
                    WidgetBitmapHelper.drawProfileBar(context, views, distKm, 0f, true, actualLeftPhoto, actualRightPhoto, distanceText, togetherText, heartFlightProgress, pulsePhase)
                }
                "love_cat_to_dog" -> {
                    views.setImageViewResource(R.id.widget_bg, R.drawable.love_sent_cat)
                    views.setTextViewText(R.id.tv_status_icon, "❤️")
                    views.setTextViewText(R.id.tv_status_line1, lc.getString(R.string.status_love_line1, nameRight))
                    views.setTextViewText(R.id.tv_status_line2, lc.getString(R.string.status_love_line2))
                    views.setTextViewText(R.id.tv_status_line3, "")
                    WidgetBitmapHelper.drawProfileBar(context, views, distKm, 0f, true, actualLeftPhoto, actualRightPhoto, distanceText, togetherText, heartFlightProgress, pulsePhase)
                }
                "travel_upcoming_dog_to_cat" -> {
                    views.setImageViewResource(R.id.widget_bg, R.drawable.travel_upcoming_dog_to_cat)
                    views.setTextViewText(R.id.tv_status_icon, "🧳")
                    views.setTextViewText(R.id.tv_status_line1, lc.getString(R.string.status_getting_ready_line1, nameLeft))
                    views.setTextViewText(R.id.tv_status_line2, lc.getString(R.string.status_getting_ready_line2))
                    views.setTextViewText(R.id.tv_status_line3, lc.getString(R.string.status_trip_starts_soon))
                    WidgetBitmapHelper.drawProfileBar(context, views, distKm, 0f, true, actualLeftPhoto, actualRightPhoto, distanceText, togetherText, heartFlightProgress, pulsePhase)
                }
                "travel_upcoming_cat_to_dog" -> {
                    views.setImageViewResource(R.id.widget_bg, R.drawable.travel_upcoming_cat_to_dog)
                    views.setTextViewText(R.id.tv_status_icon, "🧳")
                    views.setTextViewText(R.id.tv_status_line1, lc.getString(R.string.status_getting_ready_line1, nameRight))
                    views.setTextViewText(R.id.tv_status_line2, lc.getString(R.string.status_getting_ready_line2))
                    views.setTextViewText(R.id.tv_status_line3, lc.getString(R.string.status_trip_starts_soon))
                    WidgetBitmapHelper.drawProfileBar(context, views, distKm, 0f, false, actualLeftPhoto, actualRightPhoto, distanceText, togetherText, heartFlightProgress, pulsePhase)
                }
                "travel_dog_to_cat" -> {
                    views.setImageViewResource(R.id.widget_bg, R.drawable.travel_dog_to_cat)
                    views.setTextViewText(R.id.tv_status_icon, "❤️")
                    views.setTextViewText(R.id.tv_status_line1, lc.getString(R.string.status_on_the_way_line1, nameLeft))
                    views.setTextViewText(R.id.tv_status_line2, lc.getString(R.string.status_on_the_way_line2, nameRight))
                    views.setTextViewText(R.id.tv_status_line3, lc.getString(R.string.status_km_to_go, distKm))
                    WidgetBitmapHelper.drawProfileBar(
                        context, views, distKm, progress, true, actualLeftPhoto, actualRightPhoto,
                        distanceText, togetherText, heartFlightProgress, pulsePhase,
                        showBikeAnimation = true, bikeFrame = bikeFrame
                    )
                }
                "travel_cat_to_dog" -> {
                    views.setImageViewResource(R.id.widget_bg, R.drawable.travel_cat_to_dog)
                    views.setTextViewText(R.id.tv_status_icon, "❤️")
                    views.setTextViewText(R.id.tv_status_line1, lc.getString(R.string.status_on_the_way_line1, nameRight))
                    views.setTextViewText(R.id.tv_status_line2, lc.getString(R.string.status_on_the_way_line2, nameLeft))
                    views.setTextViewText(R.id.tv_status_line3, lc.getString(R.string.status_km_to_go, distKm))
                    WidgetBitmapHelper.drawProfileBar(
                        context, views, distKm, progress, false, actualLeftPhoto, actualRightPhoto,
                        distanceText, togetherText, heartFlightProgress, pulsePhase,
                        showCatBikeAnimation = true, catFrame = bikeFrame
                    )
                }
                "together" -> {
                    views.setImageViewResource(R.id.widget_bg, R.drawable.together_mode)
                    views.setTextViewText(R.id.tv_status_icon, "🏡")
                    views.setTextViewText(R.id.tv_status_line1, lc.getString(R.string.status_together_line1))
                    views.setTextViewText(R.id.tv_status_line2, lc.getString(R.string.status_together_line2))
                    views.setTextViewText(R.id.tv_status_line3, "")
                    WidgetBitmapHelper.drawProfileBar(context, views, 0, 1f, true, actualLeftPhoto, actualRightPhoto, distanceText, togetherText, heartFlightProgress, pulsePhase)
                }
                "sleep_both" -> {
                    views.setImageViewResource(R.id.widget_bg, R.drawable.sleep_both)
                    views.setTextViewText(R.id.tv_status_icon, "😴")
                    views.setTextViewText(R.id.tv_status_line1, lc.getString(R.string.status_good_night))
                    views.setTextViewText(R.id.tv_status_line2, lc.getString(R.string.status_my_love))
                    views.setTextViewText(R.id.tv_status_line3, "")
                    WidgetBitmapHelper.drawProfileBar(context, views, distKm, 0f, true, actualLeftPhoto, actualRightPhoto, distanceText, togetherText, heartFlightProgress, pulsePhase)
                }
                "sleep_dog" -> {
                    views.setImageViewResource(R.id.widget_bg, R.drawable.sleep_dog)
                    views.setTextViewText(R.id.tv_status_icon, "😴")
                    views.setTextViewText(R.id.tv_status_line1, lc.getString(R.string.status_good_night))
                    views.setTextViewText(R.id.tv_status_line2, nameLeft)
                    views.setTextViewText(R.id.tv_status_line3, "")
                    WidgetBitmapHelper.drawProfileBar(context, views, distKm, 0f, true, actualLeftPhoto, actualRightPhoto, distanceText, togetherText, heartFlightProgress, pulsePhase)
                }
                "sleep_cat" -> {
                    views.setImageViewResource(R.id.widget_bg, R.drawable.sleep_cat)
                    views.setTextViewText(R.id.tv_status_icon, "😴")
                    views.setTextViewText(R.id.tv_status_line1, lc.getString(R.string.status_good_night))
                    views.setTextViewText(R.id.tv_status_line2, nameRight)
                    views.setTextViewText(R.id.tv_status_line3, "")
                    WidgetBitmapHelper.drawProfileBar(context, views, distKm, 0f, true, actualLeftPhoto, actualRightPhoto, distanceText, togetherText, heartFlightProgress, pulsePhase)
                }
                "birthday_dog" -> {
                    views.setImageViewResource(R.id.widget_bg, birthdayBackgroundRes(context, "birthday_dog"))
                    views.setTextViewText(R.id.tv_status_icon, "🎂")
                    views.setTextViewText(R.id.tv_status_line1, lc.getString(R.string.status_happy_birthday))
                    views.setTextViewText(R.id.tv_status_line2, nameLeft)
                    views.setTextViewText(R.id.tv_status_line3, "")
                    WidgetBitmapHelper.drawProfileBar(context, views, distKm, 0f, true, actualLeftPhoto, actualRightPhoto, distanceText, togetherText, heartFlightProgress, pulsePhase)
                }
                "birthday_cat" -> {
                    views.setImageViewResource(R.id.widget_bg, birthdayBackgroundRes(context, "birthday_cat"))
                    views.setTextViewText(R.id.tv_status_icon, "🎂")
                    views.setTextViewText(R.id.tv_status_line1, lc.getString(R.string.status_happy_birthday))
                    views.setTextViewText(R.id.tv_status_line2, nameRight)
                    views.setTextViewText(R.id.tv_status_line3, "")
                    WidgetBitmapHelper.drawProfileBar(context, views, distKm, 0f, true, actualLeftPhoto, actualRightPhoto, distanceText, togetherText, heartFlightProgress, pulsePhase)
                }
                "birthday_both" -> {
                    views.setImageViewResource(R.id.widget_bg, birthdayBackgroundRes(context, "birthday_both"))
                    views.setTextViewText(R.id.tv_status_icon, "🎂")
                    views.setTextViewText(R.id.tv_status_line1, lc.getString(R.string.status_happy_birthday))
                    views.setTextViewText(R.id.tv_status_line2, lc.getString(R.string.status_birthday_both_line2))
                    views.setTextViewText(R.id.tv_status_line3, "")
                    WidgetBitmapHelper.drawProfileBar(context, views, distKm, 0f, true, actualLeftPhoto, actualRightPhoto, distanceText, togetherText, heartFlightProgress, pulsePhase)
                }
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }

        private fun birthdayBackgroundRes(context: Context, name: String): Int {
            val id = context.resources.getIdentifier(name, "drawable", context.packageName)
            return if (id != 0) id else R.drawable.bg_birthday_placeholder
        }
    }
}
