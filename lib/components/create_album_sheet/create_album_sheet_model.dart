import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import "package:firebase_storagelibrary_2sa6k9/backend/schema/structs/index.dart"
    as firebase_storagelibrary_2sa6k9_data_schema;
import 'create_album_sheet_widget.dart' show CreateAlbumSheetWidget;
import 'package:flutter/material.dart';

class CreateAlbumSheetModel extends FlutterFlowModel<CreateAlbumSheetWidget> {
  ///  Local state fields for this component.

  FFUploadedFile? coverFile;

  String? coverImagePath;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for AlbumTitleField widget.
  FocusNode? albumTitleFieldFocusNode;
  TextEditingController? albumTitleFieldTextController;
  String? Function(BuildContext, String?)?
      albumTitleFieldTextControllerValidator;
  String? _albumTitleFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'ru994cl5' /* An album title must be specifi... */,
      );
    }

    if (val.length < 2) {
      return FFLocalizations.of(context).getText(
        '5p4q7duh' /* at least 2 letters */,
      );
    }
    if (val.length > 40) {
      return FFLocalizations.of(context).getText(
        'kjwq95zd' /* maximum 40 letters */,
      );
    }

    return null;
  }

  bool isDataUploading_chooseCoverData = false;
  FFUploadedFile uploadedLocalFile_chooseCoverData =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [Validate Form] action in Button widget.
  bool? albumForm;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  AlbumsRecord? newAlbumRef;
  // Stores action output result for [Custom Action - uploadFileToBucket] action in Button widget.
  firebase_storagelibrary_2sa6k9_data_schema.FileObjectStruct? coverUpload;
  // Stores action output result for [Custom Action - getDownloadUrl] action in Button widget.
  String? coverURL;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UsersRecord? partnerUserRecord;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Button widget.
  SendPartnerPushCloudFunctionCallResponse? cloudFunction6oy;

  @override
  void initState(BuildContext context) {
    albumTitleFieldTextControllerValidator =
        _albumTitleFieldTextControllerValidator;
  }

  @override
  void dispose() {
    albumTitleFieldFocusNode?.dispose();
    albumTitleFieldTextController?.dispose();
  }
}
