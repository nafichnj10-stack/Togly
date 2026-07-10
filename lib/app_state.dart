import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _hasSeenIntro = prefs.getBool('ff_hasSeenIntro') ?? _hasSeenIntro;
    });
    _safeInit(() {
      _appPartnerUID = prefs.getString('ff_appPartnerUID') ?? _appPartnerUID;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  /// Has the user already seen the tutorial?
  ///
  /// If no → show tutorial,
  /// if yes → go directly to the login/register page
  bool _hasSeenIntro = false;
  bool get hasSeenIntro => _hasSeenIntro;
  set hasSeenIntro(bool value) {
    _hasSeenIntro = value;
    prefs.setBool('ff_hasSeenIntro', value);
  }

  /// Stores which auth tab is selected
  String _authTab = '';
  String get authTab => _authTab;
  set authTab(String value) {
    _authTab = value;
  }

  DateTime? _currenttime;
  DateTime? get currenttime => _currenttime;
  set currenttime(DateTime? value) {
    _currenttime = value;
  }

  DateTime? _selectedBirthday;
  DateTime? get selectedBirthday => _selectedBirthday;
  set selectedBirthday(DateTime? value) {
    _selectedBirthday = value;
  }

  String _referralSource = '';
  String get referralSource => _referralSource;
  set referralSource(String value) {
    _referralSource = value;
  }

  String _uid = '';
  String get uid => _uid;
  set uid(String value) {
    _uid = value;
  }

  double _userAge = 0.0;
  double get userAge => _userAge;
  set userAge(double value) {
    _userAge = value;
  }

  bool _isChildAge = false;
  bool get isChildAge => _isChildAge;
  set isChildAge(bool value) {
    _isChildAge = value;
  }

  bool _isTeenAge = false;
  bool get isTeenAge => _isTeenAge;
  set isTeenAge(bool value) {
    _isTeenAge = value;
  }

  bool _isAdultAge = false;
  bool get isAdultAge => _isAdultAge;
  set isAdultAge(bool value) {
    _isAdultAge = value;
  }

  bool _isSeniorAge = false;
  bool get isSeniorAge => _isSeniorAge;
  set isSeniorAge(bool value) {
    _isSeniorAge = value;
  }

  String _dummyImage = '';
  String get dummyImage => _dummyImage;
  set dummyImage(String value) {
    _dummyImage = value;
  }

  String _dummyGender = '';
  String get dummyGender => _dummyGender;
  set dummyGender(String value) {
    _dummyGender = value;
  }

  String _dummyName = '';
  String get dummyName => _dummyName;
  set dummyName(String value) {
    _dummyName = value;
  }

  String _dummyCity = '';
  String get dummyCity => _dummyCity;
  set dummyCity(String value) {
    _dummyCity = value;
  }

  String _appPartnerUID = '';
  String get appPartnerUID => _appPartnerUID;
  set appPartnerUID(String value) {
    _appPartnerUID = value;
    prefs.setString('ff_appPartnerUID', value);
  }

  DateTime? _todayDate;
  DateTime? get todayDate => _todayDate;
  set todayDate(DateTime? value) {
    _todayDate = value;
  }

  DocumentReference? _activeRelationshipDoc;
  DocumentReference? get activeRelationshipDoc => _activeRelationshipDoc;
  set activeRelationshipDoc(DocumentReference? value) {
    _activeRelationshipDoc = value;
  }

  String _loveCodeGen = '';
  String get loveCodeGen => _loveCodeGen;
  set loveCodeGen(String value) {
    _loveCodeGen = value;
  }

  DocumentReference? _newRequestDoc;
  DocumentReference? get newRequestDoc => _newRequestDoc;
  set newRequestDoc(DocumentReference? value) {
    _newRequestDoc = value;
  }

  DocumentReference? _targetUserRef;
  DocumentReference? get targetUserRef => _targetUserRef;
  set targetUserRef(DocumentReference? value) {
    _targetUserRef = value;
  }

  String _relationshipid = '';
  String get relationshipid => _relationshipid;
  set relationshipid(String value) {
    _relationshipid = value;
  }

  DocumentReference? _initiatorUserRef;
  DocumentReference? get initiatorUserRef => _initiatorUserRef;
  set initiatorUserRef(DocumentReference? value) {
    _initiatorUserRef = value;
  }

  String _activePartnerUID = '';
  String get activePartnerUID => _activePartnerUID;
  set activePartnerUID(String value) {
    _activePartnerUID = value;
  }

  String _partnerPhoto = '';
  String get partnerPhoto => _partnerPhoto;
  set partnerPhoto(String value) {
    _partnerPhoto = value;
  }

  String _relationshipId = '';
  String get relationshipId => _relationshipId;
  set relationshipId(String value) {
    _relationshipId = value;
  }

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;
  set selectedDate(DateTime? value) {
    _selectedDate = value;
  }

  String _disconnectStatus = '';
  String get disconnectStatus => _disconnectStatus;
  set disconnectStatus(String value) {
    _disconnectStatus = value;
  }

  String _purgeAtIso = '';
  String get purgeAtIso => _purgeAtIso;
  set purgeAtIso(String value) {
    _purgeAtIso = value;
  }

  String _disconnectedAtIso = '';
  String get disconnectedAtIso => _disconnectedAtIso;
  set disconnectedAtIso(String value) {
    _disconnectedAtIso = value;
  }

  int _serverNowUtcMillis = 0;
  int get serverNowUtcMillis => _serverNowUtcMillis;
  set serverNowUtcMillis(int value) {
    _serverNowUtcMillis = value;
  }

  String _draftName = '';
  String get draftName => _draftName;
  set draftName(String value) {
    _draftName = value;
  }

  String _draftPartnerLoveCode = '';
  String get draftPartnerLoveCode => _draftPartnerLoveCode;
  set draftPartnerLoveCode(String value) {
    _draftPartnerLoveCode = value;
  }

  bool _draftHasPartnerCode = false;
  bool get draftHasPartnerCode => _draftHasPartnerCode;
  set draftHasPartnerCode(bool value) {
    _draftHasPartnerCode = value;
  }

  String _heartbeatSessionId = '';
  String get heartbeatSessionId => _heartbeatSessionId;
  set heartbeatSessionId(String value) {
    _heartbeatSessionId = value;
  }

  List<HeartbeatQuestionCFItemStruct> _heartbeatQuestions = [];
  List<HeartbeatQuestionCFItemStruct> get heartbeatQuestions =>
      _heartbeatQuestions;
  set heartbeatQuestions(List<HeartbeatQuestionCFItemStruct> value) {
    _heartbeatQuestions = value;
  }

  void addToHeartbeatQuestions(HeartbeatQuestionCFItemStruct value) {
    heartbeatQuestions.add(value);
  }

  void removeFromHeartbeatQuestions(HeartbeatQuestionCFItemStruct value) {
    heartbeatQuestions.remove(value);
  }

  void removeAtIndexFromHeartbeatQuestions(int index) {
    heartbeatQuestions.removeAt(index);
  }

  void updateHeartbeatQuestionsAtIndex(
    int index,
    HeartbeatQuestionCFItemStruct Function(HeartbeatQuestionCFItemStruct)
        updateFn,
  ) {
    heartbeatQuestions[index] = updateFn(_heartbeatQuestions[index]);
  }

  void insertAtIndexInHeartbeatQuestions(
      int index, HeartbeatQuestionCFItemStruct value) {
    heartbeatQuestions.insert(index, value);
  }

  int _heartbeatCurrentIndex = 0;
  int get heartbeatCurrentIndex => _heartbeatCurrentIndex;
  set heartbeatCurrentIndex(int value) {
    _heartbeatCurrentIndex = value;
  }

  int _heartbeatAnswer1 = 0;
  int get heartbeatAnswer1 => _heartbeatAnswer1;
  set heartbeatAnswer1(int value) {
    _heartbeatAnswer1 = value;
  }

  int _heartbeatAnswer2 = 0;
  int get heartbeatAnswer2 => _heartbeatAnswer2;
  set heartbeatAnswer2(int value) {
    _heartbeatAnswer2 = value;
  }

  int _heartbeatAnswer3 = 0;
  int get heartbeatAnswer3 => _heartbeatAnswer3;
  set heartbeatAnswer3(int value) {
    _heartbeatAnswer3 = value;
  }

  String _heartbeatQuestion1En = '';
  String get heartbeatQuestion1En => _heartbeatQuestion1En;
  set heartbeatQuestion1En(String value) {
    _heartbeatQuestion1En = value;
  }

  String _heartbeatQuestion2En = '';
  String get heartbeatQuestion2En => _heartbeatQuestion2En;
  set heartbeatQuestion2En(String value) {
    _heartbeatQuestion2En = value;
  }

  String _heartbeatQuestion3En = '';
  String get heartbeatQuestion3En => _heartbeatQuestion3En;
  set heartbeatQuestion3En(String value) {
    _heartbeatQuestion3En = value;
  }

  String _heartbeatQuestion1De = '';
  String get heartbeatQuestion1De => _heartbeatQuestion1De;
  set heartbeatQuestion1De(String value) {
    _heartbeatQuestion1De = value;
  }

  String _heartbeatQuestion2De = '';
  String get heartbeatQuestion2De => _heartbeatQuestion2De;
  set heartbeatQuestion2De(String value) {
    _heartbeatQuestion2De = value;
  }

  String _heartbeatQuestion3De = '';
  String get heartbeatQuestion3De => _heartbeatQuestion3De;
  set heartbeatQuestion3De(String value) {
    _heartbeatQuestion3De = value;
  }

  String _heartbeatQuestion1Es = '';
  String get heartbeatQuestion1Es => _heartbeatQuestion1Es;
  set heartbeatQuestion1Es(String value) {
    _heartbeatQuestion1Es = value;
  }

  String _heartbeatQuestion2Es = '';
  String get heartbeatQuestion2Es => _heartbeatQuestion2Es;
  set heartbeatQuestion2Es(String value) {
    _heartbeatQuestion2Es = value;
  }

  String _heartbeatQuestion3Es = '';
  String get heartbeatQuestion3Es => _heartbeatQuestion3Es;
  set heartbeatQuestion3Es(String value) {
    _heartbeatQuestion3Es = value;
  }

  DocumentReference? _heartbeatSessionRef;
  DocumentReference? get heartbeatSessionRef => _heartbeatSessionRef;
  set heartbeatSessionRef(DocumentReference? value) {
    _heartbeatSessionRef = value;
  }

  int _heartbeatScorePercent = 0;
  int get heartbeatScorePercent => _heartbeatScorePercent;
  set heartbeatScorePercent(int value) {
    _heartbeatScorePercent = value;
  }

  String _heartbeatConnectionLabelKey = '';
  String get heartbeatConnectionLabelKey => _heartbeatConnectionLabelKey;
  set heartbeatConnectionLabelKey(String value) {
    _heartbeatConnectionLabelKey = value;
  }

  String _heartbeatInsightEn = '';
  String get heartbeatInsightEn => _heartbeatInsightEn;
  set heartbeatInsightEn(String value) {
    _heartbeatInsightEn = value;
  }

  String _heartbeatInsightDe = '';
  String get heartbeatInsightDe => _heartbeatInsightDe;
  set heartbeatInsightDe(String value) {
    _heartbeatInsightDe = value;
  }

  String _heartbeatInsightEs = '';
  String get heartbeatInsightEs => _heartbeatInsightEs;
  set heartbeatInsightEs(String value) {
    _heartbeatInsightEs = value;
  }

  double _heartbeatPartnerAnswer1 = 0.0;
  double get heartbeatPartnerAnswer1 => _heartbeatPartnerAnswer1;
  set heartbeatPartnerAnswer1(double value) {
    _heartbeatPartnerAnswer1 = value;
  }

  double _heartbeatPartnerAnswer2 = 0.0;
  double get heartbeatPartnerAnswer2 => _heartbeatPartnerAnswer2;
  set heartbeatPartnerAnswer2(double value) {
    _heartbeatPartnerAnswer2 = value;
  }

  double _heartbeatPartnerAnswer3 = 0.0;
  double get heartbeatPartnerAnswer3 => _heartbeatPartnerAnswer3;
  set heartbeatPartnerAnswer3(double value) {
    _heartbeatPartnerAnswer3 = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
