import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "birthday" field.
  DateTime? _birthday;
  DateTime? get birthday => _birthday;
  bool hasBirthday() => _birthday != null;

  // "referral_source" field.
  String? _referralSource;
  String get referralSource => _referralSource ?? '';
  bool hasReferralSource() => _referralSource != null;

  // "local_time" field.
  String? _localTime;
  String get localTime => _localTime ?? '';
  bool hasLocalTime() => _localTime != null;

  // "love_code" field.
  String? _loveCode;
  String get loveCode => _loveCode ?? '';
  bool hasLoveCode() => _loveCode != null;

  // "relationship_id" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  bool hasRelationshipId() => _relationshipId != null;

  // "partnerUID" field.
  String? _partnerUID;
  String get partnerUID => _partnerUID ?? '';
  bool hasPartnerUID() => _partnerUID != null;

  // "tz_offset_minutes" field.
  int? _tzOffsetMinutes;
  int get tzOffsetMinutes => _tzOffsetMinutes ?? 0;
  bool hasTzOffsetMinutes() => _tzOffsetMinutes != null;

  // "disconnect_cooldown_until" field.
  DateTime? _disconnectCooldownUntil;
  DateTime? get disconnectCooldownUntil => _disconnectCooldownUntil;
  bool hasDisconnectCooldownUntil() => _disconnectCooldownUntil != null;

  // "last_relationship_id" field.
  String? _lastRelationshipId;
  String get lastRelationshipId => _lastRelationshipId ?? '';
  bool hasLastRelationshipId() => _lastRelationshipId != null;

  // "last_relationship_ref" field.
  DocumentReference? _lastRelationshipRef;
  DocumentReference? get lastRelationshipRef => _lastRelationshipRef;
  bool hasLastRelationshipRef() => _lastRelationshipRef != null;

  // "is_admin" field.
  bool? _isAdmin;
  bool get isAdmin => _isAdmin ?? false;
  bool hasIsAdmin() => _isAdmin != null;

  // "messagesEnabled" field.
  bool? _messagesEnabled;
  bool get messagesEnabled => _messagesEnabled ?? false;
  bool hasMessagesEnabled() => _messagesEnabled != null;

  // "dailyQuestionPartnerAlertsEnabled" field.
  bool? _dailyQuestionPartnerAlertsEnabled;
  bool get dailyQuestionPartnerAlertsEnabled =>
      _dailyQuestionPartnerAlertsEnabled ?? false;
  bool hasDailyQuestionPartnerAlertsEnabled() =>
      _dailyQuestionPartnerAlertsEnabled != null;

  // "relationshipAlertsEnabled" field.
  bool? _relationshipAlertsEnabled;
  bool get relationshipAlertsEnabled => _relationshipAlertsEnabled ?? false;
  bool hasRelationshipAlertsEnabled() => _relationshipAlertsEnabled != null;

  // "sharedMomentsEnabled" field.
  bool? _sharedMomentsEnabled;
  bool get sharedMomentsEnabled => _sharedMomentsEnabled ?? false;
  bool hasSharedMomentsEnabled() => _sharedMomentsEnabled != null;

  // "dailyQuestionRemindersEnabled" field.
  bool? _dailyQuestionRemindersEnabled;
  bool get dailyQuestionRemindersEnabled =>
      _dailyQuestionRemindersEnabled ?? false;
  bool hasDailyQuestionRemindersEnabled() =>
      _dailyQuestionRemindersEnabled != null;

  // "stayConnectedRemindersEnabled" field.
  bool? _stayConnectedRemindersEnabled;
  bool get stayConnectedRemindersEnabled =>
      _stayConnectedRemindersEnabled ?? false;
  bool hasStayConnectedRemindersEnabled() =>
      _stayConnectedRemindersEnabled != null;

  // "muteAllNotifications" field.
  bool? _muteAllNotifications;
  bool get muteAllNotifications => _muteAllNotifications ?? false;
  bool hasMuteAllNotifications() => _muteAllNotifications != null;

  // "lastDailyQuestionReminderAt" field.
  DateTime? _lastDailyQuestionReminderAt;
  DateTime? get lastDailyQuestionReminderAt => _lastDailyQuestionReminderAt;
  bool hasLastDailyQuestionReminderAt() => _lastDailyQuestionReminderAt != null;

  // "lastStayConnectedReminderAt" field.
  DateTime? _lastStayConnectedReminderAt;
  DateTime? get lastStayConnectedReminderAt => _lastStayConnectedReminderAt;
  bool hasLastStayConnectedReminderAt() => _lastStayConnectedReminderAt != null;

  // "onboardingCompleted" field.
  bool? _onboardingCompleted;
  bool get onboardingCompleted => _onboardingCompleted ?? false;
  bool hasOnboardingCompleted() => _onboardingCompleted != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "appLanguage" field.
  String? _appLanguage;
  String get appLanguage => _appLanguage ?? '';
  bool hasAppLanguage() => _appLanguage != null;

  // "appLanguageUpdatedAt" field.
  DateTime? _appLanguageUpdatedAt;
  DateTime? get appLanguageUpdatedAt => _appLanguageUpdatedAt;
  bool hasAppLanguageUpdatedAt() => _appLanguageUpdatedAt != null;

  // "restore_required" field.
  bool? _restoreRequired;
  bool get restoreRequired => _restoreRequired ?? false;
  bool hasRestoreRequired() => _restoreRequired != null;

  // "celebrate_reconnect" field.
  bool? _celebrateReconnect;
  bool get celebrateReconnect => _celebrateReconnect ?? false;
  bool hasCelebrateReconnect() => _celebrateReconnect != null;

  // "restore_state" field.
  String? _restoreState;
  String get restoreState => _restoreState ?? '';
  bool hasRestoreState() => _restoreState != null;

  // "restore_request_id" field.
  String? _restoreRequestId;
  String get restoreRequestId => _restoreRequestId ?? '';
  bool hasRestoreRequestId() => _restoreRequestId != null;

  // "restore_relationship_id" field.
  String? _restoreRelationshipId;
  String get restoreRelationshipId => _restoreRelationshipId ?? '';
  bool hasRestoreRelationshipId() => _restoreRelationshipId != null;

  // "onboarding_step" field.
  String? _onboardingStep;
  String get onboardingStep => _onboardingStep ?? '';
  bool hasOnboardingStep() => _onboardingStep != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  bool hasCity() => _city != null;

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

  // "current_lat" field.
  double? _currentLat;
  double get currentLat => _currentLat ?? 0.0;
  bool hasCurrentLat() => _currentLat != null;

  // "current_lng" field.
  double? _currentLng;
  double get currentLng => _currentLng ?? 0.0;
  bool hasCurrentLng() => _currentLng != null;

  // "current_location_updated_at" field.
  DateTime? _currentLocationUpdatedAt;
  DateTime? get currentLocationUpdatedAt => _currentLocationUpdatedAt;
  bool hasCurrentLocationUpdatedAt() => _currentLocationUpdatedAt != null;

  // "location_sharing_enabled" field.
  bool? _locationSharingEnabled;
  bool get locationSharingEnabled => _locationSharingEnabled ?? false;
  bool hasLocationSharingEnabled() => _locationSharingEnabled != null;

  // "love_buddy_live_location_enabled" field.
  bool? _loveBuddyLiveLocationEnabled;
  bool get loveBuddyLiveLocationEnabled =>
      _loveBuddyLiveLocationEnabled ?? false;
  bool hasLoveBuddyLiveLocationEnabled() =>
      _loveBuddyLiveLocationEnabled != null;

  // "love_buddy_live_location_mode" field.
  String? _loveBuddyLiveLocationMode;
  String get loveBuddyLiveLocationMode => _loveBuddyLiveLocationMode ?? '';
  bool hasLoveBuddyLiveLocationMode() => _loveBuddyLiveLocationMode != null;

  // "liveTravelTrackingEnabled" field.
  bool? _liveTravelTrackingEnabled;
  bool get liveTravelTrackingEnabled => _liveTravelTrackingEnabled ?? false;
  bool hasLiveTravelTrackingEnabled() => _liveTravelTrackingEnabled != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _email = snapshotData['email'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _birthday = snapshotData['birthday'] as DateTime?;
    _referralSource = snapshotData['referral_source'] as String?;
    _localTime = snapshotData['local_time'] as String?;
    _loveCode = snapshotData['love_code'] as String?;
    _relationshipId = snapshotData['relationship_id'] as String?;
    _partnerUID = snapshotData['partnerUID'] as String?;
    _tzOffsetMinutes = castToType<int>(snapshotData['tz_offset_minutes']);
    _disconnectCooldownUntil =
        snapshotData['disconnect_cooldown_until'] as DateTime?;
    _lastRelationshipId = snapshotData['last_relationship_id'] as String?;
    _lastRelationshipRef =
        snapshotData['last_relationship_ref'] as DocumentReference?;
    _isAdmin = snapshotData['is_admin'] as bool?;
    _messagesEnabled = snapshotData['messagesEnabled'] as bool?;
    _dailyQuestionPartnerAlertsEnabled =
        snapshotData['dailyQuestionPartnerAlertsEnabled'] as bool?;
    _relationshipAlertsEnabled =
        snapshotData['relationshipAlertsEnabled'] as bool?;
    _sharedMomentsEnabled = snapshotData['sharedMomentsEnabled'] as bool?;
    _dailyQuestionRemindersEnabled =
        snapshotData['dailyQuestionRemindersEnabled'] as bool?;
    _stayConnectedRemindersEnabled =
        snapshotData['stayConnectedRemindersEnabled'] as bool?;
    _muteAllNotifications = snapshotData['muteAllNotifications'] as bool?;
    _lastDailyQuestionReminderAt =
        snapshotData['lastDailyQuestionReminderAt'] as DateTime?;
    _lastStayConnectedReminderAt =
        snapshotData['lastStayConnectedReminderAt'] as DateTime?;
    _onboardingCompleted = snapshotData['onboardingCompleted'] as bool?;
    _displayName = snapshotData['display_name'] as String?;
    _appLanguage = snapshotData['appLanguage'] as String?;
    _appLanguageUpdatedAt = snapshotData['appLanguageUpdatedAt'] as DateTime?;
    _restoreRequired = snapshotData['restore_required'] as bool?;
    _celebrateReconnect = snapshotData['celebrate_reconnect'] as bool?;
    _restoreState = snapshotData['restore_state'] as String?;
    _restoreRequestId = snapshotData['restore_request_id'] as String?;
    _restoreRelationshipId = snapshotData['restore_relationship_id'] as String?;
    _onboardingStep = snapshotData['onboarding_step'] as String?;
    _city = snapshotData['city'] as String?;
    _countryName = snapshotData['country_name'] as String?;
    _countryCode = snapshotData['country_code'] as String?;
    _homeLat = castToType<double>(snapshotData['home_lat']);
    _homeLng = castToType<double>(snapshotData['home_lng']);
    _currentLat = castToType<double>(snapshotData['current_lat']);
    _currentLng = castToType<double>(snapshotData['current_lng']);
    _currentLocationUpdatedAt =
        snapshotData['current_location_updated_at'] as DateTime?;
    _locationSharingEnabled = snapshotData['location_sharing_enabled'] as bool?;
    _loveBuddyLiveLocationEnabled =
        snapshotData['love_buddy_live_location_enabled'] as bool?;
    _loveBuddyLiveLocationMode =
        snapshotData['love_buddy_live_location_mode'] as String?;
    _liveTravelTrackingEnabled =
        snapshotData['liveTravelTrackingEnabled'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? uid,
  String? email,
  String? photoUrl,
  DateTime? createdTime,
  String? phoneNumber,
  DateTime? birthday,
  String? referralSource,
  String? localTime,
  String? loveCode,
  String? relationshipId,
  String? partnerUID,
  int? tzOffsetMinutes,
  DateTime? disconnectCooldownUntil,
  String? lastRelationshipId,
  DocumentReference? lastRelationshipRef,
  bool? isAdmin,
  bool? messagesEnabled,
  bool? dailyQuestionPartnerAlertsEnabled,
  bool? relationshipAlertsEnabled,
  bool? sharedMomentsEnabled,
  bool? dailyQuestionRemindersEnabled,
  bool? stayConnectedRemindersEnabled,
  bool? muteAllNotifications,
  DateTime? lastDailyQuestionReminderAt,
  DateTime? lastStayConnectedReminderAt,
  bool? onboardingCompleted,
  String? displayName,
  String? appLanguage,
  DateTime? appLanguageUpdatedAt,
  bool? restoreRequired,
  bool? celebrateReconnect,
  String? restoreState,
  String? restoreRequestId,
  String? restoreRelationshipId,
  String? onboardingStep,
  String? city,
  String? countryName,
  String? countryCode,
  double? homeLat,
  double? homeLng,
  double? currentLat,
  double? currentLng,
  DateTime? currentLocationUpdatedAt,
  bool? locationSharingEnabled,
  bool? loveBuddyLiveLocationEnabled,
  String? loveBuddyLiveLocationMode,
  bool? liveTravelTrackingEnabled,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'email': email,
      'photo_url': photoUrl,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'birthday': birthday,
      'referral_source': referralSource,
      'local_time': localTime,
      'love_code': loveCode,
      'relationship_id': relationshipId,
      'partnerUID': partnerUID,
      'tz_offset_minutes': tzOffsetMinutes,
      'disconnect_cooldown_until': disconnectCooldownUntil,
      'last_relationship_id': lastRelationshipId,
      'last_relationship_ref': lastRelationshipRef,
      'is_admin': isAdmin,
      'messagesEnabled': messagesEnabled,
      'dailyQuestionPartnerAlertsEnabled': dailyQuestionPartnerAlertsEnabled,
      'relationshipAlertsEnabled': relationshipAlertsEnabled,
      'sharedMomentsEnabled': sharedMomentsEnabled,
      'dailyQuestionRemindersEnabled': dailyQuestionRemindersEnabled,
      'stayConnectedRemindersEnabled': stayConnectedRemindersEnabled,
      'muteAllNotifications': muteAllNotifications,
      'lastDailyQuestionReminderAt': lastDailyQuestionReminderAt,
      'lastStayConnectedReminderAt': lastStayConnectedReminderAt,
      'onboardingCompleted': onboardingCompleted,
      'display_name': displayName,
      'appLanguage': appLanguage,
      'appLanguageUpdatedAt': appLanguageUpdatedAt,
      'restore_required': restoreRequired,
      'celebrate_reconnect': celebrateReconnect,
      'restore_state': restoreState,
      'restore_request_id': restoreRequestId,
      'restore_relationship_id': restoreRelationshipId,
      'onboarding_step': onboardingStep,
      'city': city,
      'country_name': countryName,
      'country_code': countryCode,
      'home_lat': homeLat,
      'home_lng': homeLng,
      'current_lat': currentLat,
      'current_lng': currentLng,
      'current_location_updated_at': currentLocationUpdatedAt,
      'location_sharing_enabled': locationSharingEnabled,
      'love_buddy_live_location_enabled': loveBuddyLiveLocationEnabled,
      'love_buddy_live_location_mode': loveBuddyLiveLocationMode,
      'liveTravelTrackingEnabled': liveTravelTrackingEnabled,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.email == e2?.email &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.birthday == e2?.birthday &&
        e1?.referralSource == e2?.referralSource &&
        e1?.localTime == e2?.localTime &&
        e1?.loveCode == e2?.loveCode &&
        e1?.relationshipId == e2?.relationshipId &&
        e1?.partnerUID == e2?.partnerUID &&
        e1?.tzOffsetMinutes == e2?.tzOffsetMinutes &&
        e1?.disconnectCooldownUntil == e2?.disconnectCooldownUntil &&
        e1?.lastRelationshipId == e2?.lastRelationshipId &&
        e1?.lastRelationshipRef == e2?.lastRelationshipRef &&
        e1?.isAdmin == e2?.isAdmin &&
        e1?.messagesEnabled == e2?.messagesEnabled &&
        e1?.dailyQuestionPartnerAlertsEnabled ==
            e2?.dailyQuestionPartnerAlertsEnabled &&
        e1?.relationshipAlertsEnabled == e2?.relationshipAlertsEnabled &&
        e1?.sharedMomentsEnabled == e2?.sharedMomentsEnabled &&
        e1?.dailyQuestionRemindersEnabled ==
            e2?.dailyQuestionRemindersEnabled &&
        e1?.stayConnectedRemindersEnabled ==
            e2?.stayConnectedRemindersEnabled &&
        e1?.muteAllNotifications == e2?.muteAllNotifications &&
        e1?.lastDailyQuestionReminderAt == e2?.lastDailyQuestionReminderAt &&
        e1?.lastStayConnectedReminderAt == e2?.lastStayConnectedReminderAt &&
        e1?.onboardingCompleted == e2?.onboardingCompleted &&
        e1?.displayName == e2?.displayName &&
        e1?.appLanguage == e2?.appLanguage &&
        e1?.appLanguageUpdatedAt == e2?.appLanguageUpdatedAt &&
        e1?.restoreRequired == e2?.restoreRequired &&
        e1?.celebrateReconnect == e2?.celebrateReconnect &&
        e1?.restoreState == e2?.restoreState &&
        e1?.restoreRequestId == e2?.restoreRequestId &&
        e1?.restoreRelationshipId == e2?.restoreRelationshipId &&
        e1?.onboardingStep == e2?.onboardingStep &&
        e1?.city == e2?.city &&
        e1?.countryName == e2?.countryName &&
        e1?.countryCode == e2?.countryCode &&
        e1?.homeLat == e2?.homeLat &&
        e1?.homeLng == e2?.homeLng &&
        e1?.currentLat == e2?.currentLat &&
        e1?.currentLng == e2?.currentLng &&
        e1?.currentLocationUpdatedAt == e2?.currentLocationUpdatedAt &&
        e1?.locationSharingEnabled == e2?.locationSharingEnabled &&
        e1?.loveBuddyLiveLocationEnabled == e2?.loveBuddyLiveLocationEnabled &&
        e1?.loveBuddyLiveLocationMode == e2?.loveBuddyLiveLocationMode &&
        e1?.liveTravelTrackingEnabled == e2?.liveTravelTrackingEnabled;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.uid,
        e?.email,
        e?.photoUrl,
        e?.createdTime,
        e?.phoneNumber,
        e?.birthday,
        e?.referralSource,
        e?.localTime,
        e?.loveCode,
        e?.relationshipId,
        e?.partnerUID,
        e?.tzOffsetMinutes,
        e?.disconnectCooldownUntil,
        e?.lastRelationshipId,
        e?.lastRelationshipRef,
        e?.isAdmin,
        e?.messagesEnabled,
        e?.dailyQuestionPartnerAlertsEnabled,
        e?.relationshipAlertsEnabled,
        e?.sharedMomentsEnabled,
        e?.dailyQuestionRemindersEnabled,
        e?.stayConnectedRemindersEnabled,
        e?.muteAllNotifications,
        e?.lastDailyQuestionReminderAt,
        e?.lastStayConnectedReminderAt,
        e?.onboardingCompleted,
        e?.displayName,
        e?.appLanguage,
        e?.appLanguageUpdatedAt,
        e?.restoreRequired,
        e?.celebrateReconnect,
        e?.restoreState,
        e?.restoreRequestId,
        e?.restoreRelationshipId,
        e?.onboardingStep,
        e?.city,
        e?.countryName,
        e?.countryCode,
        e?.homeLat,
        e?.homeLng,
        e?.currentLat,
        e?.currentLng,
        e?.currentLocationUpdatedAt,
        e?.locationSharingEnabled,
        e?.loveBuddyLiveLocationEnabled,
        e?.loveBuddyLiveLocationMode,
        e?.liveTravelTrackingEnabled
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
