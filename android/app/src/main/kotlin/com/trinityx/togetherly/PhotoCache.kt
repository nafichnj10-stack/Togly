package com.trinityx.togetherly

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import java.io.File
import java.io.FileOutputStream

// প্রোফাইল ছবি internal storage-এ save/load করার জন্য — Firebase থেকে একবার
// ডাউনলোড হওয়ার পর widget-এর যেকোনো re-render এই cached ছবি ব্যবহার করতে পারে
object PhotoCache {
    private const val LEFT_FILE = "photo_left.png"
    private const val RIGHT_FILE = "photo_right.png"

    fun saveLeft(context: Context, bitmap: Bitmap) = save(context, LEFT_FILE, bitmap)
    fun saveRight(context: Context, bitmap: Bitmap) = save(context, RIGHT_FILE, bitmap)
    fun loadLeft(context: Context): Bitmap? = load(context, LEFT_FILE)
    fun loadRight(context: Context): Bitmap? = load(context, RIGHT_FILE)

    private fun save(context: Context, fileName: String, bitmap: Bitmap) {
        try {
            val file = File(context.filesDir, fileName)
            FileOutputStream(file).use { out ->
                bitmap.compress(Bitmap.CompressFormat.PNG, 100, out)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun load(context: Context, fileName: String): Bitmap? {
        return try {
            val file = File(context.filesDir, fileName)
            if (!file.exists()) return null
            BitmapFactory.decodeFile(file.absolutePath)
        } catch (e: Exception) {
            null
        }
    }
}
