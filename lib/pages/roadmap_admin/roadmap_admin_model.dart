import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'roadmap_admin_widget.dart' show RoadmapAdminWidget;
import 'package:flutter/material.dart';

class RoadmapAdminModel extends FlutterFlowModel<RoadmapAdminWidget> {
  ///  Local state fields for this page.

  bool publishedLS = false;

  String? coverUrl;

  bool hasNewCover = false;

  DateTime? publishAtRaw;

  DateTime? releaseEtaState;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextTitleCreate widget.
  FocusNode? textTitleCreateFocusNode;
  TextEditingController? textTitleCreateTextController;
  String? Function(BuildContext, String?)?
      textTitleCreateTextControllerValidator;
  // State field(s) for TextDescribCreate widget.
  FocusNode? textDescribCreateFocusNode;
  TextEditingController? textDescribCreateTextController;
  String? Function(BuildContext, String?)?
      textDescribCreateTextControllerValidator;
  // State field(s) for DropDownCreate widget.
  String? dropDownCreateValue;
  FormFieldController<String>? dropDownCreateValueController;
  // State field(s) for TextSortOrderCreate widget.
  FocusNode? textSortOrderCreateFocusNode;
  TextEditingController? textSortOrderCreateTextController;
  String? Function(BuildContext, String?)?
      textSortOrderCreateTextControllerValidator;
  // State field(s) for DateFieldCreate widget.
  FocusNode? dateFieldCreateFocusNode;
  TextEditingController? dateFieldCreateTextController;
  String? Function(BuildContext, String?)?
      dateFieldCreateTextControllerValidator;
  DateTime? datePicked1;
  // State field(s) for SwitchCreate widget.
  bool? switchCreateValue;
  // State field(s) for TextCTACreate widget.
  FocusNode? textCTACreateFocusNode;
  TextEditingController? textCTACreateTextController;
  String? Function(BuildContext, String?)? textCTACreateTextControllerValidator;
  // State field(s) for TextCTALinkCreate widget.
  FocusNode? textCTALinkCreateFocusNode;
  TextEditingController? textCTALinkCreateTextController;
  String? Function(BuildContext, String?)?
      textCTALinkCreateTextControllerValidator;
  // State field(s) for release_textCreate widget.
  FocusNode? releaseTextCreateFocusNode;
  TextEditingController? releaseTextCreateTextController;
  String? Function(BuildContext, String?)?
      releaseTextCreateTextControllerValidator;
  // State field(s) for DropDownColorCreate widget.
  String? dropDownColorCreateValue;
  FormFieldController<String>? dropDownColorCreateValueController;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  RoadmapItemsRecord? createdRoadmapItem;
  // State field(s) for TextTitleEdit widget.
  FocusNode? textTitleEditFocusNode;
  TextEditingController? textTitleEditTextController;
  String? Function(BuildContext, String?)? textTitleEditTextControllerValidator;
  // State field(s) for TextDescribEdit widget.
  FocusNode? textDescribEditFocusNode;
  TextEditingController? textDescribEditTextController;
  String? Function(BuildContext, String?)?
      textDescribEditTextControllerValidator;
  // State field(s) for DropDownEdit widget.
  String? dropDownEditValue;
  FormFieldController<String>? dropDownEditValueController;
  // State field(s) for TextSortOrderEdit widget.
  FocusNode? textSortOrderEditFocusNode;
  TextEditingController? textSortOrderEditTextController;
  String? Function(BuildContext, String?)?
      textSortOrderEditTextControllerValidator;
  // State field(s) for DateFieldEdit widget.
  FocusNode? dateFieldEditFocusNode;
  TextEditingController? dateFieldEditTextController;
  String? Function(BuildContext, String?)? dateFieldEditTextControllerValidator;
  DateTime? datePicked2;
  // State field(s) for SwitchEdit widget.
  bool? switchEditValue;
  // State field(s) for TextCTAEdit widget.
  FocusNode? textCTAEditFocusNode;
  TextEditingController? textCTAEditTextController;
  String? Function(BuildContext, String?)? textCTAEditTextControllerValidator;
  // State field(s) for TextCTALinkEdit widget.
  FocusNode? textCTALinkEditFocusNode;
  TextEditingController? textCTALinkEditTextController;
  String? Function(BuildContext, String?)?
      textCTALinkEditTextControllerValidator;
  // State field(s) for release_textEdit widget.
  FocusNode? releaseTextEditFocusNode;
  TextEditingController? releaseTextEditTextController;
  String? Function(BuildContext, String?)?
      releaseTextEditTextControllerValidator;
  // State field(s) for DropDownColorEdit widget.
  String? dropDownColorEditValue;
  FormFieldController<String>? dropDownColorEditValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textTitleCreateFocusNode?.dispose();
    textTitleCreateTextController?.dispose();

    textDescribCreateFocusNode?.dispose();
    textDescribCreateTextController?.dispose();

    textSortOrderCreateFocusNode?.dispose();
    textSortOrderCreateTextController?.dispose();

    dateFieldCreateFocusNode?.dispose();
    dateFieldCreateTextController?.dispose();

    textCTACreateFocusNode?.dispose();
    textCTACreateTextController?.dispose();

    textCTALinkCreateFocusNode?.dispose();
    textCTALinkCreateTextController?.dispose();

    releaseTextCreateFocusNode?.dispose();
    releaseTextCreateTextController?.dispose();

    textTitleEditFocusNode?.dispose();
    textTitleEditTextController?.dispose();

    textDescribEditFocusNode?.dispose();
    textDescribEditTextController?.dispose();

    textSortOrderEditFocusNode?.dispose();
    textSortOrderEditTextController?.dispose();

    dateFieldEditFocusNode?.dispose();
    dateFieldEditTextController?.dispose();

    textCTAEditFocusNode?.dispose();
    textCTAEditTextController?.dispose();

    textCTALinkEditFocusNode?.dispose();
    textCTALinkEditTextController?.dispose();

    releaseTextEditFocusNode?.dispose();
    releaseTextEditTextController?.dispose();
  }
}
