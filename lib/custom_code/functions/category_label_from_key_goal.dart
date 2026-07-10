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

String categoryLabelFromKeyGoal(String? categoryKey) {
  // Language
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

  final k = (categoryKey ?? '').trim().toLowerCase();

  switch (k) {
    case 'travel':
      return t(en: 'Travel', de: 'Reisen', es: 'Viajes');
    case 'home':
      return t(en: 'Home', de: 'Heim', es: 'Hogar');
    case 'learning':
      return t(en: 'Learning', de: 'Lernen', es: 'Aprendizaje');
    case 'health':
      return t(en: 'Health', de: 'Gesundheit', es: 'Salud');
    case 'finance':
      return t(en: 'Finance', de: 'Finanzen', es: 'Finanzas');
    case 'career':
      return t(en: 'Career', de: 'Karriere', es: 'Carrera profesional');
    case 'relationship':
      return t(en: 'Relationship', de: 'Beziehung', es: 'Relación');
    case 'creativity':
      return t(en: 'Creativity', de: 'Kreativität', es: 'Creatividad');
    case 'social_impact':
      return t(en: 'Social impact', de: 'Soziales', es: 'Impacto social');
    case 'personal_growth':
      return t(
        en: 'Personal Growth',
        de: 'Persönliches Wachstum',
        es: 'Crecimiento personal',
      );
    case 'fitness':
      return t(en: 'Fitness', de: 'Fitness', es: 'Fitness');
    case 'other':
    default:
      return t(en: 'Other', de: 'Anderes', es: 'Otros');
  }
}
