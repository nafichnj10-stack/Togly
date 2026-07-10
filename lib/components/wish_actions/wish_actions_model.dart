import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'wish_actions_widget.dart' show WishActionsWidget;
import 'package:flutter/material.dart';

class WishActionsModel extends FlutterFlowModel<WishActionsWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UsersRecord? partnerUserRecord;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Button widget.
  SendPartnerPushCloudFunctionCallResponse? cloudFunction6oy;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
