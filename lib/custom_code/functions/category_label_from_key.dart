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

String categoryLabelFromKey(String? key) {
  // language
  String lang = 'en';
  try {
    final fromUser = (currentUserDocument?.appLanguage ?? '')
        .toString()
        .toLowerCase()
        .trim();
    if (fromUser.isNotEmpty) lang = fromUser;
  } catch (_) {}

  if (lang.contains('-')) lang = lang.split('-').first;
  if (lang.contains('_')) lang = lang.split('_').first;
  if (!['de', 'en', 'es'].contains(lang)) lang = 'en';

  String t({required String en, required String de, required String es}) {
    if (lang == 'de') return de;
    if (lang == 'es') return es;
    return en;
  }

  final k = (key ?? '').trim();

  switch (k) {
    case 'next_meeting':
      return t(
          en: 'Next meeting', de: 'Nächstes Treffen', es: 'Próximo encuentro');
    case 'birthday':
      return t(en: 'Birthday', de: 'Geburtstag', es: 'Cumpleaños');
    case 'trip':
      return t(en: 'Trip', de: 'Reise', es: 'Viaje');
    case 'reminder':
      return t(en: 'Reminder', de: 'Erinnerung', es: 'Recordatorio');
    case 'date_night':
      return t(en: 'Date night', de: 'Date', es: 'Cita');
    case 'video_call':
      return t(en: 'Video call', de: 'Videoanruf', es: 'Videollamada');
    case 'anniversary':
      return t(en: 'Anniversary', de: 'Jahrestag', es: 'Aniversario');
    default:
      return t(en: 'Other', de: 'Sonstiges', es: 'Otro');
  }
}
