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

String nextMeetingDaysShort(
  DateTime? dateTime,
  bool isAllDay,
) {
  if (dateTime == null) return '-';

  // -------- language --------
  String lang = 'en';
  try {
    final l = (currentUserDocument?.appLanguage ?? '').toString().toLowerCase();
    if (l.isNotEmpty) lang = l;
  } catch (_) {}

  if (lang.contains('-')) lang = lang.split('-').first;
  if (lang.contains('_')) lang = lang.split('_').first;
  if (!['de', 'en', 'es'].contains(lang)) lang = 'en';

  String t({required String en, required String de, required String es}) {
    if (lang == 'de') return de;
    if (lang == 'es') return es;
    return en;
  }

  String dayWord(int n) => t(
        en: n == 1 ? 'day' : 'days',
        de: n == 1 ? 'Tag' : 'Tage',
        es: n == 1 ? 'día' : 'días',
      );

  DateTime localDateOnly(DateTime local) =>
      DateTime(local.year, local.month, local.day);

  // ✅ same stable base as long version
  final nowUtc = DateTime.now().toUtc();
  final targetUtc = dateTime.toUtc();

  // NOTE:
  // old function had no tzOffsetMinutes param, so we keep the same signature.
  // This means short uses device-local calendar days, which is the closest
  // possible match without changing your FF bindings.
  final nowLocal = nowUtc.toLocal();
  final targetLocal = targetUtc.toLocal();

  final nowDay = localDateOnly(nowLocal);
  final targetDay = localDateOnly(targetLocal);

  final diff = targetUtc.difference(nowUtc);
  final dayDiff = targetDay.difference(nowDay).inDays;

  if (diff.inSeconds <= 0) return '-';

  // -------- all day --------
  if (isAllDay) {
    if (dayDiff <= 0) {
      return t(en: 'Today', de: 'Heute', es: 'Hoy');
    }
    if (dayDiff == 1) {
      return t(en: 'Tomorrow', de: 'Morgen', es: 'Mañana');
    }
    return '$dayDiff ${dayWord(dayDiff)}';
  }

  // -------- timed --------
  if (dayDiff >= 2) {
    return '$dayDiff ${dayWord(dayDiff)}';
  }

  if (dayDiff == 1) {
    return t(en: 'Tomorrow', de: 'Morgen', es: 'Mañana');
  }

  if (dayDiff == 0) {
    final h = diff.inHours;
    final m = diff.inMinutes;

    if (h >= 1) {
      return h == 1
          ? t(en: '1 hour', de: '1 Stunde', es: '1 hora')
          : t(
              en: '$h hours',
              de: '$h Stunden',
              es: '$h horas',
            );
    }

    final mins = math.max(1, m);
    return mins == 1
        ? t(en: '1 minute', de: '1 Minute', es: '1 minuto')
        : t(
            en: '$mins minutes',
            de: '$mins Minuten',
            es: '$mins minutos',
          );
  }

  return '-';
}
