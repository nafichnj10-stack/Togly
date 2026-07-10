// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class HeartbeatQuestionCFItemStruct extends FFFirebaseStruct {
  HeartbeatQuestionCFItemStruct({
    String? id,
    int? order,
    String? questionRefPath,
    String? questionKey,
    String? category,
    String? questionTextDe,
    String? questionTextEn,
    String? questionTextEs,
    String? answerType,
    double? weight,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _order = order,
        _questionRefPath = questionRefPath,
        _questionKey = questionKey,
        _category = category,
        _questionTextDe = questionTextDe,
        _questionTextEn = questionTextEn,
        _questionTextEs = questionTextEs,
        _answerType = answerType,
        _weight = weight,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "order" field.
  int? _order;
  int get order => _order ?? 0;
  set order(int? val) => _order = val;

  void incrementOrder(int amount) => order = order + amount;

  bool hasOrder() => _order != null;

  // "questionRefPath" field.
  String? _questionRefPath;
  String get questionRefPath => _questionRefPath ?? '';
  set questionRefPath(String? val) => _questionRefPath = val;

  bool hasQuestionRefPath() => _questionRefPath != null;

  // "questionKey" field.
  String? _questionKey;
  String get questionKey => _questionKey ?? '';
  set questionKey(String? val) => _questionKey = val;

  bool hasQuestionKey() => _questionKey != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  set category(String? val) => _category = val;

  bool hasCategory() => _category != null;

  // "questionTextDe" field.
  String? _questionTextDe;
  String get questionTextDe => _questionTextDe ?? '';
  set questionTextDe(String? val) => _questionTextDe = val;

  bool hasQuestionTextDe() => _questionTextDe != null;

  // "questionTextEn" field.
  String? _questionTextEn;
  String get questionTextEn => _questionTextEn ?? '';
  set questionTextEn(String? val) => _questionTextEn = val;

  bool hasQuestionTextEn() => _questionTextEn != null;

  // "questionTextEs" field.
  String? _questionTextEs;
  String get questionTextEs => _questionTextEs ?? '';
  set questionTextEs(String? val) => _questionTextEs = val;

  bool hasQuestionTextEs() => _questionTextEs != null;

  // "answerType" field.
  String? _answerType;
  String get answerType => _answerType ?? '';
  set answerType(String? val) => _answerType = val;

  bool hasAnswerType() => _answerType != null;

  // "weight" field.
  double? _weight;
  double get weight => _weight ?? 0.0;
  set weight(double? val) => _weight = val;

  void incrementWeight(double amount) => weight = weight + amount;

  bool hasWeight() => _weight != null;

  static HeartbeatQuestionCFItemStruct fromMap(Map<String, dynamic> data) =>
      HeartbeatQuestionCFItemStruct(
        id: data['id'] as String?,
        order: castToType<int>(data['order']),
        questionRefPath: data['questionRefPath'] as String?,
        questionKey: data['questionKey'] as String?,
        category: data['category'] as String?,
        questionTextDe: data['questionTextDe'] as String?,
        questionTextEn: data['questionTextEn'] as String?,
        questionTextEs: data['questionTextEs'] as String?,
        answerType: data['answerType'] as String?,
        weight: castToType<double>(data['weight']),
      );

  static HeartbeatQuestionCFItemStruct? maybeFromMap(dynamic data) =>
      data is Map
          ? HeartbeatQuestionCFItemStruct.fromMap(data.cast<String, dynamic>())
          : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'order': _order,
        'questionRefPath': _questionRefPath,
        'questionKey': _questionKey,
        'category': _category,
        'questionTextDe': _questionTextDe,
        'questionTextEn': _questionTextEn,
        'questionTextEs': _questionTextEs,
        'answerType': _answerType,
        'weight': _weight,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'order': serializeParam(
          _order,
          ParamType.int,
        ),
        'questionRefPath': serializeParam(
          _questionRefPath,
          ParamType.String,
        ),
        'questionKey': serializeParam(
          _questionKey,
          ParamType.String,
        ),
        'category': serializeParam(
          _category,
          ParamType.String,
        ),
        'questionTextDe': serializeParam(
          _questionTextDe,
          ParamType.String,
        ),
        'questionTextEn': serializeParam(
          _questionTextEn,
          ParamType.String,
        ),
        'questionTextEs': serializeParam(
          _questionTextEs,
          ParamType.String,
        ),
        'answerType': serializeParam(
          _answerType,
          ParamType.String,
        ),
        'weight': serializeParam(
          _weight,
          ParamType.double,
        ),
      }.withoutNulls;

  static HeartbeatQuestionCFItemStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      HeartbeatQuestionCFItemStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        order: deserializeParam(
          data['order'],
          ParamType.int,
          false,
        ),
        questionRefPath: deserializeParam(
          data['questionRefPath'],
          ParamType.String,
          false,
        ),
        questionKey: deserializeParam(
          data['questionKey'],
          ParamType.String,
          false,
        ),
        category: deserializeParam(
          data['category'],
          ParamType.String,
          false,
        ),
        questionTextDe: deserializeParam(
          data['questionTextDe'],
          ParamType.String,
          false,
        ),
        questionTextEn: deserializeParam(
          data['questionTextEn'],
          ParamType.String,
          false,
        ),
        questionTextEs: deserializeParam(
          data['questionTextEs'],
          ParamType.String,
          false,
        ),
        answerType: deserializeParam(
          data['answerType'],
          ParamType.String,
          false,
        ),
        weight: deserializeParam(
          data['weight'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'HeartbeatQuestionCFItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is HeartbeatQuestionCFItemStruct &&
        id == other.id &&
        order == other.order &&
        questionRefPath == other.questionRefPath &&
        questionKey == other.questionKey &&
        category == other.category &&
        questionTextDe == other.questionTextDe &&
        questionTextEn == other.questionTextEn &&
        questionTextEs == other.questionTextEs &&
        answerType == other.answerType &&
        weight == other.weight;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        order,
        questionRefPath,
        questionKey,
        category,
        questionTextDe,
        questionTextEn,
        questionTextEs,
        answerType,
        weight
      ]);
}

