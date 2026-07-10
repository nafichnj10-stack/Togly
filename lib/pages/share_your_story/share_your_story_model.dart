import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import "package:firebase_storagelibrary_2sa6k9/backend/schema/structs/index.dart"
    as firebase_storagelibrary_2sa6k9_data_schema;
import 'share_your_story_widget.dart' show ShareYourStoryWidget;
import 'package:flutter/material.dart';

class ShareYourStoryModel extends FlutterFlowModel<ShareYourStoryWidget> {
  ///  Local state fields for this page.

  bool isVideo = false;

  String? storagePath;

  String? mediaURL;

  bool isUploading = false;

  double? ratingValue = 0.0;

  bool? validating;

  String? fileExt;

  FFUploadedFile? photoBytes;

  FFUploadedFile? videoBytes;

  String? videoPreviewUrl;

  bool showVideo = false;

  bool storyVideoUploaded = false;

  String? storyVideoUrl;

  bool hasStoryVideo = false;

  String? storyVideoUrlString;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for TextFieldStory widget.
  FocusNode? textFieldStoryFocusNode;
  TextEditingController? textFieldStoryTextController;
  String? Function(BuildContext, String?)?
      textFieldStoryTextControllerValidator;
  String? _textFieldStoryTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '8jnqlv77' /* Tell us about your relationshi... */,
      );
    }

    if (val.length < 200) {
      return 'Requires at least 200 characters.';
    }

    return null;
  }

  // State field(s) for TextFieldCountry widget.
  FocusNode? textFieldCountryFocusNode;
  TextEditingController? textFieldCountryTextController;
  String? Function(BuildContext, String?)?
      textFieldCountryTextControllerValidator;
  String? _textFieldCountryTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'oz80qy36' /* countries and cities... is req... */,
      );
    }

    return null;
  }

  // State field(s) for TextFieldName widget.
  FocusNode? textFieldNameFocusNode;
  TextEditingController? textFieldNameTextController;
  String? Function(BuildContext, String?)? textFieldNameTextControllerValidator;
  String? _textFieldNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '0x1kslqk' /* Tell us your names... is requi... */,
      );
    }

    return null;
  }

  // State field(s) for TextFieldMail widget.
  FocusNode? textFieldMailFocusNode;
  TextEditingController? textFieldMailTextController;
  String? Function(BuildContext, String?)? textFieldMailTextControllerValidator;
  String? _textFieldMailTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'hxfce6sj' /* Your email address... is requi... */,
      );
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'ytbrdd3u' /* Check the input */,
      );
    }
    return null;
  }

  // State field(s) for TextFieldExp widget.
  FocusNode? textFieldExpFocusNode;
  TextEditingController? textFieldExpTextController;
  String? Function(BuildContext, String?)? textFieldExpTextControllerValidator;
  String? _textFieldExpTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '2fy7ivcb' /* Share how the app has impacted... */,
      );
    }

    return null;
  }

  // State field(s) for TextFieldSocial widget.
  FocusNode? textFieldSocialFocusNode;
  TextEditingController? textFieldSocialTextController;
  String? Function(BuildContext, String?)?
      textFieldSocialTextControllerValidator;
  bool isDataUploading_choosePhoto = false;
  FFUploadedFile uploadedLocalFile_choosePhoto =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  bool isDataUploading_uploadedVideo = false;
  FFUploadedFile uploadedLocalFile_uploadedVideo =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadedVideo = '';

  bool isDataUploading_updatedVideo = false;
  FFUploadedFile uploadedLocalFile_updatedVideo =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_updatedVideo = '';

  bool isDataUploading_chooseVideo = false;
  FFUploadedFile uploadedLocalFile_chooseVideo =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [Custom Action - getDownloadUrl] action in StoryImgVideo widget.
  String? videoPreview;
  // State field(s) for RatingBar widget.
  double? ratingBarValue;
  // State field(s) for TextFieldSuggestions widget.
  FocusNode? textFieldSuggestionsFocusNode;
  TextEditingController? textFieldSuggestionsTextController;
  String? Function(BuildContext, String?)?
      textFieldSuggestionsTextControllerValidator;
  // State field(s) for CheckboxPermission widget.
  bool? checkboxPermissionValue;
  // Stores action output result for [Validate Form] action in Button widget.
  bool? formValid;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  UserStoriesRecord? newStoryRef;
  // Stores action output result for [Custom Action - uploadFileToBucket] action in Button widget.
  firebase_storagelibrary_2sa6k9_data_schema.FileObjectStruct? photoUpload;
  // Stores action output result for [Custom Action - getDownloadUrl] action in Button widget.
  String? photoURL;
  // Stores action output result for [Cloud Function - sendStorySubmissionEmail] action in Button widget.
  SendStorySubmissionEmailCloudFunctionCallResponse? cloudFunction4g3;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
    textFieldStoryTextControllerValidator =
        _textFieldStoryTextControllerValidator;
    textFieldCountryTextControllerValidator =
        _textFieldCountryTextControllerValidator;
    textFieldNameTextControllerValidator =
        _textFieldNameTextControllerValidator;
    textFieldMailTextControllerValidator =
        _textFieldMailTextControllerValidator;
    textFieldExpTextControllerValidator = _textFieldExpTextControllerValidator;
  }

  @override
  void dispose() {
    columnController?.dispose();
    textFieldStoryFocusNode?.dispose();
    textFieldStoryTextController?.dispose();

    textFieldCountryFocusNode?.dispose();
    textFieldCountryTextController?.dispose();

    textFieldNameFocusNode?.dispose();
    textFieldNameTextController?.dispose();

    textFieldMailFocusNode?.dispose();
    textFieldMailTextController?.dispose();

    textFieldExpFocusNode?.dispose();
    textFieldExpTextController?.dispose();

    textFieldSocialFocusNode?.dispose();
    textFieldSocialTextController?.dispose();

    textFieldSuggestionsFocusNode?.dispose();
    textFieldSuggestionsTextController?.dispose();
  }
}
