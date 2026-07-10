import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HeartbeatSessionsRecord extends FirestoreRecord {
  HeartbeatSessionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "relationship_id" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  bool hasRelationshipId() => _relationshipId != null;

  // "partner1_id" field.
  String? _partner1Id;
  String get partner1Id => _partner1Id ?? '';
  bool hasPartner1Id() => _partner1Id != null;

  // "partner2_id" field.
  String? _partner2Id;
  String get partner2Id => _partner2Id ?? '';
  bool hasPartner2Id() => _partner2Id != null;

  // "session_date" field.
  DateTime? _sessionDate;
  DateTime? get sessionDate => _sessionDate;
  bool hasSessionDate() => _sessionDate != null;

  // "session_date_key" field.
  String? _sessionDateKey;
  String get sessionDateKey => _sessionDateKey ?? '';
  bool hasSessionDateKey() => _sessionDateKey != null;

  // "question_refs" field.
  List<DocumentReference>? _questionRefs;
  List<DocumentReference> get questionRefs => _questionRefs ?? const [];
  bool hasQuestionRefs() => _questionRefs != null;

  // "partner1_answered" field.
  bool? _partner1Answered;
  bool get partner1Answered => _partner1Answered ?? false;
  bool hasPartner1Answered() => _partner1Answered != null;

  // "partner2_answered" field.
  bool? _partner2Answered;
  bool get partner2Answered => _partner2Answered ?? false;
  bool hasPartner2Answered() => _partner2Answered != null;

  // "partner1_average" field.
  double? _partner1Average;
  double get partner1Average => _partner1Average ?? 0.0;
  bool hasPartner1Average() => _partner1Average != null;

  // "partner2_average" field.
  double? _partner2Average;
  double get partner2Average => _partner2Average ?? 0.0;
  bool hasPartner2Average() => _partner2Average != null;

  // "heartbeat_score_raw" field.
  double? _heartbeatScoreRaw;
  double get heartbeatScoreRaw => _heartbeatScoreRaw ?? 0.0;
  bool hasHeartbeatScoreRaw() => _heartbeatScoreRaw != null;

  // "heartbeat_score_percent" field.
  int? _heartbeatScorePercent;
  int get heartbeatScorePercent => _heartbeatScorePercent ?? 0;
  bool hasHeartbeatScorePercent() => _heartbeatScorePercent != null;

  // "connection_label_key" field.
  String? _connectionLabelKey;
  String get connectionLabelKey => _connectionLabelKey ?? '';
  bool hasConnectionLabelKey() => _connectionLabelKey != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "can_view_result" field.
  bool? _canViewResult;
  bool get canViewResult => _canViewResult ?? false;
  bool hasCanViewResult() => _canViewResult != null;

  // "expires_at" field.
  DateTime? _expiresAt;
  DateTime? get expiresAt => _expiresAt;
  bool hasExpiresAt() => _expiresAt != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "insight_text_de" field.
  String? _insightTextDe;
  String get insightTextDe => _insightTextDe ?? '';
  bool hasInsightTextDe() => _insightTextDe != null;

  // "insight_text_en" field.
  String? _insightTextEn;
  String get insightTextEn => _insightTextEn ?? '';
  bool hasInsightTextEn() => _insightTextEn != null;

  // "insight_text_es" field.
  String? _insightTextEs;
  String get insightTextEs => _insightTextEs ?? '';
  bool hasInsightTextEs() => _insightTextEs != null;

  // "session_id" field.
  String? _sessionId;
  String get sessionId => _sessionId ?? '';
  bool hasSessionId() => _sessionId != null;

  void _initializeFields() {
    _relationshipId = snapshotData['relationship_id'] as String?;
    _partner1Id = snapshotData['partner1_id'] as String?;
    _partner2Id = snapshotData['partner2_id'] as String?;
    _sessionDate = snapshotData['session_date'] as DateTime?;
    _sessionDateKey = snapshotData['session_date_key'] as String?;
    _questionRefs = getDataList(snapshotData['question_refs']);
    _partner1Answered = snapshotData['partner1_answered'] as bool?;
    _partner2Answered = snapshotData['partner2_answered'] as bool?;
    _partner1Average = castToType<double>(snapshotData['partner1_average']);
    _partner2Average = castToType<double>(snapshotData['partner2_average']);
    _heartbeatScoreRaw =
        castToType<double>(snapshotData['heartbeat_score_raw']);
    _heartbeatScorePercent =
        castToType<int>(snapshotData['heartbeat_score_percent']);
    _connectionLabelKey = snapshotData['connection_label_key'] as String?;
    _status = snapshotData['status'] as String?;
    _canViewResult = snapshotData['can_view_result'] as bool?;
    _expiresAt = snapshotData['expires_at'] as DateTime?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _insightTextDe = snapshotData['insight_text_de'] as String?;
    _insightTextEn = snapshotData['insight_text_en'] as String?;
    _insightTextEs = snapshotData['insight_text_es'] as String?;
    _sessionId = snapshotData['session_id'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('heartbeat_sessions');

  static Stream<HeartbeatSessionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => HeartbeatSessionsRecord.fromSnapshot(s));

  static Future<HeartbeatSessionsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => HeartbeatSessionsRecord.fromSnapshot(s));

  static HeartbeatSessionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      HeartbeatSessionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static HeartbeatSessionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      HeartbeatSessionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'HeartbeatSessionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is HeartbeatSessionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createHeartbeatSessionsRecordData({
  String? relationshipId,
  String? partner1Id,
  String? partner2Id,
  DateTime? sessionDate,
  String? sessionDateKey,
  bool? partner1Answered,
  bool? partner2Answered,
  double? partner1Average,
  double? partner2Average,
  double? heartbeatScoreRaw,
  int? heartbeatScorePercent,
  String? connectionLabelKey,
  String? status,
  bool? canViewResult,
  DateTime? expiresAt,
  DateTime? createdAt,
  DateTime? updatedAt,
  String? insightTextDe,
  String? insightTextEn,
  String? insightTextEs,
  String? sessionId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'relationship_id': relationshipId,
      'partner1_id': partner1Id,
      'partner2_id': partner2Id,
      'session_date': sessionDate,
      'session_date_key': sessionDateKey,
      'partner1_answered': partner1Answered,
      'partner2_answered': partner2Answered,
      'partner1_average': partner1Average,
      'partner2_average': partner2Average,
      'heartbeat_score_raw': heartbeatScoreRaw,
      'heartbeat_score_percent': heartbeatScorePercent,
      'connection_label_key': connectionLabelKey,
      'status': status,
      'can_view_result': canViewResult,
      'expires_at': expiresAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'insight_text_de': insightTextDe,
      'insight_text_en': insightTextEn,
      'insight_text_es': insightTextEs,
      'session_id': sessionId,
    }.withoutNulls,
  );

  return firestoreData;
}

