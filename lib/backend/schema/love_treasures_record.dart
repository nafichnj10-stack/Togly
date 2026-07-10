import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LoveTreasuresRecord extends FirestoreRecord {
  LoveTreasuresRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "createdBy" field.
  DocumentReference? _createdBy;
  DocumentReference? get createdBy => _createdBy;
  bool hasCreatedBy() => _createdBy != null;

  // "partnerId" field.
  DocumentReference? _partnerId;
  DocumentReference? get partnerId => _partnerId;
  bool hasPartnerId() => _partnerId != null;

  // "durationDays" field.
  int? _durationDays;
  int get durationDays => _durationDays ?? 0;
  bool hasDurationDays() => _durationDays != null;

  // "maxSurprises" field.
  int? _maxSurprises;
  int get maxSurprises => _maxSurprises ?? 0;
  bool hasMaxSurprises() => _maxSurprises != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "unlockAt" field.
  DateTime? _unlockAt;
  DateTime? get unlockAt => _unlockAt;
  bool hasUnlockAt() => _unlockAt != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "surprisesCountUserA" field.
  int? _surprisesCountUserA;
  int get surprisesCountUserA => _surprisesCountUserA ?? 0;
  bool hasSurprisesCountUserA() => _surprisesCountUserA != null;

  // "surprisesCountUserB" field.
  int? _surprisesCountUserB;
  int get surprisesCountUserB => _surprisesCountUserB ?? 0;
  bool hasSurprisesCountUserB() => _surprisesCountUserB != null;

  // "openedAt" field.
  DateTime? _openedAt;
  DateTime? get openedAt => _openedAt;
  bool hasOpenedAt() => _openedAt != null;

  // "openedBy" field.
  DocumentReference? _openedBy;
  DocumentReference? get openedBy => _openedBy;
  bool hasOpenedBy() => _openedBy != null;

  // "createdByUid" field.
  String? _createdByUid;
  String get createdByUid => _createdByUid ?? '';
  bool hasCreatedByUid() => _createdByUid != null;

  // "partnerUid" field.
  String? _partnerUid;
  String get partnerUid => _partnerUid ?? '';
  bool hasPartnerUid() => _partnerUid != null;

  // "treasureId" field.
  String? _treasureId;
  String get treasureId => _treasureId ?? '';
  bool hasTreasureId() => _treasureId != null;

  // "relationship_id" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  bool hasRelationshipId() => _relationshipId != null;

  // "isOpened" field.
  bool? _isOpened;
  bool get isOpened => _isOpened ?? false;
  bool hasIsOpened() => _isOpened != null;

  void _initializeFields() {
    _createdBy = snapshotData['createdBy'] as DocumentReference?;
    _partnerId = snapshotData['partnerId'] as DocumentReference?;
    _durationDays = castToType<int>(snapshotData['durationDays']);
    _maxSurprises = castToType<int>(snapshotData['maxSurprises']);
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _unlockAt = snapshotData['unlockAt'] as DateTime?;
    _status = snapshotData['status'] as String?;
    _surprisesCountUserA = castToType<int>(snapshotData['surprisesCountUserA']);
    _surprisesCountUserB = castToType<int>(snapshotData['surprisesCountUserB']);
    _openedAt = snapshotData['openedAt'] as DateTime?;
    _openedBy = snapshotData['openedBy'] as DocumentReference?;
    _createdByUid = snapshotData['createdByUid'] as String?;
    _partnerUid = snapshotData['partnerUid'] as String?;
    _treasureId = snapshotData['treasureId'] as String?;
    _relationshipId = snapshotData['relationship_id'] as String?;
    _isOpened = snapshotData['isOpened'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('love_treasures');

  static Stream<LoveTreasuresRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => LoveTreasuresRecord.fromSnapshot(s));

  static Future<LoveTreasuresRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => LoveTreasuresRecord.fromSnapshot(s));

  static LoveTreasuresRecord fromSnapshot(DocumentSnapshot snapshot) =>
      LoveTreasuresRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static LoveTreasuresRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      LoveTreasuresRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'LoveTreasuresRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is LoveTreasuresRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createLoveTreasuresRecordData({
  DocumentReference? createdBy,
  DocumentReference? partnerId,
  int? durationDays,
  int? maxSurprises,
  DateTime? createdAt,
  DateTime? unlockAt,
  String? status,
  int? surprisesCountUserA,
  int? surprisesCountUserB,
  DateTime? openedAt,
  DocumentReference? openedBy,
  String? createdByUid,
  String? partnerUid,
  String? treasureId,
  String? relationshipId,
  bool? isOpened,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'createdBy': createdBy,
      'partnerId': partnerId,
      'durationDays': durationDays,
      'maxSurprises': maxSurprises,
      'createdAt': createdAt,
      'unlockAt': unlockAt,
      'status': status,
      'surprisesCountUserA': surprisesCountUserA,
      'surprisesCountUserB': surprisesCountUserB,
      'openedAt': openedAt,
      'openedBy': openedBy,
      'createdByUid': createdByUid,
      'partnerUid': partnerUid,
      'treasureId': treasureId,
      'relationship_id': relationshipId,
      'isOpened': isOpened,
    }.withoutNulls,
  );

  return firestoreData;
}

class LoveTreasuresRecordDocumentEquality
    implements Equality<LoveTreasuresRecord> {
  const LoveTreasuresRecordDocumentEquality();

  @override
  bool equals(LoveTreasuresRecord? e1, LoveTreasuresRecord? e2) {
    return e1?.createdBy == e2?.createdBy &&
        e1?.partnerId == e2?.partnerId &&
        e1?.durationDays == e2?.durationDays &&
        e1?.maxSurprises == e2?.maxSurprises &&
        e1?.createdAt == e2?.createdAt &&
        e1?.unlockAt == e2?.unlockAt &&
        e1?.status == e2?.status &&
        e1?.surprisesCountUserA == e2?.surprisesCountUserA &&
        e1?.surprisesCountUserB == e2?.surprisesCountUserB &&
        e1?.openedAt == e2?.openedAt &&
        e1?.openedBy == e2?.openedBy &&
        e1?.createdByUid == e2?.createdByUid &&
        e1?.partnerUid == e2?.partnerUid &&
        e1?.treasureId == e2?.treasureId &&
        e1?.relationshipId == e2?.relationshipId &&
        e1?.isOpened == e2?.isOpened;
  }

  @override
  int hash(LoveTreasuresRecord? e) => const ListEquality().hash([
        e?.createdBy,
        e?.partnerId,
        e?.durationDays,
        e?.maxSurprises,
        e?.createdAt,
        e?.unlockAt,
        e?.status,
        e?.surprisesCountUserA,
        e?.surprisesCountUserB,
        e?.openedAt,
        e?.openedBy,
        e?.createdByUid,
        e?.partnerUid,
        e?.treasureId,
        e?.relationshipId,
        e?.isOpened
      ]);

  @override
  bool isValidKey(Object? o) => o is LoveTreasuresRecord;
}
