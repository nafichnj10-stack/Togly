import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'love_treasure_page_two_widget.dart' show LoveTreasurePageTwoWidget;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class LoveTreasurePageTwoModel
    extends FlutterFlowModel<LoveTreasurePageTwoWidget> {
  ///  Local state fields for this page.

  DocumentReference? currentTreasureRef;

  bool isTreasureOpenedLocal = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - pathToTreasureRef] action in love_treasure_page_two widget.
  DocumentReference? pathToTreasureRef;
  // Stores action output result for [Cloud Function - getLoveTreasureById] action in love_treasure_page_two widget.
  GetLoveTreasureByIdCloudFunctionCallResponse? treasureData;
  // Stores action output result for [Cloud Function - unlockTreasureCoupons] action in Button widget.
  UnlockTreasureCouponsCloudFunctionCallResponse? cloudFunctionx7k;
  // Stores action output result for [Cloud Function - awardLoveTreasureOpened] action in Button widget.
  AwardLoveTreasureOpenedCloudFunctionCallResponse? awardlove;
  AudioPlayer? soundPlayer;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
