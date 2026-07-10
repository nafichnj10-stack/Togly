// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class HeartbeatSubmitCFResultStruct extends FFFirebaseStruct {
  HeartbeatSubmitCFResultStruct({
    bool? ok,
    String? code,
    String? message,
    String? requestId,
    String? relationshipId,
    String? sessionId,
    String? status,
    bool? canViewResult,
    bool? partnerAnswered,
    bool? bothAnswered,
    bool? partner1Answered,
    bool? partner2Answered,
    String? expiresAt,
    int? remainingToday,
    double? heartbeatScoreRaw,
    int? heartbeatScorePercent,
    String? connectionLabelKey,
    String? insightTextDe,
    String? insightTextEn,
    String? insightTextEs,
    String? statusText,
    String? snackText,
    int? waitMinutes,
    int? partnerAnswer1,
    int? partnerAnswer2,
    int? partnerAnswer3,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _ok = ok,
        _code = code,
        _message = message,
        _requestId = requestId,
        _relationshipId = relationshipId,
        _sessionId = sessionId,
        _status = status,
        _canViewResult = canViewResult,
        _partnerAnswered = partnerAnswered,
        _bothAnswered = bothAnswered,
        _partner1Answered = partner1Answered,
        _partner2Answered = partner2Answered,
        _expiresAt = expiresAt,
        _remainingToday = remainingToday,
        _heartbeatScoreRaw = heartbeatScoreRaw,
        _heartbeatScorePercent = heartbeatScorePercent,
        _connectionLabelKey = connectionLabelKey,
        _insightTextDe = insightTextDe,
        _insightTextEn = insightTextEn,
        _insightTextEs = insightTextEs,
        _statusText = statusText,
        _snackText = snackText,
        _waitMinutes = waitMinutes,
        _partnerAnswer1 = partnerAnswer1,
        _partnerAnswer2 = partnerAnswer2,
        _partnerAnswer3 = partnerAnswer3,
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

  // "sessionId" field.
  String? _sessionId;
  String get sessionId => _sessionId ?? '';
  set sessionId(String? val) => _sessionId = val;

  bool hasSessionId() => _sessionId != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "canViewResult" field.
  bool? _canViewResult;
  bool get canViewResult => _canViewResult ?? false;
  set canViewResult(bool? val) => _canViewResult = val;

  bool hasCanViewResult() => _canViewResult != null;

  // "partnerAnswered" field.
  bool? _partnerAnswered;
  bool get partnerAnswered => _partnerAnswered ?? false;
  set partnerAnswered(bool? val) => _partnerAnswered = val;

  bool hasPartnerAnswered() => _partnerAnswered != null;

  // "bothAnswered" field.
  bool? _bothAnswered;
  bool get bothAnswered => _bothAnswered ?? false;
  set bothAnswered(bool? val) => _bothAnswered = val;

  bool hasBothAnswered() => _bothAnswered != null;

  // "partner1Answered" field.
  bool? _partner1Answered;
  bool get partner1Answered => _partner1Answered ?? false;
  set partner1Answered(bool? val) => _partner1Answered = val;

  bool hasPartner1Answered() => _partner1Answered != null;

  // "partner2Answered" field.
  bool? _partner2Answered;
  bool get partner2Answered => _partner2Answered ?? false;
  set partner2Answered(bool? val) => _partner2Answered = val;

  bool hasPartner2Answered() => _partner2Answered != null;

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

  // "heartbeatScoreRaw" field.
  double? _heartbeatScoreRaw;
  double get heartbeatScoreRaw => _heartbeatScoreRaw ?? 0.0;
  set heartbeatScoreRaw(double? val) => _heartbeatScoreRaw = val;

  void incrementHeartbeatScoreRaw(double amount) =>
      heartbeatScoreRaw = heartbeatScoreRaw + amount;

  bool hasHeartbeatScoreRaw() => _heartbeatScoreRaw != null;

  // "heartbeatScorePercent" field.
  int? _heartbeatScorePercent;
  int get heartbeatScorePercent => _heartbeatScorePercent ?? 0;
  set heartbeatScorePercent(int? val) => _heartbeatScorePercent = val;

  void incrementHeartbeatScorePercent(int amount) =>
      heartbeatScorePercent = heartbeatScorePercent + amount;

  bool hasHeartbeatScorePercent() => _heartbeatScorePercent != null;

  // "connectionLabelKey" field.
  String? _connectionLabelKey;
  String get connectionLabelKey => _connectionLabelKey ?? '';
  set connectionLabelKey(String? val) => _connectionLabelKey = val;

  bool hasConnectionLabelKey() => _connectionLabelKey != null;

  // "insightTextDe" field.
  String? _insightTextDe;
  String get insightTextDe => _insightTextDe ?? '';
  set insightTextDe(String? val) => _insightTextDe = val;

  bool hasInsightTextDe() => _insightTextDe != null;

  // "insightTextEn" field.
  String? _insightTextEn;
  String get insightTextEn => _insightTextEn ?? '';
  set insightTextEn(String? val) => _insightTextEn = val;

  bool hasInsightTextEn() => _insightTextEn != null;

  // "insightTextEs" field.
  String? _insightTextEs;
  String get insightTextEs => _insightTextEs ?? '';
  set insightTextEs(String? val) => _insightTextEs = val;

  bool hasInsightTextEs() => _insightTextEs != null;

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

  // "partnerAnswer1" field.
  int? _partnerAnswer1;
  int get partnerAnswer1 => _partnerAnswer1 ?? 0;
  set partnerAnswer1(int? val) => _partnerAnswer1 = val;

  void incrementPartnerAnswer1(int amount) =>
      partnerAnswer1 = partnerAnswer1 + amount;

  bool hasPartnerAnswer1() => _partnerAnswer1 != null;

  // "partnerAnswer2" field.
  int? _partnerAnswer2;
  int get partnerAnswer2 => _partnerAnswer2 ?? 0;
  set partnerAnswer2(int? val) => _partnerAnswer2 = val;

  void incrementPartnerAnswer2(int amount) =>
      partnerAnswer2 = partnerAnswer2 + amount;

  bool hasPartnerAnswer2() => _partnerAnswer2 != null;

  // "partnerAnswer3" field.
  int? _partnerAnswer3;
  int get partnerAnswer3 => _partnerAnswer3 ?? 0;
  set partnerAnswer3(int? val) => _partnerAnswer3 = val;

  void incrementPartnerAnswer3(int amount) =>
      partnerAnswer3 = partnerAnswer3 + amount;

  bool hasPartnerAnswer3() => _partnerAnswer3 != null;

  static HeartbeatSubmitCFResultStruct fromMap(Map<String, dynamic> data) =>
      HeartbeatSubmitCFResultStruct(
        ok: data['ok'] as bool?,
        code: data['code'] as String?,
        message: data['message'] as String?,
        requestId: data['requestId'] as String?,
        relationshipId: data['relationshipId'] as String?,
        sessionId: data['sessionId'] as String?,
        status: data['status'] as String?,
        canViewResult: data['canViewResult'] as bool?,
        partnerAnswered: data['partnerAnswered'] as bool?,
        bothAnswered: data['bothAnswered'] as bool?,
        partner1Answered: data['partner1Answered'] as bool?,
        partner2Answered: data['partner2Answered'] as bool?,
        expiresAt: data['expiresAt'] as String?,
        remainingToday: castToType<int>(data['remainingToday']),
        heartbeatScoreRaw: castToType<double>(data['heartbeatScoreRaw']),
        heartbeatScorePercent: castToType<int>(data['heartbeatScorePercent']),
        connectionLabelKey: data['connectionLabelKey'] as String?,
        insightTextDe: data['insightTextDe'] as String?,
        insightTextEn: data['insightTextEn'] as String?,
        insightTextEs: data['insightTextEs'] as String?,
        statusText: data['statusText'] as String?,
        snackText: data['snackText'] as String?,
        waitMinutes: castToType<int>(data['waitMinutes']),
        partnerAnswer1: castToType<int>(data['partnerAnswer1']),
        partnerAnswer2: castToType<int>(data['partnerAnswer2']),
        partnerAnswer3: castToType<int>(data['partnerAnswer3']),
      );

  static HeartbeatSubmitCFResultStruct? maybeFromMap(dynamic data) =>
      data is Map
          ? HeartbeatSubmitCFResultStruct.fromMap(data.cast<String, dynamic>())
          : null;

  Map<String, dynamic> toMap() => {
        'ok': _ok,
        'code': _code,
        'message': _message,
        'requestId': _requestId,
        'relationshipId': _relationshipId,
        'sessionId': _sessionId,
        'status': _status,
        'canViewResult': _canViewResult,
        'partnerAnswered': _partnerAnswered,
        'bothAnswered': _bothAnswered,
        'partner1Answered': _partner1Answered,
        'partner2Answered': _partner2Answered,
        'expiresAt': _expiresAt,
        'remainingToday': _remainingToday,
        'heartbeatScoreRaw': _heartbeatScoreRaw,
        'heartbeatScorePercent': _heartbeatScorePercent,
        'connectionLabelKey': _connectionLabelKey,
        'insightTextDe': _insightTextDe,
        'insightTextEn': _insightTextEn,
        'insightTextEs': _insightTextEs,
        'statusText': _statusText,
        'snackText': _snackText,
        'waitMinutes': _waitMinutes,
        'partnerAnswer1': _partnerAnswer1,
        'partnerAnswer2': _partnerAnswer2,
        'partnerAnswer3': _partnerAnswer3,
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
        'sessionId': serializeParam(
          _sessionId,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'canViewResult': serializeParam(
          _canViewResult,
          ParamType.bool,
        ),
        'partnerAnswered': serializeParam(
          _partnerAnswered,
          ParamType.bool,
        ),
        'bothAnswered': serializeParam(
          _bothAnswered,
          ParamType.bool,
        ),
        'partner1Answered': serializeParam(
          _partner1Answered,
          ParamType.bool,
        ),
        'partner2Answered': serializeParam(
          _partner2Answered,
          ParamType.bool,
        ),
        'expiresAt': serializeParam(
          _expiresAt,
          ParamType.String,
        ),
        'remainingToday': serializeParam(
          _remainingToday,
          ParamType.int,
        ),
        'heartbeatScoreRaw': serializeParam(
          _heartbeatScoreRaw,
          ParamType.double,
        ),
        'heartbeatScorePercent': serializeParam(
          _heartbeatScorePercent,
          ParamType.int,
        ),
        'connectionLabelKey': serializeParam(
          _connectionLabelKey,
          ParamType.String,
        ),
        'insightTextDe': serializeParam(
          _insightTextDe,
          ParamType.String,
        ),
        'insightTextEn': serializeParam(
          _insightTextEn,
          ParamType.String,
        ),
        'insightTextEs': serializeParam(
          _insightTextEs,
          ParamType.String,
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
        'partnerAnswer1': serializeParam(
          _partnerAnswer1,
          ParamType.int,
        ),
        'partnerAnswer2': serializeParam(
          _partnerAnswer2,
          ParamType.int,
        ),
        'partnerAnswer3': serializeParam(
          _partnerAnswer3,
          ParamType.int,
        ),
      }.withoutNulls;

  static HeartbeatSubmitCFResultStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      HeartbeatSubmitCFResultStruct(
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
        sessionId: deserializeParam(
          data['sessionId'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        canViewResult: deserializeParam(
          data['canViewResult'],
          ParamType.bool,
          false,
        ),
        partnerAnswered: deserializeParam(
          data['partnerAnswered'],
          ParamType.bool,
          false,
        ),
        bothAnswered: deserializeParam(
          data['bothAnswered'],
          ParamType.bool,
          false,
        ),
        partner1Answered: deserializeParam(
          data['partner1Answered'],
          ParamType.bool,
          false,
        ),
        partner2Answered: deserializeParam(
          data['partner2Answered'],
          ParamType.bool,
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
        heartbeatScoreRaw: deserializeParam(
          data['heartbeatScoreRaw'],
          ParamType.double,
          false,
        ),
        heartbeatScorePercent: deserializeParam(
          data['heartbeatScorePercent'],
          ParamType.int,
          false,
        ),
        connectionLabelKey: deserializeParam(
          data['connectionLabelKey'],
          ParamType.String,
          false,
        ),
        insightTextDe: deserializeParam(
          data['insightTextDe'],
          ParamType.String,
          false,
        ),
        insightTextEn: deserializeParam(
          data['insightTextEn'],
          ParamType.String,
          false,
        ),
        insightTextEs: deserializeParam(
          data['insightTextEs'],
          ParamType.String,
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
        partnerAnswer1: deserializeParam(
          data['partnerAnswer1'],
          ParamType.int,
          false,
        ),
        partnerAnswer2: deserializeParam(
          data['partnerAnswer2'],
          ParamType.int,
          false,
        ),
        partnerAnswer3: deserializeParam(
          data['partnerAnswer3'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'HeartbeatSubmitCFResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is HeartbeatSubmitCFResultStruct &&
        ok == other.ok &&
        code == other.code &&
        message == other.message &&
        requestId == other.requestId &&
        relationshipId == other.relationshipId &&
        sessionId == other.sessionId &&
        status == other.status &&
        canViewResult == other.canViewResult &&
        partnerAnswered == other.partnerAnswered &&
        bothAnswered == other.bothAnswered &&
        partner1Answered == other.partner1Answered &&
        partner2Answered == other.partner2Answered &&
        expiresAt == other.expiresAt &&
        remainingToday == other.remainingToday &&
        heartbeatScoreRaw == other.heartbeatScoreRaw &&
        heartbeatScorePercent == other.heartbeatScorePercent &&
        connectionLabelKey == other.connectionLabelKey &&
        insightTextDe == other.insightTextDe &&
        insightTextEn == other.insightTextEn &&
        insightTextEs == other.insightTextEs &&
        statusText == other.statusText &&
        snackText == other.snackText &&
        waitMinutes == other.waitMinutes &&
        partnerAnswer1 == other.partnerAnswer1 &&
        partnerAnswer2 == other.partnerAnswer2 &&
        partnerAnswer3 == other.partnerAnswer3;
  }

  @override
  int get hashCode => const ListEquality().hash([
        ok,
        code,
        message,
        requestId,
        relationshipId,
        sessionId,
        status,
        canViewResult,
        partnerAnswered,
        bothAnswered,
        partner1Answered,
        partner2Answered,
        expiresAt,
        remainingToday,
        heartbeatScoreRaw,
        heartbeatScorePercent,
        connectionLabelKey,
        insightTextDe,
        insightTextEn,
        insightTextEs,
        statusText,
        snackText,
        waitMinutes,
        partnerAnswer1,
        partnerAnswer2,
        partnerAnswer3
      ]);
}

HeartbeatSubmitCFResultStruct createHeartbeatSubmitCFResultStruct({
  bool? ok,
  String? code,
  String? message,
  String? requestId,
  String? relationshipId,
  String? sessionId,
  String? status,
  bool? canViewResult,
  bool? partnerAnswered,
  bool? bothAnswered,
  bool? partner1Answered,
  bool? partner2Answered,
  String? expiresAt,
  int? remainingToday,
  double? heartbeatScoreRaw,
  int? heartbeatScorePercent,
  String? connectionLabelKey,
  String? insightTextDe,
  String? insightTextEn,
  String? insightTextEs,
  String? statusText,
  String? snackText,
  int? waitMinutes,
  int? partnerAnswer1,
  int? partnerAnswer2,
  int? partnerAnswer3,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    HeartbeatSubmitCFResultStruct(
      ok: ok,
      code: code,
      message: message,
      requestId: requestId,
      relationshipId: relationshipId,
      sessionId: sessionId,
      status: status,
      canViewResult: canViewResult,
      partnerAnswered: partnerAnswered,
      bothAnswered: bothAnswered,
      partner1Answered: partner1Answered,
      partner2Answered: partner2Answered,
      expiresAt: expiresAt,
      remainingToday: remainingToday,
      heartbeatScoreRaw: heartbeatScoreRaw,
      heartbeatScorePercent: heartbeatScorePercent,
      connectionLabelKey: connectionLabelKey,
      insightTextDe: insightTextDe,
      insightTextEn: insightTextEn,
      insightTextEs: insightTextEs,
      statusText: statusText,
      snackText: snackText,
      waitMinutes: waitMinutes,
      partnerAnswer1: partnerAnswer1,
      partnerAnswer2: partnerAnswer2,
      partnerAnswer3: partnerAnswer3,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

HeartbeatSubmitCFResultStruct? updateHeartbeatSubmitCFResultStruct(
  HeartbeatSubmitCFResultStruct? heartbeatSubmitCFResult, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    heartbeatSubmitCFResult
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addHeartbeatSubmitCFResultStructData(
  Map<String, dynamic> firestoreData,
  HeartbeatSubmitCFResultStruct? heartbeatSubmitCFResult,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (heartbeatSubmitCFResult == null) {
    return;
  }
  if (heartbeatSubmitCFResult.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      heartbeatSubmitCFResult.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final heartbeatSubmitCFResultData = getHeartbeatSubmitCFResultFirestoreData(
      heartbeatSubmitCFResult, forFieldValue);
  final nestedData =
      heartbeatSubmitCFResultData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      heartbeatSubmitCFResult.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getHeartbeatSubmitCFResultFirestoreData(
  HeartbeatSubmitCFResultStruct? heartbeatSubmitCFResult, [
  bool forFieldValue = false,
]) {
  if (heartbeatSubmitCFResult == null) {
    return {};
  }
  final firestoreData = mapToFirestore(heartbeatSubmitCFResult.toMap());

  // Add any Firestore field values
  mapToFirestore(heartbeatSubmitCFResult.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getHeartbeatSubmitCFResultListFirestoreData(
  List<HeartbeatSubmitCFResultStruct>? heartbeatSubmitCFResults,
) =>
    heartbeatSubmitCFResults
        ?.map((e) => getHeartbeatSubmitCFResultFirestoreData(e, true))
        .toList() ??
    [];
