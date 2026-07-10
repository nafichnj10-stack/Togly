import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'album_detail_page_widget.dart' show AlbumDetailPageWidget;
import 'package:flutter/material.dart';

class AlbumDetailPageModel extends FlutterFlowModel<AlbumDetailPageWidget> {
  ///  Local state fields for this page.

  String? fileName;

  bool isUploading = false;

  ///  State fields for stateful widgets in this page.

  bool isDataUploading_pickAlbumPhoto = false;
  FFUploadedFile uploadedLocalFile_pickAlbumPhoto =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [Custom Action - getDownloadUrl] action in IconButton widget.
  String? downloadimg;
  // Stores action output result for [Cloud Function - awardAlbumWeeklyPair] action in IconButton widget.
  AwardAlbumWeeklyPairCloudFunctionCallResponse? albums;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  UsersRecord? partnerUserRecord;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in IconButton widget.
  SendPartnerPushCloudFunctionCallResponse? cloudFunction6oy;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
