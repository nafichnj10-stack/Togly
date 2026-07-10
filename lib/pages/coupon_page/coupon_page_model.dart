import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'coupon_page_widget.dart' show CouponPageWidget;
import 'package:flutter/material.dart';

class CouponPageModel extends FlutterFlowModel<CouponPageWidget> {
  ///  Local state fields for this page.

  String? selectedTemplateId = '\"\"';

  String? selectedDesignKey = '\"\"';

  String? selectedIconKey = '\"\"';

  String? selectedCategory = '\"\"';

  String? couponTitle = '\"\"';

  String? couponDescription = '\"\"';

  String? uploadedPhotoUrl = '\"\"';

  String? uploadedPhotoPath = '\"\"';

  bool? isTemplateSelected = false;

  bool? isSaving = false;

  String? generatedCouponPhotoFileName;

  FFUploadedFile? selectedCouponPhoto;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  bool isDataUploading_uploadDataWgn = false;
  FFUploadedFile uploadedLocalFile_uploadDataWgn =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  String? _textController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'owwr8b3w' /* e.g. A Cozy Movie Night Just f... */,
      );
    }

    return null;
  }

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  String? _textController2Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'jj5t7ajh' /* Write a heartfelt message your... */,
      );
    }

    return null;
  }

  // Stores action output result for [Custom Action - getStorageDownloadUrlV2] action in Button widget.
  String? couponPhotoDownloadUrl;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  LoveCouponsRecord? createDoc;

  @override
  void initState(BuildContext context) {
    textController1Validator = _textController1Validator;
    textController2Validator = _textController2Validator;
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
