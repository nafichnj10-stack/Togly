// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CFStartLoveTreasureResultStruct extends FFFirebaseStruct {
  CFStartLoveTreasureResultStruct({
    bool? ok,
    String? treasureId,
    int? unlockAtMs,
    int? maxSurprises,
    int? durationDays,
    String? status,
    String? message,
    String? code,
    String? treasurePath,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _ok = ok,
        _treasureId = treasureId,
        _unlockAtMs = unlockAtMs,
        _maxSurprises = maxSurprises,
        _durationDays = durationDays,
        _status = status,
        _message = message,
        _code = code,
        _treasurePath = treasurePath,
        super(firestoreUtilData);

  // "ok" field.
  bool? _ok;
  bool get ok => _ok ?? false;
  set ok(bool? val) => _ok = val;

  bool hasOk() => _ok != null;

  // "treasureId" field.
  String? _treasureId;
  String get treasureId => _treasureId ?? '';
  set treasureId(String? val) => _treasureId = val;

  bool hasTreasureId() => _treasureId != null;

  // "unlockAtMs" field.
  int? _unlockAtMs;
  int get unlockAtMs => _unlockAtMs ?? 0;
  set unlockAtMs(int? val) => _unlockAtMs = val;

  void incrementUnlockAtMs(int amount) => unlockAtMs = unlockAtMs + amount;

  bool hasUnlockAtMs() => _unlockAtMs != null;

  // "maxSurprises" field.
  int? _maxSurprises;
  int get maxSurprises => _maxSurprises ?? 0;
  set maxSurprises(int? val) => _maxSurprises = val;

  void incrementMaxSurprises(int amount) =>
      maxSurprises = maxSurprises + amount;

  bool hasMaxSurprises() => _maxSurprises != null;

  // "durationDays" field.
  int? _durationDays;
  int get durationDays => _durationDays ?? 0;
  set durationDays(int? val) => _durationDays = val;

  void incrementDurationDays(int amount) =>
      durationDays = durationDays + amount;

  bool hasDurationDays() => _durationDays != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

  // "code" field.
  String? _code;
  String get code => _code ?? '';
  set code(String? val) => _code = val;

  bool hasCode() => _code != null;

  // "treasurePath" field.
  String? _treasurePath;
  String get treasurePath => _treasurePath ?? '';
  set treasurePath(String? val) => _treasurePath = val;

  bool hasTreasurePath() => _treasurePath != null;

  static CFStartLoveTreasureResultStruct fromMap(Map<String, dynamic> data) =>
      CFStartLoveTreasureResultStruct(
        ok: data['ok'] as bool?,
        treasureId: data['treasureId'] as String?,
        unlockAtMs: castToType<int>(data['unlockAtMs']),
        maxSurprises: castToType<int>(data['maxSurprises']),
        durationDays: castToType<int>(data['durationDays']),
        status: data['status'] as String?,
        message: data['message'] as String?,
        code: data['code'] as String?,
        treasurePath: data['treasurePath'] as String?,
      );

  static CFStartLoveTreasureResultStruct? maybeFromMap(dynamic data) => data
          is Map
      ? CFStartLoveTreasureResultStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'ok': _ok,
        'treasureId': _treasureId,
        'unlockAtMs': _unlockAtMs,
        'maxSurprises': _maxSurprises,
        'durationDays': _durationDays,
        'status': _status,
        'message': _message,
        'code': _code,
        'treasurePath': _treasurePath,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'ok': serializeParam(
          _ok,
          ParamType.bool,
        ),
        'treasureId': serializeParam(
          _treasureId,
          ParamType.String,
        ),
        'unlockAtMs': serializeParam(
          _unlockAtMs,
          ParamType.int,
        ),
        'maxSurprises': serializeParam(
          _maxSurprises,
          ParamType.int,
        ),
        'durationDays': serializeParam(
          _durationDays,
          ParamType.int,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
        'code': serializeParam(
          _code,
          ParamType.String,
        ),
        'treasurePath': serializeParam(
          _treasurePath,
          ParamType.String,
        ),
      }.withoutNulls;

  static CFStartLoveTreasureResultStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CFStartLoveTreasureResultStruct(
        ok: deserializeParam(
          data['ok'],
          ParamType.bool,
          false,
        ),
        treasureId: deserializeParam(
          data['treasureId'],
          ParamType.String,
          false,
        ),
        unlockAtMs: deserializeParam(
          data['unlockAtMs'],
          ParamType.int,
          false,
        ),
        maxSurprises: deserializeParam(
          data['maxSurprises'],
          ParamType.int,
          false,
        ),
        durationDays: deserializeParam(
          data['durationDays'],
          ParamType.int,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        message: deserializeParam(
          data['message'],
          ParamType.String,
          false,
        ),
        code: deserializeParam(
          data['code'],
          ParamType.String,
          false,
        ),
        treasurePath: deserializeParam(
          data['treasurePath'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CFStartLoveTreasureResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CFStartLoveTreasureResultStruct &&
        ok == other.ok &&
        treasureId == other.treasureId &&
        unlockAtMs == other.unlockAtMs &&
        maxSurprises == other.maxSurprises &&
        durationDays == other.durationDays &&
        status == other.status &&
        message == other.message &&
        code == other.code &&
        treasurePath == other.treasurePath;
  }

  @override
  int get hashCode => const ListEquality().hash([
        ok,
        treasureId,
        unlockAtMs,
        maxSurprises,
        durationDays,
        status,
        message,
        code,
        treasurePath
      ]);
}

CFStartLoveTreasureResultStruct createCFStartLoveTreasureResultStruct({
  bool? ok,
  String? treasureId,
  int? unlockAtMs,
  int? maxSurprises,
  int? durationDays,
  String? status,
  String? message,
  String? code,
  String? treasurePath,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CFStartLoveTreasureResultStruct(
      ok: ok,
      treasureId: treasureId,
      unlockAtMs: unlockAtMs,
      maxSurprises: maxSurprises,
      durationDays: durationDays,
      status: status,
      message: message,
      code: code,
      treasurePath: treasurePath,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CFStartLoveTreasureResultStruct? updateCFStartLoveTreasureResultStruct(
  CFStartLoveTreasureResultStruct? cFStartLoveTreasureResult, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    cFStartLoveTreasureResult
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCFStartLoveTreasureResultStructData(
  Map<String, dynamic> firestoreData,
  CFStartLoveTreasureResultStruct? cFStartLoveTreasureResult,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (cFStartLoveTreasureResult == null) {
    return;
  }
  if (cFStartLoveTreasureResult.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      cFStartLoveTreasureResult.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final cFStartLoveTreasureResultData =
      getCFStartLoveTreasureResultFirestoreData(
          cFStartLoveTreasureResult, forFieldValue);
  final nestedData =
      cFStartLoveTreasureResultData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      cFStartLoveTreasureResult.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCFStartLoveTreasureResultFirestoreData(
  CFStartLoveTreasureResultStruct? cFStartLoveTreasureResult, [
  bool forFieldValue = false,
]) {
  if (cFStartLoveTreasureResult == null) {
    return {};
  }
  final firestoreData = mapToFirestore(cFStartLoveTreasureResult.toMap());

  // Add any Firestore field values
  mapToFirestore(cFStartLoveTreasureResult.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCFStartLoveTreasureResultListFirestoreData(
  List<CFStartLoveTreasureResultStruct>? cFStartLoveTreasureResults,
) =>
    cFStartLoveTreasureResults
        ?.map((e) => getCFStartLoveTreasureResultFirestoreData(e, true))
        .toList() ??
    [];
