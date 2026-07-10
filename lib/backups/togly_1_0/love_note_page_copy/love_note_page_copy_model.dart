import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'love_note_page_copy_widget.dart' show LoveNotePageCopyWidget;
import 'package:flutter/material.dart';

class LoveNotePageCopyModel extends FlutterFlowModel<LoveNotePageCopyWidget> {
  ///  Local state fields for this page.

  String? todayKey;

  String? docIdToday;

  String? noteText;

  bool sentToday = false;

  DocumentReference? todayDocRef;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in LoveNotePageCopy widget.
  List<LoveNotesRecord>? todayNotes;
  // State field(s) for loveNoteInput widget.
  FocusNode? loveNoteInputFocusNode;
  TextEditingController? loveNoteInputTextController;
  String? Function(BuildContext, String?)? loveNoteInputTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<LoveNotesRecord>? todayQuery;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Button widget.
  SendPartnerPushCloudFunctionCallResponse? fas;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    loveNoteInputFocusNode?.dispose();
    loveNoteInputTextController?.dispose();
  }
}
