import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'event_sheet_model.dart';
export 'event_sheet_model.dart';

/// Create a new Bottom Sheet page called `EventSheet`.
///
/// Goal:
/// A polished event editor for a shared couple calendar. It must support both
/// Create and Edit modes and match a soft romantic UI (lavender/pink gradient
/// accents, rounded 24px corners, soft shadows, friendly microcopy,
/// Poppins-like typography). Keep it compact and touch-friendly.
///
/// Page parameters:
/// - eventRef : DocumentReference? (calendar_events) // optional, when set =
/// edit mode
/// - initialDate : DateTime? // optional, used to prefill start date
/// - initialCategory : String? // optional, default category
///
/// Form fields:
/// - Title (TextField, required)
/// - Category (Dropdown/Chips: "next_meeting", "birthday", "trip",
/// "reminder", "other")
/// - All-day (Switch)
/// - Start (DateTimePicker)
/// - End (DateTimePicker) → visible only when All-day is OFF
/// - Location (Text, optional)
/// - Note (Multiline text, optional)
/// - Color (small color chip row or color dropdown, optional)
///
/// Layout & style:
/// - Header row: leading icon (calendar-heart), title text: "Add event" (or
/// "Edit event" if eventRef provided), close icon on the right.
/// - Body uses 16px padding, 12–16px gaps, input fields in cards with 16px
/// radius, soft shadow, subtle outline.
/// - Primary CTA "Save" with a purple→pink gradient (e.g., #7C5CE1 →
/// #F18AB9), full width, 56px height, rounded XL.
/// - Secondary destructive button "Delete" only in Edit mode (outline, danger
/// color).
/// - Use pastel background (#F6F0FF to #FFF0F7), high-contrast labels, and
/// small helper texts.
/// - Add slight entrance animation (sheet slides up, elements fade/scale in).
///
/// Data binding (Firestore collection: `calendar_events`):
/// Each event document stores:
/// - relationship_id : String
/// - title : String
/// - category : String
/// - all_day : Boolean
/// - start : DateTime
/// - end : DateTime
/// - location : String (optional)
/// - note : String (optional)
/// - color : String or Int (optional)
/// - created_by : String
/// - updated_at : DateTime
///
/// Page logic:
/// - On Page Load:
///   - If `eventRef` is provided → query that document and prefill all
/// fields; header text becomes "Edit event".
///   - Else (Create mode):
///     - Start = `initialDate` if provided, otherwise Current Time.
///     - If `initialCategory` provided, preselect it; else default to
/// "next_meeting".
///     - End = Start + 1 hour (if All-day OFF).
/// - When "All-day" is ON: hide the End picker and internally set End = Start
/// at 00:00 + 1 day (use existing custom functions if available).
/// - Validation: Title required; if All-day OFF then End must be after Start
/// → show inline error.
///
/// Actions:
/// - On Save:
///   - If `eventRef` is null → Create Document in `calendar_events`.
///   - Else → Update Document (`eventRef`).
///   - Fields to set on create/update:
///     - relationship_id = currentUserDocument.relationship_id
///     - title, category, all_day, start, end, location, note, color (from
/// form)
///     - created_by (only on create) = authUser.uid
///     - updated_at = Current Time
///   - Show success snackbar "Event saved" and close the sheet.
/// - On Delete (only Edit mode):
///   - Confirm dialog → Delete Document (`eventRef`) → snackbar "Event
/// deleted" → close sheet.
///
/// Accessibility:
/// - Large tap targets, clear focus states, proper
/// label/placeholder/assistive text, and sufficient contrast.
///
/// In `EventSheet`, implement All-day logic:
///
/// - When the All-day switch is ON:
///   - Hide the End Time field (set its Visibility to All-day = false).
///   - On Save, set:
///       start = startOfDayLocal(selectedStart)
///       end   = addDays(startOfDayLocal(selectedStart), 1)
/// - When All-day is OFF:
///   - Show the End field.
///   - Validate: end > start. If not, show inline error text under the End
/// field.
///
/// Use the existing custom functions:
/// - startOfDayLocal(DateTime dt) → DateTime
/// - addDays(DateTime base, int days) → DateTime
///
/// On `CalendarPage`, add:
/// - A floating “+” action button. On tap → Show Bottom Sheet: `EventSheet`
/// with:
///     initialDate = selectedDate
///     initialCategory = "next_meeting" // used for the home counter
/// - In the day’s ListView item (calendar_events record), On Tap → Show
/// Bottom Sheet: `EventSheet` with:
///     eventRef = record.reference
///
/// On HomePage, add a small card/button that shows the days until the next
/// meeting.
///
/// Data:
/// - Stream query `calendar_events`
///   Filters:
///     relationship_id == currentUserDocument.relationship_id
///     category == "next_meeting"
///     start >= Current Time
///   Order by start ascending
///   Limit 1
///
/// UI:
/// - If no document → text "Plan your next meeting".
/// - Else compute days = DateTime difference in days between Current Time and
/// doc.start:
///     - if days <= 0 → "Today"
///     - if days == 1 → "Tomorrow"
///     - else → "{days} days until your next meeting"
/// - On tap → navigate to CalendarPage (optionally pass selectedDate =
/// doc.start).
/// Style consistent with app: lavender gradient pill, heart/calendar icon,
/// rounded 20–24px.
///
/// Refine `EventSheet` visuals to match a soft 2getherly style:
/// - Primary color range: lavender/purple (#7C5CE1) and warm pink (#F18AB9)
/// - Background: very light lavender (#F7F3FF)
/// - Inputs: 16px radius, subtle 1px border in #E6DDF9, soft shadow 8–12 blur
/// - Title font: semibold 20–22px; body 14–16px; labels uppercase micro 12px
/// in #8D86A9
/// - Icons: rounded, stroked 1.5–2px, friendly (calendar, clock, map-pin,
/// sticky-note, paint)
/// - Subtle entrance animation: sheet slides up 12–16px with 120ms fade
/// - Keep everything responsive and keyboard-safe (scrollable when keyboard
/// is open).
class EventSheetWidget extends StatefulWidget {
  const EventSheetWidget({
    super.key,
    this.initialStart,
    this.initialEnd,
  });

