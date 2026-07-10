import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LiveLocationsRecord extends FirestoreRecord {
  LiveLocationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "lat" field.
  double? _lat;
  double get lat => _lat ?? 0.0;
  bool hasLat() => _lat != null;

  // "lng" field.
  double? _lng;
  double get lng => _lng ?? 0.0;
  bool hasLng() => _lng != null;

  // "accuracy_m" field.
  double? _accuracyM;
  double get accuracyM => _accuracyM ?? 0.0;
  bool hasAccuracyM() => _accuracyM != null;

  // "speed_mps" field.
  double? _speedMps;
  double get speedMps => _speedMps ?? 0.0;
  bool hasSpeedMps() => _speedMps != null;

  // "heading" field.
  double? _heading;
  double get heading => _heading ?? 0.0;
  bool hasHeading() => _heading != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "source" field.
  String? _source;
  String get source => _source ?? '';
  bool hasSource() => _source != null;

  // "is_active" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  bool hasIsActive() => _isActive != null;

  // "phase" field.
  String? _phase;
  String get phase => _phase ?? '';
  bool hasPhase() => _phase != null;

  // "battery_level" field.
  double? _batteryLevel;
  double get batteryLevel => _batteryLevel ?? 0.0;
  bool hasBatteryLevel() => _batteryLevel != null;

  // "permission_status" field.
  String? _permissionStatus;
  String get permissionStatus => _permissionStatus ?? '';
  bool hasPermissionStatus() => _permissionStatus != null;

  // "last_error" field.
  String? _lastError;
  String get lastError => _lastError ?? '';
  bool hasLastError() => _lastError != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _lat = castToType<double>(snapshotData['lat']);
    _lng = castToType<double>(snapshotData['lng']);
    _accuracyM = castToType<double>(snapshotData['accuracy_m']);
    _speedMps = castToType<double>(snapshotData['speed_mps']);
    _heading = castToType<double>(snapshotData['heading']);
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _source = snapshotData['source'] as String?;
    _isActive = snapshotData['is_active'] as bool?;
    _phase = snapshotData['phase'] as String?;
    _batteryLevel = castToType<double>(snapshotData['battery_level']);
    _permissionStatus = snapshotData['permission_status'] as String?;
    _lastError = snapshotData['last_error'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('live_locations')
          : FirebaseFirestore.instance.collectionGroup('live_locations');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('live_locations').doc(id);

  static Stream<LiveLocationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => LiveLocationsRecord.fromSnapshot(s));

  static Future<LiveLocationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => LiveLocationsRecord.fromSnapshot(s));

  static LiveLocationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      LiveLocationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static LiveLocationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      LiveLocationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'LiveLocationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is LiveLocationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createLiveLocationsRecordData({
  String? uid,
  double? lat,
  double? lng,
  double? accuracyM,
  double? speedMps,
  double? heading,
  DateTime? updatedAt,
  String? source,
  bool? isActive,
  String? phase,
  double? batteryLevel,
  String? permissionStatus,
  String? lastError,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'lat': lat,
      'lng': lng,
      'accuracy_m': accuracyM,
      'speed_mps': speedMps,
      'heading': heading,
      'updated_at': updatedAt,
      'source': source,
      'is_active': isActive,
      'phase': phase,
      'battery_level': batteryLevel,
      'permission_status': permissionStatus,
      'last_error': lastError,
    }.withoutNulls,
  );

  return firestoreData;
}

class LiveLocationsRecordDocumentEquality
    implements Equality<LiveLocationsRecord> {
  const LiveLocationsRecordDocumentEquality();

  @override
  bool equals(LiveLocationsRecord? e1, LiveLocationsRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.lat == e2?.lat &&
        e1?.lng == e2?.lng &&
        e1?.accuracyM == e2?.accuracyM &&
        e1?.speedMps == e2?.speedMps &&
        e1?.heading == e2?.heading &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.source == e2?.source &&
        e1?.isActive == e2?.isActive &&
        e1?.phase == e2?.phase &&
        e1?.batteryLevel == e2?.batteryLevel &&
        e1?.permissionStatus == e2?.permissionStatus &&
        e1?.lastError == e2?.lastError;
  }

  @override
  int hash(LiveLocationsRecord? e) => const ListEquality().hash([
        e?.uid,
        e?.lat,
        e?.lng,
        e?.accuracyM,
        e?.speedMps,
        e?.heading,
        e?.updatedAt,
        e?.source,
        e?.isActive,
        e?.phase,
        e?.batteryLevel,
        e?.permissionStatus,
        e?.lastError
      ]);

  @override
  bool isValidKey(Object? o) => o is LiveLocationsRecord;
}
