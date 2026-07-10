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

String? normalizeUrl(String? input) {
  if (input == null) return '';
  var s = input.trim();
  if (s.isEmpty) return '';

  // Remove newlines/tabs and collapse spaces a bit
  s = s.replaceAll(RegExp(r'[\n\r\t]'), ' ').trim();

  // Fix cases like "https: //amazon.de" or "http :// ..."
  s = s.replaceAllMapped(
    RegExp(r'^\s*(https?)\s*:\s*//\s*', caseSensitive: false),
    (m) => '${(m.group(1) ?? 'https').toLowerCase()}://',
  );

  // If scheme missing, prepend https://
  final hasScheme = RegExp(r'^[a-zA-Z][a-zA-Z0-9+\-.]*://').hasMatch(s);
  if (!hasScheme) {
    s = 'https://$s';
  }

  try {
    final uri = Uri.parse(s);

    // Allow only http(s)
    final scheme = uri.scheme.toLowerCase();
    if (scheme != 'http' && scheme != 'https') return '';

    // Must have a host (e.g. amazon.de)
    if (uri.host.isEmpty) return '';

    // Rebuild to ensure proper encoding and consistency
    final cleaned = Uri(
      scheme: scheme,
      userInfo: uri.userInfo.isNotEmpty ? uri.userInfo : null,
      host: uri.host,
      port: uri.hasPort ? uri.port : null,
      path: uri.path.isEmpty ? '/' : uri.path,
      query: uri.hasQuery ? uri.query : null,
      fragment: uri.hasFragment ? uri.fragment : null,
    );

    return cleaned.toString();
  } catch (_) {
    return '';
  }
}
