import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RelationshipEmotionCheckinsRecord extends FirestoreRecord {
  RelationshipEmotionCheckinsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "relationship_id" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  bool hasRelationshipId() => _relationshipId != null;

  // "a_uid" field.
  String? _aUid;
  String get aUid => _aUid ?? '';
  bool hasAUid() => _aUid != null;

  // "b_uid" field.
  String? _bUid;
  String get bUid => _bUid ?? '';
  bool hasBUid() => _bUid != null;

  // "cycle_day_key" field.
  String? _cycleDayKey;
  String get cycleDayKey => _cycleDayKey ?? '';
  bool hasCycleDayKey() => _cycleDayKey != null;

  // "a_choice" field.
  String? _aChoice;
  String get aChoice => _aChoice ?? '';
  bool hasAChoice() => _aChoice != null;

  // "b_choice" field.
  String? _bChoice;
  String get bChoice => _bChoice ?? '';
  bool hasBChoice() => _bChoice != null;

  // "a_choice_at_ms" field.
  int? _aChoiceAtMs;
  int get aChoiceAtMs => _aChoiceAtMs ?? 0;
  bool hasAChoiceAtMs() => _aChoiceAtMs != null;

  // "b_choice_at_ms" field.
  int? _bChoiceAtMs;
  int get bChoiceAtMs => _bChoiceAtMs ?? 0;
  bool hasBChoiceAtMs() => _bChoiceAtMs != null;

  // "state" field.
  String? _state;
  String get state => _state ?? '';
  bool hasState() => _state != null;

  // "expires_at_ms" field.
  int? _expiresAtMs;
  int get expiresAtMs => _expiresAtMs ?? 0;
  bool hasExpiresAtMs() => _expiresAtMs != null;

  // "cooldown_until_ms" field.
  int? _cooldownUntilMs;
  int get cooldownUntilMs => _cooldownUntilMs ?? 0;
  bool hasCooldownUntilMs() => _cooldownUntilMs != null;

  // "summary_text" field.
  String? _summaryText;
  String get summaryText => _summaryText ?? '';
  bool hasSummaryText() => _summaryText != null;

  // "template_id" field.
  int? _templateId;
  int get templateId => _templateId ?? 0;
  bool hasTemplateId() => _templateId != null;

  void _initializeFields() {
    _relationshipId = snapshotData['relationship_id'] as String?;
    _aUid = snapshotData['a_uid'] as String?;
    _bUid = snapshotData['b_uid'] as String?;
    _cycleDayKey = snapshotData['cycle_day_key'] as String?;
    _aChoice = snapshotData['a_choice'] as String?;
    _bChoice = snapshotData['b_choice'] as String?;
    _aChoiceAtMs = castToType<int>(snapshotData['a_choice_at_ms']);
    _bChoiceAtMs = castToType<int>(snapshotData['b_choice_at_ms']);
    _state = snapshotData['state'] as String?;
    _expiresAtMs = castToType<int>(snapshotData['expires_at_ms']);
    _cooldownUntilMs = castToType<int>(snapshotData['cooldown_until_ms']);
    _summaryText = snapshotData['summary_text'] as String?;
    _templateId = castToType<int>(snapshotData['template_id']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('relationship_emotion_checkins');

  static Stream<RelationshipEmotionCheckinsRecord> getDocument(
          DocumentReference ref) =>
      ref
          .snapshots()
          .map((s) => RelationshipEmotionCheckinsRecord.fromSnapshot(s));

  static Future<RelationshipEmotionCheckinsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => RelationshipEmotionCheckinsRecord.fromSnapshot(s));

  static RelationshipEmotionCheckinsRecord fromSnapshot(
          DocumentSnapshot snapshot) =>
      RelationshipEmotionCheckinsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RelationshipEmotionCheckinsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RelationshipEmotionCheckinsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RelationshipEmotionCheckinsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RelationshipEmotionCheckinsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRelationshipEmotionCheckinsRecordData({
  String? relationshipId,
  String? aUid,
  String? bUid,
  String? cycleDayKey,
  String? aChoice,
  String? bChoice,
  int? aChoiceAtMs,
  int? bChoiceAtMs,
  String? state,
  int? expiresAtMs,
  int? cooldownUntilMs,
  String? summaryText,
  int? templateId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'relationship_id': relationshipId,
      'a_uid': aUid,
      'b_uid': bUid,
      'cycle_day_key': cycleDayKey,
      'a_choice': aChoice,
      'b_choice': bChoice,
      'a_choice_at_ms': aChoiceAtMs,
      'b_choice_at_ms': bChoiceAtMs,
      'state': state,
      'expires_at_ms': expiresAtMs,
      'cooldown_until_ms': cooldownUntilMs,
      'summary_text': summaryText,
      'template_id': templateId,
    }.withoutNulls,
  );

  return firestoreData;
}

class RelationshipEmotionCheckinsRecordDocumentEquality
    implements Equality<RelationshipEmotionCheckinsRecord> {
  const RelationshipEmotionCheckinsRecordDocumentEquality();

  @override
  bool equals(RelationshipEmotionCheckinsRecord? e1,
      RelationshipEmotionCheckinsRecord? e2) {
    return e1?.relationshipId == e2?.relationshipId &&
        e1?.aUid == e2?.aUid &&
        e1?.bUid == e2?.bUid &&
        e1?.cycleDayKey == e2?.cycleDayKey &&
        e1?.aChoice == e2?.aChoice &&
        e1?.bChoice == e2?.bChoice &&
        e1?.aChoiceAtMs == e2?.aChoiceAtMs &&
        e1?.bChoiceAtMs == e2?.bChoiceAtMs &&
        e1?.state == e2?.state &&
        e1?.expiresAtMs == e2?.expiresAtMs &&
        e1?.cooldownUntilMs == e2?.cooldownUntilMs &&
        e1?.summaryText == e2?.summaryText &&
        e1?.templateId == e2?.templateId;
  }

  @override
  int hash(RelationshipEmotionCheckinsRecord? e) => const ListEquality().hash([
        e?.relationshipId,
        e?.aUid,
        e?.bUid,
        e?.cycleDayKey,
        e?.aChoice,
        e?.bChoice,
        e?.aChoiceAtMs,
        e?.bChoiceAtMs,
        e?.state,
        e?.expiresAtMs,
        e?.cooldownUntilMs,
        e?.summaryText,
        e?.templateId
      ]);

  @override
  bool isValidKey(Object? o) => o is RelationshipEmotionCheckinsRecord;
}
