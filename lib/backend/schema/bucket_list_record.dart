import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BucketListRecord extends FirestoreRecord {
  BucketListRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "relationship_id" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  bool hasRelationshipId() => _relationshipId != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "note" field.
  String? _note;
  String get note => _note ?? '';
  bool hasNote() => _note != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "emoji" field.
  String? _emoji;
  String get emoji => _emoji ?? '';
  bool hasEmoji() => _emoji != null;

  // "phase" field.
  String? _phase;
  String get phase => _phase ?? '';
  bool hasPhase() => _phase != null;

  // "progress_percent" field.
  double? _progressPercent;
  double get progressPercent => _progressPercent ?? 0.0;
  bool hasProgressPercent() => _progressPercent != null;

  // "amount_current" field.
  double? _amountCurrent;
  double get amountCurrent => _amountCurrent ?? 0.0;
  bool hasAmountCurrent() => _amountCurrent != null;

  // "amount_target" field.
  double? _amountTarget;
  double get amountTarget => _amountTarget ?? 0.0;
  bool hasAmountTarget() => _amountTarget != null;

  // "currency" field.
  String? _currency;
  String get currency => _currency ?? '';
  bool hasCurrency() => _currency != null;

  // "target_date" field.
  DateTime? _targetDate;
  DateTime? get targetDate => _targetDate;
  bool hasTargetDate() => _targetDate != null;

  // "is_completed" field.
  bool? _isCompleted;
  bool get isCompleted => _isCompleted ?? false;
  bool hasIsCompleted() => _isCompleted != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  bool hasCreatedBy() => _createdBy != null;

  // "updated_by" field.
  String? _updatedBy;
  String get updatedBy => _updatedBy ?? '';
  bool hasUpdatedBy() => _updatedBy != null;

  // "sort_order" field.
  double? _sortOrder;
  double get sortOrder => _sortOrder ?? 0.0;
  bool hasSortOrder() => _sortOrder != null;

  // "image_path" field.
  String? _imagePath;
  String get imagePath => _imagePath ?? '';
  bool hasImagePath() => _imagePath != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  // "completed_at" field.
  DateTime? _completedAt;
  DateTime? get completedAt => _completedAt;
  bool hasCompletedAt() => _completedAt != null;

  // "completed_by" field.
  String? _completedBy;
  String get completedBy => _completedBy ?? '';
  bool hasCompletedBy() => _completedBy != null;

  // "category_key" field.
  String? _categoryKey;
  String get categoryKey => _categoryKey ?? '';
  bool hasCategoryKey() => _categoryKey != null;

  // "category_label" field.
  String? _categoryLabel;
  String get categoryLabel => _categoryLabel ?? '';
  bool hasCategoryLabel() => _categoryLabel != null;

  // "phase_key" field.
  String? _phaseKey;
  String get phaseKey => _phaseKey ?? '';
  bool hasPhaseKey() => _phaseKey != null;

  // "phase_label" field.
  String? _phaseLabel;
  String get phaseLabel => _phaseLabel ?? '';
  bool hasPhaseLabel() => _phaseLabel != null;

  void _initializeFields() {
    _relationshipId = snapshotData['relationship_id'] as String?;
    _title = snapshotData['title'] as String?;
    _note = snapshotData['note'] as String?;
    _category = snapshotData['category'] as String?;
    _emoji = snapshotData['emoji'] as String?;
    _phase = snapshotData['phase'] as String?;
    _progressPercent = castToType<double>(snapshotData['progress_percent']);
    _amountCurrent = castToType<double>(snapshotData['amount_current']);
    _amountTarget = castToType<double>(snapshotData['amount_target']);
    _currency = snapshotData['currency'] as String?;
    _targetDate = snapshotData['target_date'] as DateTime?;
    _isCompleted = snapshotData['is_completed'] as bool?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as String?;
    _updatedBy = snapshotData['updated_by'] as String?;
    _sortOrder = castToType<double>(snapshotData['sort_order']);
    _imagePath = snapshotData['image_path'] as String?;
    _imageUrl = snapshotData['image_url'] as String?;
    _completedAt = snapshotData['completed_at'] as DateTime?;
    _completedBy = snapshotData['completed_by'] as String?;
    _categoryKey = snapshotData['category_key'] as String?;
    _categoryLabel = snapshotData['category_label'] as String?;
    _phaseKey = snapshotData['phase_key'] as String?;
    _phaseLabel = snapshotData['phase_label'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('bucket_list');

  static Stream<BucketListRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BucketListRecord.fromSnapshot(s));

  static Future<BucketListRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BucketListRecord.fromSnapshot(s));

  static BucketListRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BucketListRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BucketListRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BucketListRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BucketListRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BucketListRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBucketListRecordData({
  String? relationshipId,
  String? title,
  String? note,
  String? category,
  String? emoji,
  String? phase,
  double? progressPercent,
  double? amountCurrent,
  double? amountTarget,
  String? currency,
  DateTime? targetDate,
  bool? isCompleted,
  DateTime? createdAt,
  DateTime? updatedAt,
  String? createdBy,
  String? updatedBy,
  double? sortOrder,
  String? imagePath,
  String? imageUrl,
  DateTime? completedAt,
  String? completedBy,
  String? categoryKey,
  String? categoryLabel,
  String? phaseKey,
  String? phaseLabel,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'relationship_id': relationshipId,
      'title': title,
      'note': note,
      'category': category,
      'emoji': emoji,
      'phase': phase,
      'progress_percent': progressPercent,
      'amount_current': amountCurrent,
      'amount_target': amountTarget,
      'currency': currency,
      'target_date': targetDate,
      'is_completed': isCompleted,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'sort_order': sortOrder,
      'image_path': imagePath,
      'image_url': imageUrl,
      'completed_at': completedAt,
      'completed_by': completedBy,
      'category_key': categoryKey,
      'category_label': categoryLabel,
      'phase_key': phaseKey,
      'phase_label': phaseLabel,
    }.withoutNulls,
  );

  return firestoreData;
}

