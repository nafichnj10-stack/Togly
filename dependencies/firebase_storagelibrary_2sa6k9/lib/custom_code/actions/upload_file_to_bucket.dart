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
import 'package:mime_type/mime_type.dart';

FileObjectStruct refToFileObject(Reference ref, bool isPrefix) {
  return FileObjectStruct(fullPath: ref.fullPath, isPrefix: isPrefix);
}

Future<FileObjectStruct> uploadFileToBucket(
  String? bucketName,
  String? fullPath,
  FFUploadedFile uploadedFile,
  String? prefix,
) async {
  final storage = (bucketName == null || bucketName.isEmpty)
      ? FirebaseStorage.instance
      : FirebaseStorage.instanceFor(bucket: bucketName);

  late Reference ref;
  if (fullPath != null && fullPath.isNotEmpty) {
    ref = storage.ref(fullPath);
  } else if (prefix != null && prefix.isNotEmpty) {
    ref = storage.ref(prefix).child(uploadedFile.name!);
  } else {
    throw Exception(
        "Either a prefix/folder or a path has to be specified, but you left both empty.");
  }

  print("Uploading ${uploadedFile.bytes!.length} bytes to $ref");

  final metadata = SettableMetadata(contentType: mime(uploadedFile.name));
  await ref.putData(uploadedFile.bytes!, metadata);

  return refToFileObject(ref, false);
}
