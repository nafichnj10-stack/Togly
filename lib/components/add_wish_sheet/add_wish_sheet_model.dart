import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import "package:firebase_storagelibrary_2sa6k9/backend/schema/structs/index.dart"
    as firebase_storagelibrary_2sa6k9_data_schema;
import 'add_wish_sheet_widget.dart' show AddWishSheetWidget;
import 'package:flutter/material.dart';

class AddWishSheetModel extends FlutterFlowModel<AddWishSheetWidget> {
  ///  Local state fields for this component.

  FFUploadedFile? wishFile;

  String? wishImagePath;

  String? fileName;

  FFUploadedFile? pickedImageUrl;

  String? categoryLabel;

  String? categoryKey;

  ///  State fields for stateful widgets in this component.

  // State field(s) for tfTitletext widget.
  FocusNode? tfTitletextFocusNode;
  TextEditingController? tfTitletextTextController;
  String? Function(BuildContext, String?)? tfTitletextTextControllerValidator;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for tfNote widget.
  FocusNode? tfNoteFocusNode;
  TextEditingController? tfNoteTextController;
  String? Function(BuildContext, String?)? tfNoteTextControllerValidator;
  // State field(s) for tfLink widget.
  FocusNode? tfLinkFocusNode;
  TextEditingController? tfLinkTextController;
  String? Function(BuildContext, String?)? tfLinkTextControllerValidator;
  bool isDataUploading_wishFile = false;
  FFUploadedFile uploadedLocalFile_wishFile =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  WishesRecord? newWishRef;
  // Stores action output result for [Custom Action - uploadFileToBucket] action in Button widget.
  firebase_storagelibrary_2sa6k9_data_schema.FileObjectStruct? uploadedObj;
  // Stores action output result for [Custom Action - getDownloadUrl] action in Button widget.
  String? coverURL;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Button widget.
  SendPartnerPushCloudFunctionCallResponse? cloudFunction7k8a;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Button widget.
  SendPartnerPushCloudFunctionCallResponse? cloudFunction7k8;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tfTitletextFocusNode?.dispose();
    tfTitletextTextController?.dispose();

    tfNoteFocusNode?.dispose();
    tfNoteTextController?.dispose();

    tfLinkFocusNode?.dispose();
    tfLinkTextController?.dispose();
  }
}
