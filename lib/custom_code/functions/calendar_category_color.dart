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

int calendarCategoryColor(String category) {
  final c = (category ?? '').trim().toLowerCase();

  switch (c) {
    case 'next meeting':
      return 0xFF7E62C5; // violet (primary)
    case 'date night':
      return 0xFFEC6AA3; // rose
    case 'video call':
      return 0xFF64B5F6; // sky blue
    case 'birthday':
      return 0xFFF3A7D8; // pink
    case 'anniversary':
      return 0xFFFFD166; // gold
    case 'trip':
      return 0xFF4DB6AC; // teal
    case 'reminder':
      return 0xFFF2A77E; // peach
    case 'other':
    default:
      return 0xFF9E9E9E; // grey
  }
}
