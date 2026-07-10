// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CFSyncHomeSnapshotResultStruct extends FFFirebaseStruct {
  CFSyncHomeSnapshotResultStruct({
    bool? ok,
    String? homeMode,
    String? relationshipId,
    String? restoreRelationshipId,
    String? restoreState,
    bool? hasActiveRelationship,
    bool? isReconnectMode,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _ok = ok,
        _homeMode = homeMode,
        _relationshipId = relationshipId,
        _restoreRelationshipId = restoreRelationshipId,
        _restoreState = restoreState,
        _hasActiveRelationship = hasActiveRelationship,
        _isReconnectMode = isReconnectMode,
        super(firestoreUtilData);

  // "ok" field.
  bool? _ok;
  bool get ok => _ok ?? false;
  set ok(bool? val) => _ok = val;

  bool hasOk() => _ok != null;

  // "homeMode" field.
  String? _homeMode;
  String get homeMode => _homeMode ?? '';
  set homeMode(String? val) => _homeMode = val;

  bool hasHomeMode() => _homeMode != null;

  // "relationshipId" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  set relationshipId(String? val) => _relationshipId = val;

  bool hasRelationshipId() => _relationshipId != null;

  // "restoreRelationshipId" field.
  String? _restoreRelationshipId;
  String get restoreRelationshipId => _restoreRelationshipId ?? '';
  set restoreRelationshipId(String? val) => _restoreRelationshipId = val;

  bool hasRestoreRelationshipId() => _restoreRelationshipId != null;

  // "restoreState" field.
  String? _restoreState;
  String get restoreState => _restoreState ?? '';
  set restoreState(String? val) => _restoreState = val;

  bool hasRestoreState() => _restoreState != null;

  // "hasActiveRelationship" field.
  bool? _hasActiveRelationship;
  bool get hasActiveRelationship => _hasActiveRelationship ?? false;
  set hasActiveRelationship(bool? val) => _hasActiveRelationship = val;

  bool hasHasActiveRelationship() => _hasActiveRelationship != null;

  // "isReconnectMode" field.
  bool? _isReconnectMode;
  bool get isReconnectMode => _isReconnectMode ?? false;
  set isReconnectMode(bool? val) => _isReconnectMode = val;

  bool hasIsReconnectMode() => _isReconnectMode != null;

  static CFSyncHomeSnapshotResultStruct fromMap(Map<String, dynamic> data) =>
      CFSyncHomeSnapshotResultStruct(
        ok: data['ok'] as bool?,
        homeMode: data['homeMode'] as String?,
        relationshipId: data['relationshipId'] as String?,
        restoreRelationshipId: data['restoreRelationshipId'] as String?,
        restoreState: data['restoreState'] as String?,
        hasActiveRelationship: data['hasActiveRelationship'] as bool?,
        isReconnectMode: data['isReconnectMode'] as bool?,
      );

  static CFSyncHomeSnapshotResultStruct? maybeFromMap(dynamic data) =>
      data is Map
          ? CFSyncHomeSnapshotResultStruct.fromMap(data.cast<String, dynamic>())
          : null;

  Map<String, dynamic> toMap() => {
        'ok': _ok,
        'homeMode': _homeMode,
        'relationshipId': _relationshipId,
        'restoreRelationshipId': _restoreRelationshipId,
        'restoreState': _restoreState,
        'hasActiveRelationship': _hasActiveRelationship,
        'isReconnectMode': _isReconnectMode,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'ok': serializeParam(
          _ok,
          ParamType.bool,
        ),
        'homeMode': serializeParam(
          _homeMode,
          ParamType.String,
        ),
        'relationshipId': serializeParam(
          _relationshipId,
          ParamType.String,
        ),
        'restoreRelationshipId': serializeParam(
          _restoreRelationshipId,
          ParamType.String,
        ),
        'restoreState': serializeParam(
          _restoreState,
          ParamType.String,
        ),
        'hasActiveRelationship': serializeParam(
          _hasActiveRelationship,
          ParamType.bool,
        ),
        'isReconnectMode': serializeParam(
          _isReconnectMode,
          ParamType.bool,
        ),
      }.withoutNulls;

  static CFSyncHomeSnapshotResultStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CFSyncHomeSnapshotResultStruct(
        ok: deserializeParam(
          data['ok'],
          ParamType.bool,
          false,
        ),
        homeMode: deserializeParam(
          data['homeMode'],
          ParamType.String,
          false,
        ),
        relationshipId: deserializeParam(
          data['relationshipId'],
          ParamType.String,
          false,
        ),
        restoreRelationshipId: deserializeParam(
          data['restoreRelationshipId'],
          ParamType.String,
          false,
        ),
        restoreState: deserializeParam(
          data['restoreState'],
          ParamType.String,
          false,
        ),
        hasActiveRelationship: deserializeParam(
          data['hasActiveRelationship'],
          ParamType.bool,
          false,
        ),
        isReconnectMode: deserializeParam(
          data['isReconnectMode'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'CFSyncHomeSnapshotResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CFSyncHomeSnapshotResultStruct &&
        ok == other.ok &&
        homeMode == other.homeMode &&
        relationshipId == other.relationshipId &&
        restoreRelationshipId == other.restoreRelationshipId &&
        restoreState == other.restoreState &&
        hasActiveRelationship == other.hasActiveRelationship &&
        isReconnectMode == other.isReconnectMode;
  }

  @override
  int get hashCode => const ListEquality().hash([
        ok,
        homeMode,
        relationshipId,
        restoreRelationshipId,
        restoreState,
        hasActiveRelationship,
        isReconnectMode
      ]);
}

CFSyncHomeSnapshotResultStruct createCFSyncHomeSnapshotResultStruct({
  bool? ok,
  String? homeMode,
  String? relationshipId,
  String? restoreRelationshipId,
  String? restoreState,
  bool? hasActiveRelationship,
  bool? isReconnectMode,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CFSyncHomeSnapshotResultStruct(
      ok: ok,
      homeMode: homeMode,
      relationshipId: relationshipId,
      restoreRelationshipId: restoreRelationshipId,
      restoreState: restoreState,
      hasActiveRelationship: hasActiveRelationship,
      isReconnectMode: isReconnectMode,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CFSyncHomeSnapshotResultStruct? updateCFSyncHomeSnapshotResultStruct(
  CFSyncHomeSnapshotResultStruct? cFSyncHomeSnapshotResult, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    cFSyncHomeSnapshotResult
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCFSyncHomeSnapshotResultStructData(
  Map<String, dynamic> firestoreData,
  CFSyncHomeSnapshotResultStruct? cFSyncHomeSnapshotResult,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (cFSyncHomeSnapshotResult == null) {
    return;
  }
  if (cFSyncHomeSnapshotResult.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      cFSyncHomeSnapshotResult.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final cFSyncHomeSnapshotResultData = getCFSyncHomeSnapshotResultFirestoreData(
      cFSyncHomeSnapshotResult, forFieldValue);
  final nestedData =
      cFSyncHomeSnapshotResultData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      cFSyncHomeSnapshotResult.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCFSyncHomeSnapshotResultFirestoreData(
  CFSyncHomeSnapshotResultStruct? cFSyncHomeSnapshotResult, [
  bool forFieldValue = false,
]) {
  if (cFSyncHomeSnapshotResult == null) {
    return {};
  }
  final firestoreData = mapToFirestore(cFSyncHomeSnapshotResult.toMap());

  // Add any Firestore field values
  mapToFirestore(cFSyncHomeSnapshotResult.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCFSyncHomeSnapshotResultListFirestoreData(
  List<CFSyncHomeSnapshotResultStruct>? cFSyncHomeSnapshotResults,
) =>
    cFSyncHomeSnapshotResults
        ?.map((e) => getCFSyncHomeSnapshotResultFirestoreData(e, true))
        .toList() ??
    [];
