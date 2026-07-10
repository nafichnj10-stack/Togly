// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class KeyValuePairStruct extends FFFirebaseStruct {
  KeyValuePairStruct({
    String? key,
    String? value,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _key = key,
        _value = value,
        super(firestoreUtilData);

  // "Key" field.
  String? _key;
  String get key => _key ?? '';
  set key(String? val) => _key = val;

  bool hasKey() => _key != null;

  // "Value" field.
  String? _value;
  String get value => _value ?? '';
  set value(String? val) => _value = val;

  bool hasValue() => _value != null;

  static KeyValuePairStruct fromMap(Map<String, dynamic> data) =>
      KeyValuePairStruct(
        key: data['Key'] as String?,
        value: data['Value'] as String?,
      );

  static KeyValuePairStruct? maybeFromMap(dynamic data) => data is Map
      ? KeyValuePairStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Key': _key,
        'Value': _value,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Key': serializeParam(
          _key,
          ParamType.String,
        ),
        'Value': serializeParam(
          _value,
          ParamType.String,
        ),
      }.withoutNulls;

  static KeyValuePairStruct fromSerializableMap(Map<String, dynamic> data) =>
      KeyValuePairStruct(
        key: deserializeParam(
          data['Key'],
          ParamType.String,
          false,
        ),
        value: deserializeParam(
          data['Value'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'KeyValuePairStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is KeyValuePairStruct &&
        key == other.key &&
        value == other.value;
  }

  @override
  int get hashCode => const ListEquality().hash([key, value]);
}

KeyValuePairStruct createKeyValuePairStruct({
  String? key,
  String? value,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    KeyValuePairStruct(
      key: key,
      value: value,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

KeyValuePairStruct? updateKeyValuePairStruct(
  KeyValuePairStruct? keyValuePair, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    keyValuePair
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addKeyValuePairStructData(
  Map<String, dynamic> firestoreData,
  KeyValuePairStruct? keyValuePair,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (keyValuePair == null) {
    return;
  }
  if (keyValuePair.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && keyValuePair.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final keyValuePairData =
      getKeyValuePairFirestoreData(keyValuePair, forFieldValue);
  final nestedData =
      keyValuePairData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = keyValuePair.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getKeyValuePairFirestoreData(
  KeyValuePairStruct? keyValuePair, [
  bool forFieldValue = false,
]) {
  if (keyValuePair == null) {
    return {};
  }
  final firestoreData = mapToFirestore(keyValuePair.toMap());

  // Add any Firestore field values
  mapToFirestore(keyValuePair.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getKeyValuePairListFirestoreData(
  List<KeyValuePairStruct>? keyValuePairs,
) =>
    keyValuePairs?.map((e) => getKeyValuePairFirestoreData(e, true)).toList() ??
    [];
