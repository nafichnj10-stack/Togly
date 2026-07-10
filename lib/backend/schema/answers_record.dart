import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AnswersRecord extends FirestoreRecord {
  AnswersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "question_id" field.
  String? _questionId;
  String get questionId => _questionId ?? '';
  bool hasQuestionId() => _questionId != null;

  // "relationship_id" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  bool hasRelationshipId() => _relationshipId != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  // "userA_id" field.
  String? _userAId;
  String get userAId => _userAId ?? '';
  bool hasUserAId() => _userAId != null;

  // "userB_id" field.
  String? _userBId;
  String get userBId => _userBId ?? '';
  bool hasUserBId() => _userBId != null;

  // "userA_answer" field.
  String? _userAAnswer;
  String get userAAnswer => _userAAnswer ?? '';
  bool hasUserAAnswer() => _userAAnswer != null;

  // "userB_answer" field.
  String? _userBAnswer;
  String get userBAnswer => _userBAnswer ?? '';
  bool hasUserBAnswer() => _userBAnswer != null;

  // "userB_answered" field.
  bool? _userBAnswered;
  bool get userBAnswered => _userBAnswered ?? false;
  bool hasUserBAnswered() => _userBAnswered != null;

  // "userA_answered" field.
  bool? _userAAnswered;
  bool get userAAnswered => _userAAnswered ?? false;
  bool hasUserAAnswered() => _userAAnswered != null;

  // "question_text" field.
  String? _questionText;
  String get questionText => _questionText ?? '';
  bool hasQuestionText() => _questionText != null;

  // "day_key" field.
  String? _dayKey;
  String get dayKey => _dayKey ?? '';
  bool hasDayKey() => _dayKey != null;

  // "question_text_en" field.
  String? _questionTextEn;
  String get questionTextEn => _questionTextEn ?? '';
  bool hasQuestionTextEn() => _questionTextEn != null;

  // "question_text_de" field.
  String? _questionTextDe;
  String get questionTextDe => _questionTextDe ?? '';
  bool hasQuestionTextDe() => _questionTextDe != null;

  // "question_text_es" field.
  String? _questionTextEs;
  String get questionTextEs => _questionTextEs ?? '';
  bool hasQuestionTextEs() => _questionTextEs != null;

  void _initializeFields() {
    _questionId = snapshotData['question_id'] as String?;
    _relationshipId = snapshotData['relationship_id'] as String?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _userAId = snapshotData['userA_id'] as String?;
    _userBId = snapshotData['userB_id'] as String?;
    _userAAnswer = snapshotData['userA_answer'] as String?;
    _userBAnswer = snapshotData['userB_answer'] as String?;
    _userBAnswered = snapshotData['userB_answered'] as bool?;
    _userAAnswered = snapshotData['userA_answered'] as bool?;
    _questionText = snapshotData['question_text'] as String?;
    _dayKey = snapshotData['day_key'] as String?;
    _questionTextEn = snapshotData['question_text_en'] as String?;
    _questionTextDe = snapshotData['question_text_de'] as String?;
    _questionTextEs = snapshotData['question_text_es'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('answers');

  static Stream<AnswersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AnswersRecord.fromSnapshot(s));

  static Future<AnswersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AnswersRecord.fromSnapshot(s));

  static AnswersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AnswersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AnswersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AnswersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AnswersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AnswersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAnswersRecordData({
  String? questionId,
  String? relationshipId,
  DateTime? timestamp,
  String? userAId,
  String? userBId,
  String? userAAnswer,
  String? userBAnswer,
  bool? userBAnswered,
  bool? userAAnswered,
  String? questionText,
  String? dayKey,
  String? questionTextEn,
  String? questionTextDe,
  String? questionTextEs,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'question_id': questionId,
      'relationship_id': relationshipId,
      'timestamp': timestamp,
      'userA_id': userAId,
      'userB_id': userBId,
      'userA_answer': userAAnswer,
      'userB_answer': userBAnswer,
      'userB_answered': userBAnswered,
      'userA_answered': userAAnswered,
      'question_text': questionText,
      'day_key': dayKey,
      'question_text_en': questionTextEn,
      'question_text_de': questionTextDe,
      'question_text_es': questionTextEs,
    }.withoutNulls,
  );

  return firestoreData;
}

class AnswersRecordDocumentEquality implements Equality<AnswersRecord> {
  const AnswersRecordDocumentEquality();

  @override
  bool equals(AnswersRecord? e1, AnswersRecord? e2) {
    return e1?.questionId == e2?.questionId &&
        e1?.relationshipId == e2?.relationshipId &&
        e1?.timestamp == e2?.timestamp &&
        e1?.userAId == e2?.userAId &&
        e1?.userBId == e2?.userBId &&
        e1?.userAAnswer == e2?.userAAnswer &&
        e1?.userBAnswer == e2?.userBAnswer &&
        e1?.userBAnswered == e2?.userBAnswered &&
        e1?.userAAnswered == e2?.userAAnswered &&
        e1?.questionText == e2?.questionText &&
        e1?.dayKey == e2?.dayKey &&
        e1?.questionTextEn == e2?.questionTextEn &&
        e1?.questionTextDe == e2?.questionTextDe &&
        e1?.questionTextEs == e2?.questionTextEs;
  }

  @override
  int hash(AnswersRecord? e) => const ListEquality().hash([
        e?.questionId,
        e?.relationshipId,
        e?.timestamp,
        e?.userAId,
        e?.userBId,
        e?.userAAnswer,
        e?.userBAnswer,
        e?.userBAnswered,
        e?.userAAnswered,
        e?.questionText,
        e?.dayKey,
        e?.questionTextEn,
        e?.questionTextDe,
        e?.questionTextEs
      ]);

  @override
  bool isValidKey(Object? o) => o is AnswersRecord;
}
