// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CFResultStruct extends FFFirebaseStruct {
  CFResultStruct({
    bool? ok,
    String? code,
    String? message,
    String? requestId,
    String? relationshipId,
    String? status,
    String? expiresAt,
    int? remainingToday,
    int? cooldownUntilMs,
    int? lastAtMs,
    String? statusText,
    String? snackText,
    int? waitMinutes,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _ok = ok,
        _code = code,
        _message = message,
        _requestId = requestId,
        _relationshipId = relationshipId,
        _status = status,
        _expiresAt = expiresAt,
        _remainingToday = remainingToday,
        _cooldownUntilMs = cooldownUntilMs,
        _lastAtMs = lastAtMs,
        _statusText = statusText,
        _snackText = snackText,
        _waitMinutes = waitMinutes,
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

  // "requestId" field.
  String? _requestId;
  String get requestId => _requestId ?? '';
  set requestId(String? val) => _requestId = val;

  bool hasRequestId() => _requestId != null;

  // "relationshipId" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  set relationshipId(String? val) => _relationshipId = val;

  bool hasRelationshipId() => _relationshipId != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "expiresAt" field.
  String? _expiresAt;
  String get expiresAt => _expiresAt ?? '';
  set expiresAt(String? val) => _expiresAt = val;

  bool hasExpiresAt() => _expiresAt != null;

  // "remainingToday" field.
  int? _remainingToday;
  int get remainingToday => _remainingToday ?? 0;
  set remainingToday(int? val) => _remainingToday = val;

  void incrementRemainingToday(int amount) =>
      remainingToday = remainingToday + amount;

  bool hasRemainingToday() => _remainingToday != null;

  // "cooldownUntilMs" field.
  int? _cooldownUntilMs;
  int get cooldownUntilMs => _cooldownUntilMs ?? 0;
  set cooldownUntilMs(int? val) => _cooldownUntilMs = val;

  void incrementCooldownUntilMs(int amount) =>
      cooldownUntilMs = cooldownUntilMs + amount;

  bool hasCooldownUntilMs() => _cooldownUntilMs != null;

  // "lastAtMs" field.
  int? _lastAtMs;
  int get lastAtMs => _lastAtMs ?? 0;
  set lastAtMs(int? val) => _lastAtMs = val;

  void incrementLastAtMs(int amount) => lastAtMs = lastAtMs + amount;

  bool hasLastAtMs() => _lastAtMs != null;

  // "statusText" field.
  String? _statusText;
  String get statusText => _statusText ?? '';
  set statusText(String? val) => _statusText = val;

  bool hasStatusText() => _statusText != null;

  // "snackText" field.
  String? _snackText;
  String get snackText => _snackText ?? '';
  set snackText(String? val) => _snackText = val;

  bool hasSnackText() => _snackText != null;

  // "waitMinutes" field.
  int? _waitMinutes;
  int get waitMinutes => _waitMinutes ?? 0;
  set waitMinutes(int? val) => _waitMinutes = val;

  void incrementWaitMinutes(int amount) => waitMinutes = waitMinutes + amount;

  bool hasWaitMinutes() => _waitMinutes != null;

  static CFResultStruct fromMap(Map<String, dynamic> data) => CFResultStruct(
        ok: data['ok'] as bool?,
        code: data['code'] as String?,
        message: data['message'] as String?,
        requestId: data['requestId'] as String?,
        relationshipId: data['relationshipId'] as String?,
        status: data['status'] as String?,
        expiresAt: data['expiresAt'] as String?,
        remainingToday: castToType<int>(data['remainingToday']),
        cooldownUntilMs: castToType<int>(data['cooldownUntilMs']),
        lastAtMs: castToType<int>(data['lastAtMs']),
        statusText: data['statusText'] as String?,
        snackText: data['snackText'] as String?,
        waitMinutes: castToType<int>(data['waitMinutes']),
      );

  static CFResultStruct? maybeFromMap(dynamic data) =>
      data is Map ? CFResultStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'ok': _ok,
        'code': _code,
        'message': _message,
        'requestId': _requestId,
        'relationshipId': _relationshipId,
        'status': _status,
        'expiresAt': _expiresAt,
        'remainingToday': _remainingToday,
        'cooldownUntilMs': _cooldownUntilMs,
        'lastAtMs': _lastAtMs,
        'statusText': _statusText,
        'snackText': _snackText,
        'waitMinutes': _waitMinutes,
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
        'requestId': serializeParam(
          _requestId,
          ParamType.String,
        ),
        'relationshipId': serializeParam(
          _relationshipId,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'expiresAt': serializeParam(
          _expiresAt,
          ParamType.String,
        ),
        'remainingToday': serializeParam(
          _remainingToday,
          ParamType.int,
        ),
        'cooldownUntilMs': serializeParam(
          _cooldownUntilMs,
          ParamType.int,
        ),
        'lastAtMs': serializeParam(
          _lastAtMs,
          ParamType.int,
        ),
        'statusText': serializeParam(
          _statusText,
          ParamType.String,
        ),
        'snackText': serializeParam(
          _snackText,
          ParamType.String,
        ),
        'waitMinutes': serializeParam(
          _waitMinutes,
          ParamType.int,
        ),
      }.withoutNulls;

  static CFResultStruct fromSerializableMap(Map<String, dynamic> data) =>
      CFResultStruct(
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
        requestId: deserializeParam(
          data['requestId'],
          ParamType.String,
          false,
        ),
        relationshipId: deserializeParam(
          data['relationshipId'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        expiresAt: deserializeParam(
          data['expiresAt'],
          ParamType.String,
          false,
        ),
        remainingToday: deserializeParam(
          data['remainingToday'],
          ParamType.int,
          false,
        ),
        cooldownUntilMs: deserializeParam(
          data['cooldownUntilMs'],
          ParamType.int,
          false,
        ),
        lastAtMs: deserializeParam(
          data['lastAtMs'],
          ParamType.int,
          false,
        ),
        statusText: deserializeParam(
          data['statusText'],
          ParamType.String,
          false,
        ),
        snackText: deserializeParam(
          data['snackText'],
          ParamType.String,
          false,
        ),
        waitMinutes: deserializeParam(
          data['waitMinutes'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'CFResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CFResultStruct &&
        ok == other.ok &&
        code == other.code &&
        message == other.message &&
        requestId == other.requestId &&
        relationshipId == other.relationshipId &&
        status == other.status &&
        expiresAt == other.expiresAt &&
        remainingToday == other.remainingToday &&
        cooldownUntilMs == other.cooldownUntilMs &&
        lastAtMs == other.lastAtMs &&
        statusText == other.statusText &&
        snackText == other.snackText &&
        waitMinutes == other.waitMinutes;
  }

  @override
  int get hashCode => const ListEquality().hash([
        ok,
        code,
        message,
        requestId,
        relationshipId,
        status,
        expiresAt,
        remainingToday,
        cooldownUntilMs,
        lastAtMs,
        statusText,
        snackText,
        waitMinutes
      ]);
}

CFResultStruct createCFResultStruct({
  bool? ok,
  String? code,
  String? message,
  String? requestId,
  String? relationshipId,
  String? status,
  String? expiresAt,
  int? remainingToday,
  int? cooldownUntilMs,
  int? lastAtMs,
  String? statusText,
  String? snackText,
  int? waitMinutes,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CFResultStruct(
      ok: ok,
      code: code,
      message: message,
      requestId: requestId,
      relationshipId: relationshipId,
      status: status,
      expiresAt: expiresAt,
      remainingToday: remainingToday,
      cooldownUntilMs: cooldownUntilMs,
      lastAtMs: lastAtMs,
      statusText: statusText,
      snackText: snackText,
      waitMinutes: waitMinutes,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CFResultStruct? updateCFResultStruct(
  CFResultStruct? cFResult, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    cFResult
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCFResultStructData(
  Map<String, dynamic> firestoreData,
  CFResultStruct? cFResult,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (cFResult == null) {
    return;
  }
  if (cFResult.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && cFResult.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final cFResultData = getCFResultFirestoreData(cFResult, forFieldValue);
  final nestedData = cFResultData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = cFResult.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCFResultFirestoreData(
  CFResultStruct? cFResult, [
  bool forFieldValue = false,
]) {
  if (cFResult == null) {
    return {};
  }
  final firestoreData = mapToFirestore(cFResult.toMap());

  // Add any Firestore field values
  mapToFirestore(cFResult.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCFResultListFirestoreData(
  List<CFResultStruct>? cFResults,
) =>
    cFResults?.map((e) => getCFResultFirestoreData(e, true)).toList() ?? [];
