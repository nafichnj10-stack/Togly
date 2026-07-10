import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GalleryRecord extends FirestoreRecord {
  GalleryRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "relationship_id" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  bool hasRelationshipId() => _relationshipId != null;

  // "caption" field.
  String? _caption;
  String get caption => _caption ?? '';
  bool hasCaption() => _caption != null;

  // "uploaded_by" field.
  String? _uploadedBy;
  String get uploadedBy => _uploadedBy ?? '';
  bool hasUploadedBy() => _uploadedBy != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

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

  // "album_id" field.
  String? _albumId;
  String get albumId => _albumId ?? '';
  bool hasAlbumId() => _albumId != null;

  // "storage_path" field.
  String? _storagePath;
  String get storagePath => _storagePath ?? '';
  bool hasStoragePath() => _storagePath != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  void _initializeFields() {
    _relationshipId = snapshotData['relationship_id'] as String?;
    _caption = snapshotData['caption'] as String?;
    _uploadedBy = snapshotData['uploaded_by'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _reactionEmoji = snapshotData['reaction_emoji'] as String?;
    _reactionBy = snapshotData['reaction_by'] as String?;
    _reactionAt = snapshotData['reaction_at'] as DateTime?;
    _albumId = snapshotData['album_id'] as String?;
    _storagePath = snapshotData['storage_path'] as String?;
    _imageUrl = snapshotData['image_url'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('gallery');

  static Stream<GalleryRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GalleryRecord.fromSnapshot(s));

  static Future<GalleryRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GalleryRecord.fromSnapshot(s));

  static GalleryRecord fromSnapshot(DocumentSnapshot snapshot) =>
      GalleryRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GalleryRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GalleryRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GalleryRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GalleryRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGalleryRecordData({
  String? relationshipId,
  String? caption,
  String? uploadedBy,
  DateTime? createdAt,
  String? reactionEmoji,
  String? reactionBy,
  DateTime? reactionAt,
  String? albumId,
  String? storagePath,
  String? imageUrl,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'relationship_id': relationshipId,
      'caption': caption,
      'uploaded_by': uploadedBy,
      'created_at': createdAt,
      'reaction_emoji': reactionEmoji,
      'reaction_by': reactionBy,
      'reaction_at': reactionAt,
      'album_id': albumId,
      'storage_path': storagePath,
      'image_url': imageUrl,
    }.withoutNulls,
  );

  return firestoreData;
}

class GalleryRecordDocumentEquality implements Equality<GalleryRecord> {
  const GalleryRecordDocumentEquality();

  @override
  bool equals(GalleryRecord? e1, GalleryRecord? e2) {
    return e1?.relationshipId == e2?.relationshipId &&
        e1?.caption == e2?.caption &&
        e1?.uploadedBy == e2?.uploadedBy &&
        e1?.createdAt == e2?.createdAt &&
        e1?.reactionEmoji == e2?.reactionEmoji &&
        e1?.reactionBy == e2?.reactionBy &&
        e1?.reactionAt == e2?.reactionAt &&
        e1?.albumId == e2?.albumId &&
        e1?.storagePath == e2?.storagePath &&
        e1?.imageUrl == e2?.imageUrl;
  }

  @override
  int hash(GalleryRecord? e) => const ListEquality().hash([
        e?.relationshipId,
        e?.caption,
        e?.uploadedBy,
        e?.createdAt,
        e?.reactionEmoji,
        e?.reactionBy,
        e?.reactionAt,
        e?.albumId,
        e?.storagePath,
        e?.imageUrl
      ]);

  @override
  bool isValidKey(Object? o) => o is GalleryRecord;
}
