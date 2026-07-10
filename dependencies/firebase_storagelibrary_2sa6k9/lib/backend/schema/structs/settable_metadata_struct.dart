// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SettableMetadataStruct extends FFFirebaseStruct {
  SettableMetadataStruct({
    String? cacheControl,
    String? contentDisposition,
    String? contentEncoding,
    String? contentLanguage,
    String? contentType,
    List<KeyValuePairStruct>? customMetadata,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _cacheControl = cacheControl,
        _contentDisposition = contentDisposition,
        _contentEncoding = contentEncoding,
        _contentLanguage = contentLanguage,
        _contentType = contentType,
        _customMetadata = customMetadata,
        super(firestoreUtilData);

  // "cacheControl" field.
  String? _cacheControl;
  String get cacheControl => _cacheControl ?? '';
  set cacheControl(String? val) => _cacheControl = val;

  bool hasCacheControl() => _cacheControl != null;

  // "contentDisposition" field.
  String? _contentDisposition;
  String get contentDisposition => _contentDisposition ?? '';
  set contentDisposition(String? val) => _contentDisposition = val;

  bool hasContentDisposition() => _contentDisposition != null;

  // "contentEncoding" field.
  String? _contentEncoding;
  String get contentEncoding => _contentEncoding ?? '';
  set contentEncoding(String? val) => _contentEncoding = val;

  bool hasContentEncoding() => _contentEncoding != null;

  // "contentLanguage" field.
  String? _contentLanguage;
  String get contentLanguage => _contentLanguage ?? '';
  set contentLanguage(String? val) => _contentLanguage = val;

  bool hasContentLanguage() => _contentLanguage != null;

  // "contentType" field.
  String? _contentType;
  String get contentType => _contentType ?? '';
  set contentType(String? val) => _contentType = val;

  bool hasContentType() => _contentType != null;

  // "customMetadata" field.
  List<KeyValuePairStruct>? _customMetadata;
  List<KeyValuePairStruct> get customMetadata => _customMetadata ?? const [];
  set customMetadata(List<KeyValuePairStruct>? val) => _customMetadata = val;

  void updateCustomMetadata(Function(List<KeyValuePairStruct>) updateFn) {
    updateFn(_customMetadata ??= []);
  }

  bool hasCustomMetadata() => _customMetadata != null;

  static SettableMetadataStruct fromMap(Map<String, dynamic> data) =>
      SettableMetadataStruct(
        cacheControl: data['cacheControl'] as String?,
        contentDisposition: data['contentDisposition'] as String?,
        contentEncoding: data['contentEncoding'] as String?,
        contentLanguage: data['contentLanguage'] as String?,
        contentType: data['contentType'] as String?,
        customMetadata: getStructList(
          data['customMetadata'],
          KeyValuePairStruct.fromMap,
        ),
      );

  static SettableMetadataStruct? maybeFromMap(dynamic data) => data is Map
      ? SettableMetadataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'cacheControl': _cacheControl,
        'contentDisposition': _contentDisposition,
        'contentEncoding': _contentEncoding,
        'contentLanguage': _contentLanguage,
        'contentType': _contentType,
        'customMetadata': _customMetadata?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'cacheControl': serializeParam(
          _cacheControl,
          ParamType.String,
        ),
        'contentDisposition': serializeParam(
          _contentDisposition,
          ParamType.String,
        ),
        'contentEncoding': serializeParam(
          _contentEncoding,
          ParamType.String,
        ),
        'contentLanguage': serializeParam(
          _contentLanguage,
          ParamType.String,
        ),
        'contentType': serializeParam(
          _contentType,
          ParamType.String,
        ),
        'customMetadata': serializeParam(
          _customMetadata,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static SettableMetadataStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SettableMetadataStruct(
        cacheControl: deserializeParam(
          data['cacheControl'],
          ParamType.String,
          false,
        ),
        contentDisposition: deserializeParam(
          data['contentDisposition'],
          ParamType.String,
          false,
        ),
        contentEncoding: deserializeParam(
          data['contentEncoding'],
          ParamType.String,
          false,
        ),
        contentLanguage: deserializeParam(
          data['contentLanguage'],
          ParamType.String,
          false,
        ),
        contentType: deserializeParam(
          data['contentType'],
          ParamType.String,
          false,
        ),
        customMetadata: deserializeStructParam<KeyValuePairStruct>(
          data['customMetadata'],
          ParamType.DataStruct,
          true,
          structBuilder: KeyValuePairStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'SettableMetadataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SettableMetadataStruct &&
        cacheControl == other.cacheControl &&
        contentDisposition == other.contentDisposition &&
        contentEncoding == other.contentEncoding &&
        contentLanguage == other.contentLanguage &&
        contentType == other.contentType &&
        listEquality.equals(customMetadata, other.customMetadata);
  }

  @override
  int get hashCode => const ListEquality().hash([
        cacheControl,
        contentDisposition,
        contentEncoding,
        contentLanguage,
        contentType,
        customMetadata
      ]);
}

SettableMetadataStruct createSettableMetadataStruct({
  String? cacheControl,
  String? contentDisposition,
  String? contentEncoding,
  String? contentLanguage,
  String? contentType,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SettableMetadataStruct(
      cacheControl: cacheControl,
      contentDisposition: contentDisposition,
      contentEncoding: contentEncoding,
      contentLanguage: contentLanguage,
      contentType: contentType,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SettableMetadataStruct? updateSettableMetadataStruct(
  SettableMetadataStruct? settableMetadata, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    settableMetadata
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSettableMetadataStructData(
  Map<String, dynamic> firestoreData,
  SettableMetadataStruct? settableMetadata,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (settableMetadata == null) {
    return;
  }
  if (settableMetadata.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && settableMetadata.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final settableMetadataData =
      getSettableMetadataFirestoreData(settableMetadata, forFieldValue);
  final nestedData =
      settableMetadataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = settableMetadata.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSettableMetadataFirestoreData(
  SettableMetadataStruct? settableMetadata, [
  bool forFieldValue = false,
]) {
  if (settableMetadata == null) {
    return {};
  }
  final firestoreData = mapToFirestore(settableMetadata.toMap());

  // Add any Firestore field values
  mapToFirestore(settableMetadata.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSettableMetadataListFirestoreData(
  List<SettableMetadataStruct>? settableMetadatas,
) =>
    settableMetadatas
        ?.map((e) => getSettableMetadataFirestoreData(e, true))
        .toList() ??
    [];
