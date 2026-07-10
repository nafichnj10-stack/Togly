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

String savingUpLabel(
  double current,
  double target,
  String currency,
) {
  // ---------- language ----------
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

  // ---------- values ----------
  final cur = math.max(0, current);
  final tar = math.max(0, target);
  final sym = currency.trim();

  String fmt(num n) {
    return n == n.roundToDouble() ? n.toStringAsFixed(0) : n.toStringAsFixed(2);
  }

  if (tar <= 0) {
    return t(
      en: 'Saving up',
      de: 'Spart gerade',
      es: 'Ahorrando',
    );
  }

  final pct = ((cur / tar) * 100).clamp(0, 100).round();

  if (pct >= 100) {
    return t(
      en: 'Goal reached 🎉',
      de: 'Ziel erreicht 🎉',
      es: 'Objetivo alcanzado 🎉',
    );
  }

  return t(
    en: '$sym ${fmt(cur)} of $sym ${fmt(tar)} ($pct%)',
    de: '$sym ${fmt(cur)} von $sym ${fmt(tar)} ($pct%)',
    es: '$sym ${fmt(cur)} de $sym ${fmt(tar)} ($pct%)',
  );
}
