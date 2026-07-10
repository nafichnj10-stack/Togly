import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 's4_partner_widget.dart' show S4PartnerWidget;
import 'package:flutter/material.dart';

class S4PartnerModel extends FlutterFlowModel<S4PartnerWidget> {
  ///  State fields for stateful widgets in this page.

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
