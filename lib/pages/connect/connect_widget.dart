import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/components/header_couple/header_couple_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'connect_model.dart';
export 'connect_model.dart';

/// Create a beautifully designed main dashboard screen for a mobile
/// relationship app called "2getherly".
///
/// The design should feel warm, modern, and emotionally supportive. Use soft
/// gradients (e.g. lavender and pastel tones) to create a loving and calming
/// atmosphere.
///
/// **Top Section:**
/// - A horizontally-aligned top bar displaying both users' profile pictures
/// side by side (circular).
/// - In the center, place a glowing animated heart logo between the avatars.
/// - Below the avatars, display both names and the city each user entered,
/// along with their respective local time shown dynamically. (e.g., "Anna –
/// 7:12 PM – Nairobi", "Liam – 6:12 PM – Berlin")
///
/// **Below this:**
/// - A visual countdown component that displays:
///   “20 days until your next meeting” (adjustable).
///   Use a heart-shaped icon or small calendar icon next to it.
///
/// **Main Interaction Section:**
/// - Use soft cards or containers to organize the following user features:
///   1. **Daily Question**
///      Show today's question and a button that says “Answer Now” or “View
/// Answers” depending on completion status.
///
///   2. **Mood Sharing**
///      A horizontal mood selector (emoji-based) with label “How are you
/// feeling today?”
///      Option to select an emoji representing the current mood (happy,
/// tired, sad, stressed, etc.)
///
///   3. **Sleep Status**
///      A toggle switch: “Going to bed now” or “Still awake” with a cute moon
/// icon.
///
///   4. **Shared Wishlist**
///      A preview card of 2–3 wishlist items from both partners. Include a
/// “+” icon to add more items.
///
///   5. **Shared Calendar**
///      Show upcoming events (e.g., date nights, anniversaries) in a
/// simplified list or card style.
///
///   6. **Shared Gallery**
///      Small preview of most recent 2–3 images in the shared gallery.
/// Include a “View All” button.
///
/// **Bottom Navigation:**
/// - Use a clean bottom navigation bar with icons:
///   Home | Journal | Gallery | Calendar | Settings
///
/// **Design Notes:**
/// - Rounded corners, slight shadows, and soft gradients.
/// - Fonts should be modern, clear, and friendly (e.g., Inter, Nunito, or
/// Poppins).
/// - Use white or soft beige background for contrast.
/// - Button accents in lavender, purple, or light pink tones.
///
/// The layout should be mobile-optimized and visually balanced, focusing on
/// simplicity, emotional design, and intuitive UX.
class ConnectWidget extends StatefulWidget {
  const ConnectWidget({super.key});

  static String routeName = 'connect';
  static String routePath = '/connect';

  @override
  State<ConnectWidget> createState() => _ConnectWidgetState();
}

