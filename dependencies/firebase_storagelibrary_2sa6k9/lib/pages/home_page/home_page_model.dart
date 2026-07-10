import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'home_page_widget.dart' show HomePageWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for lstBucket widget.
  String? lstBucketValue;
  FormFieldController<String>? lstBucketValueController;
  // Stores action output result for [Custom Action - listAllFilesInBucket] action in btnListFiles widget.
  List<FileObjectStruct>? listFiles;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Custom Action - listAllFilesInBucket] action in btnDeleteAll widget.
  List<FileObjectStruct>? filesToDelete;
  // Stores action output result for [Custom Action - downloadFile] action in btnDownload widget.
  FFUploadedFile? downloadedFile;
  // Stores action output result for [Custom Action - getDownloadUrl] action in btnGetDownloadUrl widget.
  String? downloadURL;
  // Stores action output result for [Custom Action - getMetadataForFile] action in Button widget.
  FullMetadataStruct? fullMetadata;
  // Stores action output result for [Custom Action - updateMetadataForFile] action in Button widget.
  FullMetadataStruct? updatedMetadata;
  // State field(s) for txtContentType widget.
  FocusNode? txtContentTypeFocusNode;
  TextEditingController? txtContentTypeTextController;
  String? Function(BuildContext, String?)?
      txtContentTypeTextControllerValidator;
  // State field(s) for txtCustomKey widget.
  FocusNode? txtCustomKeyFocusNode;
  TextEditingController? txtCustomKeyTextController;
  String? Function(BuildContext, String?)? txtCustomKeyTextControllerValidator;
  // State field(s) for txtCustomValue widget.
  FocusNode? txtCustomValueFocusNode;
  TextEditingController? txtCustomValueTextController;
  String? Function(BuildContext, String?)?
      txtCustomValueTextControllerValidator;
  bool isDataUploading_uploadDataW6y = false;
  FFUploadedFile uploadedLocalFile_uploadDataW6y =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // State field(s) for txtUrl widget.
  FocusNode? txtUrlFocusNode;
  TextEditingController? txtUrlTextController;
  String? Function(BuildContext, String?)? txtUrlTextControllerValidator;
  // Stores action output result for [Custom Action - getPathFromUrl] action in btnGetPathForUrl widget.
  FileObjectStruct? refFromUrl;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    txtContentTypeFocusNode?.dispose();
    txtContentTypeTextController?.dispose();

    txtCustomKeyFocusNode?.dispose();
    txtCustomKeyTextController?.dispose();

    txtCustomValueFocusNode?.dispose();
    txtCustomValueTextController?.dispose();

    txtUrlFocusNode?.dispose();
    txtUrlTextController?.dispose();
  }
}
