import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TreasureSurprisesRecord extends FirestoreRecord {
  TreasureSurprisesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "createdBy" field.
  DocumentReference? _createdBy;
  DocumentReference? get createdBy => _createdBy;
  bool hasCreatedBy() => _createdBy != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "revealOrder" field.
  int? _revealOrder;
  int get revealOrder => _revealOrder ?? 0;
  bool hasRevealOrder() => _revealOrder != null;

  // "revealed" field.
  bool? _revealed;
  bool get revealed => _revealed ?? false;
  bool hasRevealed() => _revealed != null;

  // "audioUrl" field.
  String? _audioUrl;
  String get audioUrl => _audioUrl ?? '';
  bool hasAudioUrl() => _audioUrl != null;

  // "durationMs" field.
  int? _durationMs;
  int get durationMs => _durationMs ?? 0;
  bool hasDurationMs() => _durationMs != null;

  // "treasureRef" field.
  DocumentReference? _treasureRef;
  DocumentReference? get treasureRef => _treasureRef;
  bool hasTreasureRef() => _treasureRef != null;

  // "relationship_id" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  bool hasRelationshipId() => _relationshipId != null;

  // "createdByUid" field.
  String? _createdByUid;
  String get createdByUid => _createdByUid ?? '';
  bool hasCreatedByUid() => _createdByUid != null;

  // "storage_path" field.
  String? _storagePath;
  String get storagePath => _storagePath ?? '';
  bool hasStoragePath() => _storagePath != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "coupon_id" field.
  String? _couponId;
  String get couponId => _couponId ?? '';
  bool hasCouponId() => _couponId != null;

  // "audioPath" field.
  String? _audioPath;
  String get audioPath => _audioPath ?? '';
  bool hasAudioPath() => _audioPath != null;

  // "noteIcon" field.
  String? _noteIcon;
  String get noteIcon => _noteIcon ?? '';
  bool hasNoteIcon() => _noteIcon != null;

  // "rotation" field.
  int? _rotation;
  int get rotation => _rotation ?? 0;
  bool hasRotation() => _rotation != null;

  // "noteStyle" field.
  int? _noteStyle;
  int get noteStyle => _noteStyle ?? 0;
  bool hasNoteStyle() => _noteStyle != null;

  void _initializeFields() {
    _createdBy = snapshotData['createdBy'] as DocumentReference?;
    _type = snapshotData['type'] as String?;
    _text = snapshotData['text'] as String?;
    _title = snapshotData['title'] as String?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _revealOrder = castToType<int>(snapshotData['revealOrder']);
    _revealed = snapshotData['revealed'] as bool?;
    _audioUrl = snapshotData['audioUrl'] as String?;
    _durationMs = castToType<int>(snapshotData['durationMs']);
    _treasureRef = snapshotData['treasureRef'] as DocumentReference?;
    _relationshipId = snapshotData['relationship_id'] as String?;
    _createdByUid = snapshotData['createdByUid'] as String?;
    _storagePath = snapshotData['storage_path'] as String?;
    _image = snapshotData['image'] as String?;
    _couponId = snapshotData['coupon_id'] as String?;
    _audioPath = snapshotData['audioPath'] as String?;
    _noteIcon = snapshotData['noteIcon'] as String?;
    _rotation = castToType<int>(snapshotData['rotation']);
    _noteStyle = castToType<int>(snapshotData['noteStyle']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('treasure_surprises');

  static Stream<TreasureSurprisesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TreasureSurprisesRecord.fromSnapshot(s));

  static Future<TreasureSurprisesRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => TreasureSurprisesRecord.fromSnapshot(s));

  static TreasureSurprisesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TreasureSurprisesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TreasureSurprisesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TreasureSurprisesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TreasureSurprisesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TreasureSurprisesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTreasureSurprisesRecordData({
  DocumentReference? createdBy,
  String? type,
  String? text,
  String? title,
  DateTime? createdAt,
  int? revealOrder,
  bool? revealed,
  String? audioUrl,
  int? durationMs,
  DocumentReference? treasureRef,
  String? relationshipId,
  String? createdByUid,
  String? storagePath,
  String? image,
  String? couponId,
  String? audioPath,
  String? noteIcon,
  int? rotation,
  int? noteStyle,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'createdBy': createdBy,
      'type': type,
      'text': text,
      'title': title,
      'createdAt': createdAt,
      'revealOrder': revealOrder,
      'revealed': revealed,
      'audioUrl': audioUrl,
      'durationMs': durationMs,
      'treasureRef': treasureRef,
      'relationship_id': relationshipId,
      'createdByUid': createdByUid,
      'storage_path': storagePath,
      'image': image,
      'coupon_id': couponId,
      'audioPath': audioPath,
      'noteIcon': noteIcon,
      'rotation': rotation,
      'noteStyle': noteStyle,
    }.withoutNulls,
  );

  return firestoreData;
}

class TreasureSurprisesRecordDocumentEquality
    implements Equality<TreasureSurprisesRecord> {
  const TreasureSurprisesRecordDocumentEquality();

  @override
  bool equals(TreasureSurprisesRecord? e1, TreasureSurprisesRecord? e2) {
    return e1?.createdBy == e2?.createdBy &&
        e1?.type == e2?.type &&
        e1?.text == e2?.text &&
        e1?.title == e2?.title &&
        e1?.createdAt == e2?.createdAt &&
        e1?.revealOrder == e2?.revealOrder &&
        e1?.revealed == e2?.revealed &&
        e1?.audioUrl == e2?.audioUrl &&
        e1?.durationMs == e2?.durationMs &&
        e1?.treasureRef == e2?.treasureRef &&
        e1?.relationshipId == e2?.relationshipId &&
        e1?.createdByUid == e2?.createdByUid &&
        e1?.storagePath == e2?.storagePath &&
        e1?.image == e2?.image &&
        e1?.couponId == e2?.couponId &&
        e1?.audioPath == e2?.audioPath &&
        e1?.noteIcon == e2?.noteIcon &&
        e1?.rotation == e2?.rotation &&
        e1?.noteStyle == e2?.noteStyle;
  }

  @override
  int hash(TreasureSurprisesRecord? e) => const ListEquality().hash([
        e?.createdBy,
        e?.type,
        e?.text,
        e?.title,
        e?.createdAt,
        e?.revealOrder,
        e?.revealed,
        e?.audioUrl,
        e?.durationMs,
        e?.treasureRef,
        e?.relationshipId,
        e?.createdByUid,
        e?.storagePath,
        e?.image,
        e?.couponId,
        e?.audioPath,
        e?.noteIcon,
        e?.rotation,
        e?.noteStyle
      ]);

  @override
  bool isValidKey(Object? o) => o is TreasureSurprisesRecord;
}
