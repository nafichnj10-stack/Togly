import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DailyQuestionsRecord extends FirestoreRecord {
  DailyQuestionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "question_text" field.
  String? _questionText;
  String get questionText => _questionText ?? '';
  bool hasQuestionText() => _questionText != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "is_published" field.
  bool? _isPublished;
  bool get isPublished => _isPublished ?? false;
  bool hasIsPublished() => _isPublished != null;

  // "notify_done" field.
  bool? _notifyDone;
  bool get notifyDone => _notifyDone ?? false;
  bool hasNotifyDone() => _notifyDone != null;

  // "question_text_en" field.
  String? _questionTextEn;
  String get questionTextEn => _questionTextEn ?? '';
  bool hasQuestionTextEn() => _questionTextEn != null;

  // "question_text_de" field.
  String? _questionTextDe;
  String get questionTextDe => _questionTextDe ?? '';
  bool hasQuestionTextDe() => _questionTextDe != null;

  // "question_text_es" field.
  String? _questionTextEs;
  String get questionTextEs => _questionTextEs ?? '';
  bool hasQuestionTextEs() => _questionTextEs != null;

  void _initializeFields() {
    _questionText = snapshotData['question_text'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _isPublished = snapshotData['is_published'] as bool?;
    _notifyDone = snapshotData['notify_done'] as bool?;
    _questionTextEn = snapshotData['question_text_en'] as String?;
    _questionTextDe = snapshotData['question_text_de'] as String?;
    _questionTextEs = snapshotData['question_text_es'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('daily_questions');

  static Stream<DailyQuestionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DailyQuestionsRecord.fromSnapshot(s));

  static Future<DailyQuestionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DailyQuestionsRecord.fromSnapshot(s));

  static DailyQuestionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DailyQuestionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DailyQuestionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DailyQuestionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DailyQuestionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DailyQuestionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDailyQuestionsRecordData({
  String? questionText,
  DateTime? date,
  bool? isPublished,
  bool? notifyDone,
  String? questionTextEn,
  String? questionTextDe,
  String? questionTextEs,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'question_text': questionText,
      'date': date,
      'is_published': isPublished,
      'notify_done': notifyDone,
      'question_text_en': questionTextEn,
      'question_text_de': questionTextDe,
      'question_text_es': questionTextEs,
    }.withoutNulls,
  );

  return firestoreData;
}

class DailyQuestionsRecordDocumentEquality
    implements Equality<DailyQuestionsRecord> {
  const DailyQuestionsRecordDocumentEquality();

  @override
  bool equals(DailyQuestionsRecord? e1, DailyQuestionsRecord? e2) {
    return e1?.questionText == e2?.questionText &&
        e1?.date == e2?.date &&
        e1?.isPublished == e2?.isPublished &&
        e1?.notifyDone == e2?.notifyDone &&
        e1?.questionTextEn == e2?.questionTextEn &&
        e1?.questionTextDe == e2?.questionTextDe &&
        e1?.questionTextEs == e2?.questionTextEs;
  }

  @override
  int hash(DailyQuestionsRecord? e) => const ListEquality().hash([
        e?.questionText,
        e?.date,
        e?.isPublished,
        e?.notifyDone,
        e?.questionTextEn,
        e?.questionTextDe,
        e?.questionTextEs
      ]);

  @override
  bool isValidKey(Object? o) => o is DailyQuestionsRecord;
}
