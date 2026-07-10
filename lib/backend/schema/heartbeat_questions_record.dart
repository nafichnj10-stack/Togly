import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HeartbeatQuestionsRecord extends FirestoreRecord {
  HeartbeatQuestionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "question_text_de" field.
  String? _questionTextDe;
  String get questionTextDe => _questionTextDe ?? '';
  bool hasQuestionTextDe() => _questionTextDe != null;

  // "question_text_en" field.
  String? _questionTextEn;
  String get questionTextEn => _questionTextEn ?? '';
  bool hasQuestionTextEn() => _questionTextEn != null;

  // "question_text_es" field.
  String? _questionTextEs;
  String get questionTextEs => _questionTextEs ?? '';
  bool hasQuestionTextEs() => _questionTextEs != null;

  // "question_key" field.
  String? _questionKey;
  String get questionKey => _questionKey ?? '';
  bool hasQuestionKey() => _questionKey != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "is_active" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  bool hasIsActive() => _isActive != null;

  // "sort_order" field.
  int? _sortOrder;
  int get sortOrder => _sortOrder ?? 0;
  bool hasSortOrder() => _sortOrder != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "answer_type" field.
  String? _answerType;
  String get answerType => _answerType ?? '';
  bool hasAnswerType() => _answerType != null;

  // "weight" field.
  double? _weight;
  double get weight => _weight ?? 0.0;
  bool hasWeight() => _weight != null;

  void _initializeFields() {
    _questionTextDe = snapshotData['question_text_de'] as String?;
    _questionTextEn = snapshotData['question_text_en'] as String?;
    _questionTextEs = snapshotData['question_text_es'] as String?;
    _questionKey = snapshotData['question_key'] as String?;
    _category = snapshotData['category'] as String?;
    _isActive = snapshotData['is_active'] as bool?;
    _sortOrder = castToType<int>(snapshotData['sort_order']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _answerType = snapshotData['answer_type'] as String?;
    _weight = castToType<double>(snapshotData['weight']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('heartbeat_questions');

  static Stream<HeartbeatQuestionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => HeartbeatQuestionsRecord.fromSnapshot(s));

  static Future<HeartbeatQuestionsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => HeartbeatQuestionsRecord.fromSnapshot(s));

  static HeartbeatQuestionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      HeartbeatQuestionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static HeartbeatQuestionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      HeartbeatQuestionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'HeartbeatQuestionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is HeartbeatQuestionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createHeartbeatQuestionsRecordData({
  String? questionTextDe,
  String? questionTextEn,
  String? questionTextEs,
  String? questionKey,
  String? category,
  bool? isActive,
  int? sortOrder,
  DateTime? createdAt,
  DateTime? updatedAt,
  String? answerType,
  double? weight,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'question_text_de': questionTextDe,
      'question_text_en': questionTextEn,
      'question_text_es': questionTextEs,
      'question_key': questionKey,
      'category': category,
      'is_active': isActive,
      'sort_order': sortOrder,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'answer_type': answerType,
      'weight': weight,
    }.withoutNulls,
  );

  return firestoreData;
}

class HeartbeatQuestionsRecordDocumentEquality
    implements Equality<HeartbeatQuestionsRecord> {
  const HeartbeatQuestionsRecordDocumentEquality();

  @override
  bool equals(HeartbeatQuestionsRecord? e1, HeartbeatQuestionsRecord? e2) {
    return e1?.questionTextDe == e2?.questionTextDe &&
        e1?.questionTextEn == e2?.questionTextEn &&
        e1?.questionTextEs == e2?.questionTextEs &&
        e1?.questionKey == e2?.questionKey &&
        e1?.category == e2?.category &&
        e1?.isActive == e2?.isActive &&
        e1?.sortOrder == e2?.sortOrder &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.answerType == e2?.answerType &&
        e1?.weight == e2?.weight;
  }

  @override
  int hash(HeartbeatQuestionsRecord? e) => const ListEquality().hash([
        e?.questionTextDe,
        e?.questionTextEn,
        e?.questionTextEs,
        e?.questionKey,
        e?.category,
        e?.isActive,
        e?.sortOrder,
        e?.createdAt,
        e?.updatedAt,
        e?.answerType,
        e?.weight
      ]);

  @override
  bool isValidKey(Object? o) => o is HeartbeatQuestionsRecord;
}
