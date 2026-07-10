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

String? formatMySurprisesText(
  int? count,
  String? language,
) {
  if (count == null || count == 0) {
    return '';
  }

  final lang = (language ?? 'en').toLowerCase();

// ENGLISH
  if (lang == 'en') {
    if (count == 1) {
      return 'You added 1 surprise';
    }
    return 'You added $count surprises';
  }

// GERMAN
  if (lang == 'de') {
    if (count == 1) {
      return 'Du hast 1 Überraschung hinzugefügt';
    }
    return 'Du hast $count Überraschungen hinzugefügt';
  }

// SPANISH
  if (lang == 'es') {
    if (count == 1) {
      return 'Has añadido 1 sorpresa';
    }
    return 'Has añadido $count sorpresas';
  }

// FALLBACK (EN)
  if (count == 1) {
    return 'You added 1 surprise';
  }
  return 'You added $count surprises';
}
