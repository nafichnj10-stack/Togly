import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'heartbeat_start_model.dart';
export 'heartbeat_start_model.dart';

/// Create a modern mobile app screen for a relationship app feature called
/// "Heartbeat Result".
///
/// This screen shows the shared emotional connection result between two
/// partners after they answer 3 daily questions.
///
/// Design style:
/// - romantic and emotional
/// - soft pink, purple, and lavender gradient background
/// - modern and clean UI
/// - glassmorphism cards with rounded corners
/// - subtle glow and heart details
/// - premium but realistic mobile app design
/// - highly readable and production-ready
///
/// Layout:
///
/// Top section:
/// - title: "Your Heartbeat Today"
/// - two circular partner profile images side by side
/// - a small glowing heart icon between the profiles
///
/// Center section:
/// - a large circular result component
/// - inside the circle show a percentage score (example: 82%)
/// - below the number show a label like "Connected"
/// - add a soft glow around the circle
///
/// Below the result:
/// - a short emotional insight text such as:
///   "You both feel emotionally close today."
///
/// Action section:
/// - two primary buttons:
///   "Send something sweet"
///   "Share Heartbeat"
///
/// Use a clean mobile layout with proper spacing, cards, and realistic button
/// sizes suitable for FlutterFlow implementation.
/// Avoid overly complex illustrations or cluttered elements.
class HeartbeatStartWidget extends StatefulWidget {
  const HeartbeatStartWidget({super.key});

  static String routeName = 'Heartbeat_start';
  static String routePath = '/heartbeatStart';

  @override
  State<HeartbeatStartWidget> createState() => _HeartbeatStartWidgetState();
}

