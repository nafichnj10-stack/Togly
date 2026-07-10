package com.trinityx.togetherly

import android.content.Context
import com.bumptech.glide.Glide
import com.bumptech.glide.integration.okhttp3.OkHttpUrlLoader
import com.bumptech.glide.load.model.GlideUrl
import okhttp3.OkHttpClient
import java.io.InputStream
import java.util.concurrent.TimeUnit

// Glide-কে OkHttp ব্যবহার করানোর জন্য manual setup — kapt/annotation-processing ছাড়াই
object GlideNetworkSetup {
    @Volatile
    private var initialized = false

    fun ensureInitialized(context: Context) {
        if (initialized) return
        synchronized(this) {
            if (initialized) return
            val client = OkHttpClient.Builder()
                .connectTimeout(15, TimeUnit.SECONDS)
                .readTimeout(15, TimeUnit.SECONDS)
                .writeTimeout(15, TimeUnit.SECONDS)
                .build()

            Glide.get(context).registry.replace(
                GlideUrl::class.java,
                InputStream::class.java,
                OkHttpUrlLoader.Factory(client)
            )
            initialized = true
        }
    }
}
