import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ff_commons/flutter_flow/lat_lng.dart';
import 'package:ff_commons/flutter_flow/place.dart';
import 'package:ff_commons/flutter_flow/uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';

StorageListType convertStringToListType(String listType) {
  // Convert the string input value to a StorageListType enum return value
  return deserializeEnum<StorageListType>(listType) ?? StorageListType.files;
}

String getInfoForFile(FFUploadedFile file) {
  return file.toString();
}

String? convertStringToImagePath(String? url) {
  return url;
}

String getFullMetadataAsString(FullMetadataStruct fullMetadata) {
  return fullMetadata.toString();
}

List<KeyValuePairStruct> createCustomMetadataFromKeyValue(
  String key,
  String? value,
) {
  return [KeyValuePairStruct(key: key, value: value)];
}
