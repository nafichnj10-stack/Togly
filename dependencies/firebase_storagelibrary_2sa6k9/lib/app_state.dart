import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _selectedPrefix = '';
  String get selectedPrefix => _selectedPrefix;
  set selectedPrefix(String value) {
    _selectedPrefix = value;
  }

  FileObjectStruct _selectedItem = FileObjectStruct();
  FileObjectStruct get selectedItem => _selectedItem;
  set selectedItem(FileObjectStruct value) {
    _selectedItem = value;
  }

  void updateSelectedItemStruct(Function(FileObjectStruct) updateFn) {
    updateFn(_selectedItem);
  }

  int _currentFileIndex = 0;
  int get currentFileIndex => _currentFileIndex;
  set currentFileIndex(int value) {
    _currentFileIndex = value;
  }
}
