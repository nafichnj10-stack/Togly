import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CalendarEventsRecord extends FirestoreRecord {
  CalendarEventsRecord._(
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

  // "start" field.
  DateTime? _start;
  DateTime? get start => _start;
  bool hasStart() => _start != null;

  // "end" field.
  DateTime? _end;
  DateTime? get end => _end;
  bool hasEnd() => _end != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "all_day" field.
  bool? _allDay;
  bool get allDay => _allDay ?? false;
  bool hasAllDay() => _allDay != null;

  // "note" field.
  String? _note;
  String get note => _note ?? '';
  bool hasNote() => _note != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  bool hasLocation() => _location != null;

  // "color" field.
  int? _color;
  int get color => _color ?? 0;
  bool hasColor() => _color != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  bool hasCreatedBy() => _createdBy != null;

  // "expires_at_archive" field.
  DateTime? _expiresAtArchive;
  DateTime? get expiresAtArchive => _expiresAtArchive;
  bool hasExpiresAtArchive() => _expiresAtArchive != null;

  // "category_key" field.
  String? _categoryKey;
  String get categoryKey => _categoryKey ?? '';
  bool hasCategoryKey() => _categoryKey != null;

  // "traveler_uid" field.
  String? _travelerUid;
  String get travelerUid => _travelerUid ?? '';
  bool hasTravelerUid() => _travelerUid != null;

  // "destination_uid" field.
  String? _destinationUid;
  String get destinationUid => _destinationUid ?? '';
  bool hasDestinationUid() => _destinationUid != null;

  void _initializeFields() {
    _relationshipId = snapshotData['relationship_id'] as String?;
    _title = snapshotData['title'] as String?;
    _start = snapshotData['start'] as DateTime?;
    _end = snapshotData['end'] as DateTime?;
    _category = snapshotData['category'] as String?;
    _allDay = snapshotData['all_day'] as bool?;
    _note = snapshotData['note'] as String?;
    _location = snapshotData['location'] as String?;
    _color = castToType<int>(snapshotData['color']);
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as String?;
    _expiresAtArchive = snapshotData['expires_at_archive'] as DateTime?;
    _categoryKey = snapshotData['category_key'] as String?;
    _travelerUid = snapshotData['traveler_uid'] as String?;
    _destinationUid = snapshotData['destination_uid'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('calendar_events');

  static Stream<CalendarEventsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CalendarEventsRecord.fromSnapshot(s));

  static Future<CalendarEventsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CalendarEventsRecord.fromSnapshot(s));

  static CalendarEventsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CalendarEventsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CalendarEventsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CalendarEventsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CalendarEventsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CalendarEventsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCalendarEventsRecordData({
  String? relationshipId,
  String? title,
  DateTime? start,
  DateTime? end,
  String? category,
  bool? allDay,
  String? note,
  String? location,
  int? color,
  DateTime? updatedAt,
  String? createdBy,
  DateTime? expiresAtArchive,
  String? categoryKey,
  String? travelerUid,
  String? destinationUid,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'relationship_id': relationshipId,
      'title': title,
      'start': start,
      'end': end,
      'category': category,
      'all_day': allDay,
      'note': note,
      'location': location,
      'color': color,
      'updated_at': updatedAt,
      'created_by': createdBy,
      'expires_at_archive': expiresAtArchive,
      'category_key': categoryKey,
      'traveler_uid': travelerUid,
      'destination_uid': destinationUid,
    }.withoutNulls,
  );

  return firestoreData;
}

class CalendarEventsRecordDocumentEquality
    implements Equality<CalendarEventsRecord> {
  const CalendarEventsRecordDocumentEquality();

  @override
  bool equals(CalendarEventsRecord? e1, CalendarEventsRecord? e2) {
    return e1?.relationshipId == e2?.relationshipId &&
        e1?.title == e2?.title &&
        e1?.start == e2?.start &&
        e1?.end == e2?.end &&
        e1?.category == e2?.category &&
        e1?.allDay == e2?.allDay &&
        e1?.note == e2?.note &&
        e1?.location == e2?.location &&
        e1?.color == e2?.color &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.createdBy == e2?.createdBy &&
        e1?.expiresAtArchive == e2?.expiresAtArchive &&
        e1?.categoryKey == e2?.categoryKey &&
        e1?.travelerUid == e2?.travelerUid &&
        e1?.destinationUid == e2?.destinationUid;
  }

  @override
  int hash(CalendarEventsRecord? e) => const ListEquality().hash([
        e?.relationshipId,
        e?.title,
        e?.start,
        e?.end,
        e?.category,
        e?.allDay,
        e?.note,
        e?.location,
        e?.color,
        e?.updatedAt,
        e?.createdBy,
        e?.expiresAtArchive,
        e?.categoryKey,
        e?.travelerUid,
        e?.destinationUid
      ]);

  @override
  bool isValidKey(Object? o) => o is CalendarEventsRecord;
}
