import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'event_sheet_widget.dart' show EventSheetWidget;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class EventSheetModel extends FlutterFlowModel<EventSheetWidget> {
  ///  Local state fields for this component.

  DateTime? finalStart;

  DateTime? finalEnd;

  String? title;

  String category = 'Next meeting';

  bool allDay = false;

  DateTime? dateOnly;

  DateTime? startDT;

  DateTime? endDT;

  bool startChosen = false;

  bool endChosen = false;

  String? location;

  String? notes;

  String? categoryKey;

  String? categoryLabel;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for titleField widget.
  FocusNode? titleFieldFocusNode;
  TextEditingController? titleFieldTextController;
  String? Function(BuildContext, String?)? titleFieldTextControllerValidator;
  // State field(s) for categoryChipsWidget widget.
  FormFieldController<List<String>>? categoryChipsWidgetValueController;
  String? get categoryChipsWidgetValue =>
      categoryChipsWidgetValueController?.value?.firstOrNull;
  set categoryChipsWidgetValue(String? val) =>
      categoryChipsWidgetValueController?.value = val != null ? [val] : [];
  DateTime? datePicked1;
  // State field(s) for Switch widget.
  bool? switchValue;
  DateTime? datePicked2;
  DateTime? datePicked3;
  // State field(s) for locationField widget.
  FocusNode? locationFieldFocusNode;
  TextEditingController? locationFieldTextController;
  String? Function(BuildContext, String?)? locationFieldTextControllerValidator;
  // State field(s) for notesField widget.
  FocusNode? notesFieldFocusNode;
  TextEditingController? notesFieldTextController;
  String? Function(BuildContext, String?)? notesFieldTextControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  CalendarEventsRecord? newEventDoc;
  // Stores action output result for [Cloud Function - syncLoveBuddyTravelState] action in Button widget.
  SyncLoveBuddyTravelStateCloudFunctionCallResponse? syn;
  // Stores action output result for [Cloud Function - awardNextMeetingMonthlyPair] action in Button widget.
  AwardNextMeetingMonthlyPairCloudFunctionCallResponse? awaardcal;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UsersRecord? partnerUserRecord;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Button widget.
  SendPartnerPushCloudFunctionCallResponse? calenderPage1;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  CalendarEventsRecord? call;
  // Stores action output result for [Cloud Function - syncLoveBuddyTravelState] action in Button widget.
  SyncLoveBuddyTravelStateCloudFunctionCallResponse? sync;
  // Stores action output result for [Cloud Function - awardNextMeetingMonthlyPair] action in Button widget.
  AwardNextMeetingMonthlyPairCloudFunctionCallResponse? awaardcal1;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UsersRecord? partnerUserRecord4;
  // Stores action output result for [Cloud Function - sendPartnerPush] action in Button widget.
  SendPartnerPushCloudFunctionCallResponse? calenderPag2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    titleFieldFocusNode?.dispose();
    titleFieldTextController?.dispose();

    locationFieldFocusNode?.dispose();
    locationFieldTextController?.dispose();

    notesFieldFocusNode?.dispose();
    notesFieldTextController?.dispose();
  }
}
