import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'heartbeat_questions_widget.dart' show HeartbeatQuestionsWidget;
import 'package:flutter/material.dart';

class HeartbeatQuestionsModel
    extends FlutterFlowModel<HeartbeatQuestionsWidget> {
  ///  Local state fields for this page.

  int? selectedAnswerThisPage = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Cloud Function - submitHeartbeatAnswers] action in Container widget.
  SubmitHeartbeatAnswersCloudFunctionCallResponse? heartbeatSubmitResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