class _HeartbeatStartWidgetState extends State<HeartbeatStartWidget> {
  late HeartbeatStartModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HeartbeatStartModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'Heartbeat_start'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        final result =
            await FirebaseFunctions.instanceFor(region: 'europe-west3')
                .httpsCallable('getHeartbeatSession')
                .call({});
        _model.cloudFunctionael = GetHeartbeatSessionCloudFunctionCallResponse(
          data: HeartbeatGetCFResultStruct.fromMap(result.data),
          succeeded: true,
          resultAsString: result.data.toString(),
          jsonBody: result.data,
        );
      } on FirebaseFunctionsException catch (error) {
        _model.cloudFunctionael = GetHeartbeatSessionCloudFunctionCallResponse(
          errorCode: error.code,
          succeeded: false,
        );
      }

      if (_model.cloudFunctionael?.data?.status == 'completed') {
        context.pushNamed(
          HeartbeatResultWidget.routeName,
          extra: <String, dynamic>{
            '__transition_info__': TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );
      } else if ((_model.cloudFunctionael?.data?.currentUserAnswered == true) &&
          (_model.cloudFunctionael?.data?.bothAnswered == false)) {
        context.pushNamed(
          HeartbeatWaitWidget.routeName,
          extra: <String, dynamic>{
            '__transition_info__': TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );
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
      builder: (context) => StreamBuilder<List<RelationshipViewsRecord>>(
        stream: queryRelationshipViewsRecord(
          queryBuilder: (relationshipViewsRecord) =>
              relationshipViewsRecord.where(
            'relationship_id',
            isEqualTo: valueOrDefault(currentUserDocument?.relationshipId, ''),
          ),
          singleRecord: true,
        ),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: Color(0xFF1A0A2E),
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
          List<RelationshipViewsRecord>
              heartbeatStartRelationshipViewsRecordList = snapshot.data!;
          final heartbeatStartRelationshipViewsRecord =
              heartbeatStartRelationshipViewsRecordList.isNotEmpty
                  ? heartbeatStartRelationshipViewsRecordList.first
                  : null;

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: Color(0xFF1A0A2E),
              body: Container(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: Image.asset(
                        'assets/images/background_heartbeat_result.webp',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 1.0,
                          sigmaY: 1.0,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4.0,
                                color: Color(0x33000000),
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                              )
                            ],
                            gradient: LinearGradient(
                              colors: [
                                Color(0x7B310D43),
                                Color(0x422B0F3D),
                                Color(0x4512051A)
                              ],
                              stops: [0.0, 0.45, 1.0],
                              begin: AlignmentDirectional(0.0, -1.0),
                              end: AlignmentDirectional(0, 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  child: Container(
                                    height: 32.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x4A000000),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.calendar_today_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 14.0,
                                          ),
                                          Text(
                                            dateTimeFormat(
                                              "EEEE, MMMM d",
                                              getCurrentTimestamp,
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiary,
                                                  fontSize: 13.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .labelMediumIsCustom,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 6.0)),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      '2jce9jgy' /* Today's Heartbeat */,
                                    ),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .headlineLarge
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .headlineLargeFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 28.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .headlineLargeIsCustom,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'fzbyrksa' /* A daily emotional check-in for... */,
                                    ),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .accent1,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 8.0)),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 32.0, 8.0, 32.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0x194220E1),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 32.0,
                                      color: Color(0x6DFF6EB4),
                                      offset: Offset(
                                        0.0,
                                        8.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(28.0),
                                  border: Border.all(
                                    color: Color(0x4AE6DFFF),
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            StreamBuilder<
                                                List<PublicUsersRecord>>(
                                              stream: queryPublicUsersRecord(
                                                queryBuilder:
                                                    (publicUsersRecord) =>
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
                                                List<PublicUsersRecord>
                                                    columnPublicUsersRecordList =
                                                    snapshot.data!;
                                                final columnPublicUsersRecord =
                                                    columnPublicUsersRecordList
                                                            .isNotEmpty
                                                        ? columnPublicUsersRecordList
                                                            .first
                                                        : null;

                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Container(
                                                        width: 80.0,
                                                        height: 80.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 20.0,
                                                              color: Color(
                                                                  0x66FF6EB4),
                                                              offset: Offset(
                                                                0.0,
                                                                0.0,
                                                              ),
                                                            )
                                                          ],
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: Color(
                                                                0x88FF9ED8),
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      40.0),
                                                          child: Image.network(
                                                            columnPublicUsersRecord!
                                                                .photoUrl,
                                                            width: 80.0,
                                                            height: 80.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      valueOrDefault<String>(
                                                        heartbeatStartRelationshipViewsRecord
                                                            ?.myName,
                                                        'Name',
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                            color: Colors.white,
                                                            fontSize: 15.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumIsCustom,
                                                          ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 10.0)),
                                                );
                                              },
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 48.0,
                                                    height: 48.0,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 24.0,
                                                          color:
                                                              Color(0x99FF4081),
                                                          offset: Offset(
                                                            0.0,
                                                            0.0,
                                                          ),
                                                        )
                                                      ],
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Color(0xFFFF6EB4),
                                                          Color(0xFFB44FFF)
                                                        ],
                                                        stops: [0.0, 1.0],
                                                        begin:
                                                            AlignmentDirectional(
                                                                1.0, 1.0),
                                                        end:
                                                            AlignmentDirectional(
                                                                -1.0, -1.0),
                                                      ),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Icon(
                                                        Icons.favorite_rounded,
                                                        color: Colors.white,
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 0.0)),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 80.0,
                                                    height: 80.0,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 20.0,
                                                          color:
                                                              Color(0x66B06AFF),
                                                          offset: Offset(
                                                            0.0,
                                                            0.0,
                                                          ),
                                                        )
                                                      ],
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color:
                                                            Color(0x88C099FF),
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40.0),
                                                      child: Image.network(
                                                        heartbeatStartRelationshipViewsRecord!
                                                            .partnerPhotoUrl,
                                                        width: 80.0,
                                                        height: 80.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  valueOrDefault<String>(
                                                    heartbeatStartRelationshipViewsRecord
                                                        .partnerName,
                                                    'Name',
                                                  ),
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                            color: Colors.white,
                                                            fontSize: 15.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumIsCustom,
                                                          ),
                                                ),
                                              ].divide(SizedBox(height: 10.0)),
                                            ),
                                          ].divide(SizedBox(width: 0.0)),
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 20.0)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(18.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 10.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        'ctkfq3nx' /* Take a moment to answer three ... */,
                                      ),
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .accent1,
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            lineHeight: 1.6,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      '8ajvgdmk' /* Your answers will reveal how e... */,
                                    ),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .accent1,
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          lineHeight: 1.6,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 6.0)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 40.0, 8.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  try {
                                    final result =
                                        await FirebaseFunctions.instanceFor(
                                                region: 'europe-west3')
                                            .httpsCallable(
                                                'startHeartbeatSessionNow')
                                            .call({});
                                    _model.cloudFunctionStart =
                                        StartHeartbeatSessionNowCloudFunctionCallResponse(
                                      data:
                                          HeartbeatStartCFResultStruct.fromMap(
                                              result.data),
                                      succeeded: true,
                                      resultAsString: result.data.toString(),
                                      jsonBody: result.data,
                                    );
                                  } on FirebaseFunctionsException catch (error) {
                                    _model.cloudFunctionStart =
                                        StartHeartbeatSessionNowCloudFunctionCallResponse(
                                      errorCode: error.code,
                                      succeeded: false,
                                    );
                                  }

                                  if (_model.cloudFunctionStart?.data?.ok ==
                                      true) {
                                    FFAppState().heartbeatSessionId = _model
                                        .cloudFunctionStart!.data!.sessionId;
                                    FFAppState().heartbeatCurrentIndex = 0;
                                    FFAppState().heartbeatAnswer1 = 0;
                                    FFAppState().heartbeatAnswer2 = 0;
                                    FFAppState().heartbeatAnswer3 = 0;
                                    FFAppState().heartbeatQuestions = _model
                                        .cloudFunctionStart!.data!.questions
                                        .toList()
                                        .cast<HeartbeatQuestionCFItemStruct>();
                                    FFAppState().heartbeatQuestion1En = _model
                                        .cloudFunctionStart!
                                        .data!
                                        .question1TextEn;
                                    FFAppState().heartbeatQuestion2En = _model
                                        .cloudFunctionStart!
                                        .data!
                                        .question2TextEn;
                                    FFAppState().heartbeatQuestion3En = _model
                                        .cloudFunctionStart!
                                        .data!
                                        .question3TextEn;
                                    FFAppState().heartbeatQuestion1De = _model
                                        .cloudFunctionStart!
                                        .data!
                                        .question1TextDe;
                                    FFAppState().heartbeatQuestion2De = _model
                                        .cloudFunctionStart!
                                        .data!
                                        .question2TextDe;
                                    FFAppState().heartbeatQuestion3De = _model
                                        .cloudFunctionStart!
                                        .data!
                                        .question3TextDe;
                                    FFAppState().heartbeatQuestion1Es = _model
                                        .cloudFunctionStart!
                                        .data!
                                        .question1TextEs;
                                    FFAppState().heartbeatQuestion2Es = _model
                                        .cloudFunctionStart!
                                        .data!
                                        .question2TextEs;
                                    FFAppState().heartbeatQuestion3Es = _model
                                        .cloudFunctionStart!
                                        .data!
                                        .question3TextEs;
                                    safeSetState(() {});

                                    context.goNamed(
                                      HeartbeatQuestionsWidget.routeName,
                                      queryParameters: {
                                        'sessionId': serializeParam(
                                          _model.cloudFunctionStart?.data
                                              ?.sessionId,
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        '__transition_info__': TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                          duration: Duration(milliseconds: 0),
                                        ),
                                      },
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          _model.cloudFunctionStart!.data!
                                              .message,
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor: Color(0xFF8A75BA),
                                      ),
                                    );
                                  }

                                  safeSetState(() {});
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 24.0,
                                        color: Color(0x66FF4081),
                                        offset: Offset(
                                          0.0,
                                          8.0,
                                        ),
                                      )
                                    ],
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFFF6EB4),
                                        Color(0xFFB44FFF),
                                        Color(0xFF8B5CF6)
                                      ],
                                      stops: [0.0, 0.5, 1.0],
                                      begin: AlignmentDirectional(1.0, 0.0),
                                      end: AlignmentDirectional(-1.0, 0),
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.favorite_rounded,
                                            color: Colors.white,
                                            size: 22.0,
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'ec9d0tk3' /* Start Heartbeat */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMediumFamily,
                                                  color: Colors.white,
                                                  fontSize: 17.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .titleMediumIsCustom,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 10.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 12.0, 8.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 14.0,
                                  ),
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'xjinb4kh' /* Takes less than 30 seconds */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmallFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .labelSmallIsCustom,
                                        ),
                                  ),
                                ].divide(SizedBox(width: 6.0)),
                              ),
                            ),
                          ]
                              .divide(SizedBox(height: 0.0))
                              .addToStart(SizedBox(height: 48.0))
                              .addToEnd(SizedBox(height: 48.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
