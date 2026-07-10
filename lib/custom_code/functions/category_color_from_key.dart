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

Color categoryColorFromKey(String? key) {
  final k = (key ?? '').trim().toLowerCase();

  switch (k) {
    case 'next_meeting':
      return const Color(0xFF7E57C2);
    case 'reminder':
      return const Color(0xFFE91E63);
    case 'birthday':
      return const Color(0xFF0FF22E);
    case 'date_night':
      return const Color(0xFF76042C);
    case 'video_call':
      return const Color(0xFF42A5F5);
    case 'trip':
      return const Color(0xFFF0E312);
    case 'anniversary':
      return const Color(0xFFFD570B);
    default:
      return const Color(0xFF9E9E9E);
  }
}
