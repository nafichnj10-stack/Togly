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

String hoursApart(
  int? aOffsetMin,
  int? bOffsetMin,
  bool short,
) {
  // -------- language (de / en / es) --------
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

  // -------- missing values --------
  if (aOffsetMin == null || bOffsetMin == null) {
    return short
        ? t(en: 'Soon', de: 'Bald', es: 'Pronto')
        : t(
            en: 'Time syncing',
            de: 'Zeit wird synchronisiert',
            es: 'Tiempo sincronizándose',
          );
  }

  final diffMin = (aOffsetMin - bOffsetMin).abs();

  // -------- same timezone --------
  if (diffMin == 0) {
    return short
        ? t(en: 'Same time 🫂', de: 'Gleiche Zeit 🫂', es: 'mismo tiempo 🫂')
        : t(
            en: 'You share the same time',
            de: 'Ihr teilt dieselbe Zeit',
            es: 'Comparten el mismo tiempo',
          );
  }

  // -------- under 1h --------
  if (diffMin < 60) {
    if (short) return '${diffMin}m';

    if (diffMin == 1) {
      return t(
        en: '1 minute apart',
        de: '1 Minute Unterschied',
        es: '1 minuto de diferencia',
      );
    }

    return t(
      en: '$diffMin minutes apart',
      de: '$diffMin Minuten Unterschied',
      es: '$diffMin minutos de diferencia',
    );
  }

  final h = diffMin ~/ 60;
  final m = diffMin % 60;

  // -------- short variant --------
  if (short) {
    if (m == 0) return '${h}h';
    return '${h}h ${m}m';
  }

  // -------- long variant (with correct singular/plural) --------

  String hoursText;
  if (h == 1) {
    hoursText = t(
      en: '1 hour',
      de: '1 Stunde',
      es: '1 hora',
    );
  } else {
    hoursText = t(
      en: '$h hours',
      de: '$h Stunden',
      es: '$h horas',
    );
  }

  if (m == 0) {
    return t(
      en: '$hoursText apart',
      de: '$hoursText Unterschied',
      es: '$hoursText de diferencia',
    );
  }

  String minutesText;
  if (m == 1) {
    minutesText = t(
      en: '1 minute',
      de: '1 Minute',
      es: '1 minuto',
    );
  } else {
    minutesText = t(
      en: '$m minutes',
      de: '$m Minuten',
      es: '$m minutos',
    );
  }

  return t(
    en: '$hoursText $minutesText apart',
    de: '$hoursText $minutesText Unterschied',
    es: '$hoursText $minutesText de diferencia',
  );
}