class HeartbeatSessionsRecordDocumentEquality
    implements Equality<HeartbeatSessionsRecord> {
  const HeartbeatSessionsRecordDocumentEquality();

  @override
  bool equals(HeartbeatSessionsRecord? e1, HeartbeatSessionsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.relationshipId == e2?.relationshipId &&
        e1?.partner1Id == e2?.partner1Id &&
        e1?.partner2Id == e2?.partner2Id &&
        e1?.sessionDate == e2?.sessionDate &&
        e1?.sessionDateKey == e2?.sessionDateKey &&
        listEquality.equals(e1?.questionRefs, e2?.questionRefs) &&
        e1?.partner1Answered == e2?.partner1Answered &&
        e1?.partner2Answered == e2?.partner2Answered &&
        e1?.partner1Average == e2?.partner1Average &&
        e1?.partner2Average == e2?.partner2Average &&
        e1?.heartbeatScoreRaw == e2?.heartbeatScoreRaw &&
        e1?.heartbeatScorePercent == e2?.heartbeatScorePercent &&
        e1?.connectionLabelKey == e2?.connectionLabelKey &&
        e1?.status == e2?.status &&
        e1?.canViewResult == e2?.canViewResult &&
        e1?.expiresAt == e2?.expiresAt &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.insightTextDe == e2?.insightTextDe &&
        e1?.insightTextEn == e2?.insightTextEn &&
        e1?.insightTextEs == e2?.insightTextEs &&
        e1?.sessionId == e2?.sessionId;
  }

  @override
  int hash(HeartbeatSessionsRecord? e) => const ListEquality().hash([
        e?.relationshipId,
        e?.partner1Id,
        e?.partner2Id,
        e?.sessionDate,
        e?.sessionDateKey,
        e?.questionRefs,
        e?.partner1Answered,
        e?.partner2Answered,
        e?.partner1Average,
        e?.partner2Average,
        e?.heartbeatScoreRaw,
        e?.heartbeatScorePercent,
        e?.connectionLabelKey,
        e?.status,
        e?.canViewResult,
        e?.expiresAt,
        e?.createdAt,
        e?.updatedAt,
        e?.insightTextDe,
        e?.insightTextEn,
        e?.insightTextEs,
        e?.sessionId
      ]);

  @override
  bool isValidKey(Object? o) => o is HeartbeatSessionsRecord;
}
