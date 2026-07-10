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

import 'package:geolocator/geolocator.dart';
import 'package:cloud_functions/cloud_functions.dart';

Future<String?> sendLoveBuddyLiveLocationOnce(String? relationshipId) async {
  try {
    if (relationshipId == null || relationshipId.trim().isEmpty) {
      return 'NO_RELATIONSHIP_ID';
    }

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'LOCATION_SERVICE_DISABLED';
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      return 'PERMISSION_DENIED';
    }

    if (permission == LocationPermission.deniedForever) {
      return 'PERMISSION_DENIED_FOREVER';
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final callable = FirebaseFunctions.instanceFor(
      region: 'europe-west3',
    ).httpsCallable('updateLoveBuddyLiveLocation');

    final result = await callable.call({
      'relationshipId': relationshipId.trim(),
      'lat': position.latitude,
      'lng': position.longitude,
      'accuracyMeters': position.accuracy,
    });

    final data = result.data;

    if (data is Map) {
      return data['code']?.toString() ?? data.toString();
    }

    return 'UNKNOWN_RESPONSE';
  } catch (e) {
    return 'ERROR: $e';
  }
}
