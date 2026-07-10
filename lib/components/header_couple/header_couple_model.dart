import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'header_couple_widget.dart' show HeaderCoupleWidget;
import 'package:flutter/material.dart';

class HeaderCoupleModel extends FlutterFlowModel<HeaderCoupleWidget> {
  ///  Local state fields for this component.

  String? emotionStatusText;

  String? emotionSummary;

  String? emotionMyChoice;

  String? emotionPartnerChoice;

  int? emotionCooldownUntil;

  String? emotionSelectedChoice;

  String? silentStatus;

  String? silentCheckinStatus;

  String? silentStatusText;

  String? silentSnackText;

  int? silentWaitMinutes;

  int? silentCooldownUntilMs;

  String? emotionState;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Cloud Function - sendSilentCheckIn] action in Icon widget.
  SendSilentCheckInCloudFunctionCallResponse? cfResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
