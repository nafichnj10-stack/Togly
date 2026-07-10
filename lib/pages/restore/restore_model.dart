import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'restore_widget.dart' show RestoreWidget;
import 'package:flutter/material.dart';

class RestoreModel extends FlutterFlowModel<RestoreWidget> {
  ///  State fields for stateful widgets in this page.

  UsersRecord? restorePreviousSnapshot;
  // Stores action output result for [Cloud Function - createReconnectRequest] action in Button widget.
  CreateReconnectRequestCloudFunctionCallResponse? cloudFunction30i;
  // Stores action output result for [Cloud Function - cancelReconnectRequest] action in Button widget.
  CancelReconnectRequestCloudFunctionCallResponse? cloudFunctionwhu;
  // Stores action output result for [Cloud Function - rejectReconnectRequest] action in Button widget.
  RejectReconnectRequestCloudFunctionCallResponse? cloudFunctionauc;
  // Stores action output result for [Cloud Function - acceptReconnectRequest] action in Button widget.
  AcceptReconnectRequestCloudFunctionCallResponse? cloudFunction4ir;
  // Stores action output result for [Cloud Function - purgeRelationshipNow] action in Button widget.
  PurgeRelationshipNowCloudFunctionCallResponse? delete;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
