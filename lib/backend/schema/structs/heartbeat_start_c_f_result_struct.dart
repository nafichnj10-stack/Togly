// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HeartbeatStartCFResultStruct extends FFFirebaseStruct {
  HeartbeatStartCFResultStruct({
    bool? ok,
    String? code,
    String? message,
    String? requestId,
    String? relationshipId,
    String? sessionId,
    String? sessionRefPath,
    String? status,
    String? expiresAt,
    int? remainingToday,
    bool? created,
    String? statusText,
    String? snackText,
    int? waitMinutes,
    List<HeartbeatQuestionCFItemStruct>? questions,
    String? question1TextEn,
    String? question2TextEn,
    String? question3TextEn,
    String? question1TextDe,
    String? question2TextDe,
    String? question3TextDe,
    String? question1TextEs,
    String? question2TextEs,
    String? question3TextEs,
    double? partnerAnswer1,
    double? partnerAnswer2,
    double? partnerAnswer3,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _ok = ok,
        _code = code,
        _message = message,
        _requestId = requestId,
        _relationshipId = relationshipId,
        _sessionId = sessionId,
        _sessionRefPath = sessionRefPath,
        _status = status,
        _expiresAt = expiresAt,
        _remainingToday = remainingToday,
        _created = created,
        _statusText = statusText,
        _snackText = snackText,
        _waitMinutes = waitMinutes,
        _questions = questions,
        _question1TextEn = question1TextEn,
        _question2TextEn = question2TextEn,
        _question3TextEn = question3TextEn,
        _question1TextDe = question1TextDe,
        _question2TextDe = question2TextDe,
        _question3TextDe = question3TextDe,
        _question1TextEs = question1TextEs,
        _question2TextEs = question2TextEs,
        _question3TextEs = question3TextEs,
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

  // "sessionRefPath" field.
  String? _sessionRefPath;
  String get sessionRefPath => _sessionRefPath ?? '';
  set sessionRefPath(String? val) => _sessionRefPath = val;

  bool hasSessionRefPath() => _sessionRefPath != null;

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

  // "created" field.
  bool? _created;
  bool get created => _created ?? false;
  set created(bool? val) => _created = val;

  bool hasCreated() => _created != null;

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

  // "questions" field.
  List<HeartbeatQuestionCFItemStruct>? _questions;
  List<HeartbeatQuestionCFItemStruct> get questions => _questions ?? const [];
  set questions(List<HeartbeatQuestionCFItemStruct>? val) => _questions = val;

  void updateQuestions(Function(List<HeartbeatQuestionCFItemStruct>) updateFn) {
    updateFn(_questions ??= []);
  }

  bool hasQuestions() => _questions != null;

  // "question1TextEn" field.
  String? _question1TextEn;
  String get question1TextEn => _question1TextEn ?? '';
  set question1TextEn(String? val) => _question1TextEn = val;

  bool hasQuestion1TextEn() => _question1TextEn != null;

  // "question2TextEn" field.
  String? _question2TextEn;
  String get question2TextEn => _question2TextEn ?? '';
  set question2TextEn(String? val) => _question2TextEn = val;

  bool hasQuestion2TextEn() => _question2TextEn != null;

  // "question3TextEn" field.
  String? _question3TextEn;
  String get question3TextEn => _question3TextEn ?? '';
  set question3TextEn(String? val) => _question3TextEn = val;

  bool hasQuestion3TextEn() => _question3TextEn != null;

  // "question1TextDe" field.
  String? _question1TextDe;
  String get question1TextDe => _question1TextDe ?? '';
  set question1TextDe(String? val) => _question1TextDe = val;

  bool hasQuestion1TextDe() => _question1TextDe != null;

  // "question2TextDe" field.
  String? _question2TextDe;
  String get question2TextDe => _question2TextDe ?? '';
  set question2TextDe(String? val) => _question2TextDe = val;

  bool hasQuestion2TextDe() => _question2TextDe != null;

  // "question3TextDe" field.
  String? _question3TextDe;
  String get question3TextDe => _question3TextDe ?? '';
  set question3TextDe(String? val) => _question3TextDe = val;

  bool hasQuestion3TextDe() => _question3TextDe != null;

  // "question1TextEs" field.
  String? _question1TextEs;
  String get question1TextEs => _question1TextEs ?? '';
  set question1TextEs(String? val) => _question1TextEs = val;

  bool hasQuestion1TextEs() => _question1TextEs != null;

  // "question2TextEs" field.
  String? _question2TextEs;
  String get question2TextEs => _question2TextEs ?? '';
  set question2TextEs(String? val) => _question2TextEs = val;

  bool hasQuestion2TextEs() => _question2TextEs != null;

  // "question3TextEs" field.
  String? _question3TextEs;
  String get question3TextEs => _question3TextEs ?? '';
  set question3TextEs(String? val) => _question3TextEs = val;

  bool hasQuestion3TextEs() => _question3TextEs != null;

  // "partnerAnswer1" field.
  double? _partnerAnswer1;
  double get partnerAnswer1 => _partnerAnswer1 ?? 0.0;
  set partnerAnswer1(double? val) => _partnerAnswer1 = val;

  void incrementPartnerAnswer1(double amount) =>
      partnerAnswer1 = partnerAnswer1 + amount;

  bool hasPartnerAnswer1() => _partnerAnswer1 != null;

  // "partnerAnswer2" field.
  double? _partnerAnswer2;
  double get partnerAnswer2 => _partnerAnswer2 ?? 0.0;
  set partnerAnswer2(double? val) => _partnerAnswer2 = val;

  void incrementPartnerAnswer2(double amount) =>
      partnerAnswer2 = partnerAnswer2 + amount;

  bool hasPartnerAnswer2() => _partnerAnswer2 != null;

  // "partnerAnswer3" field.
  double? _partnerAnswer3;
  double get partnerAnswer3 => _partnerAnswer3 ?? 0.0;
  set partnerAnswer3(double? val) => _partnerAnswer3 = val;

  void incrementPartnerAnswer3(double amount) =>
      partnerAnswer3 = partnerAnswer3 + amount;

  bool hasPartnerAnswer3() => _partnerAnswer3 != null;

  static HeartbeatStartCFResultStruct fromMap(Map<String, dynamic> data) =>
      HeartbeatStartCFResultStruct(
        ok: data['ok'] as bool?,
        code: data['code'] as String?,
        message: data['message'] as String?,
        requestId: data['requestId'] as String?,
        relationshipId: data['relationshipId'] as String?,
        sessionId: data['sessionId'] as String?,
        sessionRefPath: data['sessionRefPath'] as String?,
        status: data['status'] as String?,
        expiresAt: data['expiresAt'] as String?,
        remainingToday: castToType<int>(data['remainingToday']),
        created: data['created'] as bool?,
        statusText: data['statusText'] as String?,
        snackText: data['snackText'] as String?,
        waitMinutes: castToType<int>(data['waitMinutes']),
        questions: getStructList(
          data['questions'],
          HeartbeatQuestionCFItemStruct.fromMap,
        ),
        question1TextEn: data['question1TextEn'] as String?,
        question2TextEn: data['question2TextEn'] as String?,
        question3TextEn: data['question3TextEn'] as String?,
        question1TextDe: data['question1TextDe'] as String?,
        question2TextDe: data['question2TextDe'] as String?,
        question3TextDe: data['question3TextDe'] as String?,
        question1TextEs: data['question1TextEs'] as String?,
        question2TextEs: data['question2TextEs'] as String?,
        question3TextEs: data['question3TextEs'] as String?,
        partnerAnswer1: castToType<double>(data['partnerAnswer1']),
        partnerAnswer2: castToType<double>(data['partnerAnswer2']),
        partnerAnswer3: castToType<double>(data['partnerAnswer3']),
      );

  static HeartbeatStartCFResultStruct? maybeFromMap(dynamic data) => data is Map
      ? HeartbeatStartCFResultStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'ok': _ok,
        'code': _code,
        'message': _message,
        'requestId': _requestId,
        'relationshipId': _relationshipId,
        'sessionId': _sessionId,
        'sessionRefPath': _sessionRefPath,
        'status': _status,
        'expiresAt': _expiresAt,
        'remainingToday': _remainingToday,
        'created': _created,
        'statusText': _statusText,
        'snackText': _snackText,
        'waitMinutes': _waitMinutes,
        'questions': _questions?.map((e) => e.toMap()).toList(),
        'question1TextEn': _question1TextEn,
        'question2TextEn': _question2TextEn,
        'question3TextEn': _question3TextEn,
        'question1TextDe': _question1TextDe,
        'question2TextDe': _question2TextDe,
        'question3TextDe': _question3TextDe,
        'question1TextEs': _question1TextEs,
        'question2TextEs': _question2TextEs,
        'question3TextEs': _question3TextEs,
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
        'sessionRefPath': serializeParam(
          _sessionRefPath,
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
        'created': serializeParam(
          _created,
          ParamType.bool,
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
        'questions': serializeParam(
          _questions,
          ParamType.DataStruct,
          isList: true,
        ),
        'question1TextEn': serializeParam(
          _question1TextEn,
          ParamType.String,
        ),
        'question2TextEn': serializeParam(
          _question2TextEn,
          ParamType.String,
        ),
        'question3TextEn': serializeParam(
          _question3TextEn,
          ParamType.String,
        ),
        'question1TextDe': serializeParam(
          _question1TextDe,
          ParamType.String,
        ),
        'question2TextDe': serializeParam(
          _question2TextDe,
          ParamType.String,
        ),
        'question3TextDe': serializeParam(
          _question3TextDe,
          ParamType.String,
        ),
        'question1TextEs': serializeParam(
          _question1TextEs,
          ParamType.String,
        ),
        'question2TextEs': serializeParam(
          _question2TextEs,
          ParamType.String,
        ),
        'question3TextEs': serializeParam(
          _question3TextEs,
          ParamType.String,
        ),
        'partnerAnswer1': serializeParam(
          _partnerAnswer1,
          ParamType.double,
        ),
        'partnerAnswer2': serializeParam(
          _partnerAnswer2,
          ParamType.double,
        ),
        'partnerAnswer3': serializeParam(
          _partnerAnswer3,
          ParamType.double,
        ),
      }.withoutNulls;

  static HeartbeatStartCFResultStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      HeartbeatStartCFResultStruct(
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
        sessionRefPath: deserializeParam(
          data['sessionRefPath'],
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
        created: deserializeParam(
          data['created'],
          ParamType.bool,
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
        questions: deserializeStructParam<HeartbeatQuestionCFItemStruct>(
          data['questions'],
          ParamType.DataStruct,
          true,
          structBuilder: HeartbeatQuestionCFItemStruct.fromSerializableMap,
        ),
        question1TextEn: deserializeParam(
          data['question1TextEn'],
          ParamType.String,
          false,
        ),
        question2TextEn: deserializeParam(
          data['question2TextEn'],
          ParamType.String,
          false,
        ),
        question3TextEn: deserializeParam(
          data['question3TextEn'],
          ParamType.String,
          false,
        ),
        question1TextDe: deserializeParam(
          data['question1TextDe'],
          ParamType.String,
          false,
        ),
        question2TextDe: deserializeParam(
          data['question2TextDe'],
          ParamType.String,
          false,
        ),
        question3TextDe: deserializeParam(
          data['question3TextDe'],
          ParamType.String,
          false,
        ),
        question1TextEs: deserializeParam(
          data['question1TextEs'],
          ParamType.String,
          false,
        ),
        question2TextEs: deserializeParam(
          data['question2TextEs'],
          ParamType.String,
          false,
        ),
        question3TextEs: deserializeParam(
          data['question3TextEs'],
          ParamType.String,
          false,
        ),
        partnerAnswer1: deserializeParam(
          data['partnerAnswer1'],
          ParamType.double,
          false,
        ),
        partnerAnswer2: deserializeParam(
          data['partnerAnswer2'],
          ParamType.double,
          false,
        ),
        partnerAnswer3: deserializeParam(
          data['partnerAnswer3'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'HeartbeatStartCFResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is HeartbeatStartCFResultStruct &&
        ok == other.ok &&
        code == other.code &&
        message == other.message &&
        requestId == other.requestId &&
        relationshipId == other.relationshipId &&
        sessionId == other.sessionId &&
        sessionRefPath == other.sessionRefPath &&
        status == other.status &&
        expiresAt == other.expiresAt &&
        remainingToday == other.remainingToday &&
        created == other.created &&
        statusText == other.statusText &&
        snackText == other.snackText &&
        waitMinutes == other.waitMinutes &&
        listEquality.equals(questions, other.questions) &&
        question1TextEn == other.question1TextEn &&
        question2TextEn == other.question2TextEn &&
        question3TextEn == other.question3TextEn &&
        question1TextDe == other.question1TextDe &&
        question2TextDe == other.question2TextDe &&
        question3TextDe == other.question3TextDe &&
        question1TextEs == other.question1TextEs &&
        question2TextEs == other.question2TextEs &&
        question3TextEs == other.question3TextEs &&
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
        sessionRefPath,
        status,
        expiresAt,
        remainingToday,
        created,
        statusText,
        snackText,
        waitMinutes,
        questions,
        question1TextEn,
        question2TextEn,
        question3TextEn,
        question1TextDe,
        question2TextDe,
        question3TextDe,
        question1TextEs,
        question2TextEs,
        question3TextEs,
        partnerAnswer1,
        partnerAnswer2,
        partnerAnswer3
      ]);
}

HeartbeatStartCFResultStruct createHeartbeatStartCFResultStruct({
  bool? ok,
  String? code,
  String? message,
  String? requestId,
  String? relationshipId,
  String? sessionId,
  String? sessionRefPath,
  String? status,
  String? expiresAt,
  int? remainingToday,
  bool? created,
  String? statusText,
  String? snackText,
  int? waitMinutes,
  String? question1TextEn,
  String? question2TextEn,
  String? question3TextEn,
  String? question1TextDe,
  String? question2TextDe,
  String? question3TextDe,
  String? question1TextEs,
  String? question2TextEs,
  String? question3TextEs,
  double? partnerAnswer1,
  double? partnerAnswer2,
  double? partnerAnswer3,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    HeartbeatStartCFResultStruct(
      ok: ok,
      code: code,
      message: message,
      requestId: requestId,
      relationshipId: relationshipId,
      sessionId: sessionId,
      sessionRefPath: sessionRefPath,
      status: status,
      expiresAt: expiresAt,
      remainingToday: remainingToday,
      created: created,
      statusText: statusText,
      snackText: snackText,
      waitMinutes: waitMinutes,
      question1TextEn: question1TextEn,
      question2TextEn: question2TextEn,
      question3TextEn: question3TextEn,
      question1TextDe: question1TextDe,
      question2TextDe: question2TextDe,
      question3TextDe: question3TextDe,
      question1TextEs: question1TextEs,
      question2TextEs: question2TextEs,
      question3TextEs: question3TextEs,
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

HeartbeatStartCFResultStruct? updateHeartbeatStartCFResultStruct(
  HeartbeatStartCFResultStruct? heartbeatStartCFResult, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    heartbeatStartCFResult
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addHeartbeatStartCFResultStructData(
  Map<String, dynamic> firestoreData,
  HeartbeatStartCFResultStruct? heartbeatStartCFResult,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (heartbeatStartCFResult == null) {
    return;
  }
  if (heartbeatStartCFResult.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      heartbeatStartCFResult.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final heartbeatStartCFResultData = getHeartbeatStartCFResultFirestoreData(
      heartbeatStartCFResult, forFieldValue);
  final nestedData =
      heartbeatStartCFResultData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      heartbeatStartCFResult.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getHeartbeatStartCFResultFirestoreData(
  HeartbeatStartCFResultStruct? heartbeatStartCFResult, [
  bool forFieldValue = false,
]) {
  if (heartbeatStartCFResult == null) {
    return {};
  }
  final firestoreData = mapToFirestore(heartbeatStartCFResult.toMap());

  // Add any Firestore field values
  mapToFirestore(heartbeatStartCFResult.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getHeartbeatStartCFResultListFirestoreData(
  List<HeartbeatStartCFResultStruct>? heartbeatStartCFResults,
) =>
    heartbeatStartCFResults
        ?.map((e) => getHeartbeatStartCFResultFirestoreData(e, true))
        .toList() ??
    [];