HeartbeatQuestionCFItemStruct createHeartbeatQuestionCFItemStruct({
  String? id,
  int? order,
  String? questionRefPath,
  String? questionKey,
  String? category,
  String? questionTextDe,
  String? questionTextEn,
  String? questionTextEs,
  String? answerType,
  double? weight,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    HeartbeatQuestionCFItemStruct(
      id: id,
      order: order,
      questionRefPath: questionRefPath,
      questionKey: questionKey,
      category: category,
      questionTextDe: questionTextDe,
      questionTextEn: questionTextEn,
      questionTextEs: questionTextEs,
      answerType: answerType,
      weight: weight,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

HeartbeatQuestionCFItemStruct? updateHeartbeatQuestionCFItemStruct(
  HeartbeatQuestionCFItemStruct? heartbeatQuestionCFItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    heartbeatQuestionCFItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addHeartbeatQuestionCFItemStructData(
  Map<String, dynamic> firestoreData,
  HeartbeatQuestionCFItemStruct? heartbeatQuestionCFItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (heartbeatQuestionCFItem == null) {
    return;
  }
  if (heartbeatQuestionCFItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      heartbeatQuestionCFItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final heartbeatQuestionCFItemData = getHeartbeatQuestionCFItemFirestoreData(
      heartbeatQuestionCFItem, forFieldValue);
  final nestedData =
      heartbeatQuestionCFItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      heartbeatQuestionCFItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getHeartbeatQuestionCFItemFirestoreData(
  HeartbeatQuestionCFItemStruct? heartbeatQuestionCFItem, [
  bool forFieldValue = false,
]) {
  if (heartbeatQuestionCFItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(heartbeatQuestionCFItem.toMap());

  // Add any Firestore field values
  mapToFirestore(heartbeatQuestionCFItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getHeartbeatQuestionCFItemListFirestoreData(
  List<HeartbeatQuestionCFItemStruct>? heartbeatQuestionCFItems,
) =>
    heartbeatQuestionCFItems
        ?.map((e) => getHeartbeatQuestionCFItemFirestoreData(e, true))
        .toList() ??
    [];
