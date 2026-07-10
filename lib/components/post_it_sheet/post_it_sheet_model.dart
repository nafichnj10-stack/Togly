import '/flutter_flow/flutter_flow_util.dart';
import 'post_it_sheet_widget.dart' show PostItSheetWidget;
import 'package:flutter/material.dart';

class PostItSheetModel extends FlutterFlowModel<PostItSheetWidget> {
  ///  Local state fields for this component.

  String? previewText;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
