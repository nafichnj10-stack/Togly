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

String togetherSinceSmart(
  DateTime? togetherSince,
  String? lang,
) {
// Smart Together-Since display with anniversary marker 🎉
// Rules:
// < 1 month  => show days only
// < 1 year   => show months + days
// >= 1 year  => show years + months
//
// Anniversary detection (for UI Heart Mode):
// - Yearly anniversaries: exact years (months==0 && days==0 && years>=1)
// - 6 months: years==0 && months==6 && days==0
// - 100 days: totalDays == 100
//
// If anniversary -> prefix with 🎉  (you can detect this in UI)

  final DateTime? ts = togetherSince;
  if (ts == null) return '';

// normalize lang
  String l = (lang ?? 'en').toLowerCase().trim();
  if (l.contains('-')) l = l.split('-').first;
  if (l.contains('_')) l = l.split('_').first;
  if (!['en', 'de', 'es'].contains(l)) l = 'en';

  String t({required String en, required String de, required String es}) {
    if (l == 'de') return de;
    if (l == 'es') return es;
    return en;
  }

  String plural(
    int n, {
    required String oneEn,
    required String manyEn,
    required String oneDe,
    required String manyDe,
    required String oneEs,
    required String manyEs,
  }) {
    if (l == 'de') return n == 1 ? '$n $oneDe' : '$n $manyDe';
    if (l == 'es') return n == 1 ? '$n $oneEs' : '$n $manyEs';
    return n == 1 ? '$n $oneEn' : '$n $manyEn';
  }

// Use local "today" because UI is user-facing
  final now = DateTime.now();

// Compare only date parts
  final start = DateTime(ts.year, ts.month, ts.day);
  final end = DateTime(now.year, now.month, now.day);

// future date => show 0 days
  if (end.isBefore(start)) {
    return t(en: '0 days', de: '0 Tage', es: '0 días');
  }

// total days for 100-day milestone
  final totalDays = end.difference(start).inDays;

// date-diff into y/m/d (calendar-correct)
  int years = end.year - start.year;
  int months = end.month - start.month;
  int days = end.day - start.day;

  if (days < 0) {
    final prevMonthLastDay = DateTime(end.year, end.month, 0);
    days += prevMonthLastDay.day;
    months -= 1;
  }
  if (months < 0) {
    months += 12;
    years -= 1;
  }

// Anniversary detection
  final bool isYearAnniv = (years >= 1 && months == 0 && days == 0);
  final bool isSixMonths = (years == 0 && months == 6 && days == 0);
  final bool isHundredDays = (totalDays == 100);

  final bool isAnniversary = isYearAnniv || isSixMonths || isHundredDays;

// Build display text (Smart Display)
  String display;

  if (years >= 1) {
    // years + months
    final parts = <String>[];
    parts.add(plural(
      years,
      oneEn: 'year',
      manyEn: 'years',
      oneDe: 'Jahr',
      manyDe: 'Jahre',
      oneEs: 'año',
      manyEs: 'años',
    ));

    // show months even if 0? (usually no, but ok)
    if (months > 0) {
      parts.add(plural(
        months,
        oneEn: 'month',
        manyEn: 'months',
        oneDe: 'Monat',
        manyDe: 'Monate',
        oneEs: 'mes',
        manyEs: 'meses',
      ));
    }

    display = parts.join(', ');
  } else {
    // less than 1 year
    if (months <= 0) {
      // < 1 month => days only
      display = plural(
        totalDays,
        oneEn: 'day',
        manyEn: 'days',
        oneDe: 'Tag',
        manyDe: 'Tage',
        oneEs: 'día',
        manyEs: 'días',
      );
    } else {
      // months + days
      final parts = <String>[];
      parts.add(plural(
        months,
        oneEn: 'month',
        manyEn: 'months',
        oneDe: 'Monat',
        manyDe: 'Monate',
        oneEs: 'mes',
        manyEs: 'meses',
      ));

      // show days if > 0 (or show 0 days? no)
      if (days > 0) {
        parts.add(plural(
          days,
          oneEn: 'day',
          manyEn: 'days',
          oneDe: 'Tag',
          manyDe: 'Tage',
          oneEs: 'día',
          manyEs: 'días',
        ));
      }

      display = parts.join(', ');
    }
  }

// Prefix for Heart Mode trigger in UI
  if (isAnniversary) {
    return '🎉 $display';
  }

  return display;
}
