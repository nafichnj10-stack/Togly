import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RelationshipViewsRecord extends FirestoreRecord {
  RelationshipViewsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "relationship_id" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  bool hasRelationshipId() => _relationshipId != null;

  // "partner_uid" field.
  String? _partnerUid;
  String get partnerUid => _partnerUid ?? '';
  bool hasPartnerUid() => _partnerUid != null;

  // "partner_name" field.
  String? _partnerName;
  String get partnerName => _partnerName ?? '';
  bool hasPartnerName() => _partnerName != null;

  // "partner_city" field.
  String? _partnerCity;
  String get partnerCity => _partnerCity ?? '';
  bool hasPartnerCity() => _partnerCity != null;

  // "partner_photo_url" field.
  String? _partnerPhotoUrl;
  String get partnerPhotoUrl => _partnerPhotoUrl ?? '';
  bool hasPartnerPhotoUrl() => _partnerPhotoUrl != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "partner_love_code" field.
  String? _partnerLoveCode;
  String get partnerLoveCode => _partnerLoveCode ?? '';
  bool hasPartnerLoveCode() => _partnerLoveCode != null;

  // "my_mood" field.
  String? _myMood;
  String get myMood => _myMood ?? '';
  bool hasMyMood() => _myMood != null;

  // "my_mood_updated_at" field.
  DateTime? _myMoodUpdatedAt;
  DateTime? get myMoodUpdatedAt => _myMoodUpdatedAt;
  bool hasMyMoodUpdatedAt() => _myMoodUpdatedAt != null;

  // "partner_mood" field.
  String? _partnerMood;
  String get partnerMood => _partnerMood ?? '';
  bool hasPartnerMood() => _partnerMood != null;

  // "partner_mood_updated_at" field.
  DateTime? _partnerMoodUpdatedAt;
  DateTime? get partnerMoodUpdatedAt => _partnerMoodUpdatedAt;
  bool hasPartnerMoodUpdatedAt() => _partnerMoodUpdatedAt != null;

  // "my_sleep_status" field.
  bool? _mySleepStatus;
  bool get mySleepStatus => _mySleepStatus ?? false;
  bool hasMySleepStatus() => _mySleepStatus != null;

  // "my_sleep_status_updated_at" field.
  DateTime? _mySleepStatusUpdatedAt;
  DateTime? get mySleepStatusUpdatedAt => _mySleepStatusUpdatedAt;
  bool hasMySleepStatusUpdatedAt() => _mySleepStatusUpdatedAt != null;

  // "partner_sleep_status" field.
  bool? _partnerSleepStatus;
  bool get partnerSleepStatus => _partnerSleepStatus ?? false;
  bool hasPartnerSleepStatus() => _partnerSleepStatus != null;

  // "partner_sleep_status_updated_at" field.
  DateTime? _partnerSleepStatusUpdatedAt;
  DateTime? get partnerSleepStatusUpdatedAt => _partnerSleepStatusUpdatedAt;
  bool hasPartnerSleepStatusUpdatedAt() => _partnerSleepStatusUpdatedAt != null;

  // "my_sleep_started_at" field.
  DateTime? _mySleepStartedAt;
  DateTime? get mySleepStartedAt => _mySleepStartedAt;
  bool hasMySleepStartedAt() => _mySleepStartedAt != null;

  // "my_sleep_ended_at" field.
  DateTime? _mySleepEndedAt;
  DateTime? get mySleepEndedAt => _mySleepEndedAt;
  bool hasMySleepEndedAt() => _mySleepEndedAt != null;

  // "my_sleep_checkin_12h_sent" field.
  bool? _mySleepCheckin12hSent;
  bool get mySleepCheckin12hSent => _mySleepCheckin12hSent ?? false;
  bool hasMySleepCheckin12hSent() => _mySleepCheckin12hSent != null;

  // "partner_sleep_started_at" field.
  DateTime? _partnerSleepStartedAt;
  DateTime? get partnerSleepStartedAt => _partnerSleepStartedAt;
  bool hasPartnerSleepStartedAt() => _partnerSleepStartedAt != null;

  // "partner_sleep_ended_at" field.
  DateTime? _partnerSleepEndedAt;
  DateTime? get partnerSleepEndedAt => _partnerSleepEndedAt;
  bool hasPartnerSleepEndedAt() => _partnerSleepEndedAt != null;

  // "partner_sleep_checkin_12h_sent" field.
  bool? _partnerSleepCheckin12hSent;
  bool get partnerSleepCheckin12hSent => _partnerSleepCheckin12hSent ?? false;
  bool hasPartnerSleepCheckin12hSent() => _partnerSleepCheckin12hSent != null;

  // "partner_tz_offset_minutes" field.
  int? _partnerTzOffsetMinutes;
  int get partnerTzOffsetMinutes => _partnerTzOffsetMinutes ?? 0;
  bool hasPartnerTzOffsetMinutes() => _partnerTzOffsetMinutes != null;

  // "my_photo_url" field.
  String? _myPhotoUrl;
  String get myPhotoUrl => _myPhotoUrl ?? '';
  bool hasMyPhotoUrl() => _myPhotoUrl != null;

  // "my_name" field.
  String? _myName;
  String get myName => _myName ?? '';
  bool hasMyName() => _myName != null;

  // "my_city" field.
  String? _myCity;
  String get myCity => _myCity ?? '';
  bool hasMyCity() => _myCity != null;

  // "my_love_code" field.
  String? _myLoveCode;
  String get myLoveCode => _myLoveCode ?? '';
  bool hasMyLoveCode() => _myLoveCode != null;

  // "my_tz_offset_minutes" field.
  int? _myTzOffsetMinutes;
  int get myTzOffsetMinutes => _myTzOffsetMinutes ?? 0;
  bool hasMyTzOffsetMinutes() => _myTzOffsetMinutes != null;

  // "my_tz_offset_updated_at" field.
  DateTime? _myTzOffsetUpdatedAt;
  DateTime? get myTzOffsetUpdatedAt => _myTzOffsetUpdatedAt;
  bool hasMyTzOffsetUpdatedAt() => _myTzOffsetUpdatedAt != null;

  // "partner_tz_offset_updated_at" field.
  DateTime? _partnerTzOffsetUpdatedAt;
  DateTime? get partnerTzOffsetUpdatedAt => _partnerTzOffsetUpdatedAt;
  bool hasPartnerTzOffsetUpdatedAt() => _partnerTzOffsetUpdatedAt != null;

  // "silent_checkin_last_at" field.
  DateTime? _silentCheckinLastAt;
  DateTime? get silentCheckinLastAt => _silentCheckinLastAt;
  bool hasSilentCheckinLastAt() => _silentCheckinLastAt != null;

  // "silent_checkin_day_key" field.
  String? _silentCheckinDayKey;
  String get silentCheckinDayKey => _silentCheckinDayKey ?? '';
  bool hasSilentCheckinDayKey() => _silentCheckinDayKey != null;

  // "silent_checkin_count_today" field.
  double? _silentCheckinCountToday;
  double get silentCheckinCountToday => _silentCheckinCountToday ?? 0.0;
  bool hasSilentCheckinCountToday() => _silentCheckinCountToday != null;

  // "silent_checkin_cooldown_until" field.
  DateTime? _silentCheckinCooldownUntil;
  DateTime? get silentCheckinCooldownUntil => _silentCheckinCooldownUntil;
  bool hasSilentCheckinCooldownUntil() => _silentCheckinCooldownUntil != null;

  // "partner_silent_checkin_last_at" field.
  DateTime? _partnerSilentCheckinLastAt;
  DateTime? get partnerSilentCheckinLastAt => _partnerSilentCheckinLastAt;
  bool hasPartnerSilentCheckinLastAt() => _partnerSilentCheckinLastAt != null;

  // "partner_silent_checkin_day_key" field.
  String? _partnerSilentCheckinDayKey;
  String get partnerSilentCheckinDayKey => _partnerSilentCheckinDayKey ?? '';
  bool hasPartnerSilentCheckinDayKey() => _partnerSilentCheckinDayKey != null;

  // "partner_silent_checkin_count_today" field.
  double? _partnerSilentCheckinCountToday;
  double get partnerSilentCheckinCountToday =>
      _partnerSilentCheckinCountToday ?? 0.0;
  bool hasPartnerSilentCheckinCountToday() =>
      _partnerSilentCheckinCountToday != null;

  // "partner_silent_checkin_cooldown_until" field.
  DateTime? _partnerSilentCheckinCooldownUntil;
  DateTime? get partnerSilentCheckinCooldownUntil =>
      _partnerSilentCheckinCooldownUntil;
  bool hasPartnerSilentCheckinCooldownUntil() =>
      _partnerSilentCheckinCooldownUntil != null;

  // "love_score" field.
  int? _loveScore;
  int get loveScore => _loveScore ?? 0;
  bool hasLoveScore() => _loveScore != null;

  // "love_last_update" field.
  DateTime? _loveLastUpdate;
  DateTime? get loveLastUpdate => _loveLastUpdate;
  bool hasLoveLastUpdate() => _loveLastUpdate != null;

  // "love_state" field.
  String? _loveState;
  String get loveState => _loveState ?? '';
  bool hasLoveState() => _loveState != null;

  // "love_today_points" field.
  int? _loveTodayPoints;
  int get loveTodayPoints => _loveTodayPoints ?? 0;
  bool hasLoveTodayPoints() => _loveTodayPoints != null;

  // "love_percent" field.
  double? _lovePercent;
  double get lovePercent => _lovePercent ?? 0.0;
  bool hasLovePercent() => _lovePercent != null;

  // "love_today_key" field.
  String? _loveTodayKey;
  String get loveTodayKey => _loveTodayKey ?? '';
  bool hasLoveTodayKey() => _loveTodayKey != null;

  // "love_last_push_at" field.
  DateTime? _loveLastPushAt;
  DateTime? get loveLastPushAt => _loveLastPushAt;
  bool hasLoveLastPushAt() => _loveLastPushAt != null;

  // "partner_country_code" field.
  String? _partnerCountryCode;
  String get partnerCountryCode => _partnerCountryCode ?? '';
  bool hasPartnerCountryCode() => _partnerCountryCode != null;

  // "my_love_buddy_pet" field.
  String? _myLoveBuddyPet;
  String get myLoveBuddyPet => _myLoveBuddyPet ?? '';
  bool hasMyLoveBuddyPet() => _myLoveBuddyPet != null;

  // "my_love_buddy_name" field.
  String? _myLoveBuddyName;
  String get myLoveBuddyName => _myLoveBuddyName ?? '';
  bool hasMyLoveBuddyName() => _myLoveBuddyName != null;

  // "partner_love_buddy_pet" field.
  String? _partnerLoveBuddyPet;
  String get partnerLoveBuddyPet => _partnerLoveBuddyPet ?? '';
  bool hasPartnerLoveBuddyPet() => _partnerLoveBuddyPet != null;

  // "partner_love_buddy_name" field.
  String? _partnerLoveBuddyName;
  String get partnerLoveBuddyName => _partnerLoveBuddyName ?? '';
  bool hasPartnerLoveBuddyName() => _partnerLoveBuddyName != null;

  // "widget_state" field.
  String? _widgetState;
  String get widgetState => _widgetState ?? '';
  bool hasWidgetState() => _widgetState != null;

  // "widget_background_key" field.
  String? _widgetBackgroundKey;
  String get widgetBackgroundKey => _widgetBackgroundKey ?? '';
  bool hasWidgetBackgroundKey() => _widgetBackgroundKey != null;

  // "widget_distance_km" field.
  double? _widgetDistanceKm;
  double get widgetDistanceKm => _widgetDistanceKm ?? 0.0;
  bool hasWidgetDistanceKm() => _widgetDistanceKm != null;

  // "widget_distance_progress" field.
  double? _widgetDistanceProgress;
  double get widgetDistanceProgress => _widgetDistanceProgress ?? 0.0;
  bool hasWidgetDistanceProgress() => _widgetDistanceProgress != null;

  // "widget_traveler_uid" field.
  String? _widgetTravelerUid;
  String get widgetTravelerUid => _widgetTravelerUid ?? '';
  bool hasWidgetTravelerUid() => _widgetTravelerUid != null;

  // "widget_last_love_sent_by_uid" field.
  String? _widgetLastLoveSentByUid;
  String get widgetLastLoveSentByUid => _widgetLastLoveSentByUid ?? '';
  bool hasWidgetLastLoveSentByUid() => _widgetLastLoveSentByUid != null;

  // "widget_last_love_sent_at" field.
  DateTime? _widgetLastLoveSentAt;
  DateTime? get widgetLastLoveSentAt => _widgetLastLoveSentAt;
  bool hasWidgetLastLoveSentAt() => _widgetLastLoveSentAt != null;

  // "widget_updated_at" field.
  DateTime? _widgetUpdatedAt;
  DateTime? get widgetUpdatedAt => _widgetUpdatedAt;
  bool hasWidgetUpdatedAt() => _widgetUpdatedAt != null;

  // "widget_returning_uid" field.
  String? _widgetReturningUid;
  String get widgetReturningUid => _widgetReturningUid ?? '';
  bool hasWidgetReturningUid() => _widgetReturningUid != null;

  // "live_location_active" field.
  bool? _liveLocationActive;
  bool get liveLocationActive => _liveLocationActive ?? false;
  bool hasLiveLocationActive() => _liveLocationActive != null;

  // "live_location_mode" field.
  String? _liveLocationMode;
  String get liveLocationMode => _liveLocationMode ?? '';
  bool hasLiveLocationMode() => _liveLocationMode != null;

  // "widget_birthday_active" field.
  bool? _widgetBirthdayActive;
  bool get widgetBirthdayActive => _widgetBirthdayActive ?? false;
  bool hasWidgetBirthdayActive() => _widgetBirthdayActive != null;

  // "widget_birthday_user_uids" field.
  List<String>? _widgetBirthdayUserUids;
  List<String> get widgetBirthdayUserUids =>
      _widgetBirthdayUserUids ?? const [];
  bool hasWidgetBirthdayUserUids() => _widgetBirthdayUserUids != null;

  // "widget_travel_event_id" field.
  String? _widgetTravelEventId;
  String get widgetTravelEventId => _widgetTravelEventId ?? '';
  bool hasWidgetTravelEventId() => _widgetTravelEventId != null;

  // "live_travel_tracking_enabled" field.
  bool? _liveTravelTrackingEnabled;
  bool get liveTravelTrackingEnabled => _liveTravelTrackingEnabled ?? false;
  bool hasLiveTravelTrackingEnabled() => _liveTravelTrackingEnabled != null;

  // "live_travel_tracking_prompt_event_id" field.
  String? _liveTravelTrackingPromptEventId;
  String get liveTravelTrackingPromptEventId =>
      _liveTravelTrackingPromptEventId ?? '';
  bool hasLiveTravelTrackingPromptEventId() =>
      _liveTravelTrackingPromptEventId != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _relationshipId = snapshotData['relationship_id'] as String?;
    _partnerUid = snapshotData['partner_uid'] as String?;
    _partnerName = snapshotData['partner_name'] as String?;
    _partnerCity = snapshotData['partner_city'] as String?;
    _partnerPhotoUrl = snapshotData['partner_photo_url'] as String?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _partnerLoveCode = snapshotData['partner_love_code'] as String?;
    _myMood = snapshotData['my_mood'] as String?;
    _myMoodUpdatedAt = snapshotData['my_mood_updated_at'] as DateTime?;
    _partnerMood = snapshotData['partner_mood'] as String?;
    _partnerMoodUpdatedAt =
        snapshotData['partner_mood_updated_at'] as DateTime?;
    _mySleepStatus = snapshotData['my_sleep_status'] as bool?;
    _mySleepStatusUpdatedAt =
        snapshotData['my_sleep_status_updated_at'] as DateTime?;
    _partnerSleepStatus = snapshotData['partner_sleep_status'] as bool?;
    _partnerSleepStatusUpdatedAt =
        snapshotData['partner_sleep_status_updated_at'] as DateTime?;
    _mySleepStartedAt = snapshotData['my_sleep_started_at'] as DateTime?;
    _mySleepEndedAt = snapshotData['my_sleep_ended_at'] as DateTime?;
    _mySleepCheckin12hSent = snapshotData['my_sleep_checkin_12h_sent'] as bool?;
    _partnerSleepStartedAt =
        snapshotData['partner_sleep_started_at'] as DateTime?;
    _partnerSleepEndedAt = snapshotData['partner_sleep_ended_at'] as DateTime?;
    _partnerSleepCheckin12hSent =
        snapshotData['partner_sleep_checkin_12h_sent'] as bool?;
    _partnerTzOffsetMinutes =
        castToType<int>(snapshotData['partner_tz_offset_minutes']);
    _myPhotoUrl = snapshotData['my_photo_url'] as String?;
    _myName = snapshotData['my_name'] as String?;
    _myCity = snapshotData['my_city'] as String?;
    _myLoveCode = snapshotData['my_love_code'] as String?;
    _myTzOffsetMinutes = castToType<int>(snapshotData['my_tz_offset_minutes']);
    _myTzOffsetUpdatedAt = snapshotData['my_tz_offset_updated_at'] as DateTime?;
    _partnerTzOffsetUpdatedAt =
        snapshotData['partner_tz_offset_updated_at'] as DateTime?;
    _silentCheckinLastAt = snapshotData['silent_checkin_last_at'] as DateTime?;
    _silentCheckinDayKey = snapshotData['silent_checkin_day_key'] as String?;
    _silentCheckinCountToday =
        castToType<double>(snapshotData['silent_checkin_count_today']);
    _silentCheckinCooldownUntil =
        snapshotData['silent_checkin_cooldown_until'] as DateTime?;
    _partnerSilentCheckinLastAt =
        snapshotData['partner_silent_checkin_last_at'] as DateTime?;
    _partnerSilentCheckinDayKey =
        snapshotData['partner_silent_checkin_day_key'] as String?;
    _partnerSilentCheckinCountToday =
        castToType<double>(snapshotData['partner_silent_checkin_count_today']);
    _partnerSilentCheckinCooldownUntil =
        snapshotData['partner_silent_checkin_cooldown_until'] as DateTime?;
    _loveScore = castToType<int>(snapshotData['love_score']);
    _loveLastUpdate = snapshotData['love_last_update'] as DateTime?;
    _loveState = snapshotData['love_state'] as String?;
    _loveTodayPoints = castToType<int>(snapshotData['love_today_points']);
    _lovePercent = castToType<double>(snapshotData['love_percent']);
    _loveTodayKey = snapshotData['love_today_key'] as String?;
    _loveLastPushAt = snapshotData['love_last_push_at'] as DateTime?;
    _partnerCountryCode = snapshotData['partner_country_code'] as String?;
    _myLoveBuddyPet = snapshotData['my_love_buddy_pet'] as String?;
    _myLoveBuddyName = snapshotData['my_love_buddy_name'] as String?;
    _partnerLoveBuddyPet = snapshotData['partner_love_buddy_pet'] as String?;
    _partnerLoveBuddyName = snapshotData['partner_love_buddy_name'] as String?;
    _widgetState = snapshotData['widget_state'] as String?;
    _widgetBackgroundKey = snapshotData['widget_background_key'] as String?;
    _widgetDistanceKm = castToType<double>(snapshotData['widget_distance_km']);
    _widgetDistanceProgress =
        castToType<double>(snapshotData['widget_distance_progress']);
    _widgetTravelerUid = snapshotData['widget_traveler_uid'] as String?;
    _widgetLastLoveSentByUid =
        snapshotData['widget_last_love_sent_by_uid'] as String?;
    _widgetLastLoveSentAt =
        snapshotData['widget_last_love_sent_at'] as DateTime?;
    _widgetUpdatedAt = snapshotData['widget_updated_at'] as DateTime?;
    _widgetReturningUid = snapshotData['widget_returning_uid'] as String?;
    _liveLocationActive = snapshotData['live_location_active'] as bool?;
    _liveLocationMode = snapshotData['live_location_mode'] as String?;
    _widgetBirthdayActive = snapshotData['widget_birthday_active'] as bool?;
    _widgetBirthdayUserUids =
        getDataList(snapshotData['widget_birthday_user_uids']);
    _widgetTravelEventId = snapshotData['widget_travel_event_id'] as String?;
    _liveTravelTrackingEnabled =
        snapshotData['live_travel_tracking_enabled'] as bool?;
    _liveTravelTrackingPromptEventId =
        snapshotData['live_travel_tracking_prompt_event_id'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('relationship_views');

  static Stream<RelationshipViewsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RelationshipViewsRecord.fromSnapshot(s));

  static Future<RelationshipViewsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => RelationshipViewsRecord.fromSnapshot(s));

  static RelationshipViewsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RelationshipViewsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RelationshipViewsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RelationshipViewsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RelationshipViewsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RelationshipViewsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRelationshipViewsRecordData({
  String? uid,
  String? relationshipId,
  String? partnerUid,
  String? partnerName,
  String? partnerCity,
  String? partnerPhotoUrl,
  DateTime? updatedAt,
  String? partnerLoveCode,
  String? myMood,
  DateTime? myMoodUpdatedAt,
  String? partnerMood,
  DateTime? partnerMoodUpdatedAt,
  bool? mySleepStatus,
  DateTime? mySleepStatusUpdatedAt,
  bool? partnerSleepStatus,
  DateTime? partnerSleepStatusUpdatedAt,
  DateTime? mySleepStartedAt,
  DateTime? mySleepEndedAt,
  bool? mySleepCheckin12hSent,
  DateTime? partnerSleepStartedAt,
  DateTime? partnerSleepEndedAt,
  bool? partnerSleepCheckin12hSent,
  int? partnerTzOffsetMinutes,
  String? myPhotoUrl,
  String? myName,
  String? myCity,
  String? myLoveCode,
  int? myTzOffsetMinutes,
  DateTime? myTzOffsetUpdatedAt,
  DateTime? partnerTzOffsetUpdatedAt,
  DateTime? silentCheckinLastAt,
  String? silentCheckinDayKey,
  double? silentCheckinCountToday,
  DateTime? silentCheckinCooldownUntil,
  DateTime? partnerSilentCheckinLastAt,
  String? partnerSilentCheckinDayKey,
  double? partnerSilentCheckinCountToday,
  DateTime? partnerSilentCheckinCooldownUntil,
  int? loveScore,
  DateTime? loveLastUpdate,
  String? loveState,
  int? loveTodayPoints,
  double? lovePercent,
  String? loveTodayKey,
  DateTime? loveLastPushAt,
  String? partnerCountryCode,
  String? myLoveBuddyPet,
  String? myLoveBuddyName,
  String? partnerLoveBuddyPet,
  String? partnerLoveBuddyName,
  String? widgetState,
  String? widgetBackgroundKey,
  double? widgetDistanceKm,
  double? widgetDistanceProgress,
  String? widgetTravelerUid,
  String? widgetLastLoveSentByUid,
  DateTime? widgetLastLoveSentAt,
  DateTime? widgetUpdatedAt,
  String? widgetReturningUid,
  bool? liveLocationActive,
  String? liveLocationMode,
  bool? widgetBirthdayActive,
  String? widgetTravelEventId,
  bool? liveTravelTrackingEnabled,
  String? liveTravelTrackingPromptEventId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'relationship_id': relationshipId,
      'partner_uid': partnerUid,
      'partner_name': partnerName,
      'partner_city': partnerCity,
      'partner_photo_url': partnerPhotoUrl,
      'updated_at': updatedAt,
      'partner_love_code': partnerLoveCode,
      'my_mood': myMood,
      'my_mood_updated_at': myMoodUpdatedAt,
      'partner_mood': partnerMood,
      'partner_mood_updated_at': partnerMoodUpdatedAt,
      'my_sleep_status': mySleepStatus,
      'my_sleep_status_updated_at': mySleepStatusUpdatedAt,
      'partner_sleep_status': partnerSleepStatus,
      'partner_sleep_status_updated_at': partnerSleepStatusUpdatedAt,
      'my_sleep_started_at': mySleepStartedAt,
      'my_sleep_ended_at': mySleepEndedAt,
      'my_sleep_checkin_12h_sent': mySleepCheckin12hSent,
      'partner_sleep_started_at': partnerSleepStartedAt,
      'partner_sleep_ended_at': partnerSleepEndedAt,
      'partner_sleep_checkin_12h_sent': partnerSleepCheckin12hSent,
      'partner_tz_offset_minutes': partnerTzOffsetMinutes,
      'my_photo_url': myPhotoUrl,
      'my_name': myName,
      'my_city': myCity,
      'my_love_code': myLoveCode,
      'my_tz_offset_minutes': myTzOffsetMinutes,
      'my_tz_offset_updated_at': myTzOffsetUpdatedAt,
      'partner_tz_offset_updated_at': partnerTzOffsetUpdatedAt,
      'silent_checkin_last_at': silentCheckinLastAt,
      'silent_checkin_day_key': silentCheckinDayKey,
      'silent_checkin_count_today': silentCheckinCountToday,
      'silent_checkin_cooldown_until': silentCheckinCooldownUntil,
      'partner_silent_checkin_last_at': partnerSilentCheckinLastAt,
      'partner_silent_checkin_day_key': partnerSilentCheckinDayKey,
      'partner_silent_checkin_count_today': partnerSilentCheckinCountToday,
      'partner_silent_checkin_cooldown_until':
          partnerSilentCheckinCooldownUntil,
      'love_score': loveScore,
      'love_last_update': loveLastUpdate,
      'love_state': loveState,
      'love_today_points': loveTodayPoints,
      'love_percent': lovePercent,
      'love_today_key': loveTodayKey,
      'love_last_push_at': loveLastPushAt,
      'partner_country_code': partnerCountryCode,
      'my_love_buddy_pet': myLoveBuddyPet,
      'my_love_buddy_name': myLoveBuddyName,
      'partner_love_buddy_pet': partnerLoveBuddyPet,
      'partner_love_buddy_name': partnerLoveBuddyName,
      'widget_state': widgetState,
      'widget_background_key': widgetBackgroundKey,
      'widget_distance_km': widgetDistanceKm,
      'widget_distance_progress': widgetDistanceProgress,
      'widget_traveler_uid': widgetTravelerUid,
      'widget_last_love_sent_by_uid': widgetLastLoveSentByUid,
      'widget_last_love_sent_at': widgetLastLoveSentAt,
      'widget_updated_at': widgetUpdatedAt,
      'widget_returning_uid': widgetReturningUid,
      'live_location_active': liveLocationActive,
      'live_location_mode': liveLocationMode,
      'widget_birthday_active': widgetBirthdayActive,
      'widget_travel_event_id': widgetTravelEventId,
      'live_travel_tracking_enabled': liveTravelTrackingEnabled,
      'live_travel_tracking_prompt_event_id': liveTravelTrackingPromptEventId,
    }.withoutNulls,
  );

  return firestoreData;
}

