// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FileObjectStruct extends FFFirebaseStruct {
  FileObjectStruct({
    String? fullPath,
    bool? isPrefix,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _fullPath = fullPath,
        _isPrefix = isPrefix,
        super(firestoreUtilData);

  // "fullPath" field.
  String? _fullPath;
  String get fullPath => _fullPath ?? '';
  set fullPath(String? val) => _fullPath = val;

  bool hasFullPath() => _fullPath != null;

  // "isPrefix" field.
  bool? _isPrefix;
  bool get isPrefix => _isPrefix ?? false;
  set isPrefix(bool? val) => _isPrefix = val;

  bool hasIsPrefix() => _isPrefix != null;

  static FileObjectStruct fromMap(Map<String, dynamic> data) =>
      FileObjectStruct(
        fullPath: data['fullPath'] as String?,
        isPrefix: data['isPrefix'] as bool?,
      );

  static FileObjectStruct? maybeFromMap(dynamic data) => data is Map
      ? FileObjectStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'fullPath': _fullPath,
        'isPrefix': _isPrefix,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'fullPath': serializeParam(
          _fullPath,
          ParamType.String,
        ),
        'isPrefix': serializeParam(
          _isPrefix,
          ParamType.bool,
        ),
      }.withoutNulls;

  static FileObjectStruct fromSerializableMap(Map<String, dynamic> data) =>
      FileObjectStruct(
        fullPath: deserializeParam(
          data['fullPath'],
          ParamType.String,
          false,
        ),
        isPrefix: deserializeParam(
          data['isPrefix'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'FileObjectStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FileObjectStruct &&
        fullPath == other.fullPath &&
        isPrefix == other.isPrefix;
  }

  @override
  int get hashCode => const ListEquality().hash([fullPath, isPrefix]);
}

FileObjectStruct createFileObjectStruct({
  String? fullPath,
  bool? isPrefix,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FileObjectStruct(
      fullPath: fullPath,
      isPrefix: isPrefix,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FileObjectStruct? updateFileObjectStruct(
  FileObjectStruct? fileObject, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    fileObject
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFileObjectStructData(
  Map<String, dynamic> firestoreData,
  FileObjectStruct? fileObject,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (fileObject == null) {
    return;
  }
  if (fileObject.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && fileObject.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final fileObjectData = getFileObjectFirestoreData(fileObject, forFieldValue);
  final nestedData = fileObjectData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = fileObject.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFileObjectFirestoreData(
  FileObjectStruct? fileObject, [
  bool forFieldValue = false,
]) {
  if (fileObject == null) {
    return {};
  }
  final firestoreData = mapToFirestore(fileObject.toMap());

  // Add any Firestore field values
  mapToFirestore(fileObject.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFileObjectListFirestoreData(
  List<FileObjectStruct>? fileObjects,
) =>
    fileObjects?.map((e) => getFileObjectFirestoreData(e, true)).toList() ?? [];