class BucketListRecordDocumentEquality implements Equality<BucketListRecord> {
  const BucketListRecordDocumentEquality();

  @override
  bool equals(BucketListRecord? e1, BucketListRecord? e2) {
    return e1?.relationshipId == e2?.relationshipId &&
        e1?.title == e2?.title &&
        e1?.note == e2?.note &&
        e1?.category == e2?.category &&
        e1?.emoji == e2?.emoji &&
        e1?.phase == e2?.phase &&
        e1?.progressPercent == e2?.progressPercent &&
        e1?.amountCurrent == e2?.amountCurrent &&
        e1?.amountTarget == e2?.amountTarget &&
        e1?.currency == e2?.currency &&
        e1?.targetDate == e2?.targetDate &&
        e1?.isCompleted == e2?.isCompleted &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.createdBy == e2?.createdBy &&
        e1?.updatedBy == e2?.updatedBy &&
        e1?.sortOrder == e2?.sortOrder &&
        e1?.imagePath == e2?.imagePath &&
        e1?.imageUrl == e2?.imageUrl &&
        e1?.completedAt == e2?.completedAt &&
        e1?.completedBy == e2?.completedBy &&
        e1?.categoryKey == e2?.categoryKey &&
        e1?.categoryLabel == e2?.categoryLabel &&
        e1?.phaseKey == e2?.phaseKey &&
        e1?.phaseLabel == e2?.phaseLabel;
  }

  @override
  int hash(BucketListRecord? e) => const ListEquality().hash([
        e?.relationshipId,
        e?.title,
        e?.note,
        e?.category,
        e?.emoji,
        e?.phase,
        e?.progressPercent,
        e?.amountCurrent,
        e?.amountTarget,
        e?.currency,
        e?.targetDate,
        e?.isCompleted,
        e?.createdAt,
        e?.updatedAt,
        e?.createdBy,
        e?.updatedBy,
        e?.sortOrder,
        e?.imagePath,
        e?.imageUrl,
        e?.completedAt,
        e?.completedBy,
        e?.categoryKey,
        e?.categoryLabel,
        e?.phaseKey,
        e?.phaseLabel
      ]);

  @override
  bool isValidKey(Object? o) => o is BucketListRecord;
}
