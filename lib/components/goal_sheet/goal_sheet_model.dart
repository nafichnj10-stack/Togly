import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import "package:firebase_storagelibrary_2sa6k9/backend/schema/structs/index.dart"
    as firebase_storagelibrary_2sa6k9_data_schema;
import 'goal_sheet_widget.dart' show GoalSheetWidget;
import 'package:flutter/material.dart';

class GoalSheetModel extends FlutterFlowModel<GoalSheetWidget> {
  ///  Local state fields for this component.

  String? uploadedPath;

  String? phase = 'planning';

  String? fileName;

  FFUploadedFile? coverFile;

  DateTime? selectedDate;

  String? categoryLabel;

  String? categoryKey;

  String? phaseKey;

  ///  State fields for stateful widgets in this component.

  final formKey2 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // State field(s) for TextFieldtitle widget.
  FocusNode? textFieldtitleFocusNode;
  TextEditingController? textFieldtitleTextController;
  String? Function(BuildContext, String?)?
      textFieldtitleTextControllerValidator;
  String? _textFieldtitleTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'mpcazsrn' /* Enter your dream goal... is re... */,
      );
    }

    return null;
  }

  // State field(s) for category widget.
  String? categoryValue;
  FormFieldController<String>? categoryValueController;
  // State field(s) for emoji widget.
  String? emojiValue;
  FormFieldController<String>? emojiValueController;
  bool isDataUploading_buckIMG2 = false;
  FFUploadedFile uploadedLocalFile_buckIMG2 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // State field(s) for TextFieldnote widget.
  FocusNode? textFieldnoteFocusNode;
  TextEditingController? textFieldnoteTextController;
  String? Function(BuildContext, String?)? textFieldnoteTextControllerValidator;
  String? _textFieldnoteTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'u1hliufh' /* Add details about your goal...... */,
      );
    }

    return null;
  }

  // State field(s) for phasedrop widget.
  String? phasedropValue;
  FormFieldController<String>? phasedropValueController;
  // State field(s) for finalProgress widget.
  double? finalProgressValue;
  // State field(s) for current widget.
  FocusNode? currentFocusNode;
  TextEditingController? currentTextController;
  String? Function(BuildContext, String?)? currentTextControllerValidator;
  // State field(s) for target widget.
  FocusNode? targetFocusNode;
  TextEditingController? targetTextController;
  String? Function(BuildContext, String?)? targetTextControllerValidator;
  // State field(s) for currency widget.
  String? currencyValue;
  FormFieldController<String>? currencyValueController;
  DateTime? datePicked;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  BucketListRecord? newBucketRef;
  // Stores action output result for [Custom Action - uploadFileToBucket] action in Button widget.
  firebase_storagelibrary_2sa6k9_data_schema.FileObjectStruct? uploadedObj;
  // Stores action output result for [Custom Action - getDownloadUrl] action in Button widget.
  String? coverURL;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Button widget.
  SendPartnerPushCloudFunctionCallResponse? cloudFunctionzwp;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Button widget.
  SendPartnerPushCloudFunctionCallResponse? cloudFunctionzwp2;

  @override
  void initState(BuildContext context) {
    textFieldtitleTextControllerValidator =
        _textFieldtitleTextControllerValidator;
    textFieldnoteTextControllerValidator =
        _textFieldnoteTextControllerValidator;
  }

  @override
  void dispose() {
    textFieldtitleFocusNode?.dispose();
    textFieldtitleTextController?.dispose();

    textFieldnoteFocusNode?.dispose();
    textFieldnoteTextController?.dispose();

    currentFocusNode?.dispose();
    currentTextController?.dispose();

    targetFocusNode?.dispose();
    targetTextController?.dispose();
  }
}
