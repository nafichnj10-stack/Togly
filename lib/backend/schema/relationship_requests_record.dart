import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RelationshipRequestsRecord extends FirestoreRecord {
  RelationshipRequestsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "initiator_id" field.
  String? _initiatorId;
  String get initiatorId => _initiatorId ?? '';
  bool hasInitiatorId() => _initiatorId != null;

  // "target_id" field.
  String? _targetId;
  String get targetId => _targetId ?? '';
  bool hasTargetId() => _targetId != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "pair_key" field.
  String? _pairKey;
  String get pairKey => _pairKey ?? '';
  bool hasPairKey() => _pairKey != null;

  void _initializeFields() {
    _initiatorId = snapshotData['initiator_id'] as String?;
    _targetId = snapshotData['target_id'] as String?;
    _status = snapshotData['status'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _pairKey = snapshotData['pair_key'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('relationship_requests');

  static Stream<RelationshipRequestsRecord> getDocument(
          DocumentReference ref) =>
      ref.snapshots().map((s) => RelationshipRequestsRecord.fromSnapshot(s));

  static Future<RelationshipRequestsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => RelationshipRequestsRecord.fromSnapshot(s));

  static RelationshipRequestsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RelationshipRequestsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RelationshipRequestsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RelationshipRequestsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RelationshipRequestsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RelationshipRequestsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRelationshipRequestsRecordData({
  String? initiatorId,
  String? targetId,
  String? status,
  DateTime? createdAt,
  DateTime? updatedAt,
  String? pairKey,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'initiator_id': initiatorId,
      'target_id': targetId,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'pair_key': pairKey,
    }.withoutNulls,
  );

  return firestoreData;
}

class RelationshipRequestsRecordDocumentEquality
    implements Equality<RelationshipRequestsRecord> {
  const RelationshipRequestsRecordDocumentEquality();

  @override
  bool equals(RelationshipRequestsRecord? e1, RelationshipRequestsRecord? e2) {
    return e1?.initiatorId == e2?.initiatorId &&
        e1?.targetId == e2?.targetId &&
        e1?.status == e2?.status &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.pairKey == e2?.pairKey;
  }

  @override
  int hash(RelationshipRequestsRecord? e) => const ListEquality().hash([
        e?.initiatorId,
        e?.targetId,
        e?.status,
        e?.createdAt,
        e?.updatedAt,
        e?.pairKey
      ]);

  @override
  bool isValidKey(Object? o) => o is RelationshipRequestsRecord;
}
