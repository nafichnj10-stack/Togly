// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class DailyQuestionCFResultStruct extends FFFirebaseStruct {
  DailyQuestionCFResultStruct({
    bool? ok,
    String? code,
    String? message,
    String? state,
    String? relationshipId,
    String? dayKey,
    String? questionId,
    String? questionText,
    String? answerDocPath,
    String? answerDocId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _ok = ok,
        _code = code,
        _message = message,
        _state = state,
        _relationshipId = relationshipId,
        _dayKey = dayKey,
        _questionId = questionId,
        _questionText = questionText,
        _answerDocPath = answerDocPath,
        _answerDocId = answerDocId,
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

  // "state" field.
  String? _state;
  String get state => _state ?? '';
  set state(String? val) => _state = val;

  bool hasState() => _state != null;

  // "relationshipId" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  set relationshipId(String? val) => _relationshipId = val;

  bool hasRelationshipId() => _relationshipId != null;

  // "dayKey" field.
  String? _dayKey;
  String get dayKey => _dayKey ?? '';
  set dayKey(String? val) => _dayKey = val;

  bool hasDayKey() => _dayKey != null;

  // "questionId" field.
  String? _questionId;
  String get questionId => _questionId ?? '';
  set questionId(String? val) => _questionId = val;

  bool hasQuestionId() => _questionId != null;

  // "questionText" field.
  String? _questionText;
  String get questionText => _questionText ?? '';
  set questionText(String? val) => _questionText = val;

  bool hasQuestionText() => _questionText != null;

  // "answerDocPath" field.
  String? _answerDocPath;
  String get answerDocPath => _answerDocPath ?? '';
  set answerDocPath(String? val) => _answerDocPath = val;

  bool hasAnswerDocPath() => _answerDocPath != null;

  // "answerDocId" field.
  String? _answerDocId;
  String get answerDocId => _answerDocId ?? '';
  set answerDocId(String? val) => _answerDocId = val;

  bool hasAnswerDocId() => _answerDocId != null;

  static DailyQuestionCFResultStruct fromMap(Map<String, dynamic> data) =>
      DailyQuestionCFResultStruct(
        ok: data['ok'] as bool?,
        code: data['code'] as String?,
        message: data['message'] as String?,
        state: data['state'] as String?,
        relationshipId: data['relationshipId'] as String?,
        dayKey: data['dayKey'] as String?,
        questionId: data['questionId'] as String?,
        questionText: data['questionText'] as String?,
        answerDocPath: data['answerDocPath'] as String?,
        answerDocId: data['answerDocId'] as String?,
      );

  static DailyQuestionCFResultStruct? maybeFromMap(dynamic data) => data is Map
      ? DailyQuestionCFResultStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'ok': _ok,
        'code': _code,
        'message': _message,
        'state': _state,
        'relationshipId': _relationshipId,
        'dayKey': _dayKey,
        'questionId': _questionId,
        'questionText': _questionText,
        'answerDocPath': _answerDocPath,
        'answerDocId': _answerDocId,
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
        'state': serializeParam(
          _state,
          ParamType.String,
        ),
        'relationshipId': serializeParam(
          _relationshipId,
          ParamType.String,
        ),
        'dayKey': serializeParam(
          _dayKey,
          ParamType.String,
        ),
        'questionId': serializeParam(
          _questionId,
          ParamType.String,
        ),
        'questionText': serializeParam(
          _questionText,
          ParamType.String,
        ),
        'answerDocPath': serializeParam(
          _answerDocPath,
          ParamType.String,
        ),
        'answerDocId': serializeParam(
          _answerDocId,
          ParamType.String,
        ),
      }.withoutNulls;

  static DailyQuestionCFResultStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      DailyQuestionCFResultStruct(
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
        state: deserializeParam(
          data['state'],
          ParamType.String,
          false,
        ),
        relationshipId: deserializeParam(
          data['relationshipId'],
          ParamType.String,
          false,
        ),
        dayKey: deserializeParam(
          data['dayKey'],
          ParamType.String,
          false,
        ),
        questionId: deserializeParam(
          data['questionId'],
          ParamType.String,
          false,
        ),
        questionText: deserializeParam(
          data['questionText'],
          ParamType.String,
          false,
        ),
        answerDocPath: deserializeParam(
          data['answerDocPath'],
          ParamType.String,
          false,
        ),
        answerDocId: deserializeParam(
          data['answerDocId'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DailyQuestionCFResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DailyQuestionCFResultStruct &&
        ok == other.ok &&
        code == other.code &&
        message == other.message &&
        state == other.state &&
        relationshipId == other.relationshipId &&
        dayKey == other.dayKey &&
        questionId == other.questionId &&
        questionText == other.questionText &&
        answerDocPath == other.answerDocPath &&
        answerDocId == other.answerDocId;
  }

  @override
  int get hashCode => const ListEquality().hash([
        ok,
        code,
        message,
        state,
        relationshipId,
        dayKey,
        questionId,
        questionText,
        answerDocPath,
        answerDocId
      ]);
}

DailyQuestionCFResultStruct createDailyQuestionCFResultStruct({
  bool? ok,
  String? code,
  String? message,
  String? state,
  String? relationshipId,
  String? dayKey,
  String? questionId,
  String? questionText,
  String? answerDocPath,
  String? answerDocId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DailyQuestionCFResultStruct(
      ok: ok,
      code: code,
      message: message,
      state: state,
      relationshipId: relationshipId,
      dayKey: dayKey,
      questionId: questionId,
      questionText: questionText,
      answerDocPath: answerDocPath,
      answerDocId: answerDocId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DailyQuestionCFResultStruct? updateDailyQuestionCFResultStruct(
  DailyQuestionCFResultStruct? dailyQuestionCFResult, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    dailyQuestionCFResult
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDailyQuestionCFResultStructData(
  Map<String, dynamic> firestoreData,
  DailyQuestionCFResultStruct? dailyQuestionCFResult,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (dailyQuestionCFResult == null) {
    return;
  }
  if (dailyQuestionCFResult.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      dailyQuestionCFResult.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final dailyQuestionCFResultData = getDailyQuestionCFResultFirestoreData(
      dailyQuestionCFResult, forFieldValue);
  final nestedData =
      dailyQuestionCFResultData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      dailyQuestionCFResult.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDailyQuestionCFResultFirestoreData(
  DailyQuestionCFResultStruct? dailyQuestionCFResult, [
  bool forFieldValue = false,
]) {
  if (dailyQuestionCFResult == null) {
    return {};
  }
  final firestoreData = mapToFirestore(dailyQuestionCFResult.toMap());

  // Add any Firestore field values
  mapToFirestore(dailyQuestionCFResult.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getDailyQuestionCFResultListFirestoreData(
  List<DailyQuestionCFResultStruct>? dailyQuestionCFResults,
) =>
    dailyQuestionCFResults
        ?.map((e) => getDailyQuestionCFResultFirestoreData(e, true))
        .toList() ??
    [];
