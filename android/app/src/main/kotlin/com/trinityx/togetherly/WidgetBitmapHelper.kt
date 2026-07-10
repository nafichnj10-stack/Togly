package com.trinityx.togetherly

import android.content.Context
import android.graphics.*
import android.widget.RemoteViews
import kotlin.math.sin

object WidgetBitmapHelper {

    private val bikeFrameCache = HashMap<Int, Bitmap>()

    private fun loadBikeFrame(context: Context, resId: Int, targetHeight: Int): Bitmap {
        val cacheKey = resId * 10000 + targetHeight
        bikeFrameCache[cacheKey]?.let { return it }
        val original = BitmapFactory.decodeResource(context.resources, resId)
        val scale = targetHeight / original.height.toFloat()
        val targetWidth = (original.width * scale).toInt().coerceAtLeast(1)
        val scaled = Bitmap.createScaledBitmap(original, targetWidth, targetHeight, true)
        if (scaled !== original) {
            original.recycle()
        }
        bikeFrameCache[cacheKey] = scaled
        return scaled
    }

    fun drawProfileBar(
        context: Context,
        views: RemoteViews,
        distanceKm: Int,
        progress: Float,
        leftTraveling: Boolean,
        leftPhoto: Bitmap? = null,
        rightPhoto: Bitmap? = null,
        distanceText: String = "$distanceKm km apart",
        togetherText: String = "Together again ❤️",
        heartFlightProgress: Float = -1f,
        pulsePhase: Float = 0f,
        showBikeAnimation: Boolean = false,
        bikeFrame: Int = 0,
        showCatBikeAnimation: Boolean = false,
        catFrame: Int = 0
    ) {
        val W = 441
        val H = 60
        val bikeExtraTop = 88
        val bitmap = Bitmap.createBitmap(W, H + bikeExtraTop, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        canvas.translate(0f, bikeExtraTop.toFloat())

        val bgPaint = Paint().apply {
            color = Color.parseColor("#33FF69B4")
            isAntiAlias = true
        }
        canvas.drawRoundRect(
            RectF(0f, 0f, W.toFloat(), H.toFloat()),
            H / 2f, H / 2f, bgPaint
        )

        val borderPaintBg = Paint().apply {
            color = Color.parseColor("#FF69B4")
            style = Paint.Style.STROKE
            strokeWidth = 1.3f
            isAntiAlias = true
        }
        canvas.drawRoundRect(
            RectF(1.25f, 1.25f, W.toFloat() - 1.25f, H.toFloat() - 1.25f),
            H / 2f, H / 2f, borderPaintBg
        )

        val cy = H / 2f + 3f
        val r = (H / 2f - 3f) * 1.0f
        val leftCx = r + 4f
        val rightCx = W - r - 4f

        val displayText = if (progress >= 1f) togetherText else distanceText
        val distPaint = Paint().apply {
            color = Color.WHITE
            textSize = 27f
            textAlign = Paint.Align.CENTER
            typeface = Typeface.create(Typeface.DEFAULT, Typeface.BOLD)
            isAntiAlias = true
            setShadowLayer(5f, 1.8f, 1.8f, Color.parseColor("#FF8B0050"))
        }
        val distFontMetrics = distPaint.fontMetrics
        val distY = (H * 0.06f) - distFontMetrics.ascent
        canvas.drawText(displayText, W / 2f, distY, distPaint)

        val targetLeftCx = W / 2f - r - 2f
        val targetRightCx = W / 2f + r + 2f
        val t = progress.coerceIn(0f, 1f)
        val actualLeftCx = leftCx + (targetLeftCx - leftCx) * t
        val actualRightCx = rightCx + (targetRightCx - rightCx) * t

        val lineStart = leftCx + r + 4f
        val lineEnd = rightCx - r - 4f
        val midX = (lineStart + lineEnd) / 2f
        val chainBottomY = H.toFloat() - (H * 0.30f)

        val dotPaint = Paint().apply {
            color = Color.parseColor("#FFFFC9E3")
            isAntiAlias = true
        }
        for (i in -3..3) {
            if (i == 0) continue
            val dt = i / 3f
            val x = midX + dt * (lineEnd - lineStart) / 2f
            val sag = (1f - dt * dt) * (H * 0.05f)
            val y = chainBottomY + sag
            canvas.drawCircle(x, y, 1.7f, dotPaint)
        }

        val heartCenterY = chainBottomY + 4.5f
        val heartScale = 1f + 0.35f * sin(pulsePhase * (2 * Math.PI)).toFloat()
        val heartPaint = Paint().apply {
            textSize = 13f
            textAlign = Paint.Align.CENTER
            isAntiAlias = true
        }
        canvas.save()
        canvas.scale(heartScale, heartScale, midX, heartCenterY)
        canvas.drawText("❤️", midX, heartCenterY, heartPaint)
        canvas.restore()

        drawTwinkle(canvas, midX + 15f, chainBottomY - 9f, pulsePhase, speed = 4f, baseSize = 11f, offset = 0f)
        drawTwinkle(canvas, midX - 16f, chainBottomY - 6f, pulsePhase, speed = 4f, baseSize = 9f, offset = 0.5f)

        if (heartFlightProgress in 0f..1f) {
            val ft = heartFlightProgress
            val flyX = actualLeftCx + (actualRightCx - actualLeftCx) * ft
            val arcBump = -(H * 0.55f) * (4f * ft * (1f - ft))
            val flyY = cy + arcBump
            val flySize = 15f + 3f * (4f * ft * (1f - ft))
            val flyPaint = Paint().apply {
                textSize = flySize
                textAlign = Paint.Align.CENTER
                isAntiAlias = true
            }
            canvas.drawText("❤️", flyX, flyY, flyPaint)

            val trailT = (ft - 0.18f).coerceAtLeast(0f)
            if (trailT > 0f) {
                val trailX = actualLeftCx + (actualRightCx - actualLeftCx) * trailT
                val trailArc = -(H * 0.55f) * (4f * trailT * (1f - trailT))
                val trailPaint = Paint().apply {
                    textSize = 8f
                    textAlign = Paint.Align.CENTER
                    isAntiAlias = true
                    alpha = 200
                }
                canvas.drawText("✨", trailX, cy + trailArc + 5f, trailPaint)
            }
        }

        drawCircle(canvas, actualLeftCx, cy, r, "👨", leftPhoto)
        drawCircle(canvas, actualRightCx, cy, r, "👩", rightPhoto)

        if (showBikeAnimation) {
            val frameRes = when (bikeFrame % 5) {
                0 -> R.drawable.dog_cycle_1
                1 -> R.drawable.dog_cycle_2
                2 -> R.drawable.dog_cycle_3
                3 -> R.drawable.dog_cycle_2
                else -> R.drawable.dog_cycle_4
            }
            val bikeHeight = (r * 3f).toInt().coerceAtLeast(1)
            val bikeBitmap = loadBikeFrame(context, frameRes, bikeHeight)
            val bikeBottomY = 8f
            val bikeTop = bikeBottomY - bikeBitmap.height
            val bikeLeft = actualLeftCx - bikeBitmap.width / 2f
            canvas.drawBitmap(bikeBitmap, bikeLeft, bikeTop, Paint().apply { isAntiAlias = true })
        }

        if (showCatBikeAnimation) {
            val frameRes = when (catFrame % 5) {
                0 -> R.drawable.cat_cycle_1
                1 -> R.drawable.cat_cycle_2
                2 -> R.drawable.cat_cycle_3
                3 -> R.drawable.cat_cycle_2
                else -> R.drawable.cat_cycle_4
            }
            val catBikeHeight = (r * 3f).toInt().coerceAtLeast(1)
            val catBikeBitmap = loadBikeFrame(context, frameRes, catBikeHeight)
            val catBikeBottomY = 8f
            val catBikeTop = catBikeBottomY - catBikeBitmap.height
            val catBikeLeft = actualRightCx - catBikeBitmap.width / 2f
            canvas.drawBitmap(catBikeBitmap, catBikeLeft, catBikeTop, Paint().apply { isAntiAlias = true })
        }

        views.setImageViewBitmap(R.id.img_profile_bar, bitmap)
    }

    private fun drawTwinkle(
        canvas: Canvas,
        x: Float,
        y: Float,
        pulsePhase: Float,
        speed: Float,
        baseSize: Float,
        offset: Float
    ) {
        val phase = ((pulsePhase * speed) + offset) % 1f
        val wave = (sin(phase * (2 * Math.PI)).toFloat() + 1f) / 2f
        val alpha = (60 + wave * 195).toInt().coerceIn(0, 255)
        val size = baseSize * (0.75f + 0.45f * wave)

        val paint = Paint().apply {
            textSize = size
            textAlign = Paint.Align.CENTER
            isAntiAlias = true
            this.alpha = alpha
        }
        canvas.drawText("✨", x, y, paint)
    }

    private fun drawCircle(
        canvas: Canvas,
        cx: Float,
        cy: Float,
        r: Float,
        fallbackEmoji: String,
        photo: Bitmap? = null
    ) {
        val rX = r
        val rY = r * 0.94f
        val oval = RectF(cx - rX, cy - rY, cx + rX, cy + rY)

        if (photo != null) {
            canvas.save()
            val clipPath = Path().apply { addOval(oval, Path.Direction.CW) }
            canvas.clipPath(clipPath)

            val srcRect = Rect(0, 0, photo.width, photo.height)
            canvas.drawBitmap(photo, srcRect, oval, Paint().apply { isAntiAlias = true })
            canvas.restore()
        } else {
            val fillPaint = Paint().apply {
                color = Color.parseColor("#DDF5F5F5")
                isAntiAlias = true
            }
            canvas.drawOval(oval, fillPaint)

            val emojiPaint = Paint().apply {
                textSize = r * 1.15f
                isAntiAlias = true
                textAlign = Paint.Align.CENTER
            }
            canvas.drawText(fallbackEmoji, cx, cy + r * 0.40f, emojiPaint)
        }

        val thinBorderPaint = Paint().apply {
            color = Color.parseColor("#FFD16BA5")
            style = Paint.Style.STROKE
            strokeWidth = 3f
            isAntiAlias = true
        }
        canvas.drawOval(oval, thinBorderPaint)
    }
}
