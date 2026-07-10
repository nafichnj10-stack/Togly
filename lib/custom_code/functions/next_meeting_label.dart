import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/flutter_flow/custom_functions.dart';
import 'package:ff_commons/flutter_flow/lat_lng.dart';
import 'package:ff_commons/flutter_flow/place.dart';
import 'package:ff_commons/flutter_flow/uploaded_file.dart';
import '/backend/backend.dart';
import "package:firebase_storagelibrary_2sa6k9/backend/schema/structs/index.dart"
    as firebase_storagelibrary_2sa6k9_data_schema;
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/auth/firebase_auth/auth_util.dart';
import "package:firebase_storagelibrary_2sa6k9/backend/schema/structs/index.dart"
    as firebase_storagelibrary_2sa6k9_data_schema;
import "package:firebase_storagelibrary_2sa6k9/backend/schema/enums/enums.dart"
    as firebase_storagelibrary_2sa6k9_enums;
import 'package:firebase_storagelibrary_2sa6k9/flutter_flow/custom_functions.dart'
    as firebase_storagelibrary_2sa6k9_functions;

String? nextMeetingLabel(
  DateTime? start,
  DateTime? end,
  bool? isAllDay,
  int? tzOffsetMinutes,
  int? serverNowUtcMillis,
) {
  // ---------- Language ----------
  String lang = 'en';
  try {
    final fromUser = (currentUserDocument?.appLanguage ?? '')
        .toString()
        .toLowerCase()
        .trim();

    if (fromUser.isNotEmpty) {
      lang = fromUser;
    } else {
      var loc = Intl.getCurrentLocale().toLowerCase();
      if (loc.contains('-')) loc = loc.split('-').first;
      if (loc.contains('_')) loc = loc.split('_').first;
      lang = loc;
    }
  } catch (_) {
    lang = 'en';
  }

  if (lang.contains('-')) lang = lang.split('-').first;
  if (lang.contains('_')) lang = lang.split('_').first;
  if (!['de', 'en', 'es'].contains(lang)) lang = 'en';

  String t({required String en, required String de, required String es}) {
    if (lang == 'de') return de;
    if (lang == 'es') return es;
    return en;
  }

  // ---------- Guards ----------
  if (start == null) return null;

  final int offsetMin = tzOffsetMinutes ?? 0;
  final bool allDay = isAllDay ?? false;

  DateTime toLocal(DateTime utc) => utc.add(Duration(minutes: offsetMin));
  DateTime localDateOnly(DateTime local) =>
      DateTime(local.year, local.month, local.day);

  // Keep original stable behavior
  final nowUtc = DateTime.now().toUtc();
  final startUtc = start.toUtc();

  final DateTime endUtc = (end != null)
      ? end.toUtc()
      : (allDay ? startUtc.add(const Duration(days: 1)) : startUtc);

  final nowLocal = toLocal(nowUtc);
  final startLocal = toLocal(startUtc);
  final endLocal = toLocal(endUtc);

  int calendarDayDiff(DateTime fromLocal, DateTime toLocalDate) {
    final fromDay = localDateOnly(fromLocal);
    final toDay = localDateOnly(toLocalDate);
    return toDay.difference(fromDay).inDays;
  }

  String dayWord(int n) => t(
        en: n == 1 ? 'day' : 'days',
        de: n == 1 ? 'Tag' : 'Tage',
        es: n == 1 ? 'día' : 'días',
      );

  // ---------- Emotional, shorter copy ----------
  String todayLine() => t(
        en: 'Today is your day 🎉',
        de: 'Heute ist euer Tag 🎉',
        es: 'Hoy es su día 🎉',
      );

  String tomorrowLine() => t(
        en: 'Tomorrow is your day ✨',
        de: 'Morgen ist euer Tag ✨',
        es: 'Mañana es su día ✨',
      );

  String daysLine(int d) {
    if (d >= 7) {
      return t(
        en: '$d ${dayWord(d)} to go 💫',
        de: 'Noch $d ${dayWord(d)} 💫',
        es: 'Faltan $d ${dayWord(d)} 💫',
      );
    }

    if (d >= 3) {
      return t(
        en: 'Only $d ${dayWord(d)} left ✨',
        de: 'Nur noch $d ${dayWord(d)} ✨',
        es: 'Solo $d ${dayWord(d)} más ✨',
      );
    }

    return t(
      en: '$d ${dayWord(d)} left 🤍',
      de: 'Noch $d ${dayWord(d)} 🤍',
      es: 'Faltan $d ${dayWord(d)} 🤍',
    );
  }

  String hoursLine(int h, int m) => t(
        en: (m > 0) ? '$h h $m min left 🤍' : '$h h left 🤍',
        de: (m > 0) ? 'Noch $h Std. $m Min. 🤍' : 'Noch $h Std. 🤍',
        es: (m > 0) ? 'Faltan $h h $m min 🤍' : 'Faltan $h h 🤍',
      );

  String minutesLine(int m) => t(
        en: '$m min left 🤍',
        de: 'Noch $m Min. 🤍',
        es: 'Faltan $m min 🤍',
      );

  String togetherDaysLine(int d) {
    if (d == 1) {
      return t(
        en: 'Together now 💜 1 day left',
        de: 'Beieinander 💜 Noch 1 Tag',
        es: 'Juntos ahora 💜 Queda 1 día',
      );
    }

    return t(
      en: 'Together now 💜 $d days left',
      de: 'Beieinander 💜 Noch $d Tage',
      es: 'Juntos ahora 💜 Quedan $d días',
    );
  }

  String togetherHoursLine(int h, int m) => t(
        en: (m > 0)
            ? 'Together now 💜 $h h $m min left'
            : 'Together now 💜 $h h left',
        de: (m > 0)
            ? 'Beieinander 💜 Noch $h Std. $m Min.'
            : 'Beieinander 💜 Noch $h Std.',
        es: (m > 0)
            ? 'Juntos ahora 💜 Quedan $h h $m min'
            : 'Juntos ahora 💜 Quedan $h h',
      );

  String togetherMinutesLine(int m) => t(
        en: 'Together now 💜 $m min left',
        de: 'Beieinandern 💜 Noch $m Min.',
        es: 'Juntos ahora 💜 Quedan $m min',
      );

  // ---------- ALL DAY MODE ----------
  if (allDay) {
    final nowDay = localDateOnly(nowLocal);
    final startDay = localDateOnly(startLocal);
    final endDay = localDateOnly(endLocal);

    if (!nowDay.isBefore(startDay) && nowDay.isBefore(endDay)) {
      return todayLine();
    }

    final dayDiff = calendarDayDiff(nowLocal, startLocal);

    if (dayDiff == 1) return tomorrowLine();
    if (dayDiff >= 2) return daysLine(dayDiff);

    return null;
  }

  // ---------- TIMED MODE ----------
  // A) Before start
  if (nowUtc.isBefore(startUtc)) {
    final diff = startUtc.difference(nowUtc);
    final dayDiff = calendarDayDiff(nowLocal, startLocal);

    if (dayDiff >= 2) return daysLine(dayDiff);
    if (dayDiff == 1) return tomorrowLine();
    if (dayDiff == 0) return todayLine();

    final totalHours = diff.inHours;
    final mins = diff.inMinutes % 60;

    if (totalHours >= 1) {
      return hoursLine(totalHours, mins);
    }

    final m = math.max(1, diff.inMinutes);
    return minutesLine(m);
  }

  // B) During together
  if (end != null && endUtc.isAfter(startUtc) && nowUtc.isBefore(endUtc)) {
    final diff = endUtc.difference(nowUtc);
    final dayDiff = calendarDayDiff(nowLocal, endLocal);

    if (dayDiff >= 1) return togetherDaysLine(dayDiff);

    final totalHours = diff.inHours;
    final mins = diff.inMinutes % 60;

    if (totalHours >= 1) {
      return togetherHoursLine(totalHours, mins);
    }

    final m = math.max(1, diff.inMinutes);
    return togetherMinutesLine(m);
  }

  // C) After end
  return null;
}
