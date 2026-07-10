// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CFEmotionResultStruct extends FFFirebaseStruct {
  CFEmotionResultStruct({
    bool? ok,
    String? code,
    String? state,
    String? myChoice,
    String? partnerChoice,
    String? summaryText,
    String? statusText,
    String? snackText,
    int? expiresAtMs,
    int? cooldownUntilMs,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _ok = ok,
        _code = code,
        _state = state,
        _myChoice = myChoice,
        _partnerChoice = partnerChoice,
        _summaryText = summaryText,
        _statusText = statusText,
        _snackText = snackText,
        _expiresAtMs = expiresAtMs,
        _cooldownUntilMs = cooldownUntilMs,
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

  // "state" field.
  String? _state;
  String get state => _state ?? '';
  set state(String? val) => _state = val;

  bool hasState() => _state != null;

  // "myChoice" field.
  String? _myChoice;
  String get myChoice => _myChoice ?? '';
  set myChoice(String? val) => _myChoice = val;

  bool hasMyChoice() => _myChoice != null;

  // "partnerChoice" field.
  String? _partnerChoice;
  String get partnerChoice => _partnerChoice ?? '';
  set partnerChoice(String? val) => _partnerChoice = val;

  bool hasPartnerChoice() => _partnerChoice != null;

  // "summaryText" field.
  String? _summaryText;
  String get summaryText => _summaryText ?? '';
  set summaryText(String? val) => _summaryText = val;

  bool hasSummaryText() => _summaryText != null;

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

  // "expiresAtMs" field.
  int? _expiresAtMs;
  int get expiresAtMs => _expiresAtMs ?? 0;
  set expiresAtMs(int? val) => _expiresAtMs = val;

  void incrementExpiresAtMs(int amount) => expiresAtMs = expiresAtMs + amount;

  bool hasExpiresAtMs() => _expiresAtMs != null;

  // "cooldownUntilMs" field.
  int? _cooldownUntilMs;
  int get cooldownUntilMs => _cooldownUntilMs ?? 0;
  set cooldownUntilMs(int? val) => _cooldownUntilMs = val;

  void incrementCooldownUntilMs(int amount) =>
      cooldownUntilMs = cooldownUntilMs + amount;

  bool hasCooldownUntilMs() => _cooldownUntilMs != null;

  static CFEmotionResultStruct fromMap(Map<String, dynamic> data) =>
      CFEmotionResultStruct(
        ok: data['ok'] as bool?,
        code: data['code'] as String?,
        state: data['state'] as String?,
        myChoice: data['myChoice'] as String?,
        partnerChoice: data['partnerChoice'] as String?,
        summaryText: data['summaryText'] as String?,
        statusText: data['statusText'] as String?,
        snackText: data['snackText'] as String?,
        expiresAtMs: castToType<int>(data['expiresAtMs']),
        cooldownUntilMs: castToType<int>(data['cooldownUntilMs']),
      );

  static CFEmotionResultStruct? maybeFromMap(dynamic data) => data is Map
      ? CFEmotionResultStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'ok': _ok,
        'code': _code,
        'state': _state,
        'myChoice': _myChoice,
        'partnerChoice': _partnerChoice,
        'summaryText': _summaryText,
        'statusText': _statusText,
        'snackText': _snackText,
        'expiresAtMs': _expiresAtMs,
        'cooldownUntilMs': _cooldownUntilMs,
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
        'state': serializeParam(
          _state,
          ParamType.String,
        ),
        'myChoice': serializeParam(
          _myChoice,
          ParamType.String,
        ),
        'partnerChoice': serializeParam(
          _partnerChoice,
          ParamType.String,
        ),
        'summaryText': serializeParam(
          _summaryText,
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
        'expiresAtMs': serializeParam(
          _expiresAtMs,
          ParamType.int,
        ),
        'cooldownUntilMs': serializeParam(
          _cooldownUntilMs,
          ParamType.int,
        ),
      }.withoutNulls;

  static CFEmotionResultStruct fromSerializableMap(Map<String, dynamic> data) =>
      CFEmotionResultStruct(
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
        state: deserializeParam(
          data['state'],
          ParamType.String,
          false,
        ),
        myChoice: deserializeParam(
          data['myChoice'],
          ParamType.String,
          false,
        ),
        partnerChoice: deserializeParam(
          data['partnerChoice'],
          ParamType.String,
          false,
        ),
        summaryText: deserializeParam(
          data['summaryText'],
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
        expiresAtMs: deserializeParam(
          data['expiresAtMs'],
          ParamType.int,
          false,
        ),
        cooldownUntilMs: deserializeParam(
          data['cooldownUntilMs'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'CFEmotionResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CFEmotionResultStruct &&
        ok == other.ok &&
        code == other.code &&
        state == other.state &&
        myChoice == other.myChoice &&
        partnerChoice == other.partnerChoice &&
        summaryText == other.summaryText &&
        statusText == other.statusText &&
        snackText == other.snackText &&
        expiresAtMs == other.expiresAtMs &&
        cooldownUntilMs == other.cooldownUntilMs;
  }

  @override
  int get hashCode => const ListEquality().hash([
        ok,
        code,
        state,
        myChoice,
        partnerChoice,
        summaryText,
        statusText,
        snackText,
        expiresAtMs,
        cooldownUntilMs
      ]);
}

CFEmotionResultStruct createCFEmotionResultStruct({
  bool? ok,
  String? code,
  String? state,
  String? myChoice,
  String? partnerChoice,
  String? summaryText,
  String? statusText,
  String? snackText,
  int? expiresAtMs,
  int? cooldownUntilMs,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CFEmotionResultStruct(
      ok: ok,
      code: code,
      state: state,
      myChoice: myChoice,
      partnerChoice: partnerChoice,
      summaryText: summaryText,
      statusText: statusText,
      snackText: snackText,
      expiresAtMs: expiresAtMs,
      cooldownUntilMs: cooldownUntilMs,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CFEmotionResultStruct? updateCFEmotionResultStruct(
  CFEmotionResultStruct? cFEmotionResult, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    cFEmotionResult
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCFEmotionResultStructData(
  Map<String, dynamic> firestoreData,
  CFEmotionResultStruct? cFEmotionResult,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (cFEmotionResult == null) {
    return;
  }
  if (cFEmotionResult.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && cFEmotionResult.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final cFEmotionResultData =
      getCFEmotionResultFirestoreData(cFEmotionResult, forFieldValue);
  final nestedData =
      cFEmotionResultData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = cFEmotionResult.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCFEmotionResultFirestoreData(
  CFEmotionResultStruct? cFEmotionResult, [
  bool forFieldValue = false,
]) {
  if (cFEmotionResult == null) {
    return {};
  }
  final firestoreData = mapToFirestore(cFEmotionResult.toMap());

  // Add any Firestore field values
  mapToFirestore(cFEmotionResult.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCFEmotionResultListFirestoreData(
  List<CFEmotionResultStruct>? cFEmotionResults,
) =>
    cFEmotionResults
        ?.map((e) => getCFEmotionResultFirestoreData(e, true))
        .toList() ??
    [];
