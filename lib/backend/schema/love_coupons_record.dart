import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LoveCouponsRecord extends FirestoreRecord {
  LoveCouponsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "coupon_id" field.
  String? _couponId;
  String get couponId => _couponId ?? '';
  bool hasCouponId() => _couponId != null;

  // "relationship_id" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  bool hasRelationshipId() => _relationshipId != null;

  // "created_by_user_id" field.
  String? _createdByUserId;
  String get createdByUserId => _createdByUserId ?? '';
  bool hasCreatedByUserId() => _createdByUserId != null;

  // "created_for_user_id" field.
  String? _createdForUserId;
  String get createdForUserId => _createdForUserId ?? '';
  bool hasCreatedForUserId() => _createdForUserId != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "template_id" field.
  String? _templateId;
  String get templateId => _templateId ?? '';
  bool hasTemplateId() => _templateId != null;

  // "design_key" field.
  String? _designKey;
  String get designKey => _designKey ?? '';
  bool hasDesignKey() => _designKey != null;

  // "icon_key" field.
  String? _iconKey;
  String get iconKey => _iconKey ?? '';
  bool hasIconKey() => _iconKey != null;

  // "is_template" field.
  bool? _isTemplate;
  bool get isTemplate => _isTemplate ?? false;
  bool hasIsTemplate() => _isTemplate != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "photo_path" field.
  String? _photoPath;
  String get photoPath => _photoPath ?? '';
  bool hasPhotoPath() => _photoPath != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "is_redeemed" field.
  bool? _isRedeemed;
  bool get isRedeemed => _isRedeemed ?? false;
  bool hasIsRedeemed() => _isRedeemed != null;

  // "redeemed_at" field.
  DateTime? _redeemedAt;
  DateTime? get redeemedAt => _redeemedAt;
  bool hasRedeemedAt() => _redeemedAt != null;

  // "redeemed_by_user_id" field.
  String? _redeemedByUserId;
  String get redeemedByUserId => _redeemedByUserId ?? '';
  bool hasRedeemedByUserId() => _redeemedByUserId != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "is_unlimited" field.
  bool? _isUnlimited;
  bool get isUnlimited => _isUnlimited ?? false;
  bool hasIsUnlimited() => _isUnlimited != null;

  // "expires_at" field.
  DateTime? _expiresAt;
  DateTime? get expiresAt => _expiresAt;
  bool hasExpiresAt() => _expiresAt != null;

  // "created_from_treasure" field.
  bool? _createdFromTreasure;
  bool get createdFromTreasure => _createdFromTreasure ?? false;
  bool hasCreatedFromTreasure() => _createdFromTreasure != null;

  // "source_treasure_id" field.
  String? _sourceTreasureId;
  String get sourceTreasureId => _sourceTreasureId ?? '';
  bool hasSourceTreasureId() => _sourceTreasureId != null;

  // "source_treasure_ref" field.
  DocumentReference? _sourceTreasureRef;
  DocumentReference? get sourceTreasureRef => _sourceTreasureRef;
  bool hasSourceTreasureRef() => _sourceTreasureRef != null;

  // "is_visible_in_wallet" field.
  bool? _isVisibleInWallet;
  bool get isVisibleInWallet => _isVisibleInWallet ?? false;
  bool hasIsVisibleInWallet() => _isVisibleInWallet != null;

  // "unlocked_at" field.
  DateTime? _unlockedAt;
  DateTime? get unlockedAt => _unlockedAt;
  bool hasUnlockedAt() => _unlockedAt != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _couponId = snapshotData['coupon_id'] as String?;
    _relationshipId = snapshotData['relationship_id'] as String?;
    _createdByUserId = snapshotData['created_by_user_id'] as String?;
    _createdForUserId = snapshotData['created_for_user_id'] as String?;
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _category = snapshotData['category'] as String?;
    _templateId = snapshotData['template_id'] as String?;
    _designKey = snapshotData['design_key'] as String?;
    _iconKey = snapshotData['icon_key'] as String?;
    _isTemplate = snapshotData['is_template'] as bool?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _photoPath = snapshotData['photo_path'] as String?;
    _status = snapshotData['status'] as String?;
    _isRedeemed = snapshotData['is_redeemed'] as bool?;
    _redeemedAt = snapshotData['redeemed_at'] as DateTime?;
    _redeemedByUserId = snapshotData['redeemed_by_user_id'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _isUnlimited = snapshotData['is_unlimited'] as bool?;
    _expiresAt = snapshotData['expires_at'] as DateTime?;
    _createdFromTreasure = snapshotData['created_from_treasure'] as bool?;
    _sourceTreasureId = snapshotData['source_treasure_id'] as String?;
    _sourceTreasureRef =
        snapshotData['source_treasure_ref'] as DocumentReference?;
    _isVisibleInWallet = snapshotData['is_visible_in_wallet'] as bool?;
    _unlockedAt = snapshotData['unlocked_at'] as DateTime?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('love_coupons')
          : FirebaseFirestore.instance.collectionGroup('love_coupons');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('love_coupons').doc(id);

  static Stream<LoveCouponsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => LoveCouponsRecord.fromSnapshot(s));

  static Future<LoveCouponsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => LoveCouponsRecord.fromSnapshot(s));

  static LoveCouponsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      LoveCouponsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static LoveCouponsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      LoveCouponsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'LoveCouponsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is LoveCouponsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createLoveCouponsRecordData({
  String? couponId,
  String? relationshipId,
  String? createdByUserId,
  String? createdForUserId,
  String? title,
  String? description,
  String? category,
  String? templateId,
  String? designKey,
  String? iconKey,
  bool? isTemplate,
  String? photoUrl,
  String? photoPath,
  String? status,
  bool? isRedeemed,
  DateTime? redeemedAt,
  String? redeemedByUserId,
  DateTime? createdAt,
  DateTime? updatedAt,
  bool? isUnlimited,
  DateTime? expiresAt,
  bool? createdFromTreasure,
  String? sourceTreasureId,
  DocumentReference? sourceTreasureRef,
  bool? isVisibleInWallet,
  DateTime? unlockedAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'coupon_id': couponId,
      'relationship_id': relationshipId,
      'created_by_user_id': createdByUserId,
      'created_for_user_id': createdForUserId,
      'title': title,
      'description': description,
      'category': category,
      'template_id': templateId,
      'design_key': designKey,
      'icon_key': iconKey,
      'is_template': isTemplate,
      'photo_url': photoUrl,
      'photo_path': photoPath,
      'status': status,
      'is_redeemed': isRedeemed,
      'redeemed_at': redeemedAt,
      'redeemed_by_user_id': redeemedByUserId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_unlimited': isUnlimited,
      'expires_at': expiresAt,
      'created_from_treasure': createdFromTreasure,
      'source_treasure_id': sourceTreasureId,
      'source_treasure_ref': sourceTreasureRef,
      'is_visible_in_wallet': isVisibleInWallet,
      'unlocked_at': unlockedAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class LoveCouponsRecordDocumentEquality implements Equality<LoveCouponsRecord> {
  const LoveCouponsRecordDocumentEquality();

  @override
  bool equals(LoveCouponsRecord? e1, LoveCouponsRecord? e2) {
    return e1?.couponId == e2?.couponId &&
        e1?.relationshipId == e2?.relationshipId &&
        e1?.createdByUserId == e2?.createdByUserId &&
        e1?.createdForUserId == e2?.createdForUserId &&
        e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.category == e2?.category &&
        e1?.templateId == e2?.templateId &&
        e1?.designKey == e2?.designKey &&
        e1?.iconKey == e2?.iconKey &&
        e1?.isTemplate == e2?.isTemplate &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.photoPath == e2?.photoPath &&
        e1?.status == e2?.status &&
        e1?.isRedeemed == e2?.isRedeemed &&
        e1?.redeemedAt == e2?.redeemedAt &&
        e1?.redeemedByUserId == e2?.redeemedByUserId &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.isUnlimited == e2?.isUnlimited &&
        e1?.expiresAt == e2?.expiresAt &&
        e1?.createdFromTreasure == e2?.createdFromTreasure &&
        e1?.sourceTreasureId == e2?.sourceTreasureId &&
        e1?.sourceTreasureRef == e2?.sourceTreasureRef &&
        e1?.isVisibleInWallet == e2?.isVisibleInWallet &&
        e1?.unlockedAt == e2?.unlockedAt;
  }

  @override
  int hash(LoveCouponsRecord? e) => const ListEquality().hash([
        e?.couponId,
        e?.relationshipId,
        e?.createdByUserId,
        e?.createdForUserId,
        e?.title,
        e?.description,
        e?.category,
        e?.templateId,
        e?.designKey,
        e?.iconKey,
        e?.isTemplate,
        e?.photoUrl,
        e?.photoPath,
        e?.status,
        e?.isRedeemed,
        e?.redeemedAt,
        e?.redeemedByUserId,
        e?.createdAt,
        e?.updatedAt,
        e?.isUnlimited,
        e?.expiresAt,
        e?.createdFromTreasure,
        e?.sourceTreasureId,
        e?.sourceTreasureRef,
        e?.isVisibleInWallet,
        e?.unlockedAt
      ]);

  @override
  bool isValidKey(Object? o) => o is LoveCouponsRecord;
}
