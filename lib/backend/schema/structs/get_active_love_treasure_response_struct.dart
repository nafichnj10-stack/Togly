// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class GetActiveLoveTreasureResponseStruct extends FFFirebaseStruct {
  GetActiveLoveTreasureResponseStruct({
    bool? ok,
    bool? found,
    String? code,
    String? message,
    String? treasureId,
    int? unlockAtMs,
    int? durationDays,
    int? maxSurprises,
    String? status,
    String? treasurePath,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _ok = ok,
        _found = found,
        _code = code,
        _message = message,
        _treasureId = treasureId,
        _unlockAtMs = unlockAtMs,
        _durationDays = durationDays,
        _maxSurprises = maxSurprises,
        _status = status,
        _treasurePath = treasurePath,
        super(firestoreUtilData);

  // "ok" field.
  bool? _ok;
  bool get ok => _ok ?? false;
  set ok(bool? val) => _ok = val;

  bool hasOk() => _ok != null;

  // "found" field.
  bool? _found;
  bool get found => _found ?? false;
  set found(bool? val) => _found = val;

  bool hasFound() => _found != null;

  // "code" field.
  String? _code;
  String get code => _code ?? '';
  set code(String? val) => _code = val;

  bool hasCode() => _code != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

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

  // "durationDays" field.
  int? _durationDays;
  int get durationDays => _durationDays ?? 0;
  set durationDays(int? val) => _durationDays = val;

  void incrementDurationDays(int amount) =>
      durationDays = durationDays + amount;

  bool hasDurationDays() => _durationDays != null;

  // "maxSurprises" field.
  int? _maxSurprises;
  int get maxSurprises => _maxSurprises ?? 0;
  set maxSurprises(int? val) => _maxSurprises = val;

  void incrementMaxSurprises(int amount) =>
      maxSurprises = maxSurprises + amount;

  bool hasMaxSurprises() => _maxSurprises != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "treasurePath" field.
  String? _treasurePath;
  String get treasurePath => _treasurePath ?? '';
  set treasurePath(String? val) => _treasurePath = val;

  bool hasTreasurePath() => _treasurePath != null;

  static GetActiveLoveTreasureResponseStruct fromMap(
          Map<String, dynamic> data) =>
      GetActiveLoveTreasureResponseStruct(
        ok: data['ok'] as bool?,
        found: data['found'] as bool?,
        code: data['code'] as String?,
        message: data['message'] as String?,
        treasureId: data['treasureId'] as String?,
        unlockAtMs: castToType<int>(data['unlockAtMs']),
        durationDays: castToType<int>(data['durationDays']),
        maxSurprises: castToType<int>(data['maxSurprises']),
        status: data['status'] as String?,
        treasurePath: data['treasurePath'] as String?,
      );

  static GetActiveLoveTreasureResponseStruct? maybeFromMap(dynamic data) =>
      data is Map
          ? GetActiveLoveTreasureResponseStruct.fromMap(
              data.cast<String, dynamic>())
          : null;

  Map<String, dynamic> toMap() => {
        'ok': _ok,
        'found': _found,
        'code': _code,
        'message': _message,
        'treasureId': _treasureId,
        'unlockAtMs': _unlockAtMs,
        'durationDays': _durationDays,
        'maxSurprises': _maxSurprises,
        'status': _status,
        'treasurePath': _treasurePath,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'ok': serializeParam(
          _ok,
          ParamType.bool,
        ),
        'found': serializeParam(
          _found,
          ParamType.bool,
        ),
        'code': serializeParam(
          _code,
          ParamType.String,
        ),
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
        'treasureId': serializeParam(
          _treasureId,
          ParamType.String,
        ),
        'unlockAtMs': serializeParam(
          _unlockAtMs,
          ParamType.int,
        ),
        'durationDays': serializeParam(
          _durationDays,
          ParamType.int,
        ),
        'maxSurprises': serializeParam(
          _maxSurprises,
          ParamType.int,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'treasurePath': serializeParam(
          _treasurePath,
          ParamType.String,
        ),
      }.withoutNulls;

  static GetActiveLoveTreasureResponseStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      GetActiveLoveTreasureResponseStruct(
        ok: deserializeParam(
          data['ok'],
          ParamType.bool,
          false,
        ),
        found: deserializeParam(
          data['found'],
          ParamType.bool,
          false,
        ),
        code: deserializeParam(
          data['code'],
          ParamType.String,
          false,
        ),
        message: deserializeParam(
          data['message'],
          ParamType.String,
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
        durationDays: deserializeParam(
          data['durationDays'],
          ParamType.int,
          false,
        ),
        maxSurprises: deserializeParam(
          data['maxSurprises'],
          ParamType.int,
          false,
        ),
        status: deserializeParam(
          data['status'],
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
  String toString() => 'GetActiveLoveTreasureResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GetActiveLoveTreasureResponseStruct &&
        ok == other.ok &&
        found == other.found &&
        code == other.code &&
        message == other.message &&
        treasureId == other.treasureId &&
        unlockAtMs == other.unlockAtMs &&
        durationDays == other.durationDays &&
        maxSurprises == other.maxSurprises &&
        status == other.status &&
        treasurePath == other.treasurePath;
  }

  @override
  int get hashCode => const ListEquality().hash([
        ok,
        found,
        code,
        message,
        treasureId,
        unlockAtMs,
        durationDays,
        maxSurprises,
        status,
        treasurePath
      ]);
}

GetActiveLoveTreasureResponseStruct createGetActiveLoveTreasureResponseStruct({
  bool? ok,
  bool? found,
  String? code,
  String? message,
  String? treasureId,
  int? unlockAtMs,
  int? durationDays,
  int? maxSurprises,
  String? status,
  String? treasurePath,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    GetActiveLoveTreasureResponseStruct(
      ok: ok,
      found: found,
      code: code,
      message: message,
      treasureId: treasureId,
      unlockAtMs: unlockAtMs,
      durationDays: durationDays,
      maxSurprises: maxSurprises,
      status: status,
      treasurePath: treasurePath,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

GetActiveLoveTreasureResponseStruct? updateGetActiveLoveTreasureResponseStruct(
  GetActiveLoveTreasureResponseStruct? getActiveLoveTreasureResponse, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    getActiveLoveTreasureResponse
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addGetActiveLoveTreasureResponseStructData(
  Map<String, dynamic> firestoreData,
  GetActiveLoveTreasureResponseStruct? getActiveLoveTreasureResponse,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (getActiveLoveTreasureResponse == null) {
    return;
  }
  if (getActiveLoveTreasureResponse.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      getActiveLoveTreasureResponse.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final getActiveLoveTreasureResponseData =
      getGetActiveLoveTreasureResponseFirestoreData(
          getActiveLoveTreasureResponse, forFieldValue);
  final nestedData = getActiveLoveTreasureResponseData
      .map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      getActiveLoveTreasureResponse.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getGetActiveLoveTreasureResponseFirestoreData(
  GetActiveLoveTreasureResponseStruct? getActiveLoveTreasureResponse, [
  bool forFieldValue = false,
]) {
  if (getActiveLoveTreasureResponse == null) {
    return {};
  }
  final firestoreData = mapToFirestore(getActiveLoveTreasureResponse.toMap());

  // Add any Firestore field values
  mapToFirestore(getActiveLoveTreasureResponse.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getGetActiveLoveTreasureResponseListFirestoreData(
  List<GetActiveLoveTreasureResponseStruct>? getActiveLoveTreasureResponses,
) =>
    getActiveLoveTreasureResponses
        ?.map((e) => getGetActiveLoveTreasureResponseFirestoreData(e, true))
        .toList() ??
    [];
