import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'brake_up_page_widget.dart' show BrakeUpPageWidget;
import 'package:flutter/material.dart';

class BrakeUpPageModel extends FlutterFlowModel<BrakeUpPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UsersRecord? partnerUserRecord;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Button widget.
  SendPartnerPushCloudFunctionCallResponse? brake;
  // Stores action output result for [Cloud Function - disconnectCouple] action in Button widget.
  DisconnectCoupleCloudFunctionCallResponse? cloudFunctionsq;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
