import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/components/event_sheet/event_sheet_widget.dart';
import '/components/pair_required_sheet/pair_required_sheet_widget.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calender_page_model.dart';
export 'calender_page_model.dart';

/// Design a visually soft, emotionally warm, and modern mobile Shared
/// Calendar screen for the relationship app "Togetherly".
///
/// Use a consistent pastel gradient theme (lavender, soft pinks, and beige
/// tones), rounded containers, and subtle shadows to match the rest of the
/// app's UI.
///
/// 📆 Main Layout:
/// Page Title (Top Center):
/// "Shared Calendar" – large, elegant font (like Poppins or Inter), in soft
/// purple.
///
/// Header Subtitle (Optional):
/// A light line of text under the title:
/// “Plan your love-filled moments – 2gether.”
///
/// Month Selector:
/// A clean and minimal month-year picker at the top with left/right arrow
/// icons (e.g., ← August 2025 →)
/// Font is soft and clear, with small calendar icon beside it.
///
/// Main Calendar Grid:
/// A traditional month grid view with:
///
/// Rounded date cells
///
/// Highlight today's date in a subtle accent color (lavender or blush pink)
///
/// Show a small heart 💜 or dot under days that have events
///
/// Event Cards (below calendar):
/// List of upcoming or selected day’s events:
///
/// Soft card layout with icon, title (e.g., “Anniversary dinner”), time
/// (e.g., 7:30 PM), and description
///
/// Optionally color-coded by type (e.g., Romantic, Practical)
///
/// ➕ Floating Action Button:
/// A circular, floating “+” button at bottom right corner labeled:
/// Add Event – in gradient purple with a calendar-plus icon.
/// Tap leads to another screen (function not required here).
///
/// Design Specs:
/// Background: Soft gradient (lavender to off-white fade)
///
/// Fonts: Rounded, elegant, emotionally friendly (Inter or Nunito)
///
/// Card Shadows: Very subtle for depth
///
/// Icons: Pastel-themed, minimal stroke-style icons
///
/// Mood: Gentle, coordinated, cozy, and positive
class CalenderPageWidget extends StatefulWidget {
  const CalenderPageWidget({super.key});

  static String routeName = 'CalenderPage';
  static String routePath = '/calenderPage';

  @override
  State<CalenderPageWidget> createState() => _CalenderPageWidgetState();
}

