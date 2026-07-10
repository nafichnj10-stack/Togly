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

String? remainingTimeCompact(DateTime target) {
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

  if (lang != 'de' && lang != 'es' && lang != 'en') {
    lang = 'en';
  }

  String t({
    required String en,
    required String de,
    required String es,
  }) {
    if (lang == 'de') return de;
    if (lang == 'es') return es;
    return en;
  }

  // ---------- Time calculation ----------
  final now = DateTime.now().toUtc();
  final diff = target.toUtc().difference(now);

  // Reconnect window expired
  if (diff.isNegative) {
    return t(
      en: 'Ready for a new connection',
      de: 'Bereit für eine neue Verbindung',
      es: 'Listo para una nueva conexión',
    );
  }

  final days = diff.inDays;
  final hours = diff.inHours % 24;
  final minutes = diff.inMinutes % 60;
  final seconds = diff.inSeconds % 60;

  // Days
  if (days > 0) {
    return t(
      en: '$days days left',
      de: '$days Tage übrig',
      es: '$days días restantes',
    );
  }

  // Hours
  if (hours > 0) {
    return t(
      en: '$hours h left',
      de: '$hours Std. übrig',
      es: '$hours h restantes',
    );
  }

  // Minutes
  if (minutes > 0) {
    return t(
      en: '$minutes min left',
      de: '$minutes Min. übrig',
      es: '$minutes min restantes',
    );
  }

  // Seconds
  return t(
    en: '$seconds sec left',
    de: '$seconds Sek. übrig',
    es: '$seconds seg restantes',
  );
}
