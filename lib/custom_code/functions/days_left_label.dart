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

String? daysLeftLabel(DateTime? targetDate) {
  if (targetDate == null) return null;

  // -------- language --------
  String lang = 'en';
  try {
    final fromUser =
        (currentUserDocument?.appLanguage ?? '').toString().toLowerCase();
    if (fromUser.isNotEmpty) {
      lang = fromUser;
    } else {
      var loc = Intl.getCurrentLocale().toLowerCase();
      if (loc.contains('-')) loc = loc.split('-').first;
      if (loc.contains('_')) loc = loc.split('_').first;
      lang = loc;
    }
  } catch (_) {}

  if (lang.contains('-')) lang = lang.split('-').first;
  if (lang.contains('_')) lang = lang.split('_').first;
  if (!['de', 'en', 'es'].contains(lang)) lang = 'en';

  String t({
    required String en,
    required String de,
    required String es,
  }) {
    if (lang == 'de') return de;
    if (lang == 'es') return es;
    return en;
  }

  // -------- normalize to days --------
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final tDate = DateTime(targetDate.year, targetDate.month, targetDate.day);

  final diff = tDate.difference(today).inDays;

  if (diff < 0) {
    return t(
      en: 'Deadline passed',
      de: 'Frist abgelaufen',
      es: 'Plazo vencido',
    );
  }

  if (diff == 0) {
    return t(
      en: 'Today',
      de: 'Heute',
      es: 'Hoy',
    );
  }

  if (diff == 1) {
    return t(
      en: '1 day left',
      de: 'Noch 1 Tag',
      es: 'Queda 1 día',
    );
  }

  return t(
    en: '$diff days left',
    de: 'Noch $diff Tage',
    es: 'Quedan $diff días',
  );
}
