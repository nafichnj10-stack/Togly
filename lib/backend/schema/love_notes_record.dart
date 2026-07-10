import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LoveNotesRecord extends FirestoreRecord {
  LoveNotesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "relationship_id" field.
  String? _relationshipId;
  String get relationshipId => _relationshipId ?? '';
  bool hasRelationshipId() => _relationshipId != null;

  // "from_user_id" field.
  String? _fromUserId;
  String get fromUserId => _fromUserId ?? '';
  bool hasFromUserId() => _fromUserId != null;

  // "to_user_id" field.
  String? _toUserId;
  String get toUserId => _toUserId ?? '';
  bool hasToUserId() => _toUserId != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  // "day_key" field.
  String? _dayKey;
  String get dayKey => _dayKey ?? '';
  bool hasDayKey() => _dayKey != null;

  // "sender_tz" field.
  String? _senderTz;
  String get senderTz => _senderTz ?? '';
  bool hasSenderTz() => _senderTz != null;

  // "read_at" field.
  DateTime? _readAt;
  DateTime? get readAt => _readAt;
  bool hasReadAt() => _readAt != null;

  // "reaction_emoji" field.
  String? _reactionEmoji;
  String get reactionEmoji => _reactionEmoji ?? '';
  bool hasReactionEmoji() => _reactionEmoji != null;

  // "reaction_at" field.
  DateTime? _reactionAt;
  DateTime? get reactionAt => _reactionAt;
  bool hasReactionAt() => _reactionAt != null;

  // "pinned" field.
  bool? _pinned;
  bool get pinned => _pinned ?? false;
  bool hasPinned() => _pinned != null;

  void _initializeFields() {
    _relationshipId = snapshotData['relationship_id'] as String?;
    _fromUserId = snapshotData['from_user_id'] as String?;
    _toUserId = snapshotData['to_user_id'] as String?;
    _text = snapshotData['text'] as String?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _dayKey = snapshotData['day_key'] as String?;
    _senderTz = snapshotData['sender_tz'] as String?;
    _readAt = snapshotData['read_at'] as DateTime?;
    _reactionEmoji = snapshotData['reaction_emoji'] as String?;
    _reactionAt = snapshotData['reaction_at'] as DateTime?;
    _pinned = snapshotData['pinned'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('love_notes');

  static Stream<LoveNotesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => LoveNotesRecord.fromSnapshot(s));

  static Future<LoveNotesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => LoveNotesRecord.fromSnapshot(s));

  static LoveNotesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      LoveNotesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static LoveNotesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      LoveNotesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'LoveNotesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is LoveNotesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createLoveNotesRecordData({
  String? relationshipId,
  String? fromUserId,
  String? toUserId,
  String? text,
  DateTime? timestamp,
  String? dayKey,
  String? senderTz,
  DateTime? readAt,
  String? reactionEmoji,
  DateTime? reactionAt,
  bool? pinned,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'relationship_id': relationshipId,
      'from_user_id': fromUserId,
      'to_user_id': toUserId,
      'text': text,
      'timestamp': timestamp,
      'day_key': dayKey,
      'sender_tz': senderTz,
      'read_at': readAt,
      'reaction_emoji': reactionEmoji,
      'reaction_at': reactionAt,
      'pinned': pinned,
    }.withoutNulls,
  );

  return firestoreData;
}

class LoveNotesRecordDocumentEquality implements Equality<LoveNotesRecord> {
  const LoveNotesRecordDocumentEquality();

  @override
  bool equals(LoveNotesRecord? e1, LoveNotesRecord? e2) {
    return e1?.relationshipId == e2?.relationshipId &&
        e1?.fromUserId == e2?.fromUserId &&
        e1?.toUserId == e2?.toUserId &&
        e1?.text == e2?.text &&
        e1?.timestamp == e2?.timestamp &&
        e1?.dayKey == e2?.dayKey &&
        e1?.senderTz == e2?.senderTz &&
        e1?.readAt == e2?.readAt &&
        e1?.reactionEmoji == e2?.reactionEmoji &&
        e1?.reactionAt == e2?.reactionAt &&
        e1?.pinned == e2?.pinned;
  }

  @override
  int hash(LoveNotesRecord? e) => const ListEquality().hash([
        e?.relationshipId,
        e?.fromUserId,
        e?.toUserId,
        e?.text,
        e?.timestamp,
        e?.dayKey,
        e?.senderTz,
        e?.readAt,
        e?.reactionEmoji,
        e?.reactionAt,
        e?.pinned
      ]);

  @override
  bool isValidKey(Object? o) => o is LoveNotesRecord;
}
