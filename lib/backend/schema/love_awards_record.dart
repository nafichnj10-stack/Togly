import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LoveAwardsRecord extends FirestoreRecord {
  LoveAwardsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "relationship_id" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  bool hasRelationshipId() => _relationshipId != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "points" field.
  double? _points;
  double get points => _points ?? 0.0;
  bool hasPoints() => _points != null;

  // "day_key" field.
  String? _dayKey;
  String get dayKey => _dayKey ?? '';
  bool hasDayKey() => _dayKey != null;

  // "week_key" field.
  String? _weekKey;
  String get weekKey => _weekKey ?? '';
  bool hasWeekKey() => _weekKey != null;

  // "actor_uid" field.
  String? _actorUid;
  String get actorUid => _actorUid ?? '';
  bool hasActorUid() => _actorUid != null;

  // "userA_id" field.
  String? _userAId;
  String get userAId => _userAId ?? '';
  bool hasUserAId() => _userAId != null;

  // "userB_id" field.
  String? _userBId;
  String get userBId => _userBId ?? '';
  bool hasUserBId() => _userBId != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "meta" field.
  LoveAwardMetaStruct? _meta;
  LoveAwardMetaStruct get meta => _meta ?? LoveAwardMetaStruct();
  bool hasMeta() => _meta != null;

  void _initializeFields() {
    _relationshipId = snapshotData['relationship_id'] as String?;
    _type = snapshotData['type'] as String?;
    _points = castToType<double>(snapshotData['points']);
    _dayKey = snapshotData['day_key'] as String?;
    _weekKey = snapshotData['week_key'] as String?;
    _actorUid = snapshotData['actor_uid'] as String?;
    _userAId = snapshotData['userA_id'] as String?;
    _userBId = snapshotData['userB_id'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _meta = snapshotData['meta'] is LoveAwardMetaStruct
        ? snapshotData['meta']
        : LoveAwardMetaStruct.maybeFromMap(snapshotData['meta']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('love_awards');

  static Stream<LoveAwardsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => LoveAwardsRecord.fromSnapshot(s));

  static Future<LoveAwardsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => LoveAwardsRecord.fromSnapshot(s));

  static LoveAwardsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      LoveAwardsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static LoveAwardsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      LoveAwardsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'LoveAwardsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is LoveAwardsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createLoveAwardsRecordData({
  String? relationshipId,
  String? type,
  double? points,
  String? dayKey,
  String? weekKey,
  String? actorUid,
  String? userAId,
  String? userBId,
  DateTime? createdAt,
  LoveAwardMetaStruct? meta,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'relationship_id': relationshipId,
      'type': type,
      'points': points,
      'day_key': dayKey,
      'week_key': weekKey,
      'actor_uid': actorUid,
      'userA_id': userAId,
      'userB_id': userBId,
      'created_at': createdAt,
      'meta': LoveAwardMetaStruct().toMap(),
    }.withoutNulls,
  );

  // Handle nested data for "meta" field.
  addLoveAwardMetaStructData(firestoreData, meta, 'meta');

  return firestoreData;
}

class LoveAwardsRecordDocumentEquality implements Equality<LoveAwardsRecord> {
  const LoveAwardsRecordDocumentEquality();

  @override
  bool equals(LoveAwardsRecord? e1, LoveAwardsRecord? e2) {
    return e1?.relationshipId == e2?.relationshipId &&
        e1?.type == e2?.type &&
        e1?.points == e2?.points &&
        e1?.dayKey == e2?.dayKey &&
        e1?.weekKey == e2?.weekKey &&
        e1?.actorUid == e2?.actorUid &&
        e1?.userAId == e2?.userAId &&
        e1?.userBId == e2?.userBId &&
        e1?.createdAt == e2?.createdAt &&
        e1?.meta == e2?.meta;
  }

  @override
  int hash(LoveAwardsRecord? e) => const ListEquality().hash([
        e?.relationshipId,
        e?.type,
        e?.points,
        e?.dayKey,
        e?.weekKey,
        e?.actorUid,
        e?.userAId,
        e?.userBId,
        e?.createdAt,
        e?.meta
      ]);

  @override
  bool isValidKey(Object? o) => o is LoveAwardsRecord;
}
