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

String daysBetween(
  DateTime? start,
  DateTime? end,
  bool inclusive,
) {
  // --- language (prefer Firestore user setting) ---
  String lang = 'en';

  try {
    final fromUser = (currentUserDocument?.appLanguage ?? '')
        .toString()
        .toLowerCase()
        .trim();
    if (fromUser.isNotEmpty) {
      lang = fromUser;
    } else {
      // fallback to Intl (can be unreliable in FF)
      var loc = Intl.getCurrentLocale().toLowerCase();
      if (loc.contains('-')) loc = loc.split('-').first;
      if (loc.contains('_')) loc = loc.split('_').first;
      lang = loc;
    }
  } catch (_) {
    lang = 'en';
  }

  // normalize
  if (lang.contains('-')) lang = lang.split('-').first;
  if (lang.contains('_')) lang = lang.split('_').first;
  if (lang != 'de' && lang != 'es' && lang != 'en') lang = 'en';

  String t({
    required String en,
    required String de,
    required String es,
  }) {
    if (lang == 'de') return de;
    if (lang == 'es') return es;
    return en;
  }

  // Label builders
  String dayLabel(int n) {
    if (lang == 'de') return 'Tag $n';
    if (lang == 'es') return 'Día $n';
    return 'Day $n';
  }

  String daysLabel(int n) {
    if (lang == 'de') return '$n Tage';
    if (lang == 'es') return '$n días';
    return '$n days';
  }

  // --- No start date ---
  if (start == null) {
    return t(
      en: 'Just connected',
      de: 'Frisch verbunden',
      es: 'Recién conectados',
    );
  }

  end ??= DateTime.now();

  final sLocal = start.toLocal();
  final eLocal = end.toLocal();

  final s = DateTime(sLocal.year, sLocal.month, sLocal.day);
  final e = DateTime(eLocal.year, eLocal.month, eLocal.day);

  final d = e.difference(s).inDays;
  final days = inclusive ? d + 1 : d;

  if (days <= 0) {
    return t(
      en: 'Just connected',
      de: 'Frisch verbunden',
      es: 'Recién conectados',
    );
  }

  // ❤️ only from day 7+
  final emoji = days >= 7 ? ' ❤️' : '';

  if (days == 1) {
    return '${dayLabel(1)}$emoji';
  }

  return '${daysLabel(days)}$emoji';
}
