import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SupportTicketsRecord extends FirestoreRecord {
  SupportTicketsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "full_name" field.
  String? _fullName;
  String get fullName => _fullName ?? '';
  bool hasFullName() => _fullName != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "subject" field.
  String? _subject;
  String get subject => _subject ?? '';
  bool hasSubject() => _subject != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  // "last_update_at" field.
  DateTime? _lastUpdateAt;
  DateTime? get lastUpdateAt => _lastUpdateAt;
  bool hasLastUpdateAt() => _lastUpdateAt != null;

  // "priority" field.
  String? _priority;
  String get priority => _priority ?? '';
  bool hasPriority() => _priority != null;

  // "ticket_code" field.
  String? _ticketCode;
  String get ticketCode => _ticketCode ?? '';
  bool hasTicketCode() => _ticketCode != null;

  void _initializeFields() {
    _createdAt = snapshotData['created_at'] as DateTime?;
    _status = snapshotData['status'] as String?;
    _userId = snapshotData['user_id'] as String?;
    _fullName = snapshotData['full_name'] as String?;
    _email = snapshotData['email'] as String?;
    _subject = snapshotData['subject'] as String?;
    _message = snapshotData['message'] as String?;
    _lastUpdateAt = snapshotData['last_update_at'] as DateTime?;
    _priority = snapshotData['priority'] as String?;
    _ticketCode = snapshotData['ticket_code'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('support_tickets');

  static Stream<SupportTicketsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SupportTicketsRecord.fromSnapshot(s));

  static Future<SupportTicketsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SupportTicketsRecord.fromSnapshot(s));

  static SupportTicketsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SupportTicketsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SupportTicketsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SupportTicketsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SupportTicketsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SupportTicketsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSupportTicketsRecordData({
  DateTime? createdAt,
  String? status,
  String? userId,
  String? fullName,
  String? email,
  String? subject,
  String? message,
  DateTime? lastUpdateAt,
  String? priority,
  String? ticketCode,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_at': createdAt,
      'status': status,
      'user_id': userId,
      'full_name': fullName,
      'email': email,
      'subject': subject,
      'message': message,
      'last_update_at': lastUpdateAt,
      'priority': priority,
      'ticket_code': ticketCode,
    }.withoutNulls,
  );

  return firestoreData;
}

class SupportTicketsRecordDocumentEquality
    implements Equality<SupportTicketsRecord> {
  const SupportTicketsRecordDocumentEquality();

  @override
  bool equals(SupportTicketsRecord? e1, SupportTicketsRecord? e2) {
    return e1?.createdAt == e2?.createdAt &&
        e1?.status == e2?.status &&
        e1?.userId == e2?.userId &&
        e1?.fullName == e2?.fullName &&
        e1?.email == e2?.email &&
        e1?.subject == e2?.subject &&
        e1?.message == e2?.message &&
        e1?.lastUpdateAt == e2?.lastUpdateAt &&
        e1?.priority == e2?.priority &&
        e1?.ticketCode == e2?.ticketCode;
  }

  @override
  int hash(SupportTicketsRecord? e) => const ListEquality().hash([
        e?.createdAt,
        e?.status,
        e?.userId,
        e?.fullName,
        e?.email,
        e?.subject,
        e?.message,
        e?.lastUpdateAt,
        e?.priority,
        e?.ticketCode
      ]);

  @override
  bool isValidKey(Object? o) => o is SupportTicketsRecord;
}
