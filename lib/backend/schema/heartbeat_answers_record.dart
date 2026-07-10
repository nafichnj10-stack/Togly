import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HeartbeatAnswersRecord extends FirestoreRecord {
  HeartbeatAnswersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "relationship_id" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  bool hasRelationshipId() => _relationshipId != null;

  // "session_ref" field.
  DocumentReference? _sessionRef;
  DocumentReference? get sessionRef => _sessionRef;
  bool hasSessionRef() => _sessionRef != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "question_key" field.
  String? _questionKey;
  String get questionKey => _questionKey ?? '';
  bool hasQuestionKey() => _questionKey != null;

  // "answer_value" field.
  int? _answerValue;
  int get answerValue => _answerValue ?? 0;
  bool hasAnswerValue() => _answerValue != null;

  // "question_order" field.
  int? _questionOrder;
  int get questionOrder => _questionOrder ?? 0;
  bool hasQuestionOrder() => _questionOrder != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "question_ref" field.
  DocumentReference? _questionRef;
  DocumentReference? get questionRef => _questionRef;
  bool hasQuestionRef() => _questionRef != null;

  void _initializeFields() {
    _relationshipId = snapshotData['relationship_id'] as String?;
    _sessionRef = snapshotData['session_ref'] as DocumentReference?;
    _userId = snapshotData['user_id'] as String?;
    _questionKey = snapshotData['question_key'] as String?;
    _answerValue = castToType<int>(snapshotData['answer_value']);
    _questionOrder = castToType<int>(snapshotData['question_order']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _questionRef = snapshotData['question_ref'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('heartbeat_answers');

  static Stream<HeartbeatAnswersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => HeartbeatAnswersRecord.fromSnapshot(s));

  static Future<HeartbeatAnswersRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => HeartbeatAnswersRecord.fromSnapshot(s));

  static HeartbeatAnswersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      HeartbeatAnswersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static HeartbeatAnswersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      HeartbeatAnswersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'HeartbeatAnswersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is HeartbeatAnswersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createHeartbeatAnswersRecordData({
  String? relationshipId,
  DocumentReference? sessionRef,
  String? userId,
  String? questionKey,
  int? answerValue,
  int? questionOrder,
  DateTime? createdAt,
  DocumentReference? questionRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'relationship_id': relationshipId,
      'session_ref': sessionRef,
      'user_id': userId,
      'question_key': questionKey,
      'answer_value': answerValue,
      'question_order': questionOrder,
      'created_at': createdAt,
      'question_ref': questionRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class HeartbeatAnswersRecordDocumentEquality
    implements Equality<HeartbeatAnswersRecord> {
  const HeartbeatAnswersRecordDocumentEquality();

  @override
  bool equals(HeartbeatAnswersRecord? e1, HeartbeatAnswersRecord? e2) {
    return e1?.relationshipId == e2?.relationshipId &&
        e1?.sessionRef == e2?.sessionRef &&
        e1?.userId == e2?.userId &&
        e1?.questionKey == e2?.questionKey &&
        e1?.answerValue == e2?.answerValue &&
        e1?.questionOrder == e2?.questionOrder &&
        e1?.createdAt == e2?.createdAt &&
        e1?.questionRef == e2?.questionRef;
  }

  @override
  int hash(HeartbeatAnswersRecord? e) => const ListEquality().hash([
        e?.relationshipId,
        e?.sessionRef,
        e?.userId,
        e?.questionKey,
        e?.answerValue,
        e?.questionOrder,
        e?.createdAt,
        e?.questionRef
      ]);

  @override
  bool isValidKey(Object? o) => o is HeartbeatAnswersRecord;
}
