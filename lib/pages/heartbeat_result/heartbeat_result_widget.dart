import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/components/sharecard_heartbeat/sharecard_heartbeat_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:firebase_storagelibrary_2sa6k9/app_state.dart'
    as firebase_storagelibrary_2sa6k9_app_state;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'heartbeat_result_model.dart';
export 'heartbeat_result_model.dart';

/// Create a polished mobile result screen for a couple relationship app
/// feature called "Heartbeat".
///
/// The screen shows the daily shared connection score between two partners
/// after they complete a quick emotional check-in.
///
/// Design requirements:
/// - romantic and emotional visual identity
/// - soft pink, violet, and lavender gradient background
/// - modern premium mobile UI
/// - glassmorphism cards
/// - rounded corners and subtle glow effects
/// - clear hierarchy and spacing
///
/// Screen layout:
///
/// Header:
/// Title: "Your Heartbeat Today"
///
/// Partner section:
/// two circular profile images connected by a glowing heart symbol.
///
/// Main result section:
/// large circular component displaying:
/// - percentage score (example: 82%)
/// - connection label such as "Connected"
/// - soft glowing ring around the circle
///
/// Insight section:
/// a short supportive message describing the couple's emotional connection.
///
/// Action buttons:
/// - "Send something sweet"
/// - "Share Heartbeat"
///
/// The design should feel romantic and engaging but remain clean, realistic,
/// and suitable for FlutterFlow implementation.
class HeartbeatResultWidget extends StatefulWidget {
  const HeartbeatResultWidget({super.key});

  static String routeName = 'heartbeat_result';
  static String routePath = '/heartbeat';

  @override
  State<HeartbeatResultWidget> createState() => _HeartbeatResultWidgetState();
}

