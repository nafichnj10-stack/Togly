import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PublicUsersRecord extends FirestoreRecord {
  PublicUsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  bool hasCity() => _city != null;

  // "local_time" field.
  DateTime? _localTime;
  DateTime? get localTime => _localTime;
  bool hasLocalTime() => _localTime != null;

  // "dummyGender" field.
  String? _dummyGender;
  String get dummyGender => _dummyGender ?? '';
  bool hasDummyGender() => _dummyGender != null;

  // "relationship_id" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  bool hasRelationshipId() => _relationshipId != null;

  // "partnerUID" field.
  String? _partnerUID;
  String get partnerUID => _partnerUID ?? '';
  bool hasPartnerUID() => _partnerUID != null;

  // "love_code" field.
  String? _loveCode;
  String get loveCode => _loveCode ?? '';
  bool hasLoveCode() => _loveCode != null;

  // "onboardingCompleted" field.
  bool? _onboardingCompleted;
  bool get onboardingCompleted => _onboardingCompleted ?? false;
  bool hasOnboardingCompleted() => _onboardingCompleted != null;

  // "together_since" field.
  DateTime? _togetherSince;
  DateTime? get togetherSince => _togetherSince;
  bool hasTogetherSince() => _togetherSince != null;

  // "country_name" field.
  String? _countryName;
  String get countryName => _countryName ?? '';
  bool hasCountryName() => _countryName != null;

  // "country_code" field.
  String? _countryCode;
  String get countryCode => _countryCode ?? '';
  bool hasCountryCode() => _countryCode != null;

  // "home_lat" field.
  double? _homeLat;
  double get homeLat => _homeLat ?? 0.0;
  bool hasHomeLat() => _homeLat != null;

  // "home_lng" field.
  double? _homeLng;
  double get homeLng => _homeLng ?? 0.0;
  bool hasHomeLng() => _homeLng != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _name = snapshotData['name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _city = snapshotData['city'] as String?;
    _localTime = snapshotData['local_time'] as DateTime?;
    _dummyGender = snapshotData['dummyGender'] as String?;
    _relationshipId = snapshotData['relationship_id'] as String?;
    _partnerUID = snapshotData['partnerUID'] as String?;
    _loveCode = snapshotData['love_code'] as String?;
    _onboardingCompleted = snapshotData['onboardingCompleted'] as bool?;
    _togetherSince = snapshotData['together_since'] as DateTime?;
    _countryName = snapshotData['country_name'] as String?;
    _countryCode = snapshotData['country_code'] as String?;
    _homeLat = castToType<double>(snapshotData['home_lat']);
    _homeLng = castToType<double>(snapshotData['home_lng']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('PublicUsers');

  static Stream<PublicUsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PublicUsersRecord.fromSnapshot(s));

  static Future<PublicUsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PublicUsersRecord.fromSnapshot(s));

  static PublicUsersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PublicUsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PublicUsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PublicUsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PublicUsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PublicUsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPublicUsersRecordData({
  String? uid,
  String? name,
  String? photoUrl,
  String? city,
  DateTime? localTime,
  String? dummyGender,
  String? relationshipId,
  String? partnerUID,
  String? loveCode,
  bool? onboardingCompleted,
  DateTime? togetherSince,
  String? countryName,
  String? countryCode,
  double? homeLat,
  double? homeLng,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'name': name,
      'photo_url': photoUrl,
      'city': city,
      'local_time': localTime,
      'dummyGender': dummyGender,
      'relationship_id': relationshipId,
      'partnerUID': partnerUID,
      'love_code': loveCode,
      'onboardingCompleted': onboardingCompleted,
      'together_since': togetherSince,
      'country_name': countryName,
      'country_code': countryCode,
      'home_lat': homeLat,
      'home_lng': homeLng,
    }.withoutNulls,
  );

  return firestoreData;
}

class PublicUsersRecordDocumentEquality implements Equality<PublicUsersRecord> {
  const PublicUsersRecordDocumentEquality();

  @override
  bool equals(PublicUsersRecord? e1, PublicUsersRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.name == e2?.name &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.city == e2?.city &&
        e1?.localTime == e2?.localTime &&
        e1?.dummyGender == e2?.dummyGender &&
        e1?.relationshipId == e2?.relationshipId &&
        e1?.partnerUID == e2?.partnerUID &&
        e1?.loveCode == e2?.loveCode &&
        e1?.onboardingCompleted == e2?.onboardingCompleted &&
        e1?.togetherSince == e2?.togetherSince &&
        e1?.countryName == e2?.countryName &&
        e1?.countryCode == e2?.countryCode &&
        e1?.homeLat == e2?.homeLat &&
        e1?.homeLng == e2?.homeLng;
  }

  @override
  int hash(PublicUsersRecord? e) => const ListEquality().hash([
        e?.uid,
        e?.name,
        e?.photoUrl,
        e?.city,
        e?.localTime,
        e?.dummyGender,
        e?.relationshipId,
        e?.partnerUID,
        e?.loveCode,
        e?.onboardingCompleted,
        e?.togetherSince,
        e?.countryName,
        e?.countryCode,
        e?.homeLat,
        e?.homeLng
      ]);

  @override
  bool isValidKey(Object? o) => o is PublicUsersRecord;
}
