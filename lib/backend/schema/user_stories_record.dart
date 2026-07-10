import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserStoriesRecord extends FirestoreRecord {
  UserStoriesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "relationship_id" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  bool hasRelationshipId() => _relationshipId != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "story_text" field.
  String? _storyText;
  String get storyText => _storyText ?? '';
  bool hasStoryText() => _storyText != null;

  // "experience_text" field.
  String? _experienceText;
  String get experienceText => _experienceText ?? '';
  bool hasExperienceText() => _experienceText != null;

  // "suggestions_text" field.
  String? _suggestionsText;
  String get suggestionsText => _suggestionsText ?? '';
  bool hasSuggestionsText() => _suggestionsText != null;

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

  // "published_at" field.
  DateTime? _publishedAt;
  DateTime? get publishedAt => _publishedAt;
  bool hasPublishedAt() => _publishedAt != null;

  // "admin_notes" field.
  String? _adminNotes;
  String get adminNotes => _adminNotes ?? '';
  bool hasAdminNotes() => _adminNotes != null;

  // "locale" field.
  String? _locale;
  String get locale => _locale ?? '';
  bool hasLocale() => _locale != null;

  // "country" field.
  String? _country;
  String get country => _country ?? '';
  bool hasCountry() => _country != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  // "allow_public_use" field.
  String? _allowPublicUse;
  String get allowPublicUse => _allowPublicUse ?? '';
  bool hasAllowPublicUse() => _allowPublicUse != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "photo_storage_path" field.
  String? _photoStoragePath;
  String get photoStoragePath => _photoStoragePath ?? '';
  bool hasPhotoStoragePath() => _photoStoragePath != null;

  // "video_url" field.
  String? _videoUrl;
  String get videoUrl => _videoUrl ?? '';
  bool hasVideoUrl() => _videoUrl != null;

  // "video_storage_path" field.
  String? _videoStoragePath;
  String get videoStoragePath => _videoStoragePath ?? '';
  bool hasVideoStoragePath() => _videoStoragePath != null;

  // "social_media" field.
  String? _socialMedia;
  String get socialMedia => _socialMedia ?? '';
  bool hasSocialMedia() => _socialMedia != null;

  void _initializeFields() {
    _userId = snapshotData['user_id'] as String?;
    _relationshipId = snapshotData['relationship_id'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _email = snapshotData['email'] as String?;
    _storyText = snapshotData['story_text'] as String?;
    _experienceText = snapshotData['experience_text'] as String?;
    _suggestionsText = snapshotData['suggestions_text'] as String?;
    _status = snapshotData['status'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _publishedAt = snapshotData['published_at'] as DateTime?;
    _adminNotes = snapshotData['admin_notes'] as String?;
    _locale = snapshotData['locale'] as String?;
    _country = snapshotData['country'] as String?;
    _rating = castToType<double>(snapshotData['rating']);
    _allowPublicUse = snapshotData['allow_public_use'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _photoStoragePath = snapshotData['photo_storage_path'] as String?;
    _videoUrl = snapshotData['video_url'] as String?;
    _videoStoragePath = snapshotData['video_storage_path'] as String?;
    _socialMedia = snapshotData['social_media'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('user_stories');

  static Stream<UserStoriesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserStoriesRecord.fromSnapshot(s));

  static Future<UserStoriesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserStoriesRecord.fromSnapshot(s));

  static UserStoriesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserStoriesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserStoriesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserStoriesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserStoriesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserStoriesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserStoriesRecordData({
  String? userId,
  String? relationshipId,
  String? displayName,
  String? email,
  String? storyText,
  String? experienceText,
  String? suggestionsText,
  String? status,
  DateTime? createdAt,
  DateTime? updatedAt,
  DateTime? publishedAt,
  String? adminNotes,
  String? locale,
  String? country,
  double? rating,
  String? allowPublicUse,
  String? photoUrl,
  String? photoStoragePath,
  String? videoUrl,
  String? videoStoragePath,
  String? socialMedia,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_id': userId,
      'relationship_id': relationshipId,
      'display_name': displayName,
      'email': email,
      'story_text': storyText,
      'experience_text': experienceText,
      'suggestions_text': suggestionsText,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'published_at': publishedAt,
      'admin_notes': adminNotes,
      'locale': locale,
      'country': country,
      'rating': rating,
      'allow_public_use': allowPublicUse,
      'photo_url': photoUrl,
      'photo_storage_path': photoStoragePath,
      'video_url': videoUrl,
      'video_storage_path': videoStoragePath,
      'social_media': socialMedia,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserStoriesRecordDocumentEquality implements Equality<UserStoriesRecord> {
  const UserStoriesRecordDocumentEquality();

  @override
  bool equals(UserStoriesRecord? e1, UserStoriesRecord? e2) {
    return e1?.userId == e2?.userId &&
        e1?.relationshipId == e2?.relationshipId &&
        e1?.displayName == e2?.displayName &&
        e1?.email == e2?.email &&
        e1?.storyText == e2?.storyText &&
        e1?.experienceText == e2?.experienceText &&
        e1?.suggestionsText == e2?.suggestionsText &&
        e1?.status == e2?.status &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.publishedAt == e2?.publishedAt &&
        e1?.adminNotes == e2?.adminNotes &&
        e1?.locale == e2?.locale &&
        e1?.country == e2?.country &&
        e1?.rating == e2?.rating &&
        e1?.allowPublicUse == e2?.allowPublicUse &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.photoStoragePath == e2?.photoStoragePath &&
        e1?.videoUrl == e2?.videoUrl &&
        e1?.videoStoragePath == e2?.videoStoragePath &&
        e1?.socialMedia == e2?.socialMedia;
  }

  @override
  int hash(UserStoriesRecord? e) => const ListEquality().hash([
        e?.userId,
        e?.relationshipId,
        e?.displayName,
        e?.email,
        e?.storyText,
        e?.experienceText,
        e?.suggestionsText,
        e?.status,
        e?.createdAt,
        e?.updatedAt,
        e?.publishedAt,
        e?.adminNotes,
        e?.locale,
        e?.country,
        e?.rating,
        e?.allowPublicUse,
        e?.photoUrl,
        e?.photoStoragePath,
        e?.videoUrl,
        e?.videoStoragePath,
        e?.socialMedia
      ]);

  @override
  bool isValidKey(Object? o) => o is UserStoriesRecord;
}