  final DateTime? initialStart;
  final DateTime? initialEnd;

  @override
  State<EventSheetWidget> createState() => _EventSheetWidgetState();
}

class _EventSheetWidgetState extends State<EventSheetWidget> {
  late EventSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventSheetModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.category = 'Next meeting';
      _model.allDay = false;
      _model.dateOnly = null;
      _model.startDT = null;
      _model.endDT = null;
      _model.finalStart = null;
      _model.finalEnd = null;
      _model.startChosen = false;
      _model.endChosen = false;
      safeSetState(() {});
    });

    _model.titleFieldTextController ??= TextEditingController();
    _model.titleFieldFocusNode ??= FocusNode();

    _model.switchValue = _model.allDay;
    _model.locationFieldTextController ??= TextEditingController();
    _model.locationFieldFocusNode ??= FocusNode();

    _model.notesFieldTextController ??= TextEditingController();
    _model.notesFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF7F3FF),
            boxShadow: [
              BoxShadow(
                blurRadius: 12.0,
                color: Color(0x4D7C5CE1),
                offset: Offset(
                  0.0,
                  -2.0,
                ),
                spreadRadius: 0.0,
              )
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
            child: SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_rounded,
                            color: Color(0xFF7C5CE1),
                            size: 24.0,
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'voenoph3' /* Add Event */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleMediumFamily,
                                  color: Color(0xFF14181B),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleMediumIsCustom,
                                ),
                          ),
                        ].divide(SizedBox(width: 12.0)),
                      ),
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 20.0,
                        buttonSize: 40.0,
                        icon: Icon(
                          Icons.close_rounded,
                          color: Color(0xFF57636C),
                          size: 20.0,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Form(
                    key: _model.formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: SingleChildScrollView(
                      primary: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 4.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      '2goqxjkb' /* TITLE */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmallFamily,
                                          color: Color(0xFF8D86A9),
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .labelSmallIsCustom,
                                        ),
                                  ),
                                ),
                                TextFormField(
                                  controller: _model.titleFieldTextController,
                                  focusNode: _model.titleFieldFocusNode,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    '_model.titleFieldTextController',
                                    Duration(milliseconds: 2000),
                                    () async {
                                      _model.title =
                                          _model.titleFieldTextController.text;
                                      safeSetState(() {});
                                    },
                                  ),
                                  autofocus: false,
                                  textInputAction: TextInputAction.next,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText:
                                        FFLocalizations.of(context).getText(
                                      '4r0rrbae' /* What's the plan? */,
                                    ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFE6DDF9),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            16.0, 16.0, 16.0, 16.0),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                  minLines: 1,
                                  validator: _model
                                      .titleFieldTextControllerValidator
                                      .asValidator(context),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 4.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      '6bmtq60e' /* CATEGORY */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmallFamily,
                                          color: Color(0xFF8D86A9),
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .labelSmallIsCustom,
                                        ),
                                  ),
                                ),
                                FlutterFlowChoiceChips(
                                  options: [
                                    ChipData(
                                        FFLocalizations.of(context).getText(
                                      'cdympyao' /* Next meeting */,
                                    )),
                                    ChipData(
                                        FFLocalizations.of(context).getText(
                                      '6vfariv8' /* Birthday */,
                                    )),
                                    ChipData(
                                        FFLocalizations.of(context).getText(
                                      'ruf11nay' /* Trip */,
                                    )),
                                    ChipData(
                                        FFLocalizations.of(context).getText(
                                      '3cq0z5cm' /* Reminder */,
                                    )),
                                    ChipData(
                                        FFLocalizations.of(context).getText(
                                      'c0atxtx6' /* Date night */,
                                    )),
                                    ChipData(
                                        FFLocalizations.of(context).getText(
                                      'nr04kbos' /* Video call */,
                                    )),
                                    ChipData(
                                        FFLocalizations.of(context).getText(
                                      'tykxin42' /* Anniversary */,
                                    )),
                                    ChipData(
                                        FFLocalizations.of(context).getText(
                                      '1efc2xdk' /* Other */,
                                    ))
                                  ],
                                  onChanged: (val) async {
                                    safeSetState(() =>
                                        _model.categoryChipsWidgetValue =
                                            val?.firstOrNull);
                                    _model.categoryLabel =
                                        _model.categoryChipsWidgetValue;
                                    _model.categoryKey = () {
                                      if ((_model.categoryChipsWidgetValue ==
                                              'Next meeting') ||
                                          (_model.categoryChipsWidgetValue ==
                                              'Nächstes Treffen') ||
                                          (_model.categoryChipsWidgetValue ==
                                              'Próximo encuentro')) {
                                        return 'next_meeting';
                                      } else if ((_model
                                                  .categoryChipsWidgetValue ==
                                              'Birthday') ||
                                          (_model.categoryChipsWidgetValue ==
                                              'Geburtstag') ||
                                          (_model.categoryChipsWidgetValue ==
                                              'Cumpleaños')) {
                                        return 'birthday';
                                      } else if ((_model
                                                  .categoryChipsWidgetValue ==
                                              'Trip') ||
                                          (_model.categoryChipsWidgetValue ==
                                              'Reise') ||
                                          (_model.categoryChipsWidgetValue ==
                                              'Viaje')) {
                                        return 'trip';
                                      } else if ((_model
                                                  .categoryChipsWidgetValue ==
                                              'Reminder') ||
                                          (_model.categoryChipsWidgetValue ==
                                              'Erinnerung') ||
                                          (_model.categoryChipsWidgetValue ==
                                              'Recordatorio')) {
                                        return 'reminder';
                                      } else if ((_model
                                                  .categoryChipsWidgetValue ==
                                              'Date night') ||
                                          (_model.categoryChipsWidgetValue ==
                                              'Date') ||
                                          (_model.categoryChipsWidgetValue ==
                                              'Cita')) {
                                        return 'date_night';
                                      } else if ((_model
                                                  .categoryChipsWidgetValue ==
                                              'Video call') ||
                                          (_model.categoryChipsWidgetValue ==
                                              'Videoanruf') ||
                                          (_model.categoryChipsWidgetValue ==
                                              'Videollamada')) {
                                        return 'video_call';
                                      } else if ((_model
                                                  .categoryChipsWidgetValue ==
                                              'Anniversary') ||
                                          (_model.categoryChipsWidgetValue ==
                                              'Jahrestag') ||
                                          (_model.categoryChipsWidgetValue ==
                                              'Aniversario')) {
                                        return 'anniversary';
                                      } else {
                                        return 'other';
                                      }
                                    }();
                                    safeSetState(() {});
                                  },
                                  selectedChipStyle: ChipStyle(
                                    backgroundColor: Color(0xFF7C5CE1),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                    iconColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    iconSize: 18.0,
                                    elevation: 4.0,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  unselectedChipStyle: ChipStyle(
                                    backgroundColor: Colors.white,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmallFamily,
                                          color: Color(0xFF57636C),
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodySmallIsCustom,
                                        ),
                                    iconColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    iconSize: 18.0,
                                    elevation: 0.0,
                                    borderColor: Color(0xFFE6DDF9),
                                    borderWidth: 1.0,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  chipSpacing: 8.0,
                                  rowSpacing: 8.0,
                                  multiselect: false,
                                  initialized:
                                      _model.categoryChipsWidgetValue != null,
                                  alignment: WrapAlignment.start,
                                  controller: _model
                                          .categoryChipsWidgetValueController ??=
                                      FormFieldController<List<String>>(
                                    [
                                      valueOrDefault<String>(
                                        _model.category,
                                        'Next meeting',
                                      )
                                    ],
                                  ),
                                  wrapped: true,
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  26.0, 0.0, 16.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'n54u4nmt' /* ALL DAY */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelSmallFamily,
                                      color: Color(0xFF8D86A9),
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .labelSmallIsCustom,
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                  color: Color(0xFFE6DDF9),
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    4.0, 4.0, 4.0, 4.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.schedule_rounded,
                                          color: Color(0xFF7C5CE1),
                                          size: 20.0,
                                        ),
                                        if (_model.allDay)
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              final _datePicked1Date =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: (_model.dateOnly ??
                                                    DateTime.now()),
                                                firstDate: (_model.dateOnly ??
                                                    DateTime.now()),
                                                lastDate: DateTime(2050),
                                                builder: (context, child) {
                                                  return wrapInMaterialDatePickerTheme(
                                                    context,
                                                    child!,
                                                    headerBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText,
                                                    headerForegroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    headerTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineLarge
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLargeFamily,
                                                              fontSize: 32.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLargeIsCustom,
                                                            ),
                                                    pickerBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                    pickerForegroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText,
                                                    selectedDateTimeBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    selectedDateTimeForegroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText,
                                                    actionButtonForegroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText,
                                                    iconSize: 24.0,
                                                  );
                                                },
                                              );

                                              TimeOfDay? _datePicked1Time;
                                              if (_datePicked1Date != null) {
                                                _datePicked1Time =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                      TimeOfDay.fromDateTime(
                                                          (_model.dateOnly ??
                                                              DateTime.now())),
                                                  builder: (context, child) {
                                                    return wrapInMaterialTimePickerTheme(
                                                      context,
                                                      child!,
                                                      headerBackgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      headerForegroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      headerTextStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineLargeFamily,
                                                                fontSize: 32.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineLargeIsCustom,
                                                              ),
                                                      pickerBackgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      pickerForegroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      selectedDateTimeBackgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      selectedDateTimeForegroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      actionButtonForegroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      iconSize: 24.0,
                                                    );
                                                  },
                                                );
                                              }

                                              if (_datePicked1Date != null &&
                                                  _datePicked1Time != null) {
                                                safeSetState(() {
                                                  _model.datePicked1 = DateTime(
                                                    _datePicked1Date.year,
                                                    _datePicked1Date.month,
                                                    _datePicked1Date.day,
                                                    _datePicked1Time!.hour,
                                                    _datePicked1Time.minute,
                                                  );
                                                });
                                              } else if (_model.datePicked1 !=
                                                  null) {
                                                safeSetState(() {
                                                  _model.datePicked1 =
                                                      _model.dateOnly;
                                                });
                                              }
                                              _model.dateOnly =
                                                  _model.datePicked1;
                                              safeSetState(() {});
                                            },
                                            child: Text(
                                              valueOrDefault<String>(
                                                dateTimeFormat(
                                                  "MMM d, y",
                                                  _model.dateOnly,
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
                                                ),
                                                'Select date',
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: Color(0xFF14181B),
                                                    letterSpacing: 0.0,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                            ),
                                          ),
                                      ].divide(SizedBox(width: 12.0)),
                                    ),
                                    Switch(
                                      value: _model.switchValue!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue = newValue);
                                        if (newValue) {
                                          _model.allDay = true;
                                          _model.startChosen = false;
                                          _model.endChosen = false;
                                          _model.startDT = null;
                                          _model.endDT = null;
                                          safeSetState(() {});
                                        } else {
                                          _model.allDay = false;
                                          _model.dateOnly = null;
                                          safeSetState(() {});
                                        }
                                      },
                                      activeThumbColor: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context).success,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      inactiveThumbColor: Color(0xFFE6DDF9),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (!_model.allDay)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 4.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        '1az9ltku' /* START */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmallFamily,
                                            color: Color(0xFF8D86A9),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelSmallIsCustom,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        border: Border.all(
                                          color: Color(0xFFE6DDF9),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.calendar_today_rounded,
                                              color: Color(0xFF7C5CE1),
                                              size: 20.0,
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  final _datePicked2Date =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate:
                                                        (_model.dateOnly ??
                                                            DateTime.now()),
                                                    firstDate:
                                                        (_model.dateOnly ??
                                                            DateTime.now()),
                                                    lastDate: DateTime(2050),
                                                    builder: (context, child) {
                                                      return wrapInMaterialDatePickerTheme(
                                                        context,
                                                        child!,
                                                        headerBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        headerForegroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        headerTextStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineLarge
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLargeFamily,
                                                                  fontSize:
                                                                      32.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineLargeIsCustom,
                                                                ),
                                                        pickerBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryBackground,
                                                        pickerForegroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        selectedDateTimeBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        selectedDateTimeForegroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        actionButtonForegroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        iconSize: 24.0,
                                                      );
                                                    },
                                                  );

                                                  TimeOfDay? _datePicked2Time;
                                                  if (_datePicked2Date !=
                                                      null) {
                                                    _datePicked2Time =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime: TimeOfDay
                                                          .fromDateTime((_model
                                                                  .dateOnly ??
                                                              DateTime.now())),
                                                      builder:
                                                          (context, child) {
                                                        return wrapInMaterialTimePickerTheme(
                                                          context,
                                                          child!,
                                                          headerBackgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryText,
                                                          headerForegroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                          headerTextStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineLargeFamily,
                                                                    fontSize:
                                                                        32.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .headlineLargeIsCustom,
                                                                  ),
                                                          pickerBackgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryBackground,
                                                          pickerForegroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryText,
                                                          selectedDateTimeBackgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                          selectedDateTimeForegroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryText,
                                                          actionButtonForegroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryText,
                                                          iconSize: 24.0,
                                                        );
                                                      },
                                                    );
                                                  }

                                                  if (_datePicked2Date !=
                                                          null &&
                                                      _datePicked2Time !=
                                                          null) {
                                                    safeSetState(() {
                                                      _model.datePicked2 =
                                                          DateTime(
                                                        _datePicked2Date.year,
                                                        _datePicked2Date.month,
                                                        _datePicked2Date.day,
                                                        _datePicked2Time!.hour,
                                                        _datePicked2Time.minute,
                                                      );
                                                    });
                                                  } else if (_model
                                                          .datePicked2 !=
                                                      null) {
                                                    safeSetState(() {
                                                      _model.datePicked2 =
                                                          _model.dateOnly;
                                                    });
                                                  }
                                                  _model.startDT =
                                                      _model.datePicked2;
                                                  _model.startChosen = true;
                                                  safeSetState(() {});
                                                },
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    !_model.startChosen
                                                        ? 'Select start (date & time)'
                                                        : dateTimeFormat(
                                                            "MMM d, y – h:mm a",
                                                            _model.startDT,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          ),
                                                    'Select date',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMediumIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 12.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (!_model.allDay)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 4.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        '5yjdhncq' /* END */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmallFamily,
                                            color: Color(0xFF8D86A9),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelSmallIsCustom,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        border: Border.all(
                                          color: Color(0xFFE6DDF9),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.schedule_rounded,
                                              color: Color(0xFF7C5CE1),
                                              size: 20.0,
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  final _datePicked3Date =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate:
                                                        (_model.dateOnly ??
                                                            DateTime.now()),
                                                    firstDate:
                                                        (_model.dateOnly ??
                                                            DateTime.now()),
                                                    lastDate: DateTime(2050),
                                                    builder: (context, child) {
                                                      return wrapInMaterialDatePickerTheme(
                                                        context,
                                                        child!,
                                                        headerBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        headerForegroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        headerTextStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineLarge
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLargeFamily,
                                                                  fontSize:
                                                                      32.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineLargeIsCustom,
                                                                ),
                                                        pickerBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryBackground,
                                                        pickerForegroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        selectedDateTimeBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        selectedDateTimeForegroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        actionButtonForegroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        iconSize: 24.0,
                                                      );
                                                    },
                                                  );

                                                  TimeOfDay? _datePicked3Time;
                                                  if (_datePicked3Date !=
                                                      null) {
                                                    _datePicked3Time =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime: TimeOfDay
                                                          .fromDateTime((_model
                                                                  .dateOnly ??
                                                              DateTime.now())),
                                                      builder:
                                                          (context, child) {
                                                        return wrapInMaterialTimePickerTheme(
                                                          context,
                                                          child!,
                                                          headerBackgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryText,
                                                          headerForegroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                          headerTextStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineLargeFamily,
                                                                    fontSize:
                                                                        32.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .headlineLargeIsCustom,
                                                                  ),
                                                          pickerBackgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryBackground,
                                                          pickerForegroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryText,
                                                          selectedDateTimeBackgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                          selectedDateTimeForegroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryText,
                                                          actionButtonForegroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryText,
                                                          iconSize: 24.0,
                                                        );
                                                      },
                                                    );
                                                  }

                                                  if (_datePicked3Date !=
                                                          null &&
                                                      _datePicked3Time !=
                                                          null) {
                                                    safeSetState(() {
                                                      _model.datePicked3 =
                                                          DateTime(
                                                        _datePicked3Date.year,
                                                        _datePicked3Date.month,
                                                        _datePicked3Date.day,
                                                        _datePicked3Time!.hour,
                                                        _datePicked3Time.minute,
                                                      );
                                                    });
                                                  } else if (_model
                                                          .datePicked3 !=
                                                      null) {
                                                    safeSetState(() {
                                                      _model.datePicked3 =
                                                          _model.dateOnly;
                                                    });
                                                  }
                                                  _model.endDT =
                                                      _model.datePicked3;
                                                  _model.endChosen = true;
                                                  safeSetState(() {});
                                                },
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    !_model.endChosen
                                                        ? 'Select end (date & time)'
                                                        : dateTimeFormat(
                                                            "MMM d, y – h:mm a",
                                                            _model.endDT,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          ),
                                                    'Select date',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMediumIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 12.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 4.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      '4gmxebmd' /* LOCATION */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmallFamily,
                                          color: Color(0xFF8D86A9),
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .labelSmallIsCustom,
                                        ),
                                  ),
                                ),
                                TextFormField(
                                  controller:
                                      _model.locationFieldTextController,
                                  focusNode: _model.locationFieldFocusNode,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    '_model.locationFieldTextController',
                                    Duration(milliseconds: 2000),
                                    () async {
                                      _model.location = _model
                                          .locationFieldTextController.text;
                                      safeSetState(() {});
                                    },
                                  ),
                                  autofocus: false,
                                  textInputAction: TextInputAction.next,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText:
                                        FFLocalizations.of(context).getText(
                                      'frowm6yg' /* Where will you be? */,
                                    ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFE6DDF9),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            16.0, 16.0, 16.0, 16.0),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                  minLines: 1,
                                  validator: _model
                                      .locationFieldTextControllerValidator
                                      .asValidator(context),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 4.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      '8lrc287z' /* NOTES */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmallFamily,
                                          color: Color(0xFF8D86A9),
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .labelSmallIsCustom,
                                        ),
                                  ),
                                ),
                                TextFormField(
                                  controller: _model.notesFieldTextController,
                                  focusNode: _model.notesFieldFocusNode,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    '_model.notesFieldTextController',
                                    Duration(milliseconds: 2000),
                                    () async {
                                      _model.notes =
                                          _model.notesFieldTextController.text;
                                      safeSetState(() {});
                                    },
                                  ),
                                  autofocus: false,
                                  textInputAction: TextInputAction.done,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText:
                                        FFLocalizations.of(context).getText(
                                      'bthrtoeb' /* Add any details... */,
                                    ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFE6DDF9),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            16.0, 16.0, 16.0, 16.0),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                  maxLines: 5,
                                  minLines: 3,
                                  validator: _model
                                      .notesFieldTextControllerValidator
                                      .asValidator(context),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 50.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    if (/* NOT RECOMMENDED */ _model
                                            .titleFieldTextController.text ==
                                        'true') {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text(
                                                FFLocalizations.of(context)
                                                    .getVariableText(
                                              enText: 'Error❌',
                                              deText: 'Fehler❌',
                                              esText: 'Error❌',
                                            )),
                                            content: Text(
                                                FFLocalizations.of(context)
                                                    .getVariableText(
                                              enText:
                                                  'Please select start and end time',
                                              deText:
                                                  'Bitte wähle eine Start- und Endzeit aus',
                                              esText:
                                                  'Por favor, selecciona una hora de inicio y una hora de finalización',
                                            )),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: Text(
                                                    FFLocalizations.of(context)
                                                        .getVariableText(
                                                  enText: 'Okay',
                                                  deText: 'Okay',
                                                  esText: 'Okay',
                                                )),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      if (_model.allDay) {
                                        if ((_model
                                                        .titleFieldTextController
                                                        .text ==
                                                    '') ||
                                            (_model.locationFieldTextController
                                                        .text ==
                                                    '') ||
                                            (_model.notesFieldTextController
                                                        .text ==
                                                    '')) {
                                          await showDialog(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                title: Text('Error'),
                                                content: Text(
                                                    FFLocalizations.of(context)
                                                        .getVariableText(
                                                  enText:
                                                      'Make sure that a title, location and the message field is not empty',
                                                  deText:
                                                      'Bitte stelle sicher, dass Titel, Ort und Nachricht ausgefüllt sind',
                                                  esText:
                                                      'Por favor, asegúrate de que el título, la ubicación y el mensaje estén completos',
                                                )),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext),
                                                    child: Text('Ok'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          if (_model.dateOnly != null) {
                                            _model.finalStart =
                                                functions.startOfDayLocal(
                                                    _model.dateOnly);
                                            _model.finalEnd =
                                                functions.startOfNextDayLocal(
                                                    _model.dateOnly);
                                            safeSetState(() {});

                                            var calendarEventsRecordReference1 =
                                                CalendarEventsRecord.collection
                                                    .doc();
                                            await calendarEventsRecordReference1
                                                .set(
                                                    createCalendarEventsRecordData(
                                              relationshipId: valueOrDefault(
                                                  currentUserDocument
                                                      ?.relationshipId,
                                                  ''),
                                              title: _model
                                                  .titleFieldTextController
                                                  .text,
                                              category: _model.categoryLabel,
                                              allDay: _model.allDay,
                                              start: _model.finalStart,
                                              end: functions.addDays(
                                                  _model.finalStart, 1),
                                              location: _model
                                                  .locationFieldTextController
                                                  .text,
                                              note: _model
                                                  .notesFieldTextController
                                                  .text,
                                              color: functions
                                                  .calendarCategoryColor(
                                                      _model.category),
                                              createdBy: currentUserUid,
                                              updatedAt: getCurrentTimestamp,
                                              expiresAtArchive:
                                                  functions.addDays(
                                                      _model.finalEnd, 365),
                                              categoryKey: _model.categoryKey,
                                              travelerUid: currentUserUid,
                                            ));
                                            _model.newEventDoc = CalendarEventsRecord
                                                .getDocumentFromData(
                                                    createCalendarEventsRecordData(
                                                      relationshipId:
                                                          valueOrDefault(
                                                              currentUserDocument
                                                                  ?.relationshipId,
                                                              ''),
                                                      title: _model
                                                          .titleFieldTextController
                                                          .text,
                                                      category:
                                                          _model.categoryLabel,
                                                      allDay: _model.allDay,
                                                      start: _model.finalStart,
                                                      end: functions.addDays(
                                                          _model.finalStart, 1),
                                                      location: _model
                                                          .locationFieldTextController
                                                          .text,
                                                      note: _model
                                                          .notesFieldTextController
                                                          .text,
                                                      color: functions
                                                          .calendarCategoryColor(
                                                              _model.category),
                                                      createdBy: currentUserUid,
                                                      updatedAt:
                                                          getCurrentTimestamp,
                                                      expiresAtArchive:
                                                          functions.addDays(
                                                              _model.finalEnd,
                                                              365),
                                                      categoryKey:
                                                          _model.categoryKey,
                                                      travelerUid:
                                                          currentUserUid,
                                                    ),
                                                    calendarEventsRecordReference1);
                                            try {
                                              final result = await FirebaseFunctions
                                                      .instanceFor(
                                                          region:
                                                              'europe-west3')
                                                  .httpsCallable(
                                                      'syncLoveBuddyTravelState')
                                                  .call({
                                                "relationshipId":
                                                    valueOrDefault(
                                                        currentUserDocument
                                                            ?.relationshipId,
                                                        ''),
                                              });
                                              _model.syn =
                                                  SyncLoveBuddyTravelStateCloudFunctionCallResponse(
                                                succeeded: true,
                                              );
                                            } on FirebaseFunctionsException catch (error) {
                                              _model.syn =
                                                  SyncLoveBuddyTravelStateCloudFunctionCallResponse(
                                                errorCode: error.code,
                                                succeeded: false,
                                              );
                                            }

                                            try {
                                              final result = await FirebaseFunctions
                                                      .instanceFor(
                                                          region:
                                                              'europe-west3')
                                                  .httpsCallable(
                                                      'awardNextMeetingMonthlyPair')
                                                  .call({
                                                "eventId": _model
                                                    .newEventDoc?.reference.id,
                                              });
                                              _model.awaardcal =
                                                  AwardNextMeetingMonthlyPairCloudFunctionCallResponse(
                                                succeeded: true,
                                              );
                                            } on FirebaseFunctionsException catch (error) {
                                              _model.awaardcal =
                                                  AwardNextMeetingMonthlyPairCloudFunctionCallResponse(
                                                errorCode: error.code,
                                                succeeded: false,
                                              );
                                            }

                                            logFirebaseEvent(
                                              'calendar_event_created',
                                              parameters: {
                                                'category': _model
                                                    .categoryChipsWidgetValue,
                                                'all_day': _model.allDay,
                                                'source': 'shared_calendar',
                                              },
                                            );
                                            Navigator.pop(context);
                                            if (valueOrDefault(
                                                    currentUserDocument
                                                        ?.appLanguage,
                                                    '') ==
                                                'en') {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Event saved',
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            } else if (valueOrDefault(
                                                    currentUserDocument
                                                        ?.appLanguage,
                                                    '') ==
                                                'de') {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Ereignis gespeichert',
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            } else if (valueOrDefault(
                                                    currentUserDocument
                                                        ?.appLanguage,
                                                    '') ==
                                                'es') {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Evento guardado',
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            }

                                            context.goNamed(
                                              CalenderPageWidget.routeName,
                                              extra: <String, dynamic>{
                                                '__transition_info__':
                                                    TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                      PageTransitionType.fade,
                                                ),
                                              },
                                            );

                                            _model.partnerUserRecord =
                                                await queryUsersRecordOnce(
                                              queryBuilder: (usersRecord) =>
                                                  usersRecord.where(
                                                'uid',
                                                isEqualTo: valueOrDefault(
                                                    currentUserDocument
                                                        ?.partnerUID,
                                                    ''),
                                              ),
                                              singleRecord: true,
                                            ).then((s) => s.firstOrNull);
                                            try {
                                              final result =
                                                  await FirebaseFunctions
                                                          .instanceFor(
                                                              region:
                                                                  'europe-west3')
                                                      .httpsCallable(
                                                          'sendPartnerPush')
                                                      .call({
                                                "type":
                                                    'calendar_event_created',
                                                "route": 'calenderPage',
                                                "audience": 'partner',
                                              });
                                              _model.calenderPage1 =
                                                  SendPartnerPushCloudFunctionCallResponse(
                                                data: result.data,
                                                succeeded: true,
                                                resultAsString:
                                                    result.data.toString(),
                                                jsonBody: result.data,
                                              );
                                            } on FirebaseFunctionsException catch (error) {
                                              _model.calenderPage1 =
                                                  SendPartnerPushCloudFunctionCallResponse(
                                                errorCode: error.code,
                                                succeeded: false,
                                              );
                                            }
                                          } else {
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text('Error'),
                                                  content: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getVariableText(
                                                    enText:
                                                        'Please select a date',
                                                    deText:
                                                        'Bitte wähle ein Datum aus',
                                                    esText:
                                                        'Por favor, selecciona una fecha',
                                                  )),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        }
                                      } else {
                                        if (_model.startChosen &&
                                            _model.endChosen) {
                                          if (functions.isEndBeforeOrSame(
                                              _model.endDT, _model.startDT)) {
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text('Error'),
                                                  content: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getVariableText(
                                                    enText:
                                                        'End time must be after start time',
                                                    deText:
                                                        'Die Endzeit muss nach der Startzeit liegen',
                                                    esText:
                                                        'La hora de finalización debe ser posterior a la hora de inicio',
                                                  )),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          } else {
                                            if ((_model.titleFieldTextController.text == '') ||
                                                (_model.locationFieldTextController
                                                            .text ==
                                                        '') ||
                                                (_model.notesFieldTextController
                                                            .text ==
                                                        '')) {
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: Text('Error'),
                                                    content: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getVariableText(
                                                      enText:
                                                          'Make sure that a title, location and the message field is not empty',
                                                      deText:
                                                          'Bitte stelle sicher, dass Titel, Ort und Nachricht ausgefüllt sind',
                                                      esText:
                                                          'Por favor, asegúrate de que el título, la ubicación y el mensaje estén completos',
                                                    )),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext),
                                                        child: Text('Ok'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            } else {
                                              _model.finalStart =
                                                  _model.startDT;
                                              _model.finalEnd = _model.endDT;
                                              safeSetState(() {});

                                              var calendarEventsRecordReference2 =
                                                  CalendarEventsRecord
                                                      .collection
                                                      .doc();
                                              await calendarEventsRecordReference2
                                                  .set(
                                                      createCalendarEventsRecordData(
                                                relationshipId: valueOrDefault(
                                                    currentUserDocument
                                                        ?.relationshipId,
                                                    ''),
                                                title: _model
                                                    .titleFieldTextController
                                                    .text,
                                                category: _model.categoryLabel,
                                                allDay: _model.allDay,
                                                start: _model.finalStart,
                                                end: _model.finalEnd,
                                                location: _model
                                                    .locationFieldTextController
                                                    .text,
                                                note: _model
                                                    .notesFieldTextController
                                                    .text,
                                                color: functions
                                                    .calendarCategoryColor(
                                                        _model.category),
                                                createdBy: currentUserUid,
                                                updatedAt: getCurrentTimestamp,
                                                expiresAtArchive:
                                                    functions.addDays(
                                                        _model.finalEnd, 365),
                                                categoryKey: _model.categoryKey,
                                                travelerUid: currentUserUid,
                                              ));
                                              _model.call = CalendarEventsRecord
                                                  .getDocumentFromData(
                                                      createCalendarEventsRecordData(
                                                        relationshipId: valueOrDefault(
                                                            currentUserDocument
                                                                ?.relationshipId,
                                                            ''),
                                                        title: _model
                                                            .titleFieldTextController
                                                            .text,
                                                        category: _model
                                                            .categoryLabel,
                                                        allDay: _model.allDay,
                                                        start:
                                                            _model.finalStart,
                                                        end: _model.finalEnd,
                                                        location: _model
                                                            .locationFieldTextController
                                                            .text,
                                                        note: _model
                                                            .notesFieldTextController
                                                            .text,
                                                        color: functions
                                                            .calendarCategoryColor(
                                                                _model
                                                                    .category),
                                                        createdBy:
                                                            currentUserUid,
                                                        updatedAt:
                                                            getCurrentTimestamp,
                                                        expiresAtArchive:
                                                            functions.addDays(
                                                                _model.finalEnd,
                                                                365),
                                                        categoryKey:
                                                            _model.categoryKey,
                                                        travelerUid:
                                                            currentUserUid,
                                                      ),
                                                      calendarEventsRecordReference2);
                                              try {
                                                final result = await FirebaseFunctions
                                                        .instanceFor(
                                                            region:
                                                                'europe-west3')
                                                    .httpsCallable(
                                                        'syncLoveBuddyTravelState')
                                                    .call({
                                                  "relationshipId":
                                                      valueOrDefault(
                                                          currentUserDocument
                                                              ?.relationshipId,
                                                          ''),
                                                });
                                                _model.sync =
                                                    SyncLoveBuddyTravelStateCloudFunctionCallResponse(
                                                  succeeded: true,
                                                );
                                              } on FirebaseFunctionsException catch (error) {
                                                _model.sync =
                                                    SyncLoveBuddyTravelStateCloudFunctionCallResponse(
                                                  errorCode: error.code,
                                                  succeeded: false,
                                                );
                                              }

                                              try {
                                                final result = await FirebaseFunctions
                                                        .instanceFor(
                                                            region:
                                                                'europe-west3')
                                                    .httpsCallable(
                                                        'awardNextMeetingMonthlyPair')
                                                    .call({
                                                  "eventId":
                                                      _model.call?.reference.id,
                                                });
                                                _model.awaardcal1 =
                                                    AwardNextMeetingMonthlyPairCloudFunctionCallResponse(
                                                  succeeded: true,
                                                );
                                              } on FirebaseFunctionsException catch (error) {
                                                _model.awaardcal1 =
                                                    AwardNextMeetingMonthlyPairCloudFunctionCallResponse(
                                                  errorCode: error.code,
                                                  succeeded: false,
                                                );
                                              }

                                              logFirebaseEvent(
                                                'calendar_event_created',
                                                parameters: {
                                                  'category': _model
                                                      .categoryChipsWidgetValue,
                                                  'all_day': _model.allDay,
                                                  'source': 'shared_calendar',
                                                },
                                              );
                                              if (valueOrDefault(
                                                      currentUserDocument
                                                          ?.appLanguage,
                                                      '') ==
                                                  'en') {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Event saved',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              } else if (valueOrDefault(
                                                      currentUserDocument
                                                          ?.appLanguage,
                                                      '') ==
                                                  'de') {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Ereignis gespeichert',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              } else if (valueOrDefault(
                                                      currentUserDocument
                                                          ?.appLanguage,
                                                      '') ==
                                                  'es') {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Evento guardado',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              }

                                              Navigator.pop(context);
                                              _model.partnerUserRecord4 =
                                                  await queryUsersRecordOnce(
                                                queryBuilder: (usersRecord) =>
                                                    usersRecord.where(
                                                  'uid',
                                                  isEqualTo: valueOrDefault(
                                                      currentUserDocument
                                                          ?.partnerUID,
                                                      ''),
                                                ),
                                                singleRecord: true,
                                              ).then((s) => s.firstOrNull);
                                              try {
                                                final result =
                                                    await FirebaseFunctions
                                                            .instanceFor(
                                                                region:
                                                                    'europe-west3')
                                                        .httpsCallable(
                                                            'sendPartnerPush')
                                                        .call({
                                                  "type":
                                                      'calendar_event_created',
                                                  "route": 'calenderPage',
                                                  "audience": 'partner',
                                                });
                                                _model.calenderPag2 =
                                                    SendPartnerPushCloudFunctionCallResponse(
                                                  data: result.data,
                                                  succeeded: true,
                                                  resultAsString:
                                                      result.data.toString(),
                                                  jsonBody: result.data,
                                                );
                                              } on FirebaseFunctionsException catch (error) {
                                                _model.calenderPag2 =
                                                    SendPartnerPushCloudFunctionCallResponse(
                                                  errorCode: error.code,
                                                  succeeded: false,
                                                );
                                              }
                                            }
                                          }
                                        } else {
                                          await showDialog(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                title: Text('Error'),
                                                content: Text(
                                                    'Please select start and end time'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext),
                                                    child: Text('Ok'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      }
                                    }

                                    safeSetState(() {});
                                  },
                                  text: FFLocalizations.of(context).getText(
                                    'sul5m9mj' /* Save Event */,
                                  ),
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 56.0,
                                    padding: EdgeInsets.all(8.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: Color(0xFF7C5CE1),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleMediumFamily,
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .titleMediumIsCustom,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(28.0),
                                  ),
                                ),
                              ].divide(SizedBox(height: 12.0)),
                            ),
                          ),
                        ].divide(SizedBox(height: 12.0)),
                      ),
                    ),
                  ),
                ].divide(SizedBox(height: 16.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
