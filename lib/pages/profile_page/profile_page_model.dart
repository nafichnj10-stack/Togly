import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'profile_page_widget.dart' show ProfilePageWidget;
import 'package:flutter/material.dart';

class ProfilePageModel extends FlutterFlowModel<ProfilePageWidget> {
  ///  Local state fields for this page.

  DateTime? togetherSinceOverride;

  bool hasTogetherOverride = false;

  bool locationChanged = false;

  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadData1 = false;
  FFUploadedFile uploadedLocalFile_uploadData1 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadData1 = '';

  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  UsersRecord? partnerUserRecord;
  // State field(s) for TextFieldProfileName widget.
  FocusNode? textFieldProfileNameFocusNode;
  TextEditingController? textFieldProfileNameTextController;
  String? Function(BuildContext, String?)?
      textFieldProfileNameTextControllerValidator;
  // State field(s) for TextFieldProfileCity widget.
  FocusNode? textFieldProfileCityFocusNode;
  TextEditingController? textFieldProfileCityTextController;
  String? Function(BuildContext, String?)?
      textFieldProfileCityTextControllerValidator;
  // State field(s) for TextFieldProfileCountry widget.
  FocusNode? textFieldProfileCountryFocusNode;
  TextEditingController? textFieldProfileCountryTextController;
  String? Function(BuildContext, String?)?
      textFieldProfileCountryTextControllerValidator;
  // State field(s) for PlacePicker widget.
  FFPlace placePickerValue = FFPlace();
  DateTime? datePicked;
  // Stores action output result for [Backend Call - API (GoogleGeocodeLocation)] action in ButtonLogout widget.
  ApiCallResponse? geocodeResult2;
  // Stores action output result for [Custom Action - parseGoogleGeocodeLocation] action in ButtonLogout widget.
  dynamic parsegoogle;
  // Stores action output result for [Cloud Function - updateProfileSettings] action in ButtonLogout widget.
  UpdateProfileSettingsCloudFunctionCallResponse? cloudFunctionwai;
  // Stores action output result for [Cloud Function - syncRelationshipViewProfile] action in ButtonLogout widget.
  SyncRelationshipViewProfileCloudFunctionCallResponse? sync;
  // Stores action output result for [Cloud Function - syncLoveBuddyDistance] action in ButtonLogout widget.
  SyncLoveBuddyDistanceCloudFunctionCallResponse? anxlove;
  // Stores action output result for [Cloud Function - updateProfileSettings] action in ButtonLogout widget.
  UpdateProfileSettingsCloudFunctionCallResponse? cloudFunctionwai1;
  // State field(s) for Switch widget.
  bool? switchValue1;
  // State field(s) for Switch widget.
  bool? switchValue2;
  // State field(s) for Switch widget.
  bool? switchValue3;
  // State field(s) for Switch widget.
  bool? switchValue4;
  // State field(s) for Switch widget.
  bool? switchValue5;
  // State field(s) for Switch widget.
  bool? switchValue6;
  // State field(s) for Switch widget.
  bool? switchValue7;
  // Stores action output result for [Firestore Query - Query a collection] action in Switch widget.
  RelationshipViewsRecord? views;
  // State field(s) for Switch widget.
  bool? switchValue8;
  // Stores action output result for [Cloud Function - cleanUpUserData] action in ButtonDeleteAcc widget.
  DeleteMyAccountCloudFunctionCallResponse? del;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldProfileNameFocusNode?.dispose();
    textFieldProfileNameTextController?.dispose();

    textFieldProfileCityFocusNode?.dispose();
    textFieldProfileCityTextController?.dispose();

    textFieldProfileCountryFocusNode?.dispose();
    textFieldProfileCountryTextController?.dispose();
  }
}