class _HeartbeatResultWidgetState extends State<HeartbeatResultWidget> {
  late HeartbeatResultModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HeartbeatResultModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'heartbeat_result'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        final result =
            await FirebaseFunctions.instanceFor(region: 'europe-west3')
                .httpsCallable('getHeartbeatSession')
                .call({});
        _model.cloudFunctionvs6 = GetHeartbeatSessionCloudFunctionCallResponse(
          data: HeartbeatGetCFResultStruct.fromMap(result.data),
          succeeded: true,
          resultAsString: result.data.toString(),
          jsonBody: result.data,
        );
      } on FirebaseFunctionsException catch (error) {
        _model.cloudFunctionvs6 = GetHeartbeatSessionCloudFunctionCallResponse(
          errorCode: error.code,
          succeeded: false,
        );
      }

      if (_model.cloudFunctionvs6?.data?.ok == true) {
        FFAppState().heartbeatSessionId =
            _model.cloudFunctionvs6!.data!.sessionId;
        FFAppState().heartbeatScorePercent =
            _model.cloudFunctionvs6!.data!.heartbeatScorePercent;
        FFAppState().heartbeatConnectionLabelKey =
            _model.cloudFunctionvs6!.data!.connectionLabelKey;
        FFAppState().heartbeatInsightEn =
            _model.cloudFunctionvs6!.data!.insightTextEn;
        FFAppState().heartbeatInsightDe =
            _model.cloudFunctionvs6!.data!.insightTextDe;
        FFAppState().heartbeatInsightEs =
            _model.cloudFunctionvs6!.data!.insightTextEs;
        FFAppState().heartbeatQuestion1En =
            _model.cloudFunctionvs6!.data!.question1TextEn;
        FFAppState().heartbeatQuestion2En =
            _model.cloudFunctionvs6!.data!.question2TextEn;
        FFAppState().heartbeatQuestion3En =
            _model.cloudFunctionvs6!.data!.question3TextEn;
        FFAppState().heartbeatQuestion1De =
            _model.cloudFunctionvs6!.data!.question1TextDe;
        FFAppState().heartbeatQuestion2De =
            _model.cloudFunctionvs6!.data!.question2TextDe;
        FFAppState().heartbeatQuestion3De =
            _model.cloudFunctionvs6!.data!.question3TextDe;
        FFAppState().heartbeatQuestion1Es =
            _model.cloudFunctionvs6!.data!.question1TextEs;
        FFAppState().heartbeatQuestion2Es =
            _model.cloudFunctionvs6!.data!.question2TextEs;
        FFAppState().heartbeatQuestion3Es =
            _model.cloudFunctionvs6!.data!.question3TextEs;
        FFAppState().heartbeatPartnerAnswer1 =
            _model.cloudFunctionvs6!.data!.partnerAnswer1.toDouble();
        FFAppState().heartbeatPartnerAnswer2 =
            _model.cloudFunctionvs6!.data!.partnerAnswer2.toDouble();
        FFAppState().heartbeatPartnerAnswer3 =
            _model.cloudFunctionvs6!.data!.partnerAnswer3.toDouble();
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
    context.watch<FFAppState>();
    context.watch<firebase_storagelibrary_2sa6k9_app_state.FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF0E6FF),
        body: AuthUserStreamWidget(
          builder: (context) => StreamBuilder<List<RelationshipViewsRecord>>(
            stream: queryRelationshipViewsRecord(
              queryBuilder: (relationshipViewsRecord) =>
                  relationshipViewsRecord.where(
                'relationship_id',
                isEqualTo:
                    valueOrDefault(currentUserDocument?.relationshipId, ''),
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
              List<RelationshipViewsRecord> stackRelationshipViewsRecordList =
                  snapshot.data!;
              final stackRelationshipViewsRecord =
                  stackRelationshipViewsRecordList.isNotEmpty
                      ? stackRelationshipViewsRecordList.first
                      : null;

              return Stack(
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
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x30000000),
                          offset: Offset(
                            0.0,
                            2.0,
                          ),
                        )
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 25.0, 8.0, 0.0),
                              child: FlutterFlowIconButton(
                                borderColor: Color(0x4D000000),
                                borderRadius: 20.0,
                                buttonSize: 40.0,
                                fillColor: Color(0x33FFFFFF),
                                icon: Icon(
                                  Icons.arrow_back_rounded,
                                  color: Color(0xFF8E24AA),
                                  size: 22.0,
                                ),
                                onPressed: () async {
                                  context.goNamed(
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
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 8.0, 24.0, 0.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                '9vdr8lgy' /* Your Heartbeat Today */,
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .headlineMediumFamily,
                                    color: Color(0xFF6A1A6A),
                                    fontSize: 22.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .headlineMediumIsCustom,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 4.0, 24.0, 0.0),
                            child: Text(
                              dateTimeFormat(
                                "EEEE • MMMM d",
                                getCurrentTimestamp,
                                locale:
                                    FFLocalizations.of(context).languageCode,
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: Color(0xFFAB47BC),
                                    fontSize: 13.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 24.0, 24.0, 24.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0x194220E1),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 24.0,
                                    color: Color(0x22CE93D9),
                                    offset: Offset(
                                      0.0,
                                      8.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(28.0),
                                border: Border.all(
                                  color: Color(0x34FFFFFF),
                                  width: 1.5,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: StreamBuilder<List<PublicUsersRecord>>(
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
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 72.0,
                                                  height: 72.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFFCE4EC),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 16.0,
                                                        color:
                                                            Color(0x44CE93D9),
                                                        offset: Offset(
                                                          0.0,
                                                          4.0,
                                                        ),
                                                      )
                                                    ],
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Color(0xFFCE93D9),
                                                      width: 3.0,
                                                    ),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.0),
                                                    child: Image.network(
                                                      columnPublicUsersRecord!
                                                          .photoUrl,
                                                      width: 72.0,
                                                      height: 72.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      stackRelationshipViewsRecord
                                                          ?.myName,
                                                      'name',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          color:
                                                              Color(0xFF8E24AA),
                                                          fontSize: 13.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMediumIsCustom,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 0.0, 12.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 44.0,
                                                    height: 44.0,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFFCE4EC),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 20.0,
                                                          color:
                                                              Color(0x66FF80AB),
                                                          offset: Offset(
                                                            0.0,
                                                            0.0,
                                                          ),
                                                        )
                                                      ],
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color:
                                                            Color(0xFFFF80AB),
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Icon(
                                                        Icons.favorite_rounded,
                                                        color:
                                                            Color(0xFFFF4081),
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 72.0,
                                                  height: 72.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFE8EAF6),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 16.0,
                                                        color:
                                                            Color(0x44CE93D9),
                                                        offset: Offset(
                                                          0.0,
                                                          4.0,
                                                        ),
                                                      )
                                                    ],
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Color(0xFFCE93D9),
                                                      width: 3.0,
                                                    ),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.0),
                                                    child: Image.network(
                                                      stackRelationshipViewsRecord!
                                                          .partnerPhotoUrl,
                                                      width: 72.0,
                                                      height: 72.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      stackRelationshipViewsRecord
                                                          .partnerName,
                                                      'name',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          color:
                                                              Color(0xFF8E24AA),
                                                          fontSize: 13.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMediumIsCustom,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ].divide(SizedBox(width: 0.0)),
                                        ),
                                      ].divide(SizedBox(height: 0.0)),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 32.0, 24.0, 32.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0x194220E1),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 32.0,
                                    color: Color(0x33FF80AB),
                                    offset: Offset(
                                      0.0,
                                      8.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(28.0),
                                border: Border.all(
                                  color: Color(0x34FFFFFF),
                                  width: 1.5,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Stack(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                children: [
                                                  Container(
                                                    width: 200.0,
                                                    height: 200.0,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Color(0x30FF80AB),
                                                          Color(0x30CE93FD)
                                                        ],
                                                        stops: [0.0, 1.0],
                                                        begin:
                                                            AlignmentDirectional(
                                                                0.0, -1.0),
                                                        end:
                                                            AlignmentDirectional(
                                                                0, 1.0),
                                                      ),
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 180.0,
                                                    height: 180.0,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 32.0,
                                                          color:
                                                              Color(0x50FF4081),
                                                          offset: Offset(
                                                            0.0,
                                                            0.0,
                                                          ),
                                                        )
                                                      ],
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Color(0xFFFCE4EC),
                                                          Color(0xFFF3E5F5)
                                                        ],
                                                        stops: [0.0, 1.0],
                                                        begin:
                                                            AlignmentDirectional(
                                                                0.0, -1.0),
                                                        end:
                                                            AlignmentDirectional(
                                                                0, 1.0),
                                                      ),
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color:
                                                            Color(0x60FF4081),
                                                        width: 3.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 148.0,
                                                    height: 148.0,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.white,
                                                          Color(0xFFF8F0FF)
                                                        ],
                                                        stops: [0.0, 1.0],
                                                        begin:
                                                            AlignmentDirectional(
                                                                0.0, -1.0),
                                                        end:
                                                            AlignmentDirectional(
                                                                0, 1.0),
                                                      ),
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color:
                                                            Color(0x30CE93FD),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    FFAppState()
                                                                        .heartbeatScorePercent
                                                                        .toString(),
                                                                    'score',
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .displaySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).displaySmallFamily,
                                                                        color: Color(
                                                                            0xFFE91E8C),
                                                                        fontSize:
                                                                            35.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        useGoogleFonts:
                                                                            !FlutterFlowTheme.of(context).displaySmallIsCustom,
                                                                      ),
                                                                ),
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'issioo70' /* % */,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .displaySmall
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .displaySmallFamily,
                                                                      color: Color(
                                                                          0xFFE91E8C),
                                                                      fontSize:
                                                                          25.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .displaySmallIsCustom,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                          () {
                                                            if (FFAppState()
                                                                    .heartbeatConnectionLabelKey ==
                                                                'deeply_connected') {
                                                              return () {
                                                                if (valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.appLanguage,
                                                                        '') ==
                                                                    'de') {
                                                                  return 'Tief verbunden';
                                                                } else if (valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.appLanguage,
                                                                        '') ==
                                                                    'es') {
                                                                  return 'Profundamente conectados';
                                                                } else {
                                                                  return 'Deeply connected';
                                                                }
                                                              }();
                                                            } else if (FFAppState()
                                                                    .heartbeatConnectionLabelKey ==
                                                                'connected') {
                                                              return () {
                                                                if (valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.appLanguage,
                                                                        '') ==
                                                                    'de') {
                                                                  return 'Verbunden';
                                                                } else if (valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.appLanguage,
                                                                        '') ==
                                                                    'es') {
                                                                  return 'Conectados';
                                                                } else {
                                                                  return 'Connected';
                                                                }
                                                              }();
                                                            } else if (FFAppState()
                                                                    .heartbeatConnectionLabelKey ==
                                                                'gently_needs_closeness') {
                                                              return () {
                                                                if (valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.appLanguage,
                                                                        '') ==
                                                                    'de') {
                                                                  return 'Es braucht etwas Nähe';
                                                                } else if (valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.appLanguage,
                                                                        '') ==
                                                                    'es') {
                                                                  return 'Necesita un poco más de cercanía';
                                                                } else {
                                                                  return 'Needs a little more closeness';
                                                                }
                                                              }();
                                                            } else if (FFAppState()
                                                                    .heartbeatConnectionLabelKey ==
                                                                'needs_closeness') {
                                                              return () {
                                                                if (valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.appLanguage,
                                                                        '') ==
                                                                    'de') {
                                                                  return 'Es braucht mehr Nähe';
                                                                } else if (valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.appLanguage,
                                                                        '') ==
                                                                    'es') {
                                                                  return 'Necesita cercanía';
                                                                } else {
                                                                  return 'Needs more closeness';
                                                                }
                                                              }();
                                                            } else {
                                                              return '';
                                                            }
                                                          }(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLargeFamily,
                                                                color: Colors
                                                                    .purple,
                                                                fontSize: 13.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelLargeIsCustom,
                                                              ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      6.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .favorite_rounded,
                                                                color: FFAppState()
                                                                            .heartbeatScorePercent >=
                                                                        1
                                                                    ? Color(
                                                                        0xFFFF4081)
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                size: 10.0,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .favorite_rounded,
                                                                color: FFAppState()
                                                                            .heartbeatScorePercent >=
                                                                        30
                                                                    ? Color(
                                                                        0xFFFF4081)
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                size: 10.0,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .favorite_rounded,
                                                                color: FFAppState()
                                                                            .heartbeatScorePercent >=
                                                                        50
                                                                    ? Color(
                                                                        0xFFFF4081)
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                size: 10.0,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .favorite_rounded,
                                                                color: FFAppState()
                                                                            .heartbeatScorePercent >=
                                                                        70
                                                                    ? Color(
                                                                        0xFFFF4081)
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                size: 10.0,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .favorite_rounded,
                                                                color: FFAppState()
                                                                            .heartbeatScorePercent >=
                                                                        90
                                                                    ? Color(
                                                                        0xFFFF4081)
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                size: 10.0,
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 3.0)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 14.0, 16.0, 14.0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color(0x6AFBF7FF),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          border: Border.all(
                                            color: Color(0x33FFCC80),
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.favorite_rounded,
                                                color: Color(0xFFFF4081),
                                                size: 18.0,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  () {
                                                    if (valueOrDefault(
                                                            currentUserDocument
                                                                ?.appLanguage,
                                                            '') ==
                                                        'de') {
                                                      return FFAppState()
                                                          .heartbeatInsightDe;
                                                    } else if (valueOrDefault(
                                                            currentUserDocument
                                                                ?.appLanguage,
                                                            '') ==
                                                        'es') {
                                                      return FFAppState()
                                                          .heartbeatInsightEs;
                                                    } else {
                                                      return FFAppState()
                                                          .heartbeatInsightEn;
                                                    }
                                                  }(),
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        color:
                                                            Color(0xFF6A1A6A),
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMediumIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 0.0)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 20.0, 24.0, 20.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0x194220E1),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 16.0,
                                    color: Color(0x22CE93D9),
                                    offset: Offset(
                                      0.0,
                                      4.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(24.0),
                                border: Border.all(
                                  color: Color(0x34FFFFFF),
                                  width: 1.5,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'y56zjula' /* Your partner's answers */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily,
                                            color: Color(0xFF8E24AA),
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .titleSmallIsCustom,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 36.0,
                                          height: 36.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFCE4EC),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Icon(
                                              Icons.favorite_rounded,
                                              color: Color(0xFFFF4081),
                                              size: 18.0,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                () {
                                                  if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.appLanguage,
                                                          '') ==
                                                      'de') {
                                                    return FFAppState()
                                                        .heartbeatQuestion1De;
                                                  } else if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.appLanguage,
                                                          '') ==
                                                      'es') {
                                                    return FFAppState()
                                                        .heartbeatQuestion1Es;
                                                  } else {
                                                    return FFAppState()
                                                        .heartbeatQuestion1En;
                                                  }
                                                }(),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumFamily,
                                                      color: Color(0xFFAB47BC),
                                                      fontSize: 12.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumIsCustom,
                                                    ),
                                              ),
                                              Text(
                                                FFAppState()
                                                    .heartbeatPartnerAnswer1
                                                    .toString(),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color: Color(0xFF6A1A6A),
                                                      fontSize: 13.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 12.0)),
                                    ),
                                    Divider(
                                      height: 1.0,
                                      thickness: 1.0,
                                      color: Color(0x22CE93D9),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 36.0,
                                          height: 36.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFE8EAF6),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Icon(
                                              Icons.star_rounded,
                                              color: Color(0xFF7E57C2),
                                              size: 18.0,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                () {
                                                  if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.appLanguage,
                                                          '') ==
                                                      'de') {
                                                    return FFAppState()
                                                        .heartbeatQuestion2De;
                                                  } else if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.appLanguage,
                                                          '') ==
                                                      'es') {
                                                    return FFAppState()
                                                        .heartbeatQuestion2Es;
                                                  } else {
                                                    return FFAppState()
                                                        .heartbeatQuestion2En;
                                                  }
                                                }(),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumFamily,
                                                      color: Color(0xFFAB47BC),
                                                      fontSize: 12.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumIsCustom,
                                                    ),
                                              ),
                                              Text(
                                                FFAppState()
                                                    .heartbeatPartnerAnswer2
                                                    .toString(),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color: Color(0xFF6A1A6A),
                                                      fontSize: 13.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 12.0)),
                                    ),
                                    Divider(
                                      height: 1.0,
                                      thickness: 1.0,
                                      color: Color(0x22CE93D9),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 36.0,
                                          height: 36.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFCE4EC),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Icon(
                                              Icons.wb_sunny_rounded,
                                              color: Color(0xFFFF4081),
                                              size: 18.0,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                () {
                                                  if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.appLanguage,
                                                          '') ==
                                                      'de') {
                                                    return FFAppState()
                                                        .heartbeatQuestion3De;
                                                  } else if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.appLanguage,
                                                          '') ==
                                                      'es') {
                                                    return FFAppState()
                                                        .heartbeatQuestion3Es;
                                                  } else {
                                                    return FFAppState()
                                                        .heartbeatQuestion3En;
                                                  }
                                                }(),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumFamily,
                                                      color: Color(0xFFAB47BC),
                                                      fontSize: 12.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumIsCustom,
                                                    ),
                                              ),
                                              Text(
                                                FFAppState()
                                                    .heartbeatPartnerAnswer3
                                                    .toString(),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color: Color(0xFF6A1A6A),
                                                      fontSize: 13.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 12.0)),
                                    ),
                                  ].divide(SizedBox(height: 12.0)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed(
                                      LoveNotePageWidget.routeName,
                                      extra: <String, dynamic>{
                                        '__transition_info__': TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                        ),
                                      },
                                    );
                                  },
                                  text: FFLocalizations.of(context).getText(
                                    'z2dwwi09' /* 💌  Send Something Sweet */,
                                  ),
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 54.0,
                                    padding: EdgeInsets.all(8.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: Color(0xAEFF4081),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .titleSmallIsCustom,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: SharecardHeartbeatWidget(),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                  text: FFLocalizations.of(context).getText(
                                    'unocio8y' /* Share Your Result */,
                                  ),
                                  icon: Icon(
                                    Icons.share_rounded,
                                    size: 20.0,
                                  ),
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 54.0,
                                    padding: EdgeInsets.all(8.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconColor: Color(0xFFAD1457),
                                    color: Color(0xA1FCE4EC),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                          color: Color(0xFFAD1457),
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .titleSmallIsCustom,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: Color(0x9AFF80AB),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                              ].divide(SizedBox(height: 12.0)),
                            ),
                          ),
                        ]
                            .divide(SizedBox(height: 0.0))
                            .addToStart(SizedBox(height: 16.0))
                            .addToEnd(SizedBox(height: 40.0)),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
