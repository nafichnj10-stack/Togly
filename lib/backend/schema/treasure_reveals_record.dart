import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TreasureRevealsRecord extends FirestoreRecord {
  TreasureRevealsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "relationship_id" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  bool hasRelationshipId() => _relationshipId != null;

  // "treasureRef" field.
  DocumentReference? _treasureRef;
  DocumentReference? get treasureRef => _treasureRef;
  bool hasTreasureRef() => _treasureRef != null;

  // "surpriseRef" field.
  DocumentReference? _surpriseRef;
  DocumentReference? get surpriseRef => _surpriseRef;
  bool hasSurpriseRef() => _surpriseRef != null;

  // "revealedBy" field.
  DocumentReference? _revealedBy;
  DocumentReference? get revealedBy => _revealedBy;
  bool hasRevealedBy() => _revealedBy != null;

  // "revealedByUid" field.
  String? _revealedByUid;
  String get revealedByUid => _revealedByUid ?? '';
  bool hasRevealedByUid() => _revealedByUid != null;

  // "revealedAt" field.
  DateTime? _revealedAt;
  DateTime? get revealedAt => _revealedAt;
  bool hasRevealedAt() => _revealedAt != null;

  void _initializeFields() {
    _relationshipId = snapshotData['relationship_id'] as String?;
    _treasureRef = snapshotData['treasureRef'] as DocumentReference?;
    _surpriseRef = snapshotData['surpriseRef'] as DocumentReference?;
    _revealedBy = snapshotData['revealedBy'] as DocumentReference?;
    _revealedByUid = snapshotData['revealedByUid'] as String?;
    _revealedAt = snapshotData['revealedAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('treasure_reveals');

  static Stream<TreasureRevealsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TreasureRevealsRecord.fromSnapshot(s));

  static Future<TreasureRevealsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TreasureRevealsRecord.fromSnapshot(s));

  static TreasureRevealsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TreasureRevealsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TreasureRevealsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TreasureRevealsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TreasureRevealsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TreasureRevealsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTreasureRevealsRecordData({
  String? relationshipId,
  DocumentReference? treasureRef,
  DocumentReference? surpriseRef,
  DocumentReference? revealedBy,
  String? revealedByUid,
  DateTime? revealedAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'relationship_id': relationshipId,
      'treasureRef': treasureRef,
      'surpriseRef': surpriseRef,
      'revealedBy': revealedBy,
      'revealedByUid': revealedByUid,
      'revealedAt': revealedAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class TreasureRevealsRecordDocumentEquality
    implements Equality<TreasureRevealsRecord> {
  const TreasureRevealsRecordDocumentEquality();

  @override
  bool equals(TreasureRevealsRecord? e1, TreasureRevealsRecord? e2) {
    return e1?.relationshipId == e2?.relationshipId &&
        e1?.treasureRef == e2?.treasureRef &&
        e1?.surpriseRef == e2?.surpriseRef &&
        e1?.revealedBy == e2?.revealedBy &&
        e1?.revealedByUid == e2?.revealedByUid &&
        e1?.revealedAt == e2?.revealedAt;
  }

  @override
  int hash(TreasureRevealsRecord? e) => const ListEquality().hash([
        e?.relationshipId,
        e?.treasureRef,
        e?.surpriseRef,
        e?.revealedBy,
        e?.revealedByUid,
        e?.revealedAt
      ]);

  @override
  bool isValidKey(Object? o) => o is TreasureRevealsRecord;
}
