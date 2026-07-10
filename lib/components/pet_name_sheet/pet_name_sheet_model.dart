import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'pet_name_sheet_widget.dart' show PetNameSheetWidget;
import 'package:flutter/material.dart';

class PetNameSheetModel extends FlutterFlowModel<PetNameSheetWidget> {
  ///  Local state fields for this component.

  String? newPetName;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextFieldName widget.
  FocusNode? textFieldNameFocusNode;
  TextEditingController? textFieldNameTextController;
  String? Function(BuildContext, String?)? textFieldNameTextControllerValidator;
  // Stores action output result for [Cloud Function - updateLoveBuddyName] action in Button widget.
  UpdateLoveBuddyNameCloudFunctionCallResponse? cloudFunction287;
  // Stores action output result for [Cloud Function - syncLoveBuddyWidgetState] action in Button widget.
  SyncLoveBuddyWidgetStateCloudFunctionCallResponse? cloudFunctionqgo;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldNameFocusNode?.dispose();
    textFieldNameTextController?.dispose();
  }
}
