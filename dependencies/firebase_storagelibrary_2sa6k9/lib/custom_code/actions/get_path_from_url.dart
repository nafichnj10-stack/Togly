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

FileObjectStruct refToFileObject(Reference ref, bool isPrefix) =>
    FileObjectStruct(fullPath: ref.fullPath, isPrefix: isPrefix);

Future<FileObjectStruct> getPathFromUrl(
  String url,
) async {
  final storage = FirebaseStorage.instance;
  final ref = storage.refFromURL(url);

  return refToFileObject(ref, false);
}
