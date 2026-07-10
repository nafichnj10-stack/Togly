import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReconnectRequestsRecord extends FirestoreRecord {
  ReconnectRequestsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "relationship_id" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  bool hasRelationshipId() => _relationshipId != null;

  // "initiator_id" field.
  String? _initiatorId;
  String get initiatorId => _initiatorId ?? '';
  bool hasInitiatorId() => _initiatorId != null;

  // "initiator_name" field.
  String? _initiatorName;
  String get initiatorName => _initiatorName ?? '';
  bool hasInitiatorName() => _initiatorName != null;

  // "target_id" field.
  String? _targetId;
  String get targetId => _targetId ?? '';
  bool hasTargetId() => _targetId != null;

  // "target_name" field.
  String? _targetName;
  String get targetName => _targetName ?? '';
  bool hasTargetName() => _targetName != null;

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

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  void _initializeFields() {
    _relationshipId = snapshotData['relationship_id'] as String?;
    _initiatorId = snapshotData['initiator_id'] as String?;
    _initiatorName = snapshotData['initiator_name'] as String?;
    _targetId = snapshotData['target_id'] as String?;
    _targetName = snapshotData['target_name'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _pairKey = snapshotData['pair_key'] as String?;
    _status = snapshotData['status'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('reconnect_requests');

  static Stream<ReconnectRequestsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReconnectRequestsRecord.fromSnapshot(s));

  static Future<ReconnectRequestsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => ReconnectRequestsRecord.fromSnapshot(s));

  static ReconnectRequestsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReconnectRequestsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReconnectRequestsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReconnectRequestsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReconnectRequestsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReconnectRequestsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createReconnectRequestsRecordData({
  String? relationshipId,
  String? initiatorId,
  String? initiatorName,
  String? targetId,
  String? targetName,
  DateTime? createdAt,
  DateTime? updatedAt,
  String? pairKey,
  String? status,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'relationship_id': relationshipId,
      'initiator_id': initiatorId,
      'initiator_name': initiatorName,
      'target_id': targetId,
      'target_name': targetName,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'pair_key': pairKey,
      'status': status,
    }.withoutNulls,
  );

  return firestoreData;
}

class ReconnectRequestsRecordDocumentEquality
    implements Equality<ReconnectRequestsRecord> {
  const ReconnectRequestsRecordDocumentEquality();

  @override
  bool equals(ReconnectRequestsRecord? e1, ReconnectRequestsRecord? e2) {
    return e1?.relationshipId == e2?.relationshipId &&
        e1?.initiatorId == e2?.initiatorId &&
        e1?.initiatorName == e2?.initiatorName &&
        e1?.targetId == e2?.targetId &&
        e1?.targetName == e2?.targetName &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.pairKey == e2?.pairKey &&
        e1?.status == e2?.status;
  }

  @override
  int hash(ReconnectRequestsRecord? e) => const ListEquality().hash([
        e?.relationshipId,
        e?.initiatorId,
        e?.initiatorName,
        e?.targetId,
        e?.targetName,
        e?.createdAt,
        e?.updatedAt,
        e?.pairKey,
        e?.status
      ]);

  @override
  bool isValidKey(Object? o) => o is ReconnectRequestsRecord;
}
