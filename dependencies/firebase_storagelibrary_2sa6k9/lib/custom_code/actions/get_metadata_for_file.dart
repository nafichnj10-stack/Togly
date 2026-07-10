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

Future<FullMetadataStruct> getMetadataForFile(
  String? bucketName,
  String fullPath,
) async {
  final storage = (bucketName == null || bucketName.isEmpty)
      ? FirebaseStorage.instance
      : FirebaseStorage.instanceFor(bucket: bucketName);

  final response = await storage.ref(fullPath).getMetadata();

  List<KeyValuePairStruct>? customMetadata;
  if (response.customMetadata != null) {
    customMetadata = [];
    for (var entry in response.customMetadata!.entries) {
      customMetadata
          .add(KeyValuePairStruct(key: entry.key, value: entry.value));
    }
  }

  return FullMetadataStruct(
    cacheControl: response.cacheControl,
    contentDisposition: response.contentDisposition,
    contentEncoding: response.contentEncoding,
    contentLanguage: response.contentLanguage,
    contentType: response.contentType,
    fullPath: response.fullPath,
    generation: response.generation,
    md5Hash: response.md5Hash,
    metadataGeneration: response.metadataGeneration,
    metageneration: response.metageneration,
    name: response.name,
    size: response.size,
    timeCreated: response.timeCreated,
    updated: response.updated,
    customMetadata: customMetadata,
  );
}
