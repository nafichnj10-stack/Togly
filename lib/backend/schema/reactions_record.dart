import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReactionsRecord extends FirestoreRecord {
  ReactionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "emoji" field.
  String? _emoji;
  String get emoji => _emoji ?? '';
  bool hasEmoji() => _emoji != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _userId = snapshotData['user_id'] as String?;
    _emoji = snapshotData['emoji'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('reactions')
          : FirebaseFirestore.instance.collectionGroup('reactions');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('reactions').doc(id);

  static Stream<ReactionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReactionsRecord.fromSnapshot(s));

  static Future<ReactionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReactionsRecord.fromSnapshot(s));

  static ReactionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReactionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReactionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReactionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReactionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReactionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createReactionsRecordData({
  String? userId,
  String? emoji,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_id': userId,
      'emoji': emoji,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class ReactionsRecordDocumentEquality implements Equality<ReactionsRecord> {
  const ReactionsRecordDocumentEquality();

  @override
  bool equals(ReactionsRecord? e1, ReactionsRecord? e2) {
    return e1?.userId == e2?.userId &&
        e1?.emoji == e2?.emoji &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(ReactionsRecord? e) =>
      const ListEquality().hash([e?.userId, e?.emoji, e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is ReactionsRecord;
}
