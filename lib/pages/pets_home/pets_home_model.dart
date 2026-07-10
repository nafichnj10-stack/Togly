import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/components/action_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'pets_home_widget.dart' show PetsHomeWidget;
import 'package:flutter/material.dart';

class PetsHomeModel extends FlutterFlowModel<PetsHomeWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ActionBtn.
  late ActionBtnModel actionBtnModel1;
  // Stores action output result for [Cloud Function - swapLoveBuddyPets] action in ActionBtn widget.
  SwapLoveBuddyPetsCloudFunctionCallResponse? swap;
  // Stores action output result for [Cloud Function - syncLoveBuddyWidgetState] action in ActionBtn widget.
  SyncLoveBuddyWidgetStateCloudFunctionCallResponse? func;
  // Model for ActionBtn.
  late ActionBtnModel actionBtnModel2;

  @override
  void initState(BuildContext context) {
    actionBtnModel1 = createModel(context, () => ActionBtnModel());
    actionBtnModel2 = createModel(context, () => ActionBtnModel());
  }

  @override
  void dispose() {
    actionBtnModel1.dispose();
    actionBtnModel2.dispose();
  }
}
