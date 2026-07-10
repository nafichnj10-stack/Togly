import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/components/g_p_s_sheet/g_p_s_sheet_widget.dart';
import '/components/header_couple/header_couple_widget.dart';
import '/components/header_reconnect/header_reconnect_widget.dart';
import '/components/header_single/header_single_widget.dart';
import '/components/pair_required_sheet/pair_required_sheet_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'home_model.dart';
export 'home_model.dart';

/// Create a mobile Home screen (connected state) for a romantic couples app.
///
/// Use Stack: full-screen background image (cover). Foreground: SafeArea +
/// SingleChildScrollView + centered Column (padding 24, spacing 24).
///
/// Top section: Row with left and right circular profile avatars and centered
/// Column with title “Anna & Max” and small subtext (city, distance,
/// countdown). Add small heart icon between avatars.
///
/// Below add 3 rounded glass-style cards (radius 24, semi-transparent, thin
/// white border, soft shadow).
///
/// Card 1: “LoveBuddy”, image placeholder, small progress pill “3/5 love
/// today”, button “Open LoveBuddy”.
/// Card 2: “Heartbeat”, subtitle “Share your mood”, status text, button “View
/// moods”.
/// Card 3: “LoveTreasure”, subtitle “Create a surprise”, button “Prepare
/// surprise”.
///
/// White text, modern, clean spacing, no overflow.
class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  static String routeName = 'home';
  static String routePath = '/home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'home'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (valueOrDefault<bool>(
              currentUserDocument?.onboardingCompleted, false) ==
          false) {
        context.goNamed(
          GatePageWidget.routeName,
          extra: <String, dynamic>{
            '__transition_info__': TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );
      } else {
        _model.isLoading = true;
        safeSetState(() {});
        _model.homeMode = 'loading';
        try {
          final result =
              await FirebaseFunctions.instanceFor(region: 'europe-west3')
                  .httpsCallable('resolveHomeState')
                  .call({
            "tzOffsetMinutes": functions.deviceOffsetMinutes(),
          });
          _model.resolveHomeState = ResolveHomeStateCloudFunctionCallResponse(
            data: CFSyncHomeSnapshotResultStruct.fromMap(result.data),
            succeeded: true,
            resultAsString: result.data.toString(),
            jsonBody: result.data,
          );
        } on FirebaseFunctionsException catch (error) {
          _model.resolveHomeState = ResolveHomeStateCloudFunctionCallResponse(
            errorCode: error.code,
            succeeded: false,
          );
        }

        _model.homeMode = _model.resolveHomeState?.data?.homeMode;
        _model.isSingleMode =
            _model.resolveHomeState?.data?.homeMode == 'single_demo';
        _model.isReconnectMode =
            _model.resolveHomeState?.data?.homeMode == 'reconnect_pending';
        _model.activeRelationshipId =
            _model.resolveHomeState?.data?.relationshipId;
        _model.restoreRelationshipId =
            _model.resolveHomeState?.data?.restoreRelationshipId;
        _model.restoreState = _model.resolveHomeState?.data?.restoreState;
        safeSetState(() {});
        _model.isLoading = false;
        safeSetState(() {});
        if (_model.homeMode == 'couple') {
          _model.queried = await queryRelationshipsRecordOnce(
            queryBuilder: (relationshipsRecord) => relationshipsRecord.where(
              'relationship_id',
              isEqualTo: _model.resolveHomeState?.data?.relationshipId,
            ),
            singleRecord: true,
          ).then((s) => s.firstOrNull);
          _model.currentRelationshipRef = _model.queried?.reference;
          safeSetState(() {});
          if (_model.resolveHomeState?.data?.hasActiveRelationship == true) {
            try {
              final result =
                  await FirebaseFunctions.instanceFor(region: 'europe-west3')
                      .httpsCallable('sendEmotionCheckIn')
                      .call({
                "mode": 'status',
                "choice": '',
              });
              _model.cloudFunctionuex =
                  SendEmotionCheckInCloudFunctionCallResponse(
                data: CFEmotionResultStruct.fromMap(result.data),
                succeeded: true,
                resultAsString: result.data.toString(),
                jsonBody: result.data,
              );
            } on FirebaseFunctionsException catch (error) {
              _model.cloudFunctionuex =
                  SendEmotionCheckInCloudFunctionCallResponse(
                errorCode: error.code,
                succeeded: false,
              );
            }

            _model.emotionState = _model.cloudFunctionuex?.data?.state;
            _model.emotionStatusText =
                _model.cloudFunctionuex?.data?.statusText;
            _model.emotionSummary = _model.cloudFunctionuex?.data?.summaryText;
            _model.emotionMyChoice = _model.cloudFunctionuex?.data?.myChoice;
            _model.emotionPartnerChoice =
                _model.cloudFunctionuex?.data?.partnerChoice;
            _model.emotionCooldownUntil =
                _model.cloudFunctionuex?.data?.cooldownUntilMs;
            safeSetState(() {});
          } else {
            await Future.delayed(
              Duration(
                milliseconds: 150,
              ),
            );
          }

          if ((valueOrDefault<bool>(
                      currentUserDocument?.celebrateReconnect, false) ==
                  true) &&
              (valueOrDefault(currentUserDocument?.relationshipId, '') !=
                      '')) {
            await Future.delayed(
              Duration(
                milliseconds: 300,
              ),
            );

            context.goNamed(
              CelebrateWidget.routeName,
              extra: <String, dynamic>{
                '__transition_info__': TransitionInfo(
                  hasTransition: true,
                  transitionType: PageTransitionType.fade,
                ),
              },
            );
          } else {
            _model.isLoading = false;
            safeSetState(() {});
          }

          _model.gpsdata = await queryRelationshipViewsRecordOnce(
            queryBuilder: (relationshipViewsRecord) =>
                relationshipViewsRecord.where(
              'uid',
              isEqualTo: currentUserUid,
            ),
            singleRecord: true,
          ).then((s) => s.firstOrNull);
          if ((_model.gpsdata?.widgetState == 'travel_upcoming') &&
              (currentUserUid == _model.gpsdata?.widgetTravelerUid) &&
              (_model.gpsdata?.widgetTravelEventId !=
                  _model.gpsdata?.liveTravelTrackingPromptEventId)) {
            await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              enableDrag: false,
              context: context,
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Padding(
                    padding: MediaQuery.viewInsetsOf(context),
                    child: GPSSheetWidget(),
                  ),
                );
              },
            ).then((value) => safeSetState(() {}));
          } else {
            await Future.delayed(
              Duration(
                milliseconds: 120,
              ),
            );
          }

          if ((_model.gpsdata?.widgetState == 'traveling') &&
              (currentUserUid == _model.gpsdata?.widgetTravelerUid) &&
              (_model.gpsdata?.liveTravelTrackingEnabled == true)) {
            await actions.sendLoveBuddyLiveLocationOnce(
              valueOrDefault(currentUserDocument?.relationshipId, ''),
            );
          }
        }
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0x35000000),
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/background_main_home1.webp',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    SafeArea(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              StreamBuilder<List<PublicUsersRecord>>(
                                stream: queryPublicUsersRecord(
                                  queryBuilder: (publicUsersRecord) =>
                                      publicUsersRecord.where(
                                    'uid',
                                    isEqualTo: currentUserUid,
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
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  List<PublicUsersRecord>
                                      columnPublicUsersRecordList =
                                      snapshot.data!;
                                  final columnPublicUsersRecord =
                                      columnPublicUsersRecordList.isNotEmpty
                                          ? columnPublicUsersRecordList.first
                                          : null;

                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if ((_model.homeMode == 'couple') &&
                                          (_model.isLoading == false))
                                        StreamBuilder<
                                            List<RelationshipViewsRecord>>(
                                          stream: queryRelationshipViewsRecord(
                                            queryBuilder:
                                                (relationshipViewsRecord) =>
                                                    relationshipViewsRecord
                                                        .where(
                                              'uid',
                                              isEqualTo: currentUserUid,
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
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            List<RelationshipViewsRecord>
                                                headerCoupleRelationshipViewsRecordList =
                                                snapshot.data!;
                                            final headerCoupleRelationshipViewsRecord =
                                                headerCoupleRelationshipViewsRecordList
                                                        .isNotEmpty
                                                    ? headerCoupleRelationshipViewsRecordList
                                                        .first
                                                    : null;

                                            return wrapWithModel(
                                              model: _model.headerCoupleModel,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: HeaderCoupleWidget(
                                                myIsSleeping:
                                                    headerCoupleRelationshipViewsRecord
                                                        ?.mySleepStatus,
                                                myMood:
                                                    headerCoupleRelationshipViewsRecord
                                                        ?.myMood,
                                                silentStatus:
                                                    _model.silentStatus,
                                                silentStatusText:
                                                    _model.silentStatusText,
                                                partnerPhotoUrl:
                                                    headerCoupleRelationshipViewsRecord
                                                        ?.partnerPhotoUrl,
                                                partnerIsSleeping:
                                                    headerCoupleRelationshipViewsRecord
                                                        ?.partnerSleepStatus,
                                                partnerMood:
                                                    headerCoupleRelationshipViewsRecord
                                                        ?.partnerMood,
                                                partnerName:
                                                    headerCoupleRelationshipViewsRecord
                                                        ?.partnerName,
                                                partnerTimezoneOffsetMinutes:
                                                    headerCoupleRelationshipViewsRecord
                                                        ?.partnerTzOffsetMinutes,
                                                partnerCity:
                                                    headerCoupleRelationshipViewsRecord
                                                        ?.partnerCity,
                                                myTimezoneOffsetMinutes:
                                                    headerCoupleRelationshipViewsRecord
                                                        ?.myTzOffsetMinutes,
                                                mySleepStartedAt:
                                                    headerCoupleRelationshipViewsRecord
                                                        ?.mySleepStartedAt,
                                                partnerSleepStartedAt:
                                                    headerCoupleRelationshipViewsRecord
                                                        ?.partnerSleepStartedAt,
                                              ),
                                            );
                                          },
                                        ),
                                      if ((_model.homeMode ==
                                              'reconnect_pending') &&
                                          (_model.isLoading == false))
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 24.0, 24.0, 24.0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 351.1,
                                            decoration: BoxDecoration(
                                              color: Color(0x002D1F3D),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 12.0,
                                                  color: Color(0x1A000000),
                                                  offset: Offset(
                                                    0.0,
                                                    2.0,
                                                  ),
                                                  spreadRadius: 0.0,
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                wrapWithModel(
                                                  model: _model
                                                      .headerReconnectModel,
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child:
                                                      HeaderReconnectWidget(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      if ((_model.homeMode == 'single_demo') &&
                                          (_model.isLoading == false))
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 24.0, 24.0, 24.0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 349.0,
                                            decoration: BoxDecoration(
                                              color: Color(0x002D1F3D),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 12.0,
                                                  color: Color(0x1A000000),
                                                  offset: Offset(
                                                    0.0,
                                                    2.0,
                                                  ),
                                                  spreadRadius: 0.0,
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                wrapWithModel(
                                                  model:
                                                      _model.headerSingleModel,
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child: HeaderSingleWidget(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 280.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      image: Image.asset(
                                        'assets/images/card_back_com.webp',
                                      ).image,
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(32.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 200.0,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'mvyjb1lb' /* Couples 
Around the World 🌍 */
                                                            ,
                                                          ),
                                                          maxLines: 2,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                lineHeight:
                                                                    1.25,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineMediumIsCustom,
                                                              ),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
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
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .favorite_rounded,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                size: 18.0,
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'p3dh5cx8' /* Together
Across Borders. */
                                                                    ,
                                                                  ),
                                                                  maxLines: 2,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontSize:
                                                                            11.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        lineHeight:
                                                                            1.47,
                                                                        useGoogleFonts:
                                                                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                      ),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 8.0)),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .favorite_rounded,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                size: 18.0,
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    '07iyyo22' /* Love 
connects us all. */
                                                                    ,
                                                                  ),
                                                                  maxLines: 2,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontSize:
                                                                            11.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        lineHeight:
                                                                            1.47,
                                                                        useGoogleFonts:
                                                                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                      ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 8.0)),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 16.0)),
                                                      ),
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          context.pushNamed(
                                                            CommunityWidget
                                                                .routeName,
                                                            extra: <String,
                                                                dynamic>{
                                                              '__transition_info__':
                                                                  TransitionInfo(
                                                                hasTransition:
                                                                    true,
                                                                transitionType:
                                                                    PageTransitionType
                                                                        .fade,
                                                              ),
                                                            },
                                                          );
                                                        },
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          '7b2gnwtt' /* Explore the Community */,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          height: 30.0,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color:
                                                              Color(0xFF8A75BA),
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .titleSmallIsCustom,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 10.0)),
                                                  ),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 24.0)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (_model.isLoading == false)
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          StreamBuilder<
                                              List<RelationshipViewsRecord>>(
                                            stream:
                                                queryRelationshipViewsRecord(
                                              queryBuilder:
                                                  (relationshipViewsRecord) =>
                                                      relationshipViewsRecord
                                                          .where(
                                                'uid',
                                                isEqualTo: currentUserUid,
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
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              List<RelationshipViewsRecord>
                                                  stackRelationshipViewsRecordList =
                                                  snapshot.data!;
                                              final stackRelationshipViewsRecord =
                                                  stackRelationshipViewsRecordList
                                                          .isNotEmpty
                                                      ? stackRelationshipViewsRecordList
                                                          .first
                                                      : null;

                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  if (_model.homeMode ==
                                                      'couple') {
                                                    context.pushNamed(
                                                      PetsHomeWidget.routeName,
                                                      extra: <String, dynamic>{
                                                        '__transition_info__':
                                                            TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType:
                                                              PageTransitionType
                                                                  .fade,
                                                        ),
                                                      },
                                                    );
                                                  } else {
                                                    await showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      enableDrag: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus();
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          child: Padding(
                                                            padding: MediaQuery
                                                                .viewInsetsOf(
                                                                    context),
                                                            child:
                                                                PairRequiredSheetWidget(),
                                                          ),
                                                        );
                                                      },
                                                    ).then((value) =>
                                                        safeSetState(() {}));
                                                  }
                                                },
                                                child: Stack(
                                                  children: [
                                                    if (stackRelationshipViewsRecord
                                                            ?.loveState ==
                                                        'happy')
                                                      InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          context.pushNamed(
                                                            PetsHomeWidget
                                                                .routeName,
                                                            extra: <String,
                                                                dynamic>{
                                                              '__transition_info__':
                                                                  TransitionInfo(
                                                                hasTransition:
                                                                    true,
                                                                transitionType:
                                                                    PageTransitionType
                                                                        .fade,
                                                              ),
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 300.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x33FFFFFF),
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  Image.asset(
                                                                'assets/images/happy.webp',
                                                              ).image,
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius:
                                                                    20.0,
                                                                color: Color(
                                                                    0x33000000),
                                                                offset: Offset(
                                                                  0.0,
                                                                  8.0,
                                                                ),
                                                              )
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24.0),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0x66FFFFFF),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Expanded(
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          1.0),
                                                                  child: Stack(
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              10.0,
                                                                              10.0,
                                                                              12.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              'ooxgm4pt' /* Our Companions */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                  letterSpacing: 0.0,
                                                                                  shadows: [
                                                                                    Shadow(
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      offset: Offset(2.0, 2.0),
                                                                                      blurRadius: 2.0,
                                                                                    )
                                                                                  ],
                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              35.0),
                                                                          child:
                                                                              LinearPercentIndicator(
                                                                            percent:
                                                                                stackRelationshipViewsRecord!.lovePercent,
                                                                            lineHeight:
                                                                                25.0,
                                                                            animation:
                                                                                true,
                                                                            animateFromLastPercent:
                                                                                true,
                                                                            progressColor:
                                                                                FlutterFlowTheme.of(context).tertiary,
                                                                            backgroundColor:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                            center:
                                                                                Text(
                                                                              stackRelationshipViewsRecord.loveScore.toString(),
                                                                              style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).headlineSmallFamily,
                                                                                    letterSpacing: 0.0,
                                                                                    useGoogleFonts: !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                                                                                  ),
                                                                            ),
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              18.0),
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              'ise9790g' /* Bond Points collected today: */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                  fontSize: 14.0,
                                                                                  letterSpacing: 0.0,
                                                                                  shadows: [
                                                                                    Shadow(
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      offset: Offset(2.0, 2.0),
                                                                                      blurRadius: 2.0,
                                                                                    )
                                                                                  ],
                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            1.0),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            stackRelationshipViewsRecord.loveTodayPoints.toString(),
                                                                            'Score',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 14.0,
                                                                                letterSpacing: 0.0,
                                                                                shadows: [
                                                                                  Shadow(
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    offset: Offset(2.0, 2.0),
                                                                                    blurRadius: 2.0,
                                                                                  )
                                                                                ],
                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    if (stackRelationshipViewsRecord
                                                            ?.loveState ==
                                                        'sad')
                                                      InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          context.pushNamed(
                                                            PetsHomeWidget
                                                                .routeName,
                                                            extra: <String,
                                                                dynamic>{
                                                              '__transition_info__':
                                                                  TransitionInfo(
                                                                hasTransition:
                                                                    true,
                                                                transitionType:
                                                                    PageTransitionType
                                                                        .fade,
                                                              ),
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 300.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x33FFFFFF),
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  Image.asset(
                                                                'assets/images/sad.webp',
                                                              ).image,
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius:
                                                                    20.0,
                                                                color: Color(
                                                                    0x33000000),
                                                                offset: Offset(
                                                                  0.0,
                                                                  8.0,
                                                                ),
                                                              )
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24.0),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0x66FFFFFF),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Expanded(
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          1.0),
                                                                  child: Stack(
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              10.0,
                                                                              10.0,
                                                                              12.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              '31yyq6wz' /* Our Companions */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                  letterSpacing: 0.0,
                                                                                  shadows: [
                                                                                    Shadow(
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      offset: Offset(2.0, 2.0),
                                                                                      blurRadius: 2.0,
                                                                                    )
                                                                                  ],
                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              35.0),
                                                                          child:
                                                                              LinearPercentIndicator(
                                                                            percent:
                                                                                stackRelationshipViewsRecord!.lovePercent,
                                                                            lineHeight:
                                                                                25.0,
                                                                            animation:
                                                                                true,
                                                                            animateFromLastPercent:
                                                                                true,
                                                                            progressColor:
                                                                                FlutterFlowTheme.of(context).tertiary,
                                                                            backgroundColor:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                            center:
                                                                                Text(
                                                                              stackRelationshipViewsRecord.loveScore.toString(),
                                                                              style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).headlineSmallFamily,
                                                                                    letterSpacing: 0.0,
                                                                                    useGoogleFonts: !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                                                                                  ),
                                                                            ),
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              18.0),
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              '97cn5zio' /* Bond Points collected today: */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                  fontSize: 14.0,
                                                                                  letterSpacing: 0.0,
                                                                                  shadows: [
                                                                                    Shadow(
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      offset: Offset(2.0, 2.0),
                                                                                      blurRadius: 2.0,
                                                                                    )
                                                                                  ],
                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            1.0),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            stackRelationshipViewsRecord.loveTodayPoints.toString(),
                                                                            'Score',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 14.0,
                                                                                letterSpacing: 0.0,
                                                                                shadows: [
                                                                                  Shadow(
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    offset: Offset(2.0, 2.0),
                                                                                    blurRadius: 2.0,
                                                                                  )
                                                                                ],
                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    if (stackRelationshipViewsRecord
                                                            ?.loveState ==
                                                        'angry')
                                                      InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          context.pushNamed(
                                                            PetsHomeWidget
                                                                .routeName,
                                                            extra: <String,
                                                                dynamic>{
                                                              '__transition_info__':
                                                                  TransitionInfo(
                                                                hasTransition:
                                                                    true,
                                                                transitionType:
                                                                    PageTransitionType
                                                                        .fade,
                                                              ),
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 300.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x33FFFFFF),
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  Image.asset(
                                                                'assets/images/angry.webp',
                                                              ).image,
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius:
                                                                    20.0,
                                                                color: Color(
                                                                    0x33000000),
                                                                offset: Offset(
                                                                  0.0,
                                                                  8.0,
                                                                ),
                                                              )
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24.0),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0x66FFFFFF),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Expanded(
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          1.0),
                                                                  child: Stack(
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              10.0,
                                                                              10.0,
                                                                              12.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              'h4xvwx66' /* Our Companions */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  letterSpacing: 0.0,
                                                                                  shadows: [
                                                                                    Shadow(
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      offset: Offset(2.0, 2.0),
                                                                                      blurRadius: 2.0,
                                                                                    )
                                                                                  ],
                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              35.0),
                                                                          child:
                                                                              LinearPercentIndicator(
                                                                            percent:
                                                                                stackRelationshipViewsRecord!.lovePercent,
                                                                            lineHeight:
                                                                                25.0,
                                                                            animation:
                                                                                true,
                                                                            animateFromLastPercent:
                                                                                true,
                                                                            progressColor:
                                                                                FlutterFlowTheme.of(context).tertiary,
                                                                            backgroundColor:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                            center:
                                                                                Text(
                                                                              stackRelationshipViewsRecord.loveScore.toString(),
                                                                              style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).headlineSmallFamily,
                                                                                    letterSpacing: 0.0,
                                                                                    useGoogleFonts: !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                                                                                  ),
                                                                            ),
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              18.0),
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              'gfs38053' /* Bond Points collected today: */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                  fontSize: 14.0,
                                                                                  letterSpacing: 0.0,
                                                                                  shadows: [
                                                                                    Shadow(
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      offset: Offset(2.0, 2.0),
                                                                                      blurRadius: 2.0,
                                                                                    )
                                                                                  ],
                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            1.0),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            stackRelationshipViewsRecord.loveTodayPoints.toString(),
                                                                            'Score',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 14.0,
                                                                                letterSpacing: 0.0,
                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    if (_model.homeMode !=
                                                        'couple')
                                                      InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            enableDrag: false,
                                                            context: context,
                                                            builder: (context) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child: Padding(
                                                                  padding: MediaQuery
                                                                      .viewInsetsOf(
                                                                          context),
                                                                  child:
                                                                      PairRequiredSheetWidget(),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));
                                                        },
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 300.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x33FFFFFF),
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  Image.asset(
                                                                'assets/images/happy.webp',
                                                              ).image,
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius:
                                                                    20.0,
                                                                color: Color(
                                                                    0x33000000),
                                                                offset: Offset(
                                                                  0.0,
                                                                  8.0,
                                                                ),
                                                              )
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24.0),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0x66FFFFFF),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Expanded(
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          1.0),
                                                                  child: Stack(
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              10.0,
                                                                              10.0,
                                                                              12.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              '4c0gag5x' /* Our Companions */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                  letterSpacing: 0.0,
                                                                                  shadows: [
                                                                                    Shadow(
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      offset: Offset(2.0, 2.0),
                                                                                      blurRadius: 2.0,
                                                                                    )
                                                                                  ],
                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              35.0),
                                                                          child:
                                                                              LinearPercentIndicator(
                                                                            percent:
                                                                                0.65,
                                                                            lineHeight:
                                                                                25.0,
                                                                            animation:
                                                                                true,
                                                                            animateFromLastPercent:
                                                                                true,
                                                                            progressColor:
                                                                                FlutterFlowTheme.of(context).tertiary,
                                                                            backgroundColor:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                            center:
                                                                                Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                'oktv6lbs' /* 65% */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).headlineSmallFamily,
                                                                                    letterSpacing: 0.0,
                                                                                    useGoogleFonts: !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                                                                                  ),
                                                                            ),
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              18.0),
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              'bltg6v9g' /* Bond Points collected today: */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                  fontSize: 14.0,
                                                                                  letterSpacing: 0.0,
                                                                                  shadows: [
                                                                                    Shadow(
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      offset: Offset(2.0, 2.0),
                                                                                      blurRadius: 2.0,
                                                                                    )
                                                                                  ],
                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            1.0),
                                                                        child:
                                                                            Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'wxwchkjw' /* Keep earning Points by interac... */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 14.0,
                                                                                letterSpacing: 0.0,
                                                                                shadows: [
                                                                                  Shadow(
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    offset: Offset(2.0, 2.0),
                                                                                    blurRadius: 2.0,
                                                                                  )
                                                                                ],
                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Color(0x2EFFFFFF),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: Image.asset(
                                                  'assets/images/hb_home_card_b.webp',
                                                ).image,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 20.0,
                                                  color: Color(0x33000000),
                                                  offset: Offset(
                                                    0.0,
                                                    8.0,
                                                  ),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                              border: Border.all(
                                                color: Color(0x66FFFFFF),
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(20.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[]
                                                              .divide(SizedBox(
                                                                  height: 4.0)),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 12.0)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 30.0,
                                                                0.0, 30.0),
                                                    child: FFButtonWidget(
                                                      onPressed: () async {
                                                        if (_model.homeMode ==
                                                            'couple') {
                                                          context.pushNamed(
                                                            HeartbeatStartWidget
                                                                .routeName,
                                                            extra: <String,
                                                                dynamic>{
                                                              '__transition_info__':
                                                                  TransitionInfo(
                                                                hasTransition:
                                                                    true,
                                                                transitionType:
                                                                    PageTransitionType
                                                                        .fade,
                                                              ),
                                                            },
                                                          );
                                                        } else {
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            enableDrag: false,
                                                            context: context,
                                                            builder: (context) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child: Padding(
                                                                  padding: MediaQuery
                                                                      .viewInsetsOf(
                                                                          context),
                                                                  child:
                                                                      PairRequiredSheetWidget(),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));
                                                        }
                                                      },
                                                      text: FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'wx99kfrg' /* Heartbeat */,
                                                      ),
                                                      options: FFButtonOptions(
                                                        width: double.infinity,
                                                        height: 44.0,
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color:
                                                            Color(0x67121016),
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmallFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  shadows: [
                                                                    Shadow(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      offset: Offset(
                                                                          2.0,
                                                                          2.0),
                                                                      blurRadius:
                                                                          2.0,
                                                                    )
                                                                  ],
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmallIsCustom,
                                                                ),
                                                        elevation: 0.0,
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0x99FFFFFF),
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 16.0)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Color(0x00FFFFFF),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: Image.asset(
                                                  'assets/images/lt_home_card_bg.webp',
                                                ).image,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 20.0,
                                                  color: Color(0x33000000),
                                                  offset: Offset(
                                                    0.0,
                                                    8.0,
                                                  ),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                              border: Border.all(
                                                color: Color(0x66FFFFFF),
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(20.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[]
                                                              .divide(SizedBox(
                                                                  height: 4.0)),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 12.0)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 30.0,
                                                                0.0, 30.0),
                                                    child: FFButtonWidget(
                                                      onPressed: () async {
                                                        if (_model.homeMode ==
                                                            'couple') {
                                                          try {
                                                            final result = await FirebaseFunctions
                                                                    .instanceFor(
                                                                        region:
                                                                            'europe-west3')
                                                                .httpsCallable(
                                                                    'getActiveLoveTreasure')
                                                                .call({});
                                                            _model.getActiveLoveTreasureResponse =
                                                                GetActiveLoveTreasureCloudFunctionCallResponse(
                                                              data: GetActiveLoveTreasureResponseStruct
                                                                  .fromMap(result
                                                                      .data),
                                                              succeeded: true,
                                                              resultAsString:
                                                                  result.data
                                                                      .toString(),
                                                              jsonBody:
                                                                  result.data,
                                                            );
                                                          } on FirebaseFunctionsException catch (error) {
                                                            _model.getActiveLoveTreasureResponse =
                                                                GetActiveLoveTreasureCloudFunctionCallResponse(
                                                              errorCode:
                                                                  error.code,
                                                              succeeded: false,
                                                            );
                                                          }

                                                          if (_model
                                                                  .getActiveLoveTreasureResponse
                                                                  ?.data
                                                                  ?.found ==
                                                              true) {
                                                            context.pushNamed(
                                                              LoveTreasurePageTwoWidget
                                                                  .routeName,
                                                              queryParameters: {
                                                                'treasurePath':
                                                                    serializeParam(
                                                                  _model
                                                                      .getActiveLoveTreasureResponse
                                                                      ?.data
                                                                      ?.treasurePath,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'currentRelationshipRef':
                                                                    serializeParam(
                                                                  _model
                                                                      .currentRelationshipRef,
                                                                  ParamType
                                                                      .DocumentReference,
                                                                ),
                                                                'treasureId':
                                                                    serializeParam(
                                                                  _model
                                                                      .getActiveLoveTreasureResponse
                                                                      ?.data
                                                                      ?.treasureId,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          } else {
                                                            context.pushNamed(
                                                              LoveTreasureMainWidget
                                                                  .routeName,
                                                              queryParameters: {
                                                                'currentRelationshipRef':
                                                                    serializeParam(
                                                                  _model
                                                                      .currentRelationshipRef,
                                                                  ParamType
                                                                      .DocumentReference,
                                                                ),
                                                              }.withoutNulls,
                                                              extra: <String,
                                                                  dynamic>{
                                                                '__transition_info__':
                                                                    TransitionInfo(
                                                                  hasTransition:
                                                                      true,
                                                                  transitionType:
                                                                      PageTransitionType
                                                                          .fade,
                                                                ),
                                                              },
                                                            );
                                                          }
                                                        } else {
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            enableDrag: false,
                                                            context: context,
                                                            builder: (context) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child: Padding(
                                                                  padding: MediaQuery
                                                                      .viewInsetsOf(
                                                                          context),
                                                                  child:
                                                                      PairRequiredSheetWidget(),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));
                                                        }

                                                        safeSetState(() {});
                                                      },
                                                      text: FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '8an83ddx' /* Love treasure */,
                                                      ),
                                                      options: FFButtonOptions(
                                                        width: double.infinity,
                                                        height: 44.0,
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color:
                                                            Color(0x67121016),
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmallFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  shadows: [
                                                                    Shadow(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      offset: Offset(
                                                                          2.0,
                                                                          2.0),
                                                                      blurRadius:
                                                                          2.0,
                                                                    )
                                                                  ],
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmallIsCustom,
                                                                ),
                                                        elevation: 0.0,
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0x99FFFFFF),
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 16.0)),
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 24.0)),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
