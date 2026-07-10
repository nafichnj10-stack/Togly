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

import 'package:firebase_storage/firebase_storage.dart';

Future uploadVoiceNoteToBucket(
  String? bucketName,
  String? fullPath,
  FFUploadedFile? uploadedFile,
) async {
  if (fullPath == null || fullPath.isEmpty) {
    throw Exception('fullPath is required');
  }

  if (uploadedFile == null) {
    throw Exception('uploadedFile is required');
  }

  if (uploadedFile.bytes == null) {
    throw Exception('uploadedFile.bytes is null');
  }

  final storage = bucketName != null && bucketName.isNotEmpty
      ? FirebaseStorage.instanceFor(bucket: bucketName)
      : FirebaseStorage.instance;

  final ref = storage.ref().child(fullPath);

  final metadata = SettableMetadata(
    contentType: 'audio/m4a',
  );

  await ref.putData(uploadedFile.bytes!, metadata);
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