class _ConnectWidgetState extends State<ConnectWidget> {
  late ConnectModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConnectModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'connect'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (valueOrDefault(currentUserDocument?.relationshipId, '') != '') {
        try {
          final result =
              await FirebaseFunctions.instanceFor(region: 'europe-west3')
                  .httpsCallable('resolveHomeState')
                  .call({
            "tzOffsetMinutes": functions.deviceOffsetMinutes(),
          });
          _model.cloudFunctiontyl = ResolveHomeStateCloudFunctionCallResponse(
            data: CFSyncHomeSnapshotResultStruct.fromMap(result.data),
            succeeded: true,
            resultAsString: result.data.toString(),
            jsonBody: result.data,
          );
        } on FirebaseFunctionsException catch (error) {
          _model.cloudFunctiontyl = ResolveHomeStateCloudFunctionCallResponse(
            errorCode: error.code,
            succeeded: false,
          );
        }

        try {
          final result =
              await FirebaseFunctions.instanceFor(region: 'europe-west3')
                  .httpsCallable('sendEmotionCheckIn')
                  .call({
            "mode": 'status',
            "choice": '',
          });
          _model.cloudFunctionuex = SendEmotionCheckInCloudFunctionCallResponse(
            data: CFEmotionResultStruct.fromMap(result.data),
            succeeded: true,
            resultAsString: result.data.toString(),
            jsonBody: result.data,
          );
        } on FirebaseFunctionsException catch (error) {
          _model.cloudFunctionuex = SendEmotionCheckInCloudFunctionCallResponse(
            errorCode: error.code,
            succeeded: false,
          );
        }

        _model.emotionState = _model.cloudFunctionuex?.data?.state;
        _model.emotionStatusText = _model.cloudFunctionuex?.data?.statusText;
        _model.emotionSummary = _model.cloudFunctionuex?.data?.summaryText;
        _model.emotionMyChoice = _model.cloudFunctionuex?.data?.myChoice;
        _model.emotionPartnerChoice =
            _model.cloudFunctionuex?.data?.partnerChoice;
        _model.emotionCooldownUntil =
            _model.cloudFunctionuex?.data?.cooldownUntilMs;
        safeSetState(() {});
      } else {
        context.goNamed(
          PairRequiredPageWidget.routeName,
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF8F6F3),
        body: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image.asset(
                'assets/images/background_main_connect3.webp',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment(0.0, 0.0),
              ),
            ),
            StreamBuilder<List<RelationshipViewsRecord>>(
              stream: queryRelationshipViewsRecord(
                queryBuilder: (relationshipViewsRecord) =>
                    relationshipViewsRecord.where(
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
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  );
                }
                List<RelationshipViewsRecord>
                    containerRelationshipViewsRecordList = snapshot.data!;
                // Return an empty Container when the item does not exist.
                if (snapshot.data!.isEmpty) {
                  return Container();
                }
                final containerRelationshipViewsRecord =
                    containerRelationshipViewsRecordList.isNotEmpty
                        ? containerRelationshipViewsRecordList.first
                        : null;

                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0x42000000),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          wrapWithModel(
                            model: _model.headerCoupleModel,
                            updateCallback: () => safeSetState(() {}),
                            child: HeaderCoupleWidget(
                              myIsSleeping: containerRelationshipViewsRecord
                                  ?.mySleepStatus,
                              mySleepStartedAt: containerRelationshipViewsRecord
                                  ?.mySleepStartedAt,
                              myMood: containerRelationshipViewsRecord?.myMood,
                              silentStatus: _model.silentStatus,
                              silentStatusText: _model.silentStatusText,
                              partnerPhotoUrl: containerRelationshipViewsRecord
                                  ?.partnerPhotoUrl,
                              partnerIsSleeping:
                                  containerRelationshipViewsRecord
                                      ?.partnerSleepStatus,
                              partnerSleepStartedAt:
                                  containerRelationshipViewsRecord
                                      ?.partnerSleepStartedAt,
                              partnerMood:
                                  containerRelationshipViewsRecord?.partnerMood,
                              partnerName: valueOrDefault<String>(
                                containerRelationshipViewsRecord?.partnerName,
                                'name',
                              ),
                              partnerTimezoneOffsetMinutes:
                                  containerRelationshipViewsRecord
                                      ?.partnerTzOffsetMinutes,
                              partnerCity: valueOrDefault<String>(
                                containerRelationshipViewsRecord?.partnerCity,
                                'city',
                              ),
                              myTimezoneOffsetMinutes:
                                  containerRelationshipViewsRecord
                                      ?.myTzOffsetMinutes,
                            ),
                          ),
                          Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24.0),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 24.0,
                                      sigmaY: 24.0,
                                    ),
                                    child: StreamBuilder<
                                        List<DailyQuestionsRecord>>(
                                      stream: queryDailyQuestionsRecord(
                                        queryBuilder: (dailyQuestionsRecord) =>
                                            dailyQuestionsRecord
                                                .where(
                                                  'date',
                                                  isGreaterThanOrEqualTo:
                                                      functions
                                                          .startOfTodayUtc(),
                                                )
                                                .where(
                                                  'date',
                                                  isLessThan: functions
                                                      .startOfTomorrowUtc(),
                                                )
                                                .orderBy('date'),
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
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<DailyQuestionsRecord>
                                            containerDailyQuestionsRecordList =
                                            snapshot.data!;
                                        // Return an empty Container when the item does not exist.
                                        if (snapshot.data!.isEmpty) {
                                          return Container();
                                        }
                                        final containerDailyQuestionsRecord =
                                            containerDailyQuestionsRecordList
                                                    .isNotEmpty
                                                ? containerDailyQuestionsRecordList
                                                    .first
                                                : null;

                                        return Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0x194220E1),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                            border: Border.all(
                                              color: Color(0x34FFFFFF),
                                              width: 1.0,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(20.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      '3m67hksv' /* Daily Question */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).titleMediumFamily,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          fontSize:
                                                                              18.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context).titleMediumIsCustom,
                                                                        ),
                                                                  ),
                                                                  AuthUserStreamWidget(
                                                                    builder:
                                                                        (context) =>
                                                                            Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        () {
                                                                          if (valueOrDefault(currentUserDocument?.appLanguage, '') ==
                                                                              'en') {
                                                                            return containerDailyQuestionsRecord?.questionTextEn;
                                                                          } else if (valueOrDefault(currentUserDocument?.appLanguage, '') ==
                                                                              'de') {
                                                                            return containerDailyQuestionsRecord?.questionTextDe;
                                                                          } else if (valueOrDefault(currentUserDocument?.appLanguage, '') ==
                                                                              'es') {
                                                                            return containerDailyQuestionsRecord?.questionTextEs;
                                                                          } else {
                                                                            return containerDailyQuestionsRecord?.questionTextEn;
                                                                          }
                                                                        }(),
                                                                        'Daily question',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).accent1,
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            lineHeight:
                                                                                1.4,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    height:
                                                                        4.0)),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 12.0)),
                                                        ),
                                                        FFButtonWidget(
                                                          onPressed: () async {
                                                            try {
                                                              final result = await FirebaseFunctions
                                                                      .instanceFor(
                                                                          region:
                                                                              'europe-west3')
                                                                  .httpsCallable(
                                                                      'getDailyQuestionState')
                                                                  .call({});
                                                              _model.dqState =
                                                                  GetDailyQuestionStateCloudFunctionCallResponse(
                                                                data: DailyQuestionCFResultStruct
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
                                                              _model.dqState =
                                                                  GetDailyQuestionStateCloudFunctionCallResponse(
                                                                errorCode:
                                                                    error.code,
                                                                succeeded:
                                                                    false,
                                                              );
                                                            }

                                                            if (_model.dqState!
                                                                .data!.ok) {
                                                              if (_model
                                                                      .dqState
                                                                      ?.data
                                                                      ?.state ==
                                                                  'ANSWERED') {
                                                                context
                                                                    .pushNamed(
                                                                  DailyQuestionResultPageWidget
                                                                      .routeName,
                                                                  queryParameters:
                                                                      {
                                                                    'finalAnswerDocPath':
                                                                        serializeParam(
                                                                      _model
                                                                          .dqState
                                                                          ?.data
                                                                          ?.answerDocPath,
                                                                      ParamType
                                                                          .String,
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
                                                              } else {
                                                                context
                                                                    .pushNamed(
                                                                  DailyQuestionPageeWidget
                                                                      .routeName,
                                                                  queryParameters:
                                                                      {
                                                                    'finalAnswerDocPath':
                                                                        serializeParam(
                                                                      _model
                                                                          .dqState
                                                                          ?.data
                                                                          ?.answerDocPath,
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'questionText':
                                                                        serializeParam(
                                                                      _model
                                                                          .dqState
                                                                          ?.data
                                                                          ?.questionText,
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'questionId':
                                                                        serializeParam(
                                                                      _model
                                                                          .dqState
                                                                          ?.data
                                                                          ?.questionId,
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'dayKey':
                                                                        serializeParam(
                                                                      _model
                                                                          .dqState
                                                                          ?.data
                                                                          ?.dayKey,
                                                                      ParamType
                                                                          .String,
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
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    _model
                                                                        .dqState!
                                                                        .data!
                                                                        .message,
                                                                    style:
                                                                        TextStyle(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                    ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                ),
                                                              );
                                                            }

                                                            safeSetState(() {});
                                                          },
                                                          text: FFLocalizations
                                                                  .of(context)
                                                              .getText(
                                                            'rw801e5j' /* Answer Now */,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            width:
                                                                double.infinity,
                                                            height: 48.0,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    12.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: Color(
                                                                0xAD9F7BFF),
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyMediumIsCustom,
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
                                                                        18.0),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 16.0)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 30.0, 0.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24.0),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 24.0,
                                      sigmaY: 24.0,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0x194220E1),
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
                                          color: Color(0x34FFFFFF),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'mt8bq9ys' /* How are you feeling? */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMediumFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 18.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleMediumIsCustom,
                                                      ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
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
                                                        try {
                                                          final result =
                                                              await FirebaseFunctions
                                                                      .instanceFor(
                                                                          region:
                                                                              'europe-west3')
                                                                  .httpsCallable(
                                                                      'setMood')
                                                                  .call({
                                                            "mood": 'happy',
                                                          });
                                                          _model.cfSetMoodResult =
                                                              SetMoodCloudFunctionCallResponse(
                                                            data: CFResultStruct
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
                                                          _model.cfSetMoodResult =
                                                              SetMoodCloudFunctionCallResponse(
                                                            errorCode:
                                                                error.code,
                                                            succeeded: false,
                                                          );
                                                        }

                                                        if (_model
                                                            .cfSetMoodResult!
                                                            .data!
                                                            .ok) {
                                                          try {
                                                            final result = await FirebaseFunctions
                                                                    .instanceFor(
                                                                        region:
                                                                            'europe-west3')
                                                                .httpsCallable(
                                                                    'sendPartnerPush')
                                                                .call({
                                                              "type":
                                                                  'mood_changed',
                                                              "route":
                                                                  'homehome',
                                                              "audience":
                                                                  'partner',
                                                            });
                                                            _model.cloudFunction6oy6 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              data: result.data,
                                                              succeeded: true,
                                                              resultAsString:
                                                                  result.data
                                                                      .toString(),
                                                              jsonBody:
                                                                  result.data,
                                                            );
                                                          } on FirebaseFunctionsException catch (error) {
                                                            _model.cloudFunction6oy6 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              errorCode:
                                                                  error.code,
                                                              succeeded: false,
                                                            );
                                                          }
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                _model
                                                                    .cfSetMoodResult!
                                                                    .data!
                                                                    .message,
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                        }

                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                '1uxvylz0' /* 😁 */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineMediumFamily,
                                                                    fontSize:
                                                                        26.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .headlineMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
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
                                                        try {
                                                          final result =
                                                              await FirebaseFunctions
                                                                      .instanceFor(
                                                                          region:
                                                                              'europe-west3')
                                                                  .httpsCallable(
                                                                      'setMood')
                                                                  .call({
                                                            "mood": 'excited',
                                                          });
                                                          _model.excited =
                                                              SetMoodCloudFunctionCallResponse(
                                                            data: CFResultStruct
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
                                                          _model.excited =
                                                              SetMoodCloudFunctionCallResponse(
                                                            errorCode:
                                                                error.code,
                                                            succeeded: false,
                                                          );
                                                        }

                                                        if (_model.excited!
                                                            .data!.ok) {
                                                          try {
                                                            final result = await FirebaseFunctions
                                                                    .instanceFor(
                                                                        region:
                                                                            'europe-west3')
                                                                .httpsCallable(
                                                                    'sendPartnerPush')
                                                                .call({
                                                              "type":
                                                                  'mood_changed',
                                                              "route":
                                                                  'homehome',
                                                              "audience":
                                                                  'partner',
                                                            });
                                                            _model.cloudFunction6oy53 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              data: result.data,
                                                              succeeded: true,
                                                              resultAsString:
                                                                  result.data
                                                                      .toString(),
                                                              jsonBody:
                                                                  result.data,
                                                            );
                                                          } on FirebaseFunctionsException catch (error) {
                                                            _model.cloudFunction6oy53 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              errorCode:
                                                                  error.code,
                                                              succeeded: false,
                                                            );
                                                          }
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                _model
                                                                    .excited!
                                                                    .data!
                                                                    .message,
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                        }

                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'kufpw2ok' /* 😏 */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineMediumFamily,
                                                                    fontSize:
                                                                        26.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .headlineMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
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
                                                        try {
                                                          final result =
                                                              await FirebaseFunctions
                                                                      .instanceFor(
                                                                          region:
                                                                              'europe-west3')
                                                                  .httpsCallable(
                                                                      'setMood')
                                                                  .call({
                                                            "mood": 'cool',
                                                          });
                                                          _model.cool =
                                                              SetMoodCloudFunctionCallResponse(
                                                            data: CFResultStruct
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
                                                          _model.cool =
                                                              SetMoodCloudFunctionCallResponse(
                                                            errorCode:
                                                                error.code,
                                                            succeeded: false,
                                                          );
                                                        }

                                                        if (_model
                                                            .cool!.data!.ok) {
                                                          try {
                                                            final result = await FirebaseFunctions
                                                                    .instanceFor(
                                                                        region:
                                                                            'europe-west3')
                                                                .httpsCallable(
                                                                    'sendPartnerPush')
                                                                .call({
                                                              "type":
                                                                  'mood_changed',
                                                              "route":
                                                                  'homehome',
                                                              "audience":
                                                                  'partner',
                                                            });
                                                            _model.cloudFunction6oy45 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              data: result.data,
                                                              succeeded: true,
                                                              resultAsString:
                                                                  result.data
                                                                      .toString(),
                                                              jsonBody:
                                                                  result.data,
                                                            );
                                                          } on FirebaseFunctionsException catch (error) {
                                                            _model.cloudFunction6oy45 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              errorCode:
                                                                  error.code,
                                                              succeeded: false,
                                                            );
                                                          }
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                _model
                                                                    .cool!
                                                                    .data!
                                                                    .message,
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                        }

                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'l5d0n0fi' /* 😎 */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineMediumFamily,
                                                                    fontSize:
                                                                        26.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .headlineMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
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
                                                        try {
                                                          final result =
                                                              await FirebaseFunctions
                                                                      .instanceFor(
                                                                          region:
                                                                              'europe-west3')
                                                                  .httpsCallable(
                                                                      'setMood')
                                                                  .call({
                                                            "mood": 'inlove',
                                                          });
                                                          _model.inlove =
                                                              SetMoodCloudFunctionCallResponse(
                                                            data: CFResultStruct
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
                                                          _model.inlove =
                                                              SetMoodCloudFunctionCallResponse(
                                                            errorCode:
                                                                error.code,
                                                            succeeded: false,
                                                          );
                                                        }

                                                        if (_model
                                                            .inlove!.data!.ok) {
                                                          try {
                                                            final result = await FirebaseFunctions
                                                                    .instanceFor(
                                                                        region:
                                                                            'europe-west3')
                                                                .httpsCallable(
                                                                    'sendPartnerPush')
                                                                .call({
                                                              "type":
                                                                  'mood_changed',
                                                              "route":
                                                                  'homehome',
                                                              "audience":
                                                                  'partner',
                                                            });
                                                            _model.cloudFunction6oy23 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              data: result.data,
                                                              succeeded: true,
                                                              resultAsString:
                                                                  result.data
                                                                      .toString(),
                                                              jsonBody:
                                                                  result.data,
                                                            );
                                                          } on FirebaseFunctionsException catch (error) {
                                                            _model.cloudFunction6oy23 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              errorCode:
                                                                  error.code,
                                                              succeeded: false,
                                                            );
                                                          }
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                _model
                                                                    .inlove!
                                                                    .data!
                                                                    .message,
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                        }

                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                '2ytecbxi' /* 😍 */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineMediumFamily,
                                                                    fontSize:
                                                                        26.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .headlineMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
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
                                                        try {
                                                          final result =
                                                              await FirebaseFunctions
                                                                      .instanceFor(
                                                                          region:
                                                                              'europe-west3')
                                                                  .httpsCallable(
                                                                      'setMood')
                                                                  .call({
                                                            "mood": 'strong',
                                                          });
                                                          _model.strong =
                                                              SetMoodCloudFunctionCallResponse(
                                                            data: CFResultStruct
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
                                                          _model.strong =
                                                              SetMoodCloudFunctionCallResponse(
                                                            errorCode:
                                                                error.code,
                                                            succeeded: false,
                                                          );
                                                        }

                                                        if (_model
                                                            .strong!.data!.ok) {
                                                          try {
                                                            final result = await FirebaseFunctions
                                                                    .instanceFor(
                                                                        region:
                                                                            'europe-west3')
                                                                .httpsCallable(
                                                                    'sendPartnerPush')
                                                                .call({
                                                              "type":
                                                                  'mood_changed',
                                                              "route":
                                                                  'homehome',
                                                              "audience":
                                                                  'partner',
                                                            });
                                                            _model.cloudFunction6oy1 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              data: result.data,
                                                              succeeded: true,
                                                              resultAsString:
                                                                  result.data
                                                                      .toString(),
                                                              jsonBody:
                                                                  result.data,
                                                            );
                                                          } on FirebaseFunctionsException catch (error) {
                                                            _model.cloudFunction6oy1 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              errorCode:
                                                                  error.code,
                                                              succeeded: false,
                                                            );
                                                          }
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                _model
                                                                    .strong!
                                                                    .data!
                                                                    .message,
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                        }

                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'hfw3gux2' /* 💪 */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineMediumFamily,
                                                                    fontSize:
                                                                        26.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .headlineMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
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
                                                        try {
                                                          final result =
                                                              await FirebaseFunctions
                                                                      .instanceFor(
                                                                          region:
                                                                              'europe-west3')
                                                                  .httpsCallable(
                                                                      'setMood')
                                                                  .call({
                                                            "mood": 'shit',
                                                          });
                                                          _model.shit =
                                                              SetMoodCloudFunctionCallResponse(
                                                            data: CFResultStruct
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
                                                          _model.shit =
                                                              SetMoodCloudFunctionCallResponse(
                                                            errorCode:
                                                                error.code,
                                                            succeeded: false,
                                                          );
                                                        }

                                                        if (_model
                                                            .shit!.data!.ok) {
                                                          try {
                                                            final result = await FirebaseFunctions
                                                                    .instanceFor(
                                                                        region:
                                                                            'europe-west3')
                                                                .httpsCallable(
                                                                    'sendPartnerPush')
                                                                .call({
                                                              "type":
                                                                  'mood_changed',
                                                              "route":
                                                                  'homehome',
                                                              "audience":
                                                                  'partner',
                                                            });
                                                            _model.cloudFunction6oy0 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              data: result.data,
                                                              succeeded: true,
                                                              resultAsString:
                                                                  result.data
                                                                      .toString(),
                                                              jsonBody:
                                                                  result.data,
                                                            );
                                                          } on FirebaseFunctionsException catch (error) {
                                                            _model.cloudFunction6oy0 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              errorCode:
                                                                  error.code,
                                                              succeeded: false,
                                                            );
                                                          }
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                _model
                                                                    .shit!
                                                                    .data!
                                                                    .message,
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                        }

                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'fd1o97e8' /* 💩 */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineMediumFamily,
                                                                    fontSize:
                                                                        26.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .headlineMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
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
                                                        try {
                                                          final result =
                                                              await FirebaseFunctions
                                                                      .instanceFor(
                                                                          region:
                                                                              'europe-west3')
                                                                  .httpsCallable(
                                                                      'setMood')
                                                                  .call({
                                                            "mood": 'sick',
                                                          });
                                                          _model.sick =
                                                              SetMoodCloudFunctionCallResponse(
                                                            data: CFResultStruct
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
                                                          _model.sick =
                                                              SetMoodCloudFunctionCallResponse(
                                                            errorCode:
                                                                error.code,
                                                            succeeded: false,
                                                          );
                                                        }

                                                        if (_model
                                                            .sick!.data!.ok) {
                                                          try {
                                                            final result = await FirebaseFunctions
                                                                    .instanceFor(
                                                                        region:
                                                                            'europe-west3')
                                                                .httpsCallable(
                                                                    'sendPartnerPush')
                                                                .call({
                                                              "type":
                                                                  'mood_changed',
                                                              "route":
                                                                  'homehome',
                                                              "audience":
                                                                  'partner',
                                                            });
                                                            _model.cloudFunction6oy99 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              data: result.data,
                                                              succeeded: true,
                                                              resultAsString:
                                                                  result.data
                                                                      .toString(),
                                                              jsonBody:
                                                                  result.data,
                                                            );
                                                          } on FirebaseFunctionsException catch (error) {
                                                            _model.cloudFunction6oy99 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              errorCode:
                                                                  error.code,
                                                              succeeded: false,
                                                            );
                                                          }
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                _model
                                                                    .sick!
                                                                    .data!
                                                                    .message,
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                        }

                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'lv73uisu' /* 🤒 */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineMediumFamily,
                                                                    fontSize:
                                                                        26.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .headlineMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
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
                                                        try {
                                                          final result =
                                                              await FirebaseFunctions
                                                                      .instanceFor(
                                                                          region:
                                                                              'europe-west3')
                                                                  .httpsCallable(
                                                                      'setMood')
                                                                  .call({
                                                            "mood": 'sad',
                                                          });
                                                          _model.sad =
                                                              SetMoodCloudFunctionCallResponse(
                                                            data: CFResultStruct
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
                                                          _model.sad =
                                                              SetMoodCloudFunctionCallResponse(
                                                            errorCode:
                                                                error.code,
                                                            succeeded: false,
                                                          );
                                                        }

                                                        if (_model
                                                            .sad!.data!.ok) {
                                                          try {
                                                            final result = await FirebaseFunctions
                                                                    .instanceFor(
                                                                        region:
                                                                            'europe-west3')
                                                                .httpsCallable(
                                                                    'sendPartnerPush')
                                                                .call({
                                                              "type":
                                                                  'mood_changed',
                                                              "route":
                                                                  'homehome',
                                                              "audience":
                                                                  'partner',
                                                            });
                                                            _model.cloudFunction6oy88 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              data: result.data,
                                                              succeeded: true,
                                                              resultAsString:
                                                                  result.data
                                                                      .toString(),
                                                              jsonBody:
                                                                  result.data,
                                                            );
                                                          } on FirebaseFunctionsException catch (error) {
                                                            _model.cloudFunction6oy88 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              errorCode:
                                                                  error.code,
                                                              succeeded: false,
                                                            );
                                                          }
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                _model
                                                                    .sad!
                                                                    .data!
                                                                    .message,
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                        }

                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'vwfb16xl' /* 😭 */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineMediumFamily,
                                                                    fontSize:
                                                                        26.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .headlineMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
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
                                                        try {
                                                          final result =
                                                              await FirebaseFunctions
                                                                      .instanceFor(
                                                                          region:
                                                                              'europe-west3')
                                                                  .httpsCallable(
                                                                      'setMood')
                                                                  .call({
                                                            "mood": 'angry',
                                                          });
                                                          _model.angry =
                                                              SetMoodCloudFunctionCallResponse(
                                                            data: CFResultStruct
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
                                                          _model.angry =
                                                              SetMoodCloudFunctionCallResponse(
                                                            errorCode:
                                                                error.code,
                                                            succeeded: false,
                                                          );
                                                        }

                                                        if (_model
                                                            .angry!.data!.ok) {
                                                          try {
                                                            final result = await FirebaseFunctions
                                                                    .instanceFor(
                                                                        region:
                                                                            'europe-west3')
                                                                .httpsCallable(
                                                                    'sendPartnerPush')
                                                                .call({
                                                              "type":
                                                                  'mood_changed',
                                                              "route":
                                                                  'homehome',
                                                              "audience":
                                                                  'partner',
                                                            });
                                                            _model.cloudFunction6oy5 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              data: result.data,
                                                              succeeded: true,
                                                              resultAsString:
                                                                  result.data
                                                                      .toString(),
                                                              jsonBody:
                                                                  result.data,
                                                            );
                                                          } on FirebaseFunctionsException catch (error) {
                                                            _model.cloudFunction6oy5 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              errorCode:
                                                                  error.code,
                                                              succeeded: false,
                                                            );
                                                          }
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                _model
                                                                    .angry!
                                                                    .data!
                                                                    .message,
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                        }

                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'fdjj0fpn' /* 😡 */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineMediumFamily,
                                                                    fontSize:
                                                                        26.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .headlineMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
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
                                                        try {
                                                          final result =
                                                              await FirebaseFunctions
                                                                      .instanceFor(
                                                                          region:
                                                                              'europe-west3')
                                                                  .httpsCallable(
                                                                      'setMood')
                                                                  .call({
                                                            "mood": 'tired',
                                                          });
                                                          _model.tired =
                                                              SetMoodCloudFunctionCallResponse(
                                                            data: CFResultStruct
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
                                                          _model.tired =
                                                              SetMoodCloudFunctionCallResponse(
                                                            errorCode:
                                                                error.code,
                                                            succeeded: false,
                                                          );
                                                        }

                                                        if (_model
                                                            .tired!.data!.ok) {
                                                          try {
                                                            final result = await FirebaseFunctions
                                                                    .instanceFor(
                                                                        region:
                                                                            'europe-west3')
                                                                .httpsCallable(
                                                                    'sendPartnerPush')
                                                                .call({
                                                              "type":
                                                                  'mood_changed',
                                                              "route":
                                                                  'homehome',
                                                              "audience":
                                                                  'partner',
                                                            });
                                                            _model.cloudFunction6oy7 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              data: result.data,
                                                              succeeded: true,
                                                              resultAsString:
                                                                  result.data
                                                                      .toString(),
                                                              jsonBody:
                                                                  result.data,
                                                            );
                                                          } on FirebaseFunctionsException catch (error) {
                                                            _model.cloudFunction6oy7 =
                                                                SendPartnerPushCloudFunctionCallResponse(
                                                              errorCode:
                                                                  error.code,
                                                              succeeded: false,
                                                            );
                                                          }
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                _model
                                                                    .tired!
                                                                    .data!
                                                                    .message,
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                        }

                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                '11uuwym2' /* 😓 */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineMediumFamily,
                                                                    fontSize:
                                                                        26.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .headlineMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ].divide(SizedBox(height: 16.0)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 30.0, 0.0, 0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24.0),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 24.0,
                                  sigmaY: 24.0,
                                ),
                                child:
                                    StreamBuilder<List<DailyQuestionsRecord>>(
                                  stream: queryDailyQuestionsRecord(
                                    queryBuilder: (dailyQuestionsRecord) =>
                                        dailyQuestionsRecord
                                            .where(
                                              'date',
                                              isGreaterThanOrEqualTo:
                                                  functions.startOfTodayUtc(),
                                            )
                                            .where(
                                              'date',
                                              isLessThan: functions
                                                  .startOfTomorrowUtc(),
                                            )
                                            .orderBy('date'),
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
                                    List<DailyQuestionsRecord>
                                        containerDailyQuestionsRecordList =
                                        snapshot.data!;
                                    // Return an empty Container when the item does not exist.
                                    if (snapshot.data!.isEmpty) {
                                      return Container();
                                    }
                                    final containerDailyQuestionsRecord =
                                        containerDailyQuestionsRecordList
                                                .isNotEmpty
                                            ? containerDailyQuestionsRecordList
                                                .first
                                            : null;

                                    return Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0x194220E1),
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
                                          color: Color(0x34FFFFFF),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
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
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .nightlight_round,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                size: 30.0,
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'frcagdon' /* Sleep Status: */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleMediumFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontSize:
                                                                          20.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .titleMediumIsCustom,
                                                                    ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child:
                                                                    FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    try {
                                                                      final result = await FirebaseFunctions.instanceFor(
                                                                              region:
                                                                                  'europe-west3')
                                                                          .httpsCallable(
                                                                              'setSleepStatus')
                                                                          .call({
                                                                        "sleeping": containerRelationshipViewsRecord?.mySleepStatus ==
                                                                                true
                                                                            ? false
                                                                            : true,
                                                                      });
                                                                      _model.cloudFunctionSleep =
                                                                          SetSleepStatusCloudFunctionCallResponse(
                                                                        data: CFResultStruct.fromMap(
                                                                            result.data),
                                                                        succeeded:
                                                                            true,
                                                                        resultAsString: result
                                                                            .data
                                                                            .toString(),
                                                                        jsonBody:
                                                                            result.data,
                                                                      );
                                                                    } on FirebaseFunctionsException catch (error) {
                                                                      _model.cloudFunctionSleep =
                                                                          SetSleepStatusCloudFunctionCallResponse(
                                                                        errorCode:
                                                                            error.code,
                                                                        succeeded:
                                                                            false,
                                                                      );
                                                                    }

                                                                    if (_model
                                                                        .cloudFunctionSleep!
                                                                        .data!
                                                                        .ok) {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                          content:
                                                                              Text(
                                                                            _model.cloudFunctionSleep!.data!.message,
                                                                            style:
                                                                                TextStyle(
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                            ),
                                                                          ),
                                                                          duration:
                                                                              Duration(milliseconds: 4000),
                                                                          backgroundColor:
                                                                              FlutterFlowTheme.of(context).secondary,
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                          content:
                                                                              Text(
                                                                            _model.cloudFunctionSleep!.data!.message,
                                                                            style:
                                                                                TextStyle(
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                            ),
                                                                          ),
                                                                          duration:
                                                                              Duration(milliseconds: 4000),
                                                                          backgroundColor:
                                                                              FlutterFlowTheme.of(context).secondary,
                                                                        ),
                                                                      );
                                                                    }

                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  text: valueOrDefault<
                                                                      String>(
                                                                    containerRelationshipViewsRecord?.mySleepStatus ==
                                                                            true
                                                                        ? FFLocalizations.of(context)
                                                                            .getVariableText(
                                                                            enText:
                                                                                'Sleeping',
                                                                            deText:
                                                                                'Schlafe',
                                                                            esText:
                                                                                'Durmiendo',
                                                                          )
                                                                        : FFLocalizations.of(context)
                                                                            .getVariableText(
                                                                            enText:
                                                                                'Awake',
                                                                            deText:
                                                                                'Wach',
                                                                            esText:
                                                                                'Despierto',
                                                                          ),
                                                                    'SleepMode',
                                                                  ),
                                                                  options:
                                                                      FFButtonOptions(
                                                                    height:
                                                                        36.0,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    color: containerRelationshipViewsRecord?.mySleepStatus ==
                                                                            true
                                                                        ? Color(
                                                                            0xFFEF4444)
                                                                        : Color(
                                                                            0xFF22C55E),
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                        ),
                                                                    elevation:
                                                                        0.0,
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Colors
                                                                          .transparent,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.0),
                                                                  ),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 12.0)),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 4.0)),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 12.0)),
                                                ),
                                              ].divide(SizedBox(height: 16.0)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ]
                            .divide(SizedBox(height: 20.0))
                            .addToStart(SizedBox(height: 16.0))
                            .addToEnd(SizedBox(height: 100.0)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
