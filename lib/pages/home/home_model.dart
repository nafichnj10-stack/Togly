import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/components/header_couple/header_couple_widget.dart';
import '/components/header_reconnect/header_reconnect_widget.dart';
import '/components/header_single/header_single_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

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

  bool isSingleMode = true;

  DocumentReference? currentRelationship;

  String? homeMode = 'loading';

  bool isReconnectMode = false;

  String? activeRelationshipId;

  String? restoreRelationshipId;

  String? restoreState;

  DocumentReference? currentRelationshipRef;

  bool isLoading = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Cloud Function - resolveHomeState] action in home widget.
  ResolveHomeStateCloudFunctionCallResponse? resolveHomeState;
  // Stores action output result for [Firestore Query - Query a collection] action in home widget.
  RelationshipsRecord? queried;
  // Stores action output result for [Cloud Function - sendEmotionCheckIn] action in home widget.
  SendEmotionCheckInCloudFunctionCallResponse? cloudFunctionuex;
  // Stores action output result for [Firestore Query - Query a collection] action in home widget.
  RelationshipViewsRecord? gpsdata;
  // Model for HeaderCouple component.
  late HeaderCoupleModel headerCoupleModel;
  // Model for HeaderReconnect component.
  late HeaderReconnectModel headerReconnectModel;
  // Model for HeaderSingle component.
  late HeaderSingleModel headerSingleModel;
  // Stores action output result for [Cloud Function - getActiveLoveTreasure] action in Button widget.
  GetActiveLoveTreasureCloudFunctionCallResponse? getActiveLoveTreasureResponse;

  @override
  void initState(BuildContext context) {
    headerCoupleModel = createModel(context, () => HeaderCoupleModel());
    headerReconnectModel = createModel(context, () => HeaderReconnectModel());
    headerSingleModel = createModel(context, () => HeaderSingleModel());
  }

  @override
  void dispose() {
    headerCoupleModel.dispose();
    headerReconnectModel.dispose();
    headerSingleModel.dispose();
  }
}
