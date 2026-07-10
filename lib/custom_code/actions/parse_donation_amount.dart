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

import 'dart:async';

Future<int> parseDonationAmount(String amountText) async {
  // Leerzeichen entfernen
  final trimmed = amountText.trim();
  if (trimmed.isEmpty) {
    throw Exception('Please enter an amount.');
  }

  // Komma -> Punkt (z.B. 7,50 -> 7.50)
  final normalized = trimmed.replaceAll(',', '.');

  // Zahl parsen
  final value = double.tryParse(normalized);
  if (value == null || value <= 0) {
    throw Exception('Please enter a valid amount.');
  }

  // Mindestspende, z.B. 1.00 USD
  if (value < 1.0) {
    throw Exception('Minimum donation is 1 USD.');
  }

  // In Cents umrechnen (Stripe braucht Integer)
  final cents = (value * 100).round();

  return cents;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
