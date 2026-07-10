// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FullMetadataStruct extends FFFirebaseStruct {
  FullMetadataStruct({
    String? cacheControl,
    String? contentDisposition,
    String? contentEncoding,
    String? contentLanguage,
    String? contentType,
    String? fullPath,
    String? generation,
    String? md5Hash,
    String? metadataGeneration,
    String? metageneration,
    String? name,
    int? size,
    DateTime? timeCreated,
    DateTime? updated,
    List<KeyValuePairStruct>? customMetadata,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _cacheControl = cacheControl,
        _contentDisposition = contentDisposition,
        _contentEncoding = contentEncoding,
        _contentLanguage = contentLanguage,
        _contentType = contentType,
        _fullPath = fullPath,
        _generation = generation,
        _md5Hash = md5Hash,
        _metadataGeneration = metadataGeneration,
        _metageneration = metageneration,
        _name = name,
        _size = size,
        _timeCreated = timeCreated,
        _updated = updated,
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

  // "fullPath" field.
  String? _fullPath;
  String get fullPath => _fullPath ?? '';
  set fullPath(String? val) => _fullPath = val;

  bool hasFullPath() => _fullPath != null;

  // "generation" field.
  String? _generation;
  String get generation => _generation ?? '';
  set generation(String? val) => _generation = val;

  bool hasGeneration() => _generation != null;

  // "md5Hash" field.
  String? _md5Hash;
  String get md5Hash => _md5Hash ?? '';
  set md5Hash(String? val) => _md5Hash = val;

  bool hasMd5Hash() => _md5Hash != null;

  // "metadataGeneration" field.
  String? _metadataGeneration;
  String get metadataGeneration => _metadataGeneration ?? '';
  set metadataGeneration(String? val) => _metadataGeneration = val;

  bool hasMetadataGeneration() => _metadataGeneration != null;

  // "metageneration" field.
  String? _metageneration;
  String get metageneration => _metageneration ?? '';
  set metageneration(String? val) => _metageneration = val;

  bool hasMetageneration() => _metageneration != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "size" field.
  int? _size;
  int get size => _size ?? 0;
  set size(int? val) => _size = val;

  void incrementSize(int amount) => size = size + amount;

  bool hasSize() => _size != null;

  // "timeCreated" field.
  DateTime? _timeCreated;
  DateTime? get timeCreated => _timeCreated;
  set timeCreated(DateTime? val) => _timeCreated = val;

  bool hasTimeCreated() => _timeCreated != null;

  // "updated" field.
  DateTime? _updated;
  DateTime? get updated => _updated;
  set updated(DateTime? val) => _updated = val;

  bool hasUpdated() => _updated != null;

  // "customMetadata" field.
  List<KeyValuePairStruct>? _customMetadata;
  List<KeyValuePairStruct> get customMetadata => _customMetadata ?? const [];
  set customMetadata(List<KeyValuePairStruct>? val) => _customMetadata = val;

  void updateCustomMetadata(Function(List<KeyValuePairStruct>) updateFn) {
    updateFn(_customMetadata ??= []);
  }

  bool hasCustomMetadata() => _customMetadata != null;

  static FullMetadataStruct fromMap(Map<String, dynamic> data) =>
      FullMetadataStruct(
        cacheControl: data['cacheControl'] as String?,
        contentDisposition: data['contentDisposition'] as String?,
        contentEncoding: data['contentEncoding'] as String?,
        contentLanguage: data['contentLanguage'] as String?,
        contentType: data['contentType'] as String?,
        fullPath: data['fullPath'] as String?,
        generation: data['generation'] as String?,
        md5Hash: data['md5Hash'] as String?,
        metadataGeneration: data['metadataGeneration'] as String?,
        metageneration: data['metageneration'] as String?,
        name: data['name'] as String?,
        size: castToType<int>(data['size']),
        timeCreated: data['timeCreated'] as DateTime?,
        updated: data['updated'] as DateTime?,
        customMetadata: getStructList(
          data['customMetadata'],
          KeyValuePairStruct.fromMap,
        ),
      );

  static FullMetadataStruct? maybeFromMap(dynamic data) => data is Map
      ? FullMetadataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'cacheControl': _cacheControl,
        'contentDisposition': _contentDisposition,
        'contentEncoding': _contentEncoding,
        'contentLanguage': _contentLanguage,
        'contentType': _contentType,
        'fullPath': _fullPath,
        'generation': _generation,
        'md5Hash': _md5Hash,
        'metadataGeneration': _metadataGeneration,
        'metageneration': _metageneration,
        'name': _name,
        'size': _size,
        'timeCreated': _timeCreated,
        'updated': _updated,
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
        'fullPath': serializeParam(
          _fullPath,
          ParamType.String,
        ),
        'generation': serializeParam(
          _generation,
          ParamType.String,
        ),
        'md5Hash': serializeParam(
          _md5Hash,
          ParamType.String,
        ),
        'metadataGeneration': serializeParam(
          _metadataGeneration,
          ParamType.String,
        ),
        'metageneration': serializeParam(
          _metageneration,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'size': serializeParam(
          _size,
          ParamType.int,
        ),
        'timeCreated': serializeParam(
          _timeCreated,
          ParamType.DateTime,
        ),
        'updated': serializeParam(
          _updated,
          ParamType.DateTime,
        ),
        'customMetadata': serializeParam(
          _customMetadata,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static FullMetadataStruct fromSerializableMap(Map<String, dynamic> data) =>
      FullMetadataStruct(
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
        fullPath: deserializeParam(
          data['fullPath'],
          ParamType.String,
          false,
        ),
        generation: deserializeParam(
          data['generation'],
          ParamType.String,
          false,
        ),
        md5Hash: deserializeParam(
          data['md5Hash'],
          ParamType.String,
          false,
        ),
        metadataGeneration: deserializeParam(
          data['metadataGeneration'],
          ParamType.String,
          false,
        ),
        metageneration: deserializeParam(
          data['metageneration'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        size: deserializeParam(
          data['size'],
          ParamType.int,
          false,
        ),
        timeCreated: deserializeParam(
          data['timeCreated'],
          ParamType.DateTime,
          false,
        ),
        updated: deserializeParam(
          data['updated'],
          ParamType.DateTime,
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
  String toString() => 'FullMetadataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is FullMetadataStruct &&
        cacheControl == other.cacheControl &&
        contentDisposition == other.contentDisposition &&
        contentEncoding == other.contentEncoding &&
        contentLanguage == other.contentLanguage &&
        contentType == other.contentType &&
        fullPath == other.fullPath &&
        generation == other.generation &&
        md5Hash == other.md5Hash &&
        metadataGeneration == other.metadataGeneration &&
        metageneration == other.metageneration &&
        name == other.name &&
        size == other.size &&
        timeCreated == other.timeCreated &&
        updated == other.updated &&
        listEquality.equals(customMetadata, other.customMetadata);
  }

  @override
  int get hashCode => const ListEquality().hash([
        cacheControl,
        contentDisposition,
        contentEncoding,
        contentLanguage,
        contentType,
        fullPath,
        generation,
        md5Hash,
        metadataGeneration,
        metageneration,
        name,
        size,
        timeCreated,
        updated,
        customMetadata
      ]);
}

FullMetadataStruct createFullMetadataStruct({
  String? cacheControl,
  String? contentDisposition,
  String? contentEncoding,
  String? contentLanguage,
  String? contentType,
  String? fullPath,
  String? generation,
  String? md5Hash,
  String? metadataGeneration,
  String? metageneration,
  String? name,
  int? size,
  DateTime? timeCreated,
  DateTime? updated,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FullMetadataStruct(
      cacheControl: cacheControl,
      contentDisposition: contentDisposition,
      contentEncoding: contentEncoding,
      contentLanguage: contentLanguage,
      contentType: contentType,
      fullPath: fullPath,
      generation: generation,
      md5Hash: md5Hash,
      metadataGeneration: metadataGeneration,
      metageneration: metageneration,
      name: name,
      size: size,
      timeCreated: timeCreated,
      updated: updated,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FullMetadataStruct? updateFullMetadataStruct(
  FullMetadataStruct? fullMetadata, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    fullMetadata
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFullMetadataStructData(
  Map<String, dynamic> firestoreData,
  FullMetadataStruct? fullMetadata,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (fullMetadata == null) {
    return;
  }
  if (fullMetadata.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && fullMetadata.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final fullMetadataData =
      getFullMetadataFirestoreData(fullMetadata, forFieldValue);
  final nestedData =
      fullMetadataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = fullMetadata.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFullMetadataFirestoreData(
  FullMetadataStruct? fullMetadata, [
  bool forFieldValue = false,
]) {
  if (fullMetadata == null) {
    return {};
  }
  final firestoreData = mapToFirestore(fullMetadata.toMap());

  // Add any Firestore field values
  mapToFirestore(fullMetadata.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFullMetadataListFirestoreData(
  List<FullMetadataStruct>? fullMetadatas,
) =>
    fullMetadatas?.map((e) => getFullMetadataFirestoreData(e, true)).toList() ??
    [];
