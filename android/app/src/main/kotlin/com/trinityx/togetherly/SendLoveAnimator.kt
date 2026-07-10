package com.trinityx.togetherly

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.os.Handler
import android.os.Looper

// ✅ "Send Love" চাপলে একটা হার্ট left বাড়ি থেকে right বাড়ির দিকে উড়ে যায় —
// widget bitmap-টা প্রতি ৬০-৭০ms পরপর একটু একটু করে সামনে এগিয়ে আবার redraw
// করে পাঠানো হচ্ছে (RemoteViews-এ real video/GIF animation সম্ভব না)
object SendLoveAnimator {

    @Volatile
    var isPlaying: Boolean = false
        private set

    private const val FRAME_COUNT = 16
    private const val FRAME_DELAY_MS = 65L

    fun play(context: Context, widgetId: Int, onFinished: (() -> Unit)? = null) {
        if (isPlaying) {
            onFinished?.invoke()
            return
        }
        isPlaying = true

        val handler = Handler(Looper.getMainLooper())
        val appWidgetManager = AppWidgetManager.getInstance(context)

        fun renderFrame(frame: Int) {
            val t = frame / (FRAME_COUNT - 1).toFloat()

            val targetIds: IntArray = if (widgetId != -1) {
                intArrayOf(widgetId)
            } else {
                appWidgetManager.getAppWidgetIds(ComponentName(context, ToglyWidgetProvider::class.java))
            }

            for (id in targetIds) {
                ToglyWidgetProvider.updateWidget(
                    context = context,
                    appWidgetManager = appWidgetManager,
                    widgetId = id,
                    heartFlightProgress = t
                )
            }

            if (frame < FRAME_COUNT - 1) {
                handler.postDelayed({ renderFrame(frame + 1) }, FRAME_DELAY_MS)
            } else {
                for (id in targetIds) {
                    ToglyWidgetProvider.updateWidget(context, appWidgetManager, id)
                }
                isPlaying = false
                onFinished?.invoke()
            }
        }

        renderFrame(0)
    }
}
