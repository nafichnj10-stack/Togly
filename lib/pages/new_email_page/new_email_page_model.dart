import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'new_email_page_widget.dart' show NewEmailPageWidget;
import 'package:flutter/material.dart';

class NewEmailPageModel extends FlutterFlowModel<NewEmailPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for NewEMailField widget.
  FocusNode? newEMailFieldFocusNode;
  TextEditingController? newEMailFieldTextController;
  String? Function(BuildContext, String?)? newEMailFieldTextControllerValidator;
  // State field(s) for NewEMailFieldPW widget.
  FocusNode? newEMailFieldPWFocusNode;
  TextEditingController? newEMailFieldPWTextController;
  late bool newEMailFieldPWVisibility;
  String? Function(BuildContext, String?)?
      newEMailFieldPWTextControllerValidator;

  @override
  void initState(BuildContext context) {
    newEMailFieldPWVisibility = false;
  }

  @override
  void dispose() {
    newEMailFieldFocusNode?.dispose();
    newEMailFieldTextController?.dispose();

    newEMailFieldPWFocusNode?.dispose();
    newEMailFieldPWTextController?.dispose();
  }
}
