import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AlbumsRecord extends FirestoreRecord {
  AlbumsRecord._(
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

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  bool hasCreatedBy() => _createdBy != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "cover_url" field.
  String? _coverUrl;
  String get coverUrl => _coverUrl ?? '';
  bool hasCoverUrl() => _coverUrl != null;

  // "storage_path" field.
  String? _storagePath;
  String get storagePath => _storagePath ?? '';
  bool hasStoragePath() => _storagePath != null;

  // "photo_count" field.
  int? _photoCount;
  int get photoCount => _photoCount ?? 0;
  bool hasPhotoCount() => _photoCount != null;

  void _initializeFields() {
    _relationshipId = snapshotData['relationship_id'] as String?;
    _title = snapshotData['title'] as String?;
    _createdBy = snapshotData['created_by'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _coverUrl = snapshotData['cover_url'] as String?;
    _storagePath = snapshotData['storage_path'] as String?;
    _photoCount = castToType<int>(snapshotData['photo_count']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('albums');

  static Stream<AlbumsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AlbumsRecord.fromSnapshot(s));

  static Future<AlbumsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AlbumsRecord.fromSnapshot(s));

  static AlbumsRecord fromSnapshot(DocumentSnapshot snapshot) => AlbumsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AlbumsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AlbumsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AlbumsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AlbumsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAlbumsRecordData({
  String? relationshipId,
  String? title,
  String? createdBy,
  DateTime? createdAt,
  String? coverUrl,
  String? storagePath,
  int? photoCount,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'relationship_id': relationshipId,
      'title': title,
      'created_by': createdBy,
      'created_at': createdAt,
      'cover_url': coverUrl,
      'storage_path': storagePath,
      'photo_count': photoCount,
    }.withoutNulls,
  );

  return firestoreData;
}

class AlbumsRecordDocumentEquality implements Equality<AlbumsRecord> {
  const AlbumsRecordDocumentEquality();

  @override
  bool equals(AlbumsRecord? e1, AlbumsRecord? e2) {
    return e1?.relationshipId == e2?.relationshipId &&
        e1?.title == e2?.title &&
        e1?.createdBy == e2?.createdBy &&
        e1?.createdAt == e2?.createdAt &&
        e1?.coverUrl == e2?.coverUrl &&
        e1?.storagePath == e2?.storagePath &&
        e1?.photoCount == e2?.photoCount;
  }

  @override
  int hash(AlbumsRecord? e) => const ListEquality().hash([
        e?.relationshipId,
        e?.title,
        e?.createdBy,
        e?.createdAt,
        e?.coverUrl,
        e?.storagePath,
        e?.photoCount
      ]);

  @override
  bool isValidKey(Object? o) => o is AlbumsRecord;
}
