package com.trinityx.togetherly

import android.content.Context
import android.content.res.Configuration
import java.util.Locale

// ✅ Widget সবসময় ডিভাইসের সিস্টেম ভাষা না দেখে, Togly অ্যাপের Users/{uid}.appLanguage
// ফিল্ড থেকে LoveBuddyLiveService যা togly_prefs("app_language")-এ ক্যাশ করে রাখে,
// সেটাই দেখায় — অর্থাৎ ইউজার অ্যাপের ভেতরে যে ভাষা বেছে নিয়েছে তার সাথে সবসময় sync থাকে।
object LocaleHelper {

    private const val PREFS_NAME = "togly_prefs"
    private const val KEY_LANGUAGE = "app_language"
    private val SUPPORTED_LANGUAGES = setOf("en", "de", "es")

    fun localizedContext(context: Context): Context {
        val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        val savedLang = prefs.getString(KEY_LANGUAGE, null)

        val lang = if (savedLang != null && savedLang in SUPPORTED_LANGUAGES) {
            savedLang
        } else {
            Locale.getDefault().language
        }

        val locale = Locale(lang)
        val config = Configuration(context.resources.configuration)
        config.setLocale(locale)
        return context.createConfigurationContext(config)
    }
}
