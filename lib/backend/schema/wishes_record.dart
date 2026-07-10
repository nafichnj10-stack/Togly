import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WishesRecord extends FirestoreRecord {
  WishesRecord._(
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

  // "emoji" field.
  String? _emoji;
  String get emoji => _emoji ?? '';
  bool hasEmoji() => _emoji != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  bool hasCreatedBy() => _createdBy != null;

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

  // "completed_at" field.
  DateTime? _completedAt;
  DateTime? get completedAt => _completedAt;
  bool hasCompletedAt() => _completedAt != null;

  // "priority" field.
  double? _priority;
  double get priority => _priority ?? 0.0;
  bool hasPriority() => _priority != null;

  // "note" field.
  String? _note;
  String get note => _note ?? '';
  bool hasNote() => _note != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "link_url" field.
  String? _linkUrl;
  String get linkUrl => _linkUrl ?? '';
  bool hasLinkUrl() => _linkUrl != null;

  // "liked_by" field.
  List<String>? _likedBy;
  List<String> get likedBy => _likedBy ?? const [];
  bool hasLikedBy() => _likedBy != null;

  // "reaction_emoji" field.
  String? _reactionEmoji;
  String get reactionEmoji => _reactionEmoji ?? '';
  bool hasReactionEmoji() => _reactionEmoji != null;

  // "reaction_by" field.
  String? _reactionBy;
  String get reactionBy => _reactionBy ?? '';
  bool hasReactionBy() => _reactionBy != null;

  // "reaction_at" field.
  DateTime? _reactionAt;
  DateTime? get reactionAt => _reactionAt;
  bool hasReactionAt() => _reactionAt != null;

  // "storage_path" field.
  String? _storagePath;
  String get storagePath => _storagePath ?? '';
  bool hasStoragePath() => _storagePath != null;

  // "wishimage" field.
  String? _wishimage;
  String get wishimage => _wishimage ?? '';
  bool hasWishimage() => _wishimage != null;

  // "category_key" field.
  String? _categoryKey;
  String get categoryKey => _categoryKey ?? '';
  bool hasCategoryKey() => _categoryKey != null;

  // "category_label" field.
  String? _categoryLabel;
  String get categoryLabel => _categoryLabel ?? '';
  bool hasCategoryLabel() => _categoryLabel != null;

  void _initializeFields() {
    _relationshipId = snapshotData['relationship_id'] as String?;
    _title = snapshotData['title'] as String?;
    _emoji = snapshotData['emoji'] as String?;
    _createdBy = snapshotData['created_by'] as String?;
    _isCompleted = snapshotData['is_completed'] as bool?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _completedAt = snapshotData['completed_at'] as DateTime?;
    _priority = castToType<double>(snapshotData['priority']);
    _note = snapshotData['note'] as String?;
    _category = snapshotData['category'] as String?;
    _linkUrl = snapshotData['link_url'] as String?;
    _likedBy = getDataList(snapshotData['liked_by']);
    _reactionEmoji = snapshotData['reaction_emoji'] as String?;
    _reactionBy = snapshotData['reaction_by'] as String?;
    _reactionAt = snapshotData['reaction_at'] as DateTime?;
    _storagePath = snapshotData['storage_path'] as String?;
    _wishimage = snapshotData['wishimage'] as String?;
    _categoryKey = snapshotData['category_key'] as String?;
    _categoryLabel = snapshotData['category_label'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('wishes');

  static Stream<WishesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => WishesRecord.fromSnapshot(s));

  static Future<WishesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => WishesRecord.fromSnapshot(s));

  static WishesRecord fromSnapshot(DocumentSnapshot snapshot) => WishesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static WishesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      WishesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'WishesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is WishesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createWishesRecordData({
  String? relationshipId,
  String? title,
  String? emoji,
  String? createdBy,
  bool? isCompleted,
  DateTime? createdAt,
  DateTime? updatedAt,
  DateTime? completedAt,
  double? priority,
  String? note,
  String? category,
  String? linkUrl,
  String? reactionEmoji,
  String? reactionBy,
  DateTime? reactionAt,
  String? storagePath,
  String? wishimage,
  String? categoryKey,
  String? categoryLabel,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'relationship_id': relationshipId,
      'title': title,
      'emoji': emoji,
      'created_by': createdBy,
      'is_completed': isCompleted,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'completed_at': completedAt,
      'priority': priority,
      'note': note,
      'category': category,
      'link_url': linkUrl,
      'reaction_emoji': reactionEmoji,
      'reaction_by': reactionBy,
      'reaction_at': reactionAt,
      'storage_path': storagePath,
      'wishimage': wishimage,
      'category_key': categoryKey,
      'category_label': categoryLabel,
    }.withoutNulls,
  );

  return firestoreData;
}

class WishesRecordDocumentEquality implements Equality<WishesRecord> {
  const WishesRecordDocumentEquality();

  @override
  bool equals(WishesRecord? e1, WishesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.relationshipId == e2?.relationshipId &&
        e1?.title == e2?.title &&
        e1?.emoji == e2?.emoji &&
        e1?.createdBy == e2?.createdBy &&
        e1?.isCompleted == e2?.isCompleted &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.completedAt == e2?.completedAt &&
        e1?.priority == e2?.priority &&
        e1?.note == e2?.note &&
        e1?.category == e2?.category &&
        e1?.linkUrl == e2?.linkUrl &&
        listEquality.equals(e1?.likedBy, e2?.likedBy) &&
        e1?.reactionEmoji == e2?.reactionEmoji &&
        e1?.reactionBy == e2?.reactionBy &&
        e1?.reactionAt == e2?.reactionAt &&
        e1?.storagePath == e2?.storagePath &&
        e1?.wishimage == e2?.wishimage &&
        e1?.categoryKey == e2?.categoryKey &&
        e1?.categoryLabel == e2?.categoryLabel;
  }

  @override
  int hash(WishesRecord? e) => const ListEquality().hash([
        e?.relationshipId,
        e?.title,
        e?.emoji,
        e?.createdBy,
        e?.isCompleted,
        e?.createdAt,
        e?.updatedAt,
        e?.completedAt,
        e?.priority,
        e?.note,
        e?.category,
        e?.linkUrl,
        e?.likedBy,
        e?.reactionEmoji,
        e?.reactionBy,
        e?.reactionAt,
        e?.storagePath,
        e?.wishimage,
        e?.categoryKey,
        e?.categoryLabel
      ]);

  @override
  bool isValidKey(Object? o) => o is WishesRecord;
}