class RelationshipViewsRecordDocumentEquality
    implements Equality<RelationshipViewsRecord> {
  const RelationshipViewsRecordDocumentEquality();

  @override
  bool equals(RelationshipViewsRecord? e1, RelationshipViewsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.uid == e2?.uid &&
        e1?.relationshipId == e2?.relationshipId &&
        e1?.partnerUid == e2?.partnerUid &&
        e1?.partnerName == e2?.partnerName &&
        e1?.partnerCity == e2?.partnerCity &&
        e1?.partnerPhotoUrl == e2?.partnerPhotoUrl &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.partnerLoveCode == e2?.partnerLoveCode &&
        e1?.myMood == e2?.myMood &&
        e1?.myMoodUpdatedAt == e2?.myMoodUpdatedAt &&
        e1?.partnerMood == e2?.partnerMood &&
        e1?.partnerMoodUpdatedAt == e2?.partnerMoodUpdatedAt &&
        e1?.mySleepStatus == e2?.mySleepStatus &&
        e1?.mySleepStatusUpdatedAt == e2?.mySleepStatusUpdatedAt &&
        e1?.partnerSleepStatus == e2?.partnerSleepStatus &&
        e1?.partnerSleepStatusUpdatedAt == e2?.partnerSleepStatusUpdatedAt &&
        e1?.mySleepStartedAt == e2?.mySleepStartedAt &&
        e1?.mySleepEndedAt == e2?.mySleepEndedAt &&
        e1?.mySleepCheckin12hSent == e2?.mySleepCheckin12hSent &&
        e1?.partnerSleepStartedAt == e2?.partnerSleepStartedAt &&
        e1?.partnerSleepEndedAt == e2?.partnerSleepEndedAt &&
        e1?.partnerSleepCheckin12hSent == e2?.partnerSleepCheckin12hSent &&
        e1?.partnerTzOffsetMinutes == e2?.partnerTzOffsetMinutes &&
        e1?.myPhotoUrl == e2?.myPhotoUrl &&
        e1?.myName == e2?.myName &&
        e1?.myCity == e2?.myCity &&
        e1?.myLoveCode == e2?.myLoveCode &&
        e1?.myTzOffsetMinutes == e2?.myTzOffsetMinutes &&
        e1?.myTzOffsetUpdatedAt == e2?.myTzOffsetUpdatedAt &&
        e1?.partnerTzOffsetUpdatedAt == e2?.partnerTzOffsetUpdatedAt &&
        e1?.silentCheckinLastAt == e2?.silentCheckinLastAt &&
        e1?.silentCheckinDayKey == e2?.silentCheckinDayKey &&
        e1?.silentCheckinCountToday == e2?.silentCheckinCountToday &&
        e1?.silentCheckinCooldownUntil == e2?.silentCheckinCooldownUntil &&
        e1?.partnerSilentCheckinLastAt == e2?.partnerSilentCheckinLastAt &&
        e1?.partnerSilentCheckinDayKey == e2?.partnerSilentCheckinDayKey &&
        e1?.partnerSilentCheckinCountToday ==
            e2?.partnerSilentCheckinCountToday &&
        e1?.partnerSilentCheckinCooldownUntil ==
            e2?.partnerSilentCheckinCooldownUntil &&
        e1?.loveScore == e2?.loveScore &&
        e1?.loveLastUpdate == e2?.loveLastUpdate &&
        e1?.loveState == e2?.loveState &&
        e1?.loveTodayPoints == e2?.loveTodayPoints &&
        e1?.lovePercent == e2?.lovePercent &&
        e1?.loveTodayKey == e2?.loveTodayKey &&
        e1?.loveLastPushAt == e2?.loveLastPushAt &&
        e1?.partnerCountryCode == e2?.partnerCountryCode &&
        e1?.myLoveBuddyPet == e2?.myLoveBuddyPet &&
        e1?.myLoveBuddyName == e2?.myLoveBuddyName &&
        e1?.partnerLoveBuddyPet == e2?.partnerLoveBuddyPet &&
        e1?.partnerLoveBuddyName == e2?.partnerLoveBuddyName &&
        e1?.widgetState == e2?.widgetState &&
        e1?.widgetBackgroundKey == e2?.widgetBackgroundKey &&
        e1?.widgetDistanceKm == e2?.widgetDistanceKm &&
        e1?.widgetDistanceProgress == e2?.widgetDistanceProgress &&
        e1?.widgetTravelerUid == e2?.widgetTravelerUid &&
        e1?.widgetLastLoveSentByUid == e2?.widgetLastLoveSentByUid &&
        e1?.widgetLastLoveSentAt == e2?.widgetLastLoveSentAt &&
        e1?.widgetUpdatedAt == e2?.widgetUpdatedAt &&
        e1?.widgetReturningUid == e2?.widgetReturningUid &&
        e1?.liveLocationActive == e2?.liveLocationActive &&
        e1?.liveLocationMode == e2?.liveLocationMode &&
        e1?.widgetBirthdayActive == e2?.widgetBirthdayActive &&
        listEquality.equals(
            e1?.widgetBirthdayUserUids, e2?.widgetBirthdayUserUids) &&
        e1?.widgetTravelEventId == e2?.widgetTravelEventId &&
        e1?.liveTravelTrackingEnabled == e2?.liveTravelTrackingEnabled &&
        e1?.liveTravelTrackingPromptEventId ==
            e2?.liveTravelTrackingPromptEventId;
  }

  @override
  int hash(RelationshipViewsRecord? e) => const ListEquality().hash([
        e?.uid,
        e?.relationshipId,
        e?.partnerUid,
        e?.partnerName,
        e?.partnerCity,
        e?.partnerPhotoUrl,
        e?.updatedAt,
        e?.partnerLoveCode,
        e?.myMood,
        e?.myMoodUpdatedAt,
        e?.partnerMood,
        e?.partnerMoodUpdatedAt,
        e?.mySleepStatus,
        e?.mySleepStatusUpdatedAt,
        e?.partnerSleepStatus,
        e?.partnerSleepStatusUpdatedAt,
        e?.mySleepStartedAt,
        e?.mySleepEndedAt,
        e?.mySleepCheckin12hSent,
        e?.partnerSleepStartedAt,
        e?.partnerSleepEndedAt,
        e?.partnerSleepCheckin12hSent,
        e?.partnerTzOffsetMinutes,
        e?.myPhotoUrl,
        e?.myName,
        e?.myCity,
        e?.myLoveCode,
        e?.myTzOffsetMinutes,
        e?.myTzOffsetUpdatedAt,
        e?.partnerTzOffsetUpdatedAt,
        e?.silentCheckinLastAt,
        e?.silentCheckinDayKey,
        e?.silentCheckinCountToday,
        e?.silentCheckinCooldownUntil,
        e?.partnerSilentCheckinLastAt,
        e?.partnerSilentCheckinDayKey,
        e?.partnerSilentCheckinCountToday,
        e?.partnerSilentCheckinCooldownUntil,
        e?.loveScore,
        e?.loveLastUpdate,
        e?.loveState,
        e?.loveTodayPoints,
        e?.lovePercent,
        e?.loveTodayKey,
        e?.loveLastPushAt,
        e?.partnerCountryCode,
        e?.myLoveBuddyPet,
        e?.myLoveBuddyName,
        e?.partnerLoveBuddyPet,
        e?.partnerLoveBuddyName,
        e?.widgetState,
        e?.widgetBackgroundKey,
        e?.widgetDistanceKm,
        e?.widgetDistanceProgress,
        e?.widgetTravelerUid,
        e?.widgetLastLoveSentByUid,
        e?.widgetLastLoveSentAt,
        e?.widgetUpdatedAt,
        e?.widgetReturningUid,
        e?.liveLocationActive,
        e?.liveLocationMode,
        e?.widgetBirthdayActive,
        e?.widgetBirthdayUserUids,
        e?.widgetTravelEventId,
        e?.liveTravelTrackingEnabled,
        e?.liveTravelTrackingPromptEventId
      ]);

  @override
  bool isValidKey(Object? o) => o is RelationshipViewsRecord;
}
