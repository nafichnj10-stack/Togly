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

// Coerce empty string value back to null, since Firebase treats those two differently and our SettableMetadataStruct converts null to empty string
String? getValue(String? str) {
  return str == null || str.isEmpty ? null : str;
}

Future<FullMetadataStruct> updateMetadataForFile(
  String? bucketName,
  String fullPath,
  SettableMetadataStruct metadata,
) async {
  final storage = (bucketName == null || bucketName.isEmpty)
      ? FirebaseStorage.instance
      : FirebaseStorage.instanceFor(bucket: bucketName);

  Map<String, String>? customMetadata;
  if (metadata.customMetadata.isNotEmpty) {
    customMetadata = {};
    for (KeyValuePairStruct kvp in metadata.customMetadata) {
      customMetadata[kvp.key] = kvp.value;
    }
  }

  final settableMetadata = SettableMetadata(
    cacheControl: getValue(metadata.cacheControl),
    contentDisposition: getValue(metadata.contentDisposition),
    contentEncoding: getValue(metadata.contentEncoding),
    contentLanguage: getValue(metadata.contentLanguage),
    contentType: getValue(metadata.contentType),
    customMetadata: customMetadata,
  );

  final response = await storage.ref(fullPath).updateMetadata(settableMetadata);

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
  );
}
