import '/flutter_flow/flutter_flow_util.dart';
import "package:firebase_storagelibrary_2sa6k9/backend/schema/structs/index.dart"
    as firebase_storagelibrary_2sa6k9_data_schema;
import 'photo_sheet_widget.dart' show PhotoSheetWidget;
import 'package:flutter/material.dart';

class PhotoSheetModel extends FlutterFlowModel<PhotoSheetWidget> {
  ///  Local state fields for this component.

  FFUploadedFile? selectedTreasurePhoto;

  String? generatedTreasurePhotoFileName;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  bool isDataUploading_photoCamera = false;
  FFUploadedFile uploadedLocalFile_photoCamera =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  bool isDataUploading_photoGalerie = false;
  FFUploadedFile uploadedLocalFile_photoGalerie =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  String? _textControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'a26rxixq' /* Title of the image is required */,
      );
    }

    return null;
  }

  // Stores action output result for [Custom Action - uploadFileToBucket] action in Container widget.
  firebase_storagelibrary_2sa6k9_data_schema.FileObjectStruct?
      treasurePhotoDownloadUrl1;
  // Stores action output result for [Custom Action - getStorageDownloadUrlV2] action in Container widget.
  String? treasurePhotoDownloadUrl;

  @override
  void initState(BuildContext context) {
    textControllerValidator = _textControllerValidator;
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
