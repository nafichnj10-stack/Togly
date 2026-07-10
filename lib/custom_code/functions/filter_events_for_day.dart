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

List<CalendarEventsRecord> filterEventsForDay(
  List<CalendarEventsRecord> items,
  DateTime dayStart,
) {
  if (items == null || items.isEmpty) return <CalendarEventsRecord>[];

  // 24h-Fenster ab dayStart
  final DateTime dayEnd = dayStart.add(const Duration(days: 1));

  final List<CalendarEventsRecord> filtered = items.where((event) {
    // >>> explizit NICHT-nullbar typisieren
    final DateTime eventStart = event.start ?? DateTime.now();
    // Falls kein end vorhanden: 1 Tag nach start (All-Day fallback)
    final DateTime eventEnd =
        (event.end ?? eventStart.add(const Duration(days: 1)));

    // Overlap-Test: start < dayEnd && end > dayStart
    return eventStart.isBefore(dayEnd) && eventEnd.isAfter(dayStart);
  }).toList();

  filtered.sort(
      (a, b) => (a.start ?? DateTime(0)).compareTo(b.start ?? DateTime(0)));

  return filtered;
}
