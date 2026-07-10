// Automatic FlutterFlow imports
import '/backend/backend.dart';
import "package:firebase_storagelibrary_2sa6k9/backend/schema/structs/index.dart"
    as firebase_storagelibrary_2sa6k9_data_schema;
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import "package:firebase_storagelibrary_2sa6k9/backend/schema/structs/index.dart"
    as firebase_storagelibrary_2sa6k9_data_schema;
import "package:firebase_storagelibrary_2sa6k9/backend/schema/enums/enums.dart"
    as firebase_storagelibrary_2sa6k9_enums;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<dynamic> parseGoogleGeocodeLocation(dynamic geocodeJson) async {
  if (geocodeJson == null) {
    return null;
  }

  final results = geocodeJson['results'];

  if (results == null || results is! List || results.isEmpty) {
    return null;
  }

  final firstResult = results.first;
  final components = firstResult['address_components'];

  String city = '';
  String countryName = '';
  String countryCode = '';

  if (components is List) {
    for (final component in components) {
      final types = component['types'];

      if (types is List && types.contains('locality')) {
        city = (component['long_name'] ?? '').toString();
      }

      if (types is List && types.contains('country')) {
        countryName = (component['long_name'] ?? '').toString();
        countryCode = (component['short_name'] ?? '').toString();
      }
    }
  }

  final location = firstResult['geometry']?['location'];
  final lat = location?['lat'];
  final lng = location?['lng'];

  final isValidLocation = city.trim().isNotEmpty &&
      countryName.trim().isNotEmpty &&
      countryCode.trim().isNotEmpty &&
      lat != null &&
      lng != null;

  if (!isValidLocation) {
    return null;
  }

  return {
    'city': city.trim(),
    'countryName': countryName.trim(),
    'countryCode': countryCode.trim(),
    'lat': lat,
    'lng': lng,
  };
}
