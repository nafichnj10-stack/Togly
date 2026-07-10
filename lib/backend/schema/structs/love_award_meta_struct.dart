// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class LoveAwardMetaStruct extends FFFirebaseStruct {
  LoveAwardMetaStruct({
    String? dummy,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _dummy = dummy,
        super(firestoreUtilData);

  // "dummy" field.
  String? _dummy;
  String get dummy => _dummy ?? '';
  set dummy(String? val) => _dummy = val;

  bool hasDummy() => _dummy != null;

  static LoveAwardMetaStruct fromMap(Map<String, dynamic> data) =>
      LoveAwardMetaStruct(
        dummy: data['dummy'] as String?,
      );

  static LoveAwardMetaStruct? maybeFromMap(dynamic data) => data is Map
      ? LoveAwardMetaStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'dummy': _dummy,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'dummy': serializeParam(
          _dummy,
          ParamType.String,
        ),
      }.withoutNulls;

  static LoveAwardMetaStruct fromSerializableMap(Map<String, dynamic> data) =>
      LoveAwardMetaStruct(
        dummy: deserializeParam(
          data['dummy'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LoveAwardMetaStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LoveAwardMetaStruct && dummy == other.dummy;
  }

  @override
  int get hashCode => const ListEquality().hash([dummy]);
}

LoveAwardMetaStruct createLoveAwardMetaStruct({
  String? dummy,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LoveAwardMetaStruct(
      dummy: dummy,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LoveAwardMetaStruct? updateLoveAwardMetaStruct(
  LoveAwardMetaStruct? loveAwardMeta, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    loveAwardMeta
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLoveAwardMetaStructData(
  Map<String, dynamic> firestoreData,
  LoveAwardMetaStruct? loveAwardMeta,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (loveAwardMeta == null) {
    return;
  }
  if (loveAwardMeta.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && loveAwardMeta.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final loveAwardMetaData =
      getLoveAwardMetaFirestoreData(loveAwardMeta, forFieldValue);
  final nestedData =
      loveAwardMetaData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = loveAwardMeta.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLoveAwardMetaFirestoreData(
  LoveAwardMetaStruct? loveAwardMeta, [
  bool forFieldValue = false,
]) {
  if (loveAwardMeta == null) {
    return {};
  }
  final firestoreData = mapToFirestore(loveAwardMeta.toMap());

  // Add any Firestore field values
  mapToFirestore(loveAwardMeta.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLoveAwardMetaListFirestoreData(
  List<LoveAwardMetaStruct>? loveAwardMetas,
) =>
    loveAwardMetas
        ?.map((e) => getLoveAwardMetaFirestoreData(e, true))
        .toList() ??
    [];