class _CalenderPageWidgetState extends State<CalenderPageWidget> {
  late CalenderPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalenderPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'CalenderPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if ((valueOrDefault(currentUserDocument?.relationshipId, '') == '') ||
          (valueOrDefault(currentUserDocument?.relationshipId, '') == '')) {
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          isDismissible: false,
          enableDrag: false,
          useSafeArea: true,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: PairRequiredSheetWidget(),
              ),
            );
          },
        ).then((value) => safeSetState(() {}));

        context.goNamed(ConnectWidget.routeName);
      } else {
        _model.selectedDay = getCurrentTimestamp;
        _model.dayStart = functions.startOfDayUtc(_model.selectedDay!);
        _model.dayEnd = functions.startOfNextDayUtc(_model.selectedDay!);
        _model.upStart = functions.startOfDayUtc(getCurrentTimestamp);
        _model.upEnd = functions.addDays(_model.upStart, 14);
        safeSetState(() {});
        _model.calendarQueryResult = await queryCalendarEventsRecordOnce(
          queryBuilder: (calendarEventsRecord) => calendarEventsRecord
              .where(
                'relationship_id',
                isEqualTo:
                    valueOrDefault(currentUserDocument?.relationshipId, ''),
              )
              .where(
                'start',
                isLessThan: _model.dayEnd,
              )
              .orderBy('start'),
        );
        _model.eventsForDay = functions
            .filterEventsForDay(
                _model.calendarQueryResult!.toList(), _model.dayStart!)
            .toList()
            .cast<CalendarEventsRecord>();
        safeSetState(() {});
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthUserStreamWidget(
      builder: (context) => StreamBuilder<List<CalendarEventsRecord>>(
        stream: queryCalendarEventsRecord(
          queryBuilder: (calendarEventsRecord) => calendarEventsRecord
              .where(
                'relationship_id',
                isEqualTo:
                    valueOrDefault(currentUserDocument?.relationshipId, ''),
              )
              .where(
                'start',
                isGreaterThanOrEqualTo: _model.dayStart,
              )
              .where(
                'start',
                isLessThan: _model.dayEnd,
              )
              .orderBy('start'),
        ),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                ),
              ),
            );
          }
          List<CalendarEventsRecord> calenderPageCalendarEventsRecordList =
              snapshot.data!;

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              key: scaffoldKey,
              body: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.asset(
                      'assets/images/background_calendar.webp',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0x101D1C1C),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                      child: SingleChildScrollView(
                        controller: _model.columnController1,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30.0,
                                borderWidth: 1.0,
                                buttonSize: 60.0,
                                icon: Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                                onPressed: () async {
                                  if (Navigator.of(context).canPop()) {
                                    context.pop();
                                  }
                                  context.pushNamed(
                                    HomeWidget.routeName,
                                    extra: <String, dynamic>{
                                      '__transition_info__': TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                      ),
                                    },
                                  );
                                },
                              ),
                            ),
                            Text(
                              FFLocalizations.of(context).getText(
                                'kch0xqqn' /* Shared Calendar */,
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .headlineLarge
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineLarge
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF9B7CB8),
                                    fontSize: 28.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineLarge
                                        .fontStyle,
                                  ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'ksjgorwh' /* Plan or inform together */,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.normal,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: Container(
                                      width: 56.0,
                                      height: 56.0,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 6.0,
                                            color: Color(0x1ADE8BA6),
                                            offset: Offset(
                                              0.0,
                                              2.0,
                                            ),
                                          )
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFB8A9DA),
                                            Color(0xFFDE8BA6)
                                          ],
                                          stops: [0.8, 1.0],
                                          begin:
                                              AlignmentDirectional(1.0, -1.0),
                                          end: AlignmentDirectional(-1.0, 1.0),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(28.0),
                                      ),
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  useSafeArea: true,
                                                  context: context,
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        FocusManager.instance
                                                            .primaryFocus
                                                            ?.unfocus();
                                                      },
                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child: Container(
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.9,
                                                          child:
                                                              EventSheetWidget(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));
                                              },
                                              child: Icon(
                                                Icons.add_rounded,
                                                color: Colors.white,
                                                size: 24.0,
                                              ),
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'lmsu6q7g' /* Add */,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color: Colors.white,
                                                        fontSize: 10.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 8.0)),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 22.0,
                                  sigmaY: 22.0,
                                ),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  decoration: BoxDecoration(
                                    color: Color(0x194220E1),
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(
                                      color: Color(0x34FFFFFF),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      SingleChildScrollView(
                                        controller: _model.columnController2,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            FlutterFlowCalendar(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              iconColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              weekFormat: false,
                                              weekStartsMonday: true,
                                              initialDate: _model.calendarDate,
                                              rowHeight: 48.0,
                                              onChange: (DateTimeRange?
                                                  newSelectedDate) async {
                                                if (_model
                                                        .calendarSelectedDay ==
                                                    newSelectedDate) {
                                                  return;
                                                }
                                                _model.calendarSelectedDay =
                                                    newSelectedDate;
                                                _model.selectedDay = _model
                                                    .calendarSelectedDay?.start;
                                                _model.dayStart =
                                                    functions.startOfDayUtc(
                                                        _model.selectedDay!);
                                                safeSetState(() {});
                                                _model.calendarQueryResult2 =
                                                    await queryCalendarEventsRecordOnce(
                                                  queryBuilder:
                                                      (calendarEventsRecord) =>
                                                          calendarEventsRecord
                                                              .where(
                                                                'relationship_id',
                                                                isEqualTo: valueOrDefault(
                                                                    currentUserDocument
                                                                        ?.relationshipId,
                                                                    ''),
                                                              )
                                                              .orderBy('start'),
                                                );
                                                _model.eventsForDay = functions
                                                    .filterEventsForDay(
                                                        _model
                                                            .calendarQueryResult2!
                                                            .toList(),
                                                        _model.dayStart!)
                                                    .toList()
                                                    .cast<
                                                        CalendarEventsRecord>();
                                                safeSetState(() {});
                                                _model.partnerList =
                                                    await queryUsersRecordOnce(
                                                  queryBuilder: (usersRecord) =>
                                                      usersRecord
                                                          .where(
                                                            'relationship_id',
                                                            isEqualTo: valueOrDefault(
                                                                currentUserDocument
                                                                    ?.relationshipId,
                                                                ''),
                                                          )
                                                          .where(
                                                            'uid',
                                                            isNotEqualTo:
                                                                currentUserUid,
                                                          ),
                                                );
                                                _model.partnerUserData = _model
                                                    .partnerList?.firstOrNull;
                                                safeSetState(() {});
                                                _model.selectedDay =
                                                    _model.selectedDay;
                                                _model.calendarDate =
                                                    _model.selectedDay;
                                                _model.dayStart =
                                                    functions.startOfDayUtc(
                                                        _model.selectedDay!);
                                                _model.dayEnd =
                                                    functions.startOfNextDayUtc(
                                                        _model.selectedDay!);
                                                safeSetState(() {});
                                                safeSetState(() {});
                                              },
                                              titleStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .titleLarge
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleLargeFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .titleLargeIsCustom,
                                                  ),
                                              dayOfWeekStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLargeFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyLargeIsCustom,
                                                      ),
                                              dateStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                              selectedDateStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmallFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleSmallIsCustom,
                                                      ),
                                              inactiveDateStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMediumFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMediumIsCustom,
                                                      ),
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Builder(
                                              builder: (context) {
                                                final events = _model
                                                    .eventsForDay
                                                    .toList();

                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: events.length,
                                                  itemBuilder:
                                                      (context, eventsIndex) {
                                                    final eventsItem =
                                                        events[eventsIndex];
                                                    return Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  20.0),
                                                      child: StreamBuilder<
                                                          List<
                                                              RelationshipViewsRecord>>(
                                                        stream:
                                                            queryRelationshipViewsRecord(
                                                          queryBuilder:
                                                              (relationshipViewsRecord) =>
                                                                  relationshipViewsRecord
                                                                      .where(
                                                            'relationship_id',
                                                            isEqualTo: valueOrDefault(
                                                                currentUserDocument
                                                                    ?.relationshipId,
                                                                ''),
                                                          ),
                                                          singleRecord: true,
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  valueColor:
                                                                      AlwaysStoppedAnimation<
                                                                          Color>(
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<RelationshipViewsRecord>
                                                              containerRelationshipViewsRecordList =
                                                              snapshot.data!;
                                                          final containerRelationshipViewsRecord =
                                                              containerRelationshipViewsRecordList
                                                                      .isNotEmpty
                                                                  ? containerRelationshipViewsRecordList
                                                                      .first
                                                                  : null;

                                                          return Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0x194220E1),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius:
                                                                      12.0,
                                                                  color: Color(
                                                                      0x33E1BEE7),
                                                                  offset:
                                                                      Offset(
                                                                    0.0,
                                                                    4.0,
                                                                  ),
                                                                  spreadRadius:
                                                                      0.0,
                                                                )
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                width: 0.5,
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            6.0,
                                                                            12.0,
                                                                            6.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                valueOrDefault<Color>(
                                                                              functions.categoryColorFromKey(eventsItem.categoryKey),
                                                                              FlutterFlowTheme.of(context).secondary,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(16.0),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
                                                                              functions.categoryLabelFromKey(eventsItem.categoryKey),
                                                                              style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).labelSmallFamily,
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    fontSize: 11.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    useGoogleFonts: !FlutterFlowTheme.of(context).labelSmallIsCustom,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    if (eventsItem
                                                                            .createdBy ==
                                                                        currentUserUid)
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            12.0,
                                                                            6.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.transparent,
                                                                          ),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                48.0,
                                                                            height:
                                                                                48.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              borderRadius: BorderRadius.circular(24.0),
                                                                              border: Border.all(
                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                width: 1.0,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(24.0),
                                                                              child: Image.network(
                                                                                containerRelationshipViewsRecord!.myPhotoUrl,
                                                                                width: 48.0,
                                                                                height: 48.0,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    if (eventsItem
                                                                            .createdBy !=
                                                                        currentUserUid)
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            12.0,
                                                                            6.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.transparent,
                                                                          ),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                48.0,
                                                                            height:
                                                                                48.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              borderRadius: BorderRadius.circular(24.0),
                                                                              border: Border.all(
                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                width: 1.0,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(24.0),
                                                                              child: Image.network(
                                                                                containerRelationshipViewsRecord!.partnerPhotoUrl,
                                                                                width: 48.0,
                                                                                height: 48.0,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Align(
                                                                      alignment: AlignmentDirectional(
                                                                          -1.0,
                                                                          -1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            6.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .place,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).alternate,
                                                                          size:
                                                                              16.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                      child:
                                                                          Text(
                                                                        eventsItem
                                                                            .location
                                                                            .maybeHandleOverflow(
                                                                          maxChars:
                                                                              20,
                                                                        ),
                                                                        maxLines:
                                                                            2,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          8.0)),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          20.0,
                                                                          20.0,
                                                                          20.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          if (eventsItem.allDay ==
                                                                              false)
                                                                            Align(
                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                              child: Text(
                                                                                dateTimeFormat(
                                                                                  "MMM d, y • h:mm a",
                                                                                  eventsItem.start!,
                                                                                  locale: FFLocalizations.of(context).languageCode,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      letterSpacing: 0.0,
                                                                                      useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          if (eventsItem.allDay ==
                                                                              false)
                                                                            Align(
                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                              child: Text(
                                                                                dateTimeFormat(
                                                                                  "MMM d, y • h:mm a",
                                                                                  eventsItem.end!,
                                                                                  locale: FFLocalizations.of(context).languageCode,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      letterSpacing: 0.0,
                                                                                      useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children:
                                                                            [
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  eventsItem.title.maybeHandleOverflow(
                                                                                    maxChars: 25,
                                                                                    replacement: '…',
                                                                                  ),
                                                                                  textAlign: TextAlign.start,
                                                                                  maxLines: 2,
                                                                                  style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        fontSize: 18.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).titleLargeIsCustom,
                                                                                      ),
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    if (eventsItem.allDay == true)
                                                                                      Text(
                                                                                        dateTimeFormat(
                                                                                          "MMM d, y",
                                                                                          eventsItem.start!,
                                                                                          locale: FFLocalizations.of(context).languageCode,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                              letterSpacing: 0.0,
                                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                            ),
                                                                                      ),
                                                                                    if (eventsItem.allDay == true)
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(4.0, 8.0, 4.0, 8.0),
                                                                                        child: Container(
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).alternate,
                                                                                            borderRadius: BorderRadius.circular(12.0),
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.all(8.0),
                                                                                            child: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'wgi2p6k3' /* All Day */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                                    fontFamily: FlutterFlowTheme.of(context).labelSmallFamily,
                                                                                                    color: Color(0xFF7B1FA2),
                                                                                                    fontSize: 10.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    useGoogleFonts: !FlutterFlowTheme.of(context).labelSmallIsCustom,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                  ].divide(SizedBox(width: 8.0)),
                                                                                ),
                                                                              ].divide(SizedBox(height: 4.0)),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 8.0)),
                                                                      ),
                                                                      Text(
                                                                        eventsItem
                                                                            .note,
                                                                        maxLines:
                                                                            4,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                            ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            12.0)),
                                                                  ),
                                                                ),
                                                                if (eventsItem
                                                                        .createdBy ==
                                                                    currentUserUid)
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            1.0,
                                                                            0.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          10.0,
                                                                          10.0),
                                                                      child:
                                                                          InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          var confirmDialogResponse = await showDialog<bool>(
                                                                                context: context,
                                                                                builder: (alertDialogContext) {
                                                                                  return AlertDialog(
                                                                                    title: Text('Delete wish?'),
                                                                                    content: Text('Do you want to delete your wish?'),
                                                                                    actions: [
                                                                                      TextButton(
                                                                                        onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                        child: Text('No'),
                                                                                      ),
                                                                                      TextButton(
                                                                                        onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                        child: Text('Yes'),
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                },
                                                                              ) ??
                                                                              false;
                                                                          if (confirmDialogResponse) {
                                                                            await eventsItem.reference.delete();
                                                                            try {
                                                                              final result = await FirebaseFunctions.instanceFor(region: 'europe-west3').httpsCallable('syncLoveBuddyTravelState').call({
                                                                                "relationshipId": containerRelationshipViewsRecord?.relationshipId,
                                                                              });
                                                                              _model.sync = SyncLoveBuddyTravelStateCloudFunctionCallResponse(
                                                                                succeeded: true,
                                                                              );
                                                                            } on FirebaseFunctionsException catch (error) {
                                                                              _model.sync = SyncLoveBuddyTravelStateCloudFunctionCallResponse(
                                                                                errorCode: error.code,
                                                                                succeeded: false,
                                                                              );
                                                                            }

                                                                            _model.removeAtIndexFromEventsForDay(eventsIndex);
                                                                            safeSetState(() {});
                                                                            if (valueOrDefault(currentUserDocument?.appLanguage, '') ==
                                                                                'en') {
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  content: Text(
                                                                                    'Deleted ✅',
                                                                                    style: TextStyle(
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                    ),
                                                                                  ),
                                                                                  duration: Duration(milliseconds: 4000),
                                                                                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                ),
                                                                              );
                                                                            } else if (valueOrDefault(currentUserDocument?.appLanguage, '') ==
                                                                                'de') {
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  content: Text(
                                                                                    'Gelöscht ✅',
                                                                                    style: TextStyle(
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                    ),
                                                                                  ),
                                                                                  duration: Duration(milliseconds: 4000),
                                                                                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                ),
                                                                              );
                                                                            } else if (valueOrDefault(currentUserDocument?.appLanguage, '') ==
                                                                                'es') {
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  content: Text(
                                                                                    'Eliminado ✅',
                                                                                    style: TextStyle(
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                    ),
                                                                                  ),
                                                                                  duration: Duration(milliseconds: 4000),
                                                                                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                ),
                                                                              );
                                                                            }
                                                                          }

                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        child:
                                                                            FaIcon(
                                                                          FontAwesomeIcons
                                                                              .solidTrashAlt,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).error,
                                                                          size:
                                                                              15.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .transparent,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  controller: _model
                                                      .listViewController1,
                                                );
                                              },
                                            ),
                                          ].divide(SizedBox(height: 16.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 290.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        FlutterFlowTheme.of(context).primary,
                                        FlutterFlowTheme.of(context).tertiary
                                      ],
                                      stops: [0.0, 1.0],
                                      begin: AlignmentDirectional(0.0, -1.0),
                                      end: AlignmentDirectional(0, 1.0),
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'teua2rw1' /* Upcoming • next 14 days */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 12.0)),
                                  ),
                                ),
                              ],
                            ),
                            StreamBuilder<List<CalendarEventsRecord>>(
                              stream: queryCalendarEventsRecord(
                                queryBuilder: (calendarEventsRecord) =>
                                    calendarEventsRecord
                                        .where(
                                          'relationship_id',
                                          isEqualTo: valueOrDefault(
                                              currentUserDocument
                                                  ?.relationshipId,
                                              ''),
                                        )
                                        .where(
                                          'start',
                                          isGreaterThanOrEqualTo:
                                              _model.upStart,
                                        )
                                        .where(
                                          'start',
                                          isLessThan: _model.upEnd,
                                        )
                                        .orderBy('start'),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<CalendarEventsRecord>
                                    listViewCalendarEventsRecordList =
                                    snapshot.data!;

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      listViewCalendarEventsRecordList.length,
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewCalendarEventsRecord =
                                        listViewCalendarEventsRecordList[
                                            listViewIndex];
                                    return Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: StreamBuilder<
                                          List<RelationshipViewsRecord>>(
                                        stream: queryRelationshipViewsRecord(
                                          queryBuilder:
                                              (relationshipViewsRecord) =>
                                                  relationshipViewsRecord.where(
                                            'relationship_id',
                                            isEqualTo: valueOrDefault(
                                                currentUserDocument
                                                    ?.relationshipId,
                                                ''),
                                          ),
                                          singleRecord: true,
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          List<RelationshipViewsRecord>
                                              containerRelationshipViewsRecordList =
                                              snapshot.data!;
                                          final containerRelationshipViewsRecord =
                                              containerRelationshipViewsRecordList
                                                      .isNotEmpty
                                                  ? containerRelationshipViewsRecordList
                                                      .first
                                                  : null;

                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                    sigmaX: 22.0,
                                                    sigmaY: 22.0,
                                                  ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0x194220E1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                      border: Border.all(
                                                        color:
                                                            Color(0x34FFFFFF),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(12.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                _model.selectedDay =
                                                                    functions.startOfDayLocal(
                                                                        listViewCalendarEventsRecord
                                                                            .start);
                                                                _model.dayStart =
                                                                    functions.startOfDayUtc(
                                                                        _model
                                                                            .selectedDay!);
                                                                _model.dayEnd =
                                                                    functions.startOfNextDayUtc(
                                                                        _model
                                                                            .selectedDay!);
                                                                _model.calendarDate =
                                                                    listViewCalendarEventsRecord
                                                                        .start;
                                                                safeSetState(
                                                                    () {});
                                                                await _model
                                                                    .listViewController1
                                                                    ?.animateTo(
                                                                  0,
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          100),
                                                                  curve: Curves
                                                                      .ease,
                                                                );
                                                              },
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              6.0,
                                                                              12.0,
                                                                              6.0,
                                                                              0.0),
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: valueOrDefault<Color>(
                                                                                functions.categoryColorFromKey(listViewCalendarEventsRecord.categoryKey),
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                functions.categoryLabelFromKey(listViewCalendarEventsRecord.categoryKey),
                                                                                style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).labelSmallFamily,
                                                                                      color: Colors.white,
                                                                                      fontSize: 11.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      useGoogleFonts: !FlutterFlowTheme.of(context).labelSmallIsCustom,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      if (listViewCalendarEventsRecord
                                                                              .createdBy ==
                                                                          currentUserUid)
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              12.0,
                                                                              6.0,
                                                                              0.0),
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.transparent,
                                                                            ),
                                                                            child:
                                                                                Container(
                                                                              width: 48.0,
                                                                              height: 48.0,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                borderRadius: BorderRadius.circular(24.0),
                                                                                border: Border.all(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                  width: 1.0,
                                                                                ),
                                                                              ),
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(24.0),
                                                                                child: Image.network(
                                                                                  containerRelationshipViewsRecord!.myPhotoUrl,
                                                                                  width: 48.0,
                                                                                  height: 48.0,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      if (listViewCalendarEventsRecord
                                                                              .createdBy !=
                                                                          currentUserUid)
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              12.0,
                                                                              6.0,
                                                                              0.0),
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.transparent,
                                                                            ),
                                                                            child:
                                                                                Container(
                                                                              width: 48.0,
                                                                              height: 48.0,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                borderRadius: BorderRadius.circular(24.0),
                                                                                border: Border.all(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                  width: 1.0,
                                                                                ),
                                                                              ),
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(24.0),
                                                                                child: Image.network(
                                                                                  containerRelationshipViewsRecord!.partnerPhotoUrl,
                                                                                  width: 48.0,
                                                                                  height: 48.0,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      if (!listViewCalendarEventsRecord
                                                                          .allDay)
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            '7m981rwu' /* Start:  */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                letterSpacing: 0.0,
                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                              ),
                                                                        ),
                                                                      if (listViewCalendarEventsRecord
                                                                              .allDay ==
                                                                          false)
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            dateTimeFormat(
                                                                              "MMM d, y • h:mm a",
                                                                              listViewCalendarEventsRecord.start!,
                                                                              locale: FFLocalizations.of(context).languageCode,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  letterSpacing: 0.0,
                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      if (!listViewCalendarEventsRecord
                                                                          .allDay)
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            '4f5et1ws' /* End:  */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                letterSpacing: 0.0,
                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                              ),
                                                                        ),
                                                                      if (listViewCalendarEventsRecord
                                                                              .allDay ==
                                                                          false)
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            dateTimeFormat(
                                                                              "MMM d, y • h:mm a",
                                                                              listViewCalendarEventsRecord.end!,
                                                                              locale: FFLocalizations.of(context).languageCode,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  letterSpacing: 0.0,
                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                  if (listViewCalendarEventsRecord
                                                                          .allDay ==
                                                                      true)
                                                                    Text(
                                                                      dateTimeFormat(
                                                                        "MMM d, y",
                                                                        listViewCalendarEventsRecord
                                                                            .start!,
                                                                        locale:
                                                                            FFLocalizations.of(context).languageCode,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                          ),
                                                                    ),
                                                                  Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      listViewCalendarEventsRecord
                                                                          .title,
                                                                      'Title',
                                                                    ).maybeHandleOverflow(
                                                                      maxChars:
                                                                          25,
                                                                    ),
                                                                    maxLines: 2,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                        ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .place,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        size:
                                                                            14.0,
                                                                      ),
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          listViewCalendarEventsRecord
                                                                              .location,
                                                                          'Location',
                                                                        ).maybeHandleOverflow(
                                                                          maxChars:
                                                                              20,
                                                                          replacement:
                                                                              '…',
                                                                        ),
                                                                        maxLines:
                                                                            2,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).labelSmallFamily,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).labelSmallIsCustom,
                                                                            ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            6.0)),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    height:
                                                                        4.0)),
                                                              ),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 12.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  controller: _model.listViewController2,
                                );
                              },
                            ),
                          ]
                              .divide(SizedBox(height: 24.0))
                              .addToStart(SizedBox(height: 16.0))
                              .addToEnd(SizedBox(height: 100.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
