import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'calender_page_widget.dart' show CalenderPageWidget;
import 'package:flutter/material.dart';

class CalenderPageModel extends FlutterFlowModel<CalenderPageWidget> {
  ///  Local state fields for this page.

  DateTime? dayStart;

  DateTime? dayEnd;

  DateTime? selectedDay;

  DateTime? focusedMonth;

  List<CalendarEventsRecord> eventsForDay = [];
  void addToEventsForDay(CalendarEventsRecord item) => eventsForDay.add(item);
  void removeFromEventsForDay(CalendarEventsRecord item) =>
      eventsForDay.remove(item);
  void removeAtIndexFromEventsForDay(int index) => eventsForDay.removeAt(index);
  void insertAtIndexInEventsForDay(int index, CalendarEventsRecord item) =>
      eventsForDay.insert(index, item);
  void updateEventsForDayAtIndex(
          int index, Function(CalendarEventsRecord) updateFn) =>
      eventsForDay[index] = updateFn(eventsForDay[index]);

  UsersRecord? partnerUserData;

  DateTime? upStart;

  DateTime? upEnd;

  DateTime? calendarDate;

  String calendarKey = 'boot';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in CalenderPage widget.
  List<CalendarEventsRecord>? calendarQueryResult;
  // State field(s) for Column widget.
  ScrollController? columnController1;
  // State field(s) for Column widget.
  ScrollController? columnController2;
  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;
  // Stores action output result for [Firestore Query - Query a collection] action in Calendar widget.
  List<CalendarEventsRecord>? calendarQueryResult2;
  // Stores action output result for [Firestore Query - Query a collection] action in Calendar widget.
  List<UsersRecord>? partnerList;
  // State field(s) for ListView widget.
  ScrollController? listViewController1;
  // Stores action output result for [Cloud Function - syncLoveBuddyTravelState] action in Icon widget.
  SyncLoveBuddyTravelStateCloudFunctionCallResponse? sync;
  // State field(s) for ListView widget.
  ScrollController? listViewController2;

  @override
  void initState(BuildContext context) {
    columnController1 = ScrollController();
    columnController2 = ScrollController();
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    listViewController1 = ScrollController();
    listViewController2 = ScrollController();
  }

  @override
  void dispose() {
    columnController1?.dispose();
    columnController2?.dispose();
    listViewController1?.dispose();
    listViewController2?.dispose();
  }
}
