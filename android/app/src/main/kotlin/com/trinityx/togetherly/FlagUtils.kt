package com.trinityx.togetherly

object FlagUtils {
    // country_code (যেমন "DE", "TH") কে ফ্ল্যাগ ইমোজি ("🇩🇪", "🇹🇭") তে রূপান্তর করে
    fun countryCodeToFlagEmoji(countryCode: String?): String {
        if (countryCode == null || countryCode.length != 2) return "🏳️"
        val code = countryCode.uppercase()
        val firstChar = Character.codePointAt(code, 0) - 0x41 + 0x1F1E6
        val secondChar = Character.codePointAt(code, 1) - 0x41 + 0x1F1E6
        return String(Character.toChars(firstChar)) + String(Character.toChars(secondChar))
    }
}
