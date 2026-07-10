// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class GetLoveTreasureByIdResponseStruct extends FFFirebaseStruct {
  GetLoveTreasureByIdResponseStruct({
    bool? ok,
    String? code,
    String? message,
    String? treasureId,
    String? status,
    int? durationDays,
    int? maxSurprises,
    int? unlockAtMs,
    int? createdAtMs,
    int? surprisesCountUserA,
    int? surprisesCountUserB,
    int? openedAtMs,
    String? createdByUid,
    String? partnerUid,
    bool? isUnlocked,
    bool? isOpened,
    int? mySurprisesCount,
    int? partnerSurprisesCount,
    String? treasurePath,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _ok = ok,
        _code = code,
        _message = message,
        _treasureId = treasureId,
        _status = status,
        _durationDays = durationDays,
        _maxSurprises = maxSurprises,
        _unlockAtMs = unlockAtMs,
        _createdAtMs = createdAtMs,
        _surprisesCountUserA = surprisesCountUserA,
        _surprisesCountUserB = surprisesCountUserB,
        _openedAtMs = openedAtMs,
        _createdByUid = createdByUid,
        _partnerUid = partnerUid,
        _isUnlocked = isUnlocked,
        _isOpened = isOpened,
        _mySurprisesCount = mySurprisesCount,
        _partnerSurprisesCount = partnerSurprisesCount,
        _treasurePath = treasurePath,
        super(firestoreUtilData);

  // "ok" field.
  bool? _ok;
  bool get ok => _ok ?? false;
  set ok(bool? val) => _ok = val;

  bool hasOk() => _ok != null;

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

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

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

  // "unlockAtMs" field.
  int? _unlockAtMs;
  int get unlockAtMs => _unlockAtMs ?? 0;
  set unlockAtMs(int? val) => _unlockAtMs = val;

  void incrementUnlockAtMs(int amount) => unlockAtMs = unlockAtMs + amount;

  bool hasUnlockAtMs() => _unlockAtMs != null;

  // "createdAtMs" field.
  int? _createdAtMs;
  int get createdAtMs => _createdAtMs ?? 0;
  set createdAtMs(int? val) => _createdAtMs = val;

  void incrementCreatedAtMs(int amount) => createdAtMs = createdAtMs + amount;

  bool hasCreatedAtMs() => _createdAtMs != null;

  // "surprisesCountUserA" field.
  int? _surprisesCountUserA;
  int get surprisesCountUserA => _surprisesCountUserA ?? 0;
  set surprisesCountUserA(int? val) => _surprisesCountUserA = val;

  void incrementSurprisesCountUserA(int amount) =>
      surprisesCountUserA = surprisesCountUserA + amount;

  bool hasSurprisesCountUserA() => _surprisesCountUserA != null;

  // "surprisesCountUserB" field.
  int? _surprisesCountUserB;
  int get surprisesCountUserB => _surprisesCountUserB ?? 0;
  set surprisesCountUserB(int? val) => _surprisesCountUserB = val;

  void incrementSurprisesCountUserB(int amount) =>
      surprisesCountUserB = surprisesCountUserB + amount;

  bool hasSurprisesCountUserB() => _surprisesCountUserB != null;

  // "openedAtMs" field.
  int? _openedAtMs;
  int get openedAtMs => _openedAtMs ?? 0;
  set openedAtMs(int? val) => _openedAtMs = val;

  void incrementOpenedAtMs(int amount) => openedAtMs = openedAtMs + amount;

  bool hasOpenedAtMs() => _openedAtMs != null;

  // "createdByUid" field.
  String? _createdByUid;
  String get createdByUid => _createdByUid ?? '';
  set createdByUid(String? val) => _createdByUid = val;

  bool hasCreatedByUid() => _createdByUid != null;

  // "partnerUid" field.
  String? _partnerUid;
  String get partnerUid => _partnerUid ?? '';
  set partnerUid(String? val) => _partnerUid = val;

  bool hasPartnerUid() => _partnerUid != null;

  // "isUnlocked" field.
  bool? _isUnlocked;
  bool get isUnlocked => _isUnlocked ?? false;
  set isUnlocked(bool? val) => _isUnlocked = val;

  bool hasIsUnlocked() => _isUnlocked != null;

  // "isOpened" field.
  bool? _isOpened;
  bool get isOpened => _isOpened ?? false;
  set isOpened(bool? val) => _isOpened = val;

  bool hasIsOpened() => _isOpened != null;

  // "mySurprisesCount" field.
  int? _mySurprisesCount;
  int get mySurprisesCount => _mySurprisesCount ?? 0;
  set mySurprisesCount(int? val) => _mySurprisesCount = val;

  void incrementMySurprisesCount(int amount) =>
      mySurprisesCount = mySurprisesCount + amount;

  bool hasMySurprisesCount() => _mySurprisesCount != null;

  // "partnerSurprisesCount" field.
  int? _partnerSurprisesCount;
  int get partnerSurprisesCount => _partnerSurprisesCount ?? 0;
  set partnerSurprisesCount(int? val) => _partnerSurprisesCount = val;

  void incrementPartnerSurprisesCount(int amount) =>
      partnerSurprisesCount = partnerSurprisesCount + amount;

  bool hasPartnerSurprisesCount() => _partnerSurprisesCount != null;

  // "treasurePath" field.
  String? _treasurePath;
  String get treasurePath => _treasurePath ?? '';
  set treasurePath(String? val) => _treasurePath = val;

  bool hasTreasurePath() => _treasurePath != null;

  static GetLoveTreasureByIdResponseStruct fromMap(Map<String, dynamic> data) =>
      GetLoveTreasureByIdResponseStruct(
        ok: data['ok'] as bool?,
        code: data['code'] as String?,
        message: data['message'] as String?,
        treasureId: data['treasureId'] as String?,
        status: data['status'] as String?,
        durationDays: castToType<int>(data['durationDays']),
        maxSurprises: castToType<int>(data['maxSurprises']),
        unlockAtMs: castToType<int>(data['unlockAtMs']),
        createdAtMs: castToType<int>(data['createdAtMs']),
        surprisesCountUserA: castToType<int>(data['surprisesCountUserA']),
        surprisesCountUserB: castToType<int>(data['surprisesCountUserB']),
        openedAtMs: castToType<int>(data['openedAtMs']),
        createdByUid: data['createdByUid'] as String?,
        partnerUid: data['partnerUid'] as String?,
        isUnlocked: data['isUnlocked'] as bool?,
        isOpened: data['isOpened'] as bool?,
        mySurprisesCount: castToType<int>(data['mySurprisesCount']),
        partnerSurprisesCount: castToType<int>(data['partnerSurprisesCount']),
        treasurePath: data['treasurePath'] as String?,
      );

  static GetLoveTreasureByIdResponseStruct? maybeFromMap(dynamic data) => data
          is Map
      ? GetLoveTreasureByIdResponseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'ok': _ok,
        'code': _code,
        'message': _message,
        'treasureId': _treasureId,
        'status': _status,
        'durationDays': _durationDays,
        'maxSurprises': _maxSurprises,
        'unlockAtMs': _unlockAtMs,
        'createdAtMs': _createdAtMs,
        'surprisesCountUserA': _surprisesCountUserA,
        'surprisesCountUserB': _surprisesCountUserB,
        'openedAtMs': _openedAtMs,
        'createdByUid': _createdByUid,
        'partnerUid': _partnerUid,
        'isUnlocked': _isUnlocked,
        'isOpened': _isOpened,
        'mySurprisesCount': _mySurprisesCount,
        'partnerSurprisesCount': _partnerSurprisesCount,
        'treasurePath': _treasurePath,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'ok': serializeParam(
          _ok,
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
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'durationDays': serializeParam(
          _durationDays,
          ParamType.int,
        ),
        'maxSurprises': serializeParam(
          _maxSurprises,
          ParamType.int,
        ),
        'unlockAtMs': serializeParam(
          _unlockAtMs,
          ParamType.int,
        ),
        'createdAtMs': serializeParam(
          _createdAtMs,
          ParamType.int,
        ),
        'surprisesCountUserA': serializeParam(
          _surprisesCountUserA,
          ParamType.int,
        ),
        'surprisesCountUserB': serializeParam(
          _surprisesCountUserB,
          ParamType.int,
        ),
        'openedAtMs': serializeParam(
          _openedAtMs,
          ParamType.int,
        ),
        'createdByUid': serializeParam(
          _createdByUid,
          ParamType.String,
        ),
        'partnerUid': serializeParam(
          _partnerUid,
          ParamType.String,
        ),
        'isUnlocked': serializeParam(
          _isUnlocked,
          ParamType.bool,
        ),
        'isOpened': serializeParam(
          _isOpened,
          ParamType.bool,
        ),
        'mySurprisesCount': serializeParam(
          _mySurprisesCount,
          ParamType.int,
        ),
        'partnerSurprisesCount': serializeParam(
          _partnerSurprisesCount,
          ParamType.int,
        ),
        'treasurePath': serializeParam(
          _treasurePath,
          ParamType.String,
        ),
      }.withoutNulls;

  static GetLoveTreasureByIdResponseStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      GetLoveTreasureByIdResponseStruct(
        ok: deserializeParam(
          data['ok'],
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
        status: deserializeParam(
          data['status'],
          ParamType.String,
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
        unlockAtMs: deserializeParam(
          data['unlockAtMs'],
          ParamType.int,
          false,
        ),
        createdAtMs: deserializeParam(
          data['createdAtMs'],
          ParamType.int,
          false,
        ),
        surprisesCountUserA: deserializeParam(
          data['surprisesCountUserA'],
          ParamType.int,
          false,
        ),
        surprisesCountUserB: deserializeParam(
          data['surprisesCountUserB'],
          ParamType.int,
          false,
        ),
        openedAtMs: deserializeParam(
          data['openedAtMs'],
          ParamType.int,
          false,
        ),
        createdByUid: deserializeParam(
          data['createdByUid'],
          ParamType.String,
          false,
        ),
        partnerUid: deserializeParam(
          data['partnerUid'],
          ParamType.String,
          false,
        ),
        isUnlocked: deserializeParam(
          data['isUnlocked'],
          ParamType.bool,
          false,
        ),
        isOpened: deserializeParam(
          data['isOpened'],
          ParamType.bool,
          false,
        ),
        mySurprisesCount: deserializeParam(
          data['mySurprisesCount'],
          ParamType.int,
          false,
        ),
        partnerSurprisesCount: deserializeParam(
          data['partnerSurprisesCount'],
          ParamType.int,
          false,
        ),
        treasurePath: deserializeParam(
          data['treasurePath'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'GetLoveTreasureByIdResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GetLoveTreasureByIdResponseStruct &&
        ok == other.ok &&
        code == other.code &&
        message == other.message &&
        treasureId == other.treasureId &&
        status == other.status &&
        durationDays == other.durationDays &&
        maxSurprises == other.maxSurprises &&
        unlockAtMs == other.unlockAtMs &&
        createdAtMs == other.createdAtMs &&
        surprisesCountUserA == other.surprisesCountUserA &&
        surprisesCountUserB == other.surprisesCountUserB &&
        openedAtMs == other.openedAtMs &&
        createdByUid == other.createdByUid &&
        partnerUid == other.partnerUid &&
        isUnlocked == other.isUnlocked &&
        isOpened == other.isOpened &&
        mySurprisesCount == other.mySurprisesCount &&
        partnerSurprisesCount == other.partnerSurprisesCount &&
        treasurePath == other.treasurePath;
  }

  @override
  int get hashCode => const ListEquality().hash([
        ok,
        code,
        message,
        treasureId,
        status,
        durationDays,
        maxSurprises,
        unlockAtMs,
        createdAtMs,
        surprisesCountUserA,
        surprisesCountUserB,
        openedAtMs,
        createdByUid,
        partnerUid,
        isUnlocked,
        isOpened,
        mySurprisesCount,
        partnerSurprisesCount,
        treasurePath
      ]);
}

GetLoveTreasureByIdResponseStruct createGetLoveTreasureByIdResponseStruct({
  bool? ok,
  String? code,
  String? message,
  String? treasureId,
  String? status,
  int? durationDays,
  int? maxSurprises,
  int? unlockAtMs,
  int? createdAtMs,
  int? surprisesCountUserA,
  int? surprisesCountUserB,
  int? openedAtMs,
  String? createdByUid,
  String? partnerUid,
  bool? isUnlocked,
  bool? isOpened,
  int? mySurprisesCount,
  int? partnerSurprisesCount,
  String? treasurePath,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    GetLoveTreasureByIdResponseStruct(
      ok: ok,
      code: code,
      message: message,
      treasureId: treasureId,
      status: status,
      durationDays: durationDays,
      maxSurprises: maxSurprises,
      unlockAtMs: unlockAtMs,
      createdAtMs: createdAtMs,
      surprisesCountUserA: surprisesCountUserA,
      surprisesCountUserB: surprisesCountUserB,
      openedAtMs: openedAtMs,
      createdByUid: createdByUid,
      partnerUid: partnerUid,
      isUnlocked: isUnlocked,
      isOpened: isOpened,
      mySurprisesCount: mySurprisesCount,
      partnerSurprisesCount: partnerSurprisesCount,
      treasurePath: treasurePath,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

GetLoveTreasureByIdResponseStruct? updateGetLoveTreasureByIdResponseStruct(
  GetLoveTreasureByIdResponseStruct? getLoveTreasureByIdResponse, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    getLoveTreasureByIdResponse
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addGetLoveTreasureByIdResponseStructData(
  Map<String, dynamic> firestoreData,
  GetLoveTreasureByIdResponseStruct? getLoveTreasureByIdResponse,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (getLoveTreasureByIdResponse == null) {
    return;
  }
  if (getLoveTreasureByIdResponse.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      getLoveTreasureByIdResponse.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final getLoveTreasureByIdResponseData =
      getGetLoveTreasureByIdResponseFirestoreData(
          getLoveTreasureByIdResponse, forFieldValue);
  final nestedData = getLoveTreasureByIdResponseData
      .map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      getLoveTreasureByIdResponse.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getGetLoveTreasureByIdResponseFirestoreData(
  GetLoveTreasureByIdResponseStruct? getLoveTreasureByIdResponse, [
  bool forFieldValue = false,
]) {
  if (getLoveTreasureByIdResponse == null) {
    return {};
  }
  final firestoreData = mapToFirestore(getLoveTreasureByIdResponse.toMap());

  // Add any Firestore field values
  mapToFirestore(getLoveTreasureByIdResponse.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getGetLoveTreasureByIdResponseListFirestoreData(
  List<GetLoveTreasureByIdResponseStruct>? getLoveTreasureByIdResponses,
) =>
    getLoveTreasureByIdResponses
        ?.map((e) => getGetLoveTreasureByIdResponseFirestoreData(e, true))
        .toList() ??
    [];
