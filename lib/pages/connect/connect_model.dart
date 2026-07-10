import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/components/header_couple/header_couple_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'connect_widget.dart' show ConnectWidget;
import 'package:flutter/material.dart';

class ConnectModel extends FlutterFlowModel<ConnectWidget> {
  ///  Local state fields for this page.

  String dummyName = 'Dummy';

  String dummyImage = 'https://...';

  String dummyCity = 'Nowhere';

  DateTime? pageBirthday;

  bool moodBusy = false;

  String? partnerUserId;

  RelationshipsRecord? relationshipRef;

  String? silentStatus;

  String? silentCheckinStatus;

  String? silentStatusText;

  String? silentSnackText;

  int? silentWaitMinutes;

  int? silentCooldownUntilMs;

  String? emotionState;

  String? emotionStatusText;

  String? emotionSummary;

  String? emotionMyChoice;

  String? emotionPartnerChoice;

  int? emotionCooldownUntil;

  String? emotionSelectedChoice;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Cloud Function - resolveHomeState] action in connect widget.
  ResolveHomeStateCloudFunctionCallResponse? cloudFunctiontyl;
  // Stores action output result for [Cloud Function - sendEmotionCheckIn] action in connect widget.
  SendEmotionCheckInCloudFunctionCallResponse? cloudFunctionuex;
  // Model for HeaderCouple component.
  late HeaderCoupleModel headerCoupleModel;
  // Stores action output result for [Cloud Function - getDailyQuestionState] action in Button widget.
  GetDailyQuestionStateCloudFunctionCallResponse? dqState;
  // Stores action output result for [Cloud Function - setMood] action in Container widget.
  SetMoodCloudFunctionCallResponse? cfSetMoodResult;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Container widget.
  SendPartnerPushCloudFunctionCallResponse? cloudFunction6oy6;
  // Stores action output result for [Cloud Function - setMood] action in Container widget.
  SetMoodCloudFunctionCallResponse? excited;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Container widget.
  SendPartnerPushCloudFunctionCallResponse? cloudFunction6oy53;
  // Stores action output result for [Cloud Function - setMood] action in Container widget.
  SetMoodCloudFunctionCallResponse? cool;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Container widget.
  SendPartnerPushCloudFunctionCallResponse? cloudFunction6oy45;
  // Stores action output result for [Cloud Function - setMood] action in Container widget.
  SetMoodCloudFunctionCallResponse? inlove;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Container widget.
  SendPartnerPushCloudFunctionCallResponse? cloudFunction6oy23;
  // Stores action output result for [Cloud Function - setMood] action in Container widget.
  SetMoodCloudFunctionCallResponse? strong;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Container widget.
  SendPartnerPushCloudFunctionCallResponse? cloudFunction6oy1;
  // Stores action output result for [Cloud Function - setMood] action in Container widget.
  SetMoodCloudFunctionCallResponse? shit;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Container widget.
  SendPartnerPushCloudFunctionCallResponse? cloudFunction6oy0;
  // Stores action output result for [Cloud Function - setMood] action in Container widget.
  SetMoodCloudFunctionCallResponse? sick;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Container widget.
  SendPartnerPushCloudFunctionCallResponse? cloudFunction6oy99;
  // Stores action output result for [Cloud Function - setMood] action in Container widget.
  SetMoodCloudFunctionCallResponse? sad;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Container widget.
  SendPartnerPushCloudFunctionCallResponse? cloudFunction6oy88;
  // Stores action output result for [Cloud Function - setMood] action in Container widget.
  SetMoodCloudFunctionCallResponse? angry;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Container widget.
  SendPartnerPushCloudFunctionCallResponse? cloudFunction6oy5;
  // Stores action output result for [Cloud Function - setMood] action in Container widget.
  SetMoodCloudFunctionCallResponse? tired;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Container widget.
  SendPartnerPushCloudFunctionCallResponse? cloudFunction6oy7;
  // Stores action output result for [Cloud Function - setSleepStatus] action in Button widget.
  SetSleepStatusCloudFunctionCallResponse? cloudFunctionSleep;

  @override
  void initState(BuildContext context) {
    headerCoupleModel = createModel(context, () => HeaderCoupleModel());
  }

  @override
  void dispose() {
    headerCoupleModel.dispose();
  }
}
