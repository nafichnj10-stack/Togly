import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FeedbackRecord extends FirestoreRecord {
  FeedbackRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "last_update_at" field.
  DateTime? _lastUpdateAt;
  DateTime? get lastUpdateAt => _lastUpdateAt;
  bool hasLastUpdateAt() => _lastUpdateAt != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "feedback_code" field.
  String? _feedbackCode;
  String get feedbackCode => _feedbackCode ?? '';
  bool hasFeedbackCode() => _feedbackCode != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "relationship_id" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  bool hasRelationshipId() => _relationshipId != null;

  // "app_version" field.
  String? _appVersion;
  String get appVersion => _appVersion ?? '';
  bool hasAppVersion() => _appVersion != null;

  // "platform" field.
  String? _platform;
  String get platform => _platform ?? '';
  bool hasPlatform() => _platform != null;

  // "locale" field.
  String? _locale;
  String get locale => _locale ?? '';
  bool hasLocale() => _locale != null;

  void _initializeFields() {
    _createdAt = snapshotData['created_at'] as DateTime?;
    _lastUpdateAt = snapshotData['last_update_at'] as DateTime?;
    _status = snapshotData['status'] as String?;
    _feedbackCode = snapshotData['feedback_code'] as String?;
    _type = snapshotData['type'] as String?;
    _rating = castToType<double>(snapshotData['rating']);
    _message = snapshotData['message'] as String?;
    _email = snapshotData['email'] as String?;
    _userId = snapshotData['user_id'] as String?;
    _relationshipId = snapshotData['relationship_id'] as String?;
    _appVersion = snapshotData['app_version'] as String?;
    _platform = snapshotData['platform'] as String?;
    _locale = snapshotData['locale'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('feedback');

  static Stream<FeedbackRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FeedbackRecord.fromSnapshot(s));

  static Future<FeedbackRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FeedbackRecord.fromSnapshot(s));

  static FeedbackRecord fromSnapshot(DocumentSnapshot snapshot) =>
      FeedbackRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FeedbackRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FeedbackRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FeedbackRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FeedbackRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFeedbackRecordData({
  DateTime? createdAt,
  DateTime? lastUpdateAt,
  String? status,
  String? feedbackCode,
  String? type,
  double? rating,
  String? message,
  String? email,
  String? userId,
  String? relationshipId,
  String? appVersion,
  String? platform,
  String? locale,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_at': createdAt,
      'last_update_at': lastUpdateAt,
      'status': status,
      'feedback_code': feedbackCode,
      'type': type,
      'rating': rating,
      'message': message,
      'email': email,
      'user_id': userId,
      'relationship_id': relationshipId,
      'app_version': appVersion,
      'platform': platform,
      'locale': locale,
    }.withoutNulls,
  );

  return firestoreData;
}

class FeedbackRecordDocumentEquality implements Equality<FeedbackRecord> {
  const FeedbackRecordDocumentEquality();

  @override
  bool equals(FeedbackRecord? e1, FeedbackRecord? e2) {
    return e1?.createdAt == e2?.createdAt &&
        e1?.lastUpdateAt == e2?.lastUpdateAt &&
        e1?.status == e2?.status &&
        e1?.feedbackCode == e2?.feedbackCode &&
        e1?.type == e2?.type &&
        e1?.rating == e2?.rating &&
        e1?.message == e2?.message &&
        e1?.email == e2?.email &&
        e1?.userId == e2?.userId &&
        e1?.relationshipId == e2?.relationshipId &&
        e1?.appVersion == e2?.appVersion &&
        e1?.platform == e2?.platform &&
        e1?.locale == e2?.locale;
  }

  @override
  int hash(FeedbackRecord? e) => const ListEquality().hash([
        e?.createdAt,
        e?.lastUpdateAt,
        e?.status,
        e?.feedbackCode,
        e?.type,
        e?.rating,
        e?.message,
        e?.email,
        e?.userId,
        e?.relationshipId,
        e?.appVersion,
        e?.platform,
        e?.locale
      ]);

  @override
  bool isValidKey(Object? o) => o is FeedbackRecord;
}
