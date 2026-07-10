// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_storage/firebase_storage.dart';

Future<FFUploadedFile> downloadFile(
  String? bucketName,
  String fullPath,
) async {
  final storage = (bucketName == null || bucketName.isEmpty)
      ? FirebaseStorage.instance
      : FirebaseStorage.instanceFor(bucket: bucketName);

  final Uint8List response = (await storage.ref(fullPath).getData())!;

  final FFUploadedFile file = FFUploadedFile(
    name: fullPath.split('/').last, // Extract the file name from the path
    bytes: response, // The response is the file bytes
    height: null, // TODO: Add height if it's an image and metadata is available
    width: null, // TODO: Add width if it's an image and metadata is available
    blurHash: null, // Optional: Add blurHash if needed
  );

  return file;
}
