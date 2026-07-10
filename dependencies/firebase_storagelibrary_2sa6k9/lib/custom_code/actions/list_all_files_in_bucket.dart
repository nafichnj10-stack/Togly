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

/// List all files in any bucket that you have read access to.
///
/// Parameters:
///
/// * The `bucketName` (`String?`) to list the files from. If you leave this
/// empty, it uses the default bucket of the associated Firebase project.
/// * The `listType` (`StorageListType?`) of the items to list (files,
/// directories, both). If left empty, the action will list both files and
/// prefixes (folders/directories).
/// * The `prefix` (`String?`) is the / separated path from which to list
/// files. If left empty, the action will list the items in the root of the
/// storage bucket.
///
/// Action result:
/// * If successful, the action results in a `List` of `fileObject` elements.
Future<List<FileObjectStruct>> listAllFilesInBucket(
  String? bucketName,
  StorageListType? listType,
  String? prefix,
) async {
  listType ??= StorageListType.filesAndPrefixes;

  final refToFileObject = (Reference ref, bool isPrefix) =>
      FileObjectStruct(fullPath: ref.fullPath, isPrefix: isPrefix);

  final storage = (bucketName == null || bucketName.isEmpty)
      ? FirebaseStorage.instance
      : FirebaseStorage.instanceFor(bucket: bucketName);

  var ref =
      (prefix == null || prefix.isEmpty) ? storage.ref() : storage.ref(prefix);

  var listResult = await ref.listAll();

  List<FileObjectStruct> results = [];
  if ({StorageListType.filesAndPrefixes, StorageListType.prefixes}
      .contains(listType)) {
    results
        .addAll(listResult.prefixes.map((ref) => refToFileObject(ref, true)));
  }
  if ({StorageListType.filesAndPrefixes, StorageListType.files}
      .contains(listType)) {
    results.addAll(listResult.items.map((ref) => refToFileObject(ref, false)));
  }

  return results;
}
