import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'daily_question_pagee_widget.dart' show DailyQuestionPageeWidget;
import 'package:flutter/material.dart';

class DailyQuestionPageeModel
    extends FlutterFlowModel<DailyQuestionPageeWidget> {
  ///  Local state fields for this page.

  String? answerInput = '';

  String? answerDocId;

  DocumentReference? answerDocRef;

  String? todayKey;

  DocumentReference? finalDocRef;

  bool showOriginalEN = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in DailyQuestionPagee widget.
  List<RelationshipsRecord>? relationshipDocA;
  // Stores action output result for [Firestore Query - Query a collection] action in DailyQuestionPagee widget.
  List<RelationshipsRecord>? relationshipDocB;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Cloud Function - submitDailyAnswer] action in Button widget.
  SubmitDailyAnswerCloudFunctionCallResponse? answersoutput;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Button widget.
  SendPartnerPushCloudFunctionCallResponse? fa;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
