import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RelationshipsRecord extends FirestoreRecord {
  RelationshipsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userA_id" field.
  String? _userAId;
  String get userAId => _userAId ?? '';
  bool hasUserAId() => _userAId != null;

  // "userB_id" field.
  String? _userBId;
  String get userBId => _userBId ?? '';
  bool hasUserBId() => _userBId != null;

  // "started_at" field.
  DateTime? _startedAt;
  DateTime? get startedAt => _startedAt;
  bool hasStartedAt() => _startedAt != null;

  // "next_meeting_date" field.
  DateTime? _nextMeetingDate;
  DateTime? get nextMeetingDate => _nextMeetingDate;
  bool hasNextMeetingDate() => _nextMeetingDate != null;

  // "active" field.
  bool? _active;
  bool get active => _active ?? false;
  bool hasActive() => _active != null;

  // "relationship_id" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  bool hasRelationshipId() => _relationshipId != null;

  // "partnerUserId" field.
  String? _partnerUserId;
  String get partnerUserId => _partnerUserId ?? '';
  bool hasPartnerUserId() => _partnerUserId != null;

  // "disconnected_at" field.
  DateTime? _disconnectedAt;
  DateTime? get disconnectedAt => _disconnectedAt;
  bool hasDisconnectedAt() => _disconnectedAt != null;

  // "purge_at" field.
  DateTime? _purgeAt;
  DateTime? get purgeAt => _purgeAt;
  bool hasPurgeAt() => _purgeAt != null;

  // "together_since" field.
  DateTime? _togetherSince;
  DateTime? get togetherSince => _togetherSince;
  bool hasTogetherSince() => _togetherSince != null;

  // "together_since_conflict" field.
  bool? _togetherSinceConflict;
  bool get togetherSinceConflict => _togetherSinceConflict ?? false;
  bool hasTogetherSinceConflict() => _togetherSinceConflict != null;

  // "love_buddies_enabled" field.
  bool? _loveBuddiesEnabled;
  bool get loveBuddiesEnabled => _loveBuddiesEnabled ?? false;
  bool hasLoveBuddiesEnabled() => _loveBuddiesEnabled != null;

  // "love_buddies_user_a_pet" field.
  String? _loveBuddiesUserAPet;
  String get loveBuddiesUserAPet => _loveBuddiesUserAPet ?? '';
  bool hasLoveBuddiesUserAPet() => _loveBuddiesUserAPet != null;

  // "love_buddies_user_b_pet" field.
  String? _loveBuddiesUserBPet;
  String get loveBuddiesUserBPet => _loveBuddiesUserBPet ?? '';
  bool hasLoveBuddiesUserBPet() => _loveBuddiesUserBPet != null;

  // "love_buddies_user_a_name" field.
  String? _loveBuddiesUserAName;
  String get loveBuddiesUserAName => _loveBuddiesUserAName ?? '';
  bool hasLoveBuddiesUserAName() => _loveBuddiesUserAName != null;

  // "love_buddies_user_b_name" field.
  String? _loveBuddiesUserBName;
  String get loveBuddiesUserBName => _loveBuddiesUserBName ?? '';
  bool hasLoveBuddiesUserBName() => _loveBuddiesUserBName != null;

  // "love_buddies_created_at" field.
  DateTime? _loveBuddiesCreatedAt;
  DateTime? get loveBuddiesCreatedAt => _loveBuddiesCreatedAt;
  bool hasLoveBuddiesCreatedAt() => _loveBuddiesCreatedAt != null;

  // "love_buddies_updated_at" field.
  DateTime? _loveBuddiesUpdatedAt;
  DateTime? get loveBuddiesUpdatedAt => _loveBuddiesUpdatedAt;
  bool hasLoveBuddiesUpdatedAt() => _loveBuddiesUpdatedAt != null;

  // "love_buddies_traveler_uid" field.
  String? _loveBuddiesTravelerUid;
  String get loveBuddiesTravelerUid => _loveBuddiesTravelerUid ?? '';
  bool hasLoveBuddiesTravelerUid() => _loveBuddiesTravelerUid != null;

  // "love_buddies_travel_active" field.
  bool? _loveBuddiesTravelActive;
  bool get loveBuddiesTravelActive => _loveBuddiesTravelActive ?? false;
  bool hasLoveBuddiesTravelActive() => _loveBuddiesTravelActive != null;

  // "love_buddies_travel_started_at" field.
  DateTime? _loveBuddiesTravelStartedAt;
  DateTime? get loveBuddiesTravelStartedAt => _loveBuddiesTravelStartedAt;
  bool hasLoveBuddiesTravelStartedAt() => _loveBuddiesTravelStartedAt != null;

  // "love_buddies_last_love_sent_by_uid" field.
  String? _loveBuddiesLastLoveSentByUid;
  String get loveBuddiesLastLoveSentByUid =>
      _loveBuddiesLastLoveSentByUid ?? '';
  bool hasLoveBuddiesLastLoveSentByUid() =>
      _loveBuddiesLastLoveSentByUid != null;

  // "love_buddies_last_love_sent_at" field.
  DateTime? _loveBuddiesLastLoveSentAt;
  DateTime? get loveBuddiesLastLoveSentAt => _loveBuddiesLastLoveSentAt;
  bool hasLoveBuddiesLastLoveSentAt() => _loveBuddiesLastLoveSentAt != null;

  // "love_buddies_current_distance_km" field.
  double? _loveBuddiesCurrentDistanceKm;
  double get loveBuddiesCurrentDistanceKm =>
      _loveBuddiesCurrentDistanceKm ?? 0.0;
  bool hasLoveBuddiesCurrentDistanceKm() =>
      _loveBuddiesCurrentDistanceKm != null;

  // "love_buddies_start_distance_km" field.
  double? _loveBuddiesStartDistanceKm;
  double get loveBuddiesStartDistanceKm => _loveBuddiesStartDistanceKm ?? 0.0;
  bool hasLoveBuddiesStartDistanceKm() => _loveBuddiesStartDistanceKm != null;

  // "love_buddies_destination_uid" field.
  String? _loveBuddiesDestinationUid;
  String get loveBuddiesDestinationUid => _loveBuddiesDestinationUid ?? '';
  bool hasLoveBuddiesDestinationUid() => _loveBuddiesDestinationUid != null;

  // "love_buddies_travel_target_at" field.
  DateTime? _loveBuddiesTravelTargetAt;
  DateTime? get loveBuddiesTravelTargetAt => _loveBuddiesTravelTargetAt;
  bool hasLoveBuddiesTravelTargetAt() => _loveBuddiesTravelTargetAt != null;

  // "love_buddies_distance_updated_at" field.
  DateTime? _loveBuddiesDistanceUpdatedAt;
  DateTime? get loveBuddiesDistanceUpdatedAt => _loveBuddiesDistanceUpdatedAt;
  bool hasLoveBuddiesDistanceUpdatedAt() =>
      _loveBuddiesDistanceUpdatedAt != null;

  // "love_buddies_together_active" field.
  bool? _loveBuddiesTogetherActive;
  bool get loveBuddiesTogetherActive => _loveBuddiesTogetherActive ?? false;
  bool hasLoveBuddiesTogetherActive() => _loveBuddiesTogetherActive != null;

  // "love_buddies_together_started_at" field.
  DateTime? _loveBuddiesTogetherStartedAt;
  DateTime? get loveBuddiesTogetherStartedAt => _loveBuddiesTogetherStartedAt;
  bool hasLoveBuddiesTogetherStartedAt() =>
      _loveBuddiesTogetherStartedAt != null;

  // "love_buddies_travel_upcoming_active" field.
  bool? _loveBuddiesTravelUpcomingActive;
  bool get loveBuddiesTravelUpcomingActive =>
      _loveBuddiesTravelUpcomingActive ?? false;
  bool hasLoveBuddiesTravelUpcomingActive() =>
      _loveBuddiesTravelUpcomingActive != null;

  // "love_buddies_travel_pack_active" field.
  bool? _loveBuddiesTravelPackActive;
  bool get loveBuddiesTravelPackActive => _loveBuddiesTravelPackActive ?? false;
  bool hasLoveBuddiesTravelPackActive() => _loveBuddiesTravelPackActive != null;

  // "love_buddies_travel_pack_started_at" field.
  DateTime? _loveBuddiesTravelPackStartedAt;
  DateTime? get loveBuddiesTravelPackStartedAt =>
      _loveBuddiesTravelPackStartedAt;
  bool hasLoveBuddiesTravelPackStartedAt() =>
      _loveBuddiesTravelPackStartedAt != null;

  // "love_buddies_travel_pack_ended_at" field.
  DateTime? _loveBuddiesTravelPackEndedAt;
  DateTime? get loveBuddiesTravelPackEndedAt => _loveBuddiesTravelPackEndedAt;
  bool hasLoveBuddiesTravelPackEndedAt() =>
      _loveBuddiesTravelPackEndedAt != null;

  // "love_buddies_returning_uid" field.
  String? _loveBuddiesReturningUid;
  String get loveBuddiesReturningUid => _loveBuddiesReturningUid ?? '';
  bool hasLoveBuddiesReturningUid() => _loveBuddiesReturningUid != null;

  // "love_buddies_return_started_at" field.
  DateTime? _loveBuddiesReturnStartedAt;
  DateTime? get loveBuddiesReturnStartedAt => _loveBuddiesReturnStartedAt;
  bool hasLoveBuddiesReturnStartedAt() => _loveBuddiesReturnStartedAt != null;

  // "love_buddies_return_completed_at" field.
  DateTime? _loveBuddiesReturnCompletedAt;
  DateTime? get loveBuddiesReturnCompletedAt => _loveBuddiesReturnCompletedAt;
  bool hasLoveBuddiesReturnCompletedAt() =>
      _loveBuddiesReturnCompletedAt != null;

  // "love_buddies_live_location_mode" field.
  String? _loveBuddiesLiveLocationMode;
  String get loveBuddiesLiveLocationMode => _loveBuddiesLiveLocationMode ?? '';
  bool hasLoveBuddiesLiveLocationMode() => _loveBuddiesLiveLocationMode != null;

  // "love_buddies_live_location_active" field.
  bool? _loveBuddiesLiveLocationActive;
  bool get loveBuddiesLiveLocationActive =>
      _loveBuddiesLiveLocationActive ?? false;
  bool hasLoveBuddiesLiveLocationActive() =>
      _loveBuddiesLiveLocationActive != null;

  // "love_buddies_live_location_userA_consent" field.
  bool? _loveBuddiesLiveLocationUserAConsent;
  bool get loveBuddiesLiveLocationUserAConsent =>
      _loveBuddiesLiveLocationUserAConsent ?? false;
  bool hasLoveBuddiesLiveLocationUserAConsent() =>
      _loveBuddiesLiveLocationUserAConsent != null;

  // "love_buddies_live_location_userB_consent" field.
  bool? _loveBuddiesLiveLocationUserBConsent;
  bool get loveBuddiesLiveLocationUserBConsent =>
      _loveBuddiesLiveLocationUserBConsent ?? false;
  bool hasLoveBuddiesLiveLocationUserBConsent() =>
      _loveBuddiesLiveLocationUserBConsent != null;

  // "love_buddies_live_location_userA_consent_at" field.
  DateTime? _loveBuddiesLiveLocationUserAConsentAt;
  DateTime? get loveBuddiesLiveLocationUserAConsentAt =>
      _loveBuddiesLiveLocationUserAConsentAt;
  bool hasLoveBuddiesLiveLocationUserAConsentAt() =>
      _loveBuddiesLiveLocationUserAConsentAt != null;

  // "love_buddies_live_location_userB_consent_at" field.
  DateTime? _loveBuddiesLiveLocationUserBConsentAt;
  DateTime? get loveBuddiesLiveLocationUserBConsentAt =>
      _loveBuddiesLiveLocationUserBConsentAt;
  bool hasLoveBuddiesLiveLocationUserBConsentAt() =>
      _loveBuddiesLiveLocationUserBConsentAt != null;

  // "love_buddies_birthday_active" field.
  bool? _loveBuddiesBirthdayActive;
  bool get loveBuddiesBirthdayActive => _loveBuddiesBirthdayActive ?? false;
  bool hasLoveBuddiesBirthdayActive() => _loveBuddiesBirthdayActive != null;

  // "love_buddies_birthday_user_uids" field.
  List<String>? _loveBuddiesBirthdayUserUids;
  List<String> get loveBuddiesBirthdayUserUids =>
      _loveBuddiesBirthdayUserUids ?? const [];
  bool hasLoveBuddiesBirthdayUserUids() => _loveBuddiesBirthdayUserUids != null;

  // "love_buddies_birthday_started_at" field.
  DateTime? _loveBuddiesBirthdayStartedAt;
  DateTime? get loveBuddiesBirthdayStartedAt => _loveBuddiesBirthdayStartedAt;
  bool hasLoveBuddiesBirthdayStartedAt() =>
      _loveBuddiesBirthdayStartedAt != null;

  // "love_buddies_birthday_ended_at" field.
  DateTime? _loveBuddiesBirthdayEndedAt;
  DateTime? get loveBuddiesBirthdayEndedAt => _loveBuddiesBirthdayEndedAt;
  bool hasLoveBuddiesBirthdayEndedAt() => _loveBuddiesBirthdayEndedAt != null;

  void _initializeFields() {
    _userAId = snapshotData['userA_id'] as String?;
    _userBId = snapshotData['userB_id'] as String?;
    _startedAt = snapshotData['started_at'] as DateTime?;
    _nextMeetingDate = snapshotData['next_meeting_date'] as DateTime?;
    _active = snapshotData['active'] as bool?;
    _relationshipId = snapshotData['relationship_id'] as String?;
    _partnerUserId = snapshotData['partnerUserId'] as String?;
    _disconnectedAt = snapshotData['disconnected_at'] as DateTime?;
    _purgeAt = snapshotData['purge_at'] as DateTime?;
    _togetherSince = snapshotData['together_since'] as DateTime?;
    _togetherSinceConflict = snapshotData['together_since_conflict'] as bool?;
    _loveBuddiesEnabled = snapshotData['love_buddies_enabled'] as bool?;
    _loveBuddiesUserAPet = snapshotData['love_buddies_user_a_pet'] as String?;
    _loveBuddiesUserBPet = snapshotData['love_buddies_user_b_pet'] as String?;
    _loveBuddiesUserAName = snapshotData['love_buddies_user_a_name'] as String?;
    _loveBuddiesUserBName = snapshotData['love_buddies_user_b_name'] as String?;
    _loveBuddiesCreatedAt =
        snapshotData['love_buddies_created_at'] as DateTime?;
    _loveBuddiesUpdatedAt =
        snapshotData['love_buddies_updated_at'] as DateTime?;
    _loveBuddiesTravelerUid =
        snapshotData['love_buddies_traveler_uid'] as String?;
    _loveBuddiesTravelActive =
        snapshotData['love_buddies_travel_active'] as bool?;
    _loveBuddiesTravelStartedAt =
        snapshotData['love_buddies_travel_started_at'] as DateTime?;
    _loveBuddiesLastLoveSentByUid =
        snapshotData['love_buddies_last_love_sent_by_uid'] as String?;
    _loveBuddiesLastLoveSentAt =
        snapshotData['love_buddies_last_love_sent_at'] as DateTime?;
    _loveBuddiesCurrentDistanceKm =
        castToType<double>(snapshotData['love_buddies_current_distance_km']);
    _loveBuddiesStartDistanceKm =
        castToType<double>(snapshotData['love_buddies_start_distance_km']);
    _loveBuddiesDestinationUid =
        snapshotData['love_buddies_destination_uid'] as String?;
    _loveBuddiesTravelTargetAt =
        snapshotData['love_buddies_travel_target_at'] as DateTime?;
    _loveBuddiesDistanceUpdatedAt =
        snapshotData['love_buddies_distance_updated_at'] as DateTime?;
    _loveBuddiesTogetherActive =
        snapshotData['love_buddies_together_active'] as bool?;
    _loveBuddiesTogetherStartedAt =
        snapshotData['love_buddies_together_started_at'] as DateTime?;
    _loveBuddiesTravelUpcomingActive =
        snapshotData['love_buddies_travel_upcoming_active'] as bool?;
    _loveBuddiesTravelPackActive =
        snapshotData['love_buddies_travel_pack_active'] as bool?;
    _loveBuddiesTravelPackStartedAt =
        snapshotData['love_buddies_travel_pack_started_at'] as DateTime?;
    _loveBuddiesTravelPackEndedAt =
        snapshotData['love_buddies_travel_pack_ended_at'] as DateTime?;
    _loveBuddiesReturningUid =
        snapshotData['love_buddies_returning_uid'] as String?;
    _loveBuddiesReturnStartedAt =
        snapshotData['love_buddies_return_started_at'] as DateTime?;
    _loveBuddiesReturnCompletedAt =
        snapshotData['love_buddies_return_completed_at'] as DateTime?;
    _loveBuddiesLiveLocationMode =
        snapshotData['love_buddies_live_location_mode'] as String?;
    _loveBuddiesLiveLocationActive =
        snapshotData['love_buddies_live_location_active'] as bool?;
    _loveBuddiesLiveLocationUserAConsent =
        snapshotData['love_buddies_live_location_userA_consent'] as bool?;
    _loveBuddiesLiveLocationUserBConsent =
        snapshotData['love_buddies_live_location_userB_consent'] as bool?;
    _loveBuddiesLiveLocationUserAConsentAt =
        snapshotData['love_buddies_live_location_userA_consent_at']
            as DateTime?;
    _loveBuddiesLiveLocationUserBConsentAt =
        snapshotData['love_buddies_live_location_userB_consent_at']
            as DateTime?;
    _loveBuddiesBirthdayActive =
        snapshotData['love_buddies_birthday_active'] as bool?;
    _loveBuddiesBirthdayUserUids =
        getDataList(snapshotData['love_buddies_birthday_user_uids']);
    _loveBuddiesBirthdayStartedAt =
        snapshotData['love_buddies_birthday_started_at'] as DateTime?;
    _loveBuddiesBirthdayEndedAt =
        snapshotData['love_buddies_birthday_ended_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('relationships');

  static Stream<RelationshipsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RelationshipsRecord.fromSnapshot(s));

  static Future<RelationshipsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RelationshipsRecord.fromSnapshot(s));

  static RelationshipsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RelationshipsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RelationshipsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RelationshipsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RelationshipsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RelationshipsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRelationshipsRecordData({
  String? userAId,
  String? userBId,
  DateTime? startedAt,
  DateTime? nextMeetingDate,
  bool? active,
  String? relationshipId,
  String? partnerUserId,
  DateTime? disconnectedAt,
  DateTime? purgeAt,
  DateTime? togetherSince,
  bool? togetherSinceConflict,
  bool? loveBuddiesEnabled,
  String? loveBuddiesUserAPet,
  String? loveBuddiesUserBPet,
  String? loveBuddiesUserAName,
  String? loveBuddiesUserBName,
  DateTime? loveBuddiesCreatedAt,
  DateTime? loveBuddiesUpdatedAt,
  String? loveBuddiesTravelerUid,
  bool? loveBuddiesTravelActive,
  DateTime? loveBuddiesTravelStartedAt,
  String? loveBuddiesLastLoveSentByUid,
  DateTime? loveBuddiesLastLoveSentAt,
  double? loveBuddiesCurrentDistanceKm,
  double? loveBuddiesStartDistanceKm,
  String? loveBuddiesDestinationUid,
  DateTime? loveBuddiesTravelTargetAt,
  DateTime? loveBuddiesDistanceUpdatedAt,
  bool? loveBuddiesTogetherActive,
  DateTime? loveBuddiesTogetherStartedAt,
  bool? loveBuddiesTravelUpcomingActive,
  bool? loveBuddiesTravelPackActive,
  DateTime? loveBuddiesTravelPackStartedAt,
  DateTime? loveBuddiesTravelPackEndedAt,
  String? loveBuddiesReturningUid,
  DateTime? loveBuddiesReturnStartedAt,
  DateTime? loveBuddiesReturnCompletedAt,
  String? loveBuddiesLiveLocationMode,
  bool? loveBuddiesLiveLocationActive,
  bool? loveBuddiesLiveLocationUserAConsent,
  bool? loveBuddiesLiveLocationUserBConsent,
  DateTime? loveBuddiesLiveLocationUserAConsentAt,
  DateTime? loveBuddiesLiveLocationUserBConsentAt,
  bool? loveBuddiesBirthdayActive,
  DateTime? loveBuddiesBirthdayStartedAt,
  DateTime? loveBuddiesBirthdayEndedAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userA_id': userAId,
      'userB_id': userBId,
      'started_at': startedAt,
      'next_meeting_date': nextMeetingDate,
      'active': active,
      'relationship_id': relationshipId,
      'partnerUserId': partnerUserId,
      'disconnected_at': disconnectedAt,
      'purge_at': purgeAt,
      'together_since': togetherSince,
      'together_since_conflict': togetherSinceConflict,
      'love_buddies_enabled': loveBuddiesEnabled,
      'love_buddies_user_a_pet': loveBuddiesUserAPet,
      'love_buddies_user_b_pet': loveBuddiesUserBPet,
      'love_buddies_user_a_name': loveBuddiesUserAName,
      'love_buddies_user_b_name': loveBuddiesUserBName,
      'love_buddies_created_at': loveBuddiesCreatedAt,
      'love_buddies_updated_at': loveBuddiesUpdatedAt,
      'love_buddies_traveler_uid': loveBuddiesTravelerUid,
      'love_buddies_travel_active': loveBuddiesTravelActive,
      'love_buddies_travel_started_at': loveBuddiesTravelStartedAt,
      'love_buddies_last_love_sent_by_uid': loveBuddiesLastLoveSentByUid,
      'love_buddies_last_love_sent_at': loveBuddiesLastLoveSentAt,
      'love_buddies_current_distance_km': loveBuddiesCurrentDistanceKm,
      'love_buddies_start_distance_km': loveBuddiesStartDistanceKm,
      'love_buddies_destination_uid': loveBuddiesDestinationUid,
      'love_buddies_travel_target_at': loveBuddiesTravelTargetAt,
      'love_buddies_distance_updated_at': loveBuddiesDistanceUpdatedAt,
      'love_buddies_together_active': loveBuddiesTogetherActive,
      'love_buddies_together_started_at': loveBuddiesTogetherStartedAt,
      'love_buddies_travel_upcoming_active': loveBuddiesTravelUpcomingActive,
      'love_buddies_travel_pack_active': loveBuddiesTravelPackActive,
      'love_buddies_travel_pack_started_at': loveBuddiesTravelPackStartedAt,
      'love_buddies_travel_pack_ended_at': loveBuddiesTravelPackEndedAt,
      'love_buddies_returning_uid': loveBuddiesReturningUid,
      'love_buddies_return_started_at': loveBuddiesReturnStartedAt,
      'love_buddies_return_completed_at': loveBuddiesReturnCompletedAt,
      'love_buddies_live_location_mode': loveBuddiesLiveLocationMode,
      'love_buddies_live_location_active': loveBuddiesLiveLocationActive,
      'love_buddies_live_location_userA_consent':
          loveBuddiesLiveLocationUserAConsent,
      'love_buddies_live_location_userB_consent':
          loveBuddiesLiveLocationUserBConsent,
      'love_buddies_live_location_userA_consent_at':
          loveBuddiesLiveLocationUserAConsentAt,
      'love_buddies_live_location_userB_consent_at':
          loveBuddiesLiveLocationUserBConsentAt,
      'love_buddies_birthday_active': loveBuddiesBirthdayActive,
      'love_buddies_birthday_started_at': loveBuddiesBirthdayStartedAt,
      'love_buddies_birthday_ended_at': loveBuddiesBirthdayEndedAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class RelationshipsRecordDocumentEquality
    implements Equality<RelationshipsRecord> {
  const RelationshipsRecordDocumentEquality();

  @override
  bool equals(RelationshipsRecord? e1, RelationshipsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.userAId == e2?.userAId &&
        e1?.userBId == e2?.userBId &&
        e1?.startedAt == e2?.startedAt &&
        e1?.nextMeetingDate == e2?.nextMeetingDate &&
        e1?.active == e2?.active &&
        e1?.relationshipId == e2?.relationshipId &&
        e1?.partnerUserId == e2?.partnerUserId &&
        e1?.disconnectedAt == e2?.disconnectedAt &&
        e1?.purgeAt == e2?.purgeAt &&
        e1?.togetherSince == e2?.togetherSince &&
        e1?.togetherSinceConflict == e2?.togetherSinceConflict &&
        e1?.loveBuddiesEnabled == e2?.loveBuddiesEnabled &&
        e1?.loveBuddiesUserAPet == e2?.loveBuddiesUserAPet &&
        e1?.loveBuddiesUserBPet == e2?.loveBuddiesUserBPet &&
        e1?.loveBuddiesUserAName == e2?.loveBuddiesUserAName &&
        e1?.loveBuddiesUserBName == e2?.loveBuddiesUserBName &&
        e1?.loveBuddiesCreatedAt == e2?.loveBuddiesCreatedAt &&
        e1?.loveBuddiesUpdatedAt == e2?.loveBuddiesUpdatedAt &&
        e1?.loveBuddiesTravelerUid == e2?.loveBuddiesTravelerUid &&
        e1?.loveBuddiesTravelActive == e2?.loveBuddiesTravelActive &&
        e1?.loveBuddiesTravelStartedAt == e2?.loveBuddiesTravelStartedAt &&
        e1?.loveBuddiesLastLoveSentByUid == e2?.loveBuddiesLastLoveSentByUid &&
        e1?.loveBuddiesLastLoveSentAt == e2?.loveBuddiesLastLoveSentAt &&
        e1?.loveBuddiesCurrentDistanceKm == e2?.loveBuddiesCurrentDistanceKm &&
        e1?.loveBuddiesStartDistanceKm == e2?.loveBuddiesStartDistanceKm &&
        e1?.loveBuddiesDestinationUid == e2?.loveBuddiesDestinationUid &&
        e1?.loveBuddiesTravelTargetAt == e2?.loveBuddiesTravelTargetAt &&
        e1?.loveBuddiesDistanceUpdatedAt == e2?.loveBuddiesDistanceUpdatedAt &&
        e1?.loveBuddiesTogetherActive == e2?.loveBuddiesTogetherActive &&
        e1?.loveBuddiesTogetherStartedAt == e2?.loveBuddiesTogetherStartedAt &&
        e1?.loveBuddiesTravelUpcomingActive ==
            e2?.loveBuddiesTravelUpcomingActive &&
        e1?.loveBuddiesTravelPackActive == e2?.loveBuddiesTravelPackActive &&
        e1?.loveBuddiesTravelPackStartedAt ==
            e2?.loveBuddiesTravelPackStartedAt &&
        e1?.loveBuddiesTravelPackEndedAt == e2?.loveBuddiesTravelPackEndedAt &&
        e1?.loveBuddiesReturningUid == e2?.loveBuddiesReturningUid &&
        e1?.loveBuddiesReturnStartedAt == e2?.loveBuddiesReturnStartedAt &&
        e1?.loveBuddiesReturnCompletedAt == e2?.loveBuddiesReturnCompletedAt &&
        e1?.loveBuddiesLiveLocationMode == e2?.loveBuddiesLiveLocationMode &&
        e1?.loveBuddiesLiveLocationActive ==
            e2?.loveBuddiesLiveLocationActive &&
        e1?.loveBuddiesLiveLocationUserAConsent ==
            e2?.loveBuddiesLiveLocationUserAConsent &&
        e1?.loveBuddiesLiveLocationUserBConsent ==
            e2?.loveBuddiesLiveLocationUserBConsent &&
        e1?.loveBuddiesLiveLocationUserAConsentAt ==
            e2?.loveBuddiesLiveLocationUserAConsentAt &&
        e1?.loveBuddiesLiveLocationUserBConsentAt ==
            e2?.loveBuddiesLiveLocationUserBConsentAt &&
        e1?.loveBuddiesBirthdayActive == e2?.loveBuddiesBirthdayActive &&
        listEquality.equals(
            e1?.loveBuddiesBirthdayUserUids, e2?.loveBuddiesBirthdayUserUids) &&
        e1?.loveBuddiesBirthdayStartedAt == e2?.loveBuddiesBirthdayStartedAt &&
        e1?.loveBuddiesBirthdayEndedAt == e2?.loveBuddiesBirthdayEndedAt;
  }

  @override
  int hash(RelationshipsRecord? e) => const ListEquality().hash([
        e?.userAId,
        e?.userBId,
        e?.startedAt,
        e?.nextMeetingDate,
        e?.active,
        e?.relationshipId,
        e?.partnerUserId,
        e?.disconnectedAt,
        e?.purgeAt,
        e?.togetherSince,
        e?.togetherSinceConflict,
        e?.loveBuddiesEnabled,
        e?.loveBuddiesUserAPet,
        e?.loveBuddiesUserBPet,
        e?.loveBuddiesUserAName,
        e?.loveBuddiesUserBName,
        e?.loveBuddiesCreatedAt,
        e?.loveBuddiesUpdatedAt,
        e?.loveBuddiesTravelerUid,
        e?.loveBuddiesTravelActive,
        e?.loveBuddiesTravelStartedAt,
        e?.loveBuddiesLastLoveSentByUid,
        e?.loveBuddiesLastLoveSentAt,
        e?.loveBuddiesCurrentDistanceKm,
        e?.loveBuddiesStartDistanceKm,
        e?.loveBuddiesDestinationUid,
        e?.loveBuddiesTravelTargetAt,
        e?.loveBuddiesDistanceUpdatedAt,
        e?.loveBuddiesTogetherActive,
        e?.loveBuddiesTogetherStartedAt,
        e?.loveBuddiesTravelUpcomingActive,
        e?.loveBuddiesTravelPackActive,
        e?.loveBuddiesTravelPackStartedAt,
        e?.loveBuddiesTravelPackEndedAt,
        e?.loveBuddiesReturningUid,
        e?.loveBuddiesReturnStartedAt,
        e?.loveBuddiesReturnCompletedAt,
        e?.loveBuddiesLiveLocationMode,
        e?.loveBuddiesLiveLocationActive,
        e?.loveBuddiesLiveLocationUserAConsent,
        e?.loveBuddiesLiveLocationUserBConsent,
        e?.loveBuddiesLiveLocationUserAConsentAt,
        e?.loveBuddiesLiveLocationUserBConsentAt,
        e?.loveBuddiesBirthdayActive,
        e?.loveBuddiesBirthdayUserUids,
        e?.loveBuddiesBirthdayStartedAt,
        e?.loveBuddiesBirthdayEndedAt
      ]);

  @override
  bool isValidKey(Object? o) => o is RelationshipsRecord;
}
