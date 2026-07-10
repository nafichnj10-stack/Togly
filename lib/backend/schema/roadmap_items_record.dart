import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RoadmapItemsRecord extends FirestoreRecord {
  RoadmapItemsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "publish_at" field.
  DateTime? _publishAt;
  DateTime? get publishAt => _publishAt;
  bool hasPublishAt() => _publishAt != null;

  // "is_published" field.
  bool? _isPublished;
  bool get isPublished => _isPublished ?? false;
  bool hasIsPublished() => _isPublished != null;

  // "sort_order" field.
  double? _sortOrder;
  double get sortOrder => _sortOrder ?? 0.0;
  bool hasSortOrder() => _sortOrder != null;

  // "cover_url" field.
  String? _coverUrl;
  String get coverUrl => _coverUrl ?? '';
  bool hasCoverUrl() => _coverUrl != null;

  // "cta_label" field.
  String? _ctaLabel;
  String get ctaLabel => _ctaLabel ?? '';
  bool hasCtaLabel() => _ctaLabel != null;

  // "cta_url" field.
  String? _ctaUrl;
  String get ctaUrl => _ctaUrl ?? '';
  bool hasCtaUrl() => _ctaUrl != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "author_id" field.
  String? _authorId;
  String get authorId => _authorId ?? '';
  bool hasAuthorId() => _authorId != null;

  // "release_eta" field.
  DateTime? _releaseEta;
  DateTime? get releaseEta => _releaseEta;
  bool hasReleaseEta() => _releaseEta != null;

  // "release_text_override" field.
  String? _releaseTextOverride;
  String get releaseTextOverride => _releaseTextOverride ?? '';
  bool hasReleaseTextOverride() => _releaseTextOverride != null;

  // "release_color" field.
  String? _releaseColor;
  String get releaseColor => _releaseColor ?? '';
  bool hasReleaseColor() => _releaseColor != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _status = snapshotData['status'] as String?;
    _publishAt = snapshotData['publish_at'] as DateTime?;
    _isPublished = snapshotData['is_published'] as bool?;
    _sortOrder = castToType<double>(snapshotData['sort_order']);
    _coverUrl = snapshotData['cover_url'] as String?;
    _ctaLabel = snapshotData['cta_label'] as String?;
    _ctaUrl = snapshotData['cta_url'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _authorId = snapshotData['author_id'] as String?;
    _releaseEta = snapshotData['release_eta'] as DateTime?;
    _releaseTextOverride = snapshotData['release_text_override'] as String?;
    _releaseColor = snapshotData['release_color'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('roadmap_items');

  static Stream<RoadmapItemsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RoadmapItemsRecord.fromSnapshot(s));

  static Future<RoadmapItemsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RoadmapItemsRecord.fromSnapshot(s));

  static RoadmapItemsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RoadmapItemsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RoadmapItemsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RoadmapItemsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RoadmapItemsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RoadmapItemsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRoadmapItemsRecordData({
  String? title,
  String? description,
  String? status,
  DateTime? publishAt,
  bool? isPublished,
  double? sortOrder,
  String? coverUrl,
  String? ctaLabel,
  String? ctaUrl,
  DateTime? createdAt,
  DateTime? updatedAt,
  String? authorId,
  DateTime? releaseEta,
  String? releaseTextOverride,
  String? releaseColor,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'description': description,
      'status': status,
      'publish_at': publishAt,
      'is_published': isPublished,
      'sort_order': sortOrder,
      'cover_url': coverUrl,
      'cta_label': ctaLabel,
      'cta_url': ctaUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'author_id': authorId,
      'release_eta': releaseEta,
      'release_text_override': releaseTextOverride,
      'release_color': releaseColor,
    }.withoutNulls,
  );

  return firestoreData;
}

class RoadmapItemsRecordDocumentEquality
    implements Equality<RoadmapItemsRecord> {
  const RoadmapItemsRecordDocumentEquality();

  @override
  bool equals(RoadmapItemsRecord? e1, RoadmapItemsRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.status == e2?.status &&
        e1?.publishAt == e2?.publishAt &&
        e1?.isPublished == e2?.isPublished &&
        e1?.sortOrder == e2?.sortOrder &&
        e1?.coverUrl == e2?.coverUrl &&
        e1?.ctaLabel == e2?.ctaLabel &&
        e1?.ctaUrl == e2?.ctaUrl &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.authorId == e2?.authorId &&
        e1?.releaseEta == e2?.releaseEta &&
        e1?.releaseTextOverride == e2?.releaseTextOverride &&
        e1?.releaseColor == e2?.releaseColor;
  }

  @override
  int hash(RoadmapItemsRecord? e) => const ListEquality().hash([
        e?.title,
        e?.description,
        e?.status,
        e?.publishAt,
        e?.isPublished,
        e?.sortOrder,
        e?.coverUrl,
        e?.ctaLabel,
        e?.ctaUrl,
        e?.createdAt,
        e?.updatedAt,
        e?.authorId,
        e?.releaseEta,
        e?.releaseTextOverride,
        e?.releaseColor
      ]);

  @override
  bool isValidKey(Object? o) => o is RoadmapItemsRecord;
}
