import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'heartbeat_wait_model.dart';
export 'heartbeat_wait_model.dart';

/// Create a mobile app screen for a relationship app feature called
/// **“Heartbeat”**.
///
/// This screen is used for answering one emotional question during a daily
/// couple check-in.
///
/// STYLE
/// The design should match a romantic relationship app with soft gradients,
/// glowing elements, rounded corners, and a calm emotional atmosphere.
/// Use a dreamy pink / purple gradient background with subtle hearts or soft
/// glowing shapes.
/// The UI should feel modern, intimate, and premium.
///
/// LAYOUT STRUCTURE
///
/// TOP SECTION
/// At the top show a small progress indicator:
///
/// "Question 1 of 3"
///
/// Below it show a thin progress bar representing the current step in the
/// heartbeat session.
///
/// QUESTION CARD
/// In the center of the screen create a glass-style rounded card with soft
/// blur and shadow.
///
/// Inside the card display the question text in large centered typography.
///
/// Example question:
/// "How emotionally connected do you feel today?"
///
/// Make the text large, readable, and centered.
///
/// ANSWER OPTIONS
/// Below the question show a **horizontal emotional scale with 5 selectable
/// options**.
///
/// The options should be large circular buttons with subtle glow and soft
/// color gradients.
///
/// Example labels below each circle:
///
/// 1 – Very distant
/// 2 – A little distant
/// 3 – Neutral
/// 4 – Close
/// 5 – Very close
///
/// The user taps one option to select it.
///
/// When selected, the circle should glow or slightly enlarge to indicate
/// selection.
///
/// NEXT BUTTON
/// Below the answer scale place a large rounded gradient button:
///
/// Text:
/// "Next"
///
/// Style:
/// • pink → purple gradient
/// • large rounded corners
/// • soft glow
///
/// The button should be disabled until an answer is selected.
///
/// BOTTOM SECTION
/// At the bottom show a small subtle caption:
///
/// "Your answers are private and shared only with your partner."
///
/// STYLE DETAILS
///
/// • Romantic and calm visual design
/// • Soft glowing UI elements
/// • Rounded corners everywhere
/// • Gentle shadows and gradients
/// • Mobile-first layout
/// • Clean spacing with strong focus on the question
///
/// The screen should feel emotionally safe and easy to use.
class HeartbeatWaitWidget extends StatefulWidget {
  const HeartbeatWaitWidget({super.key});

  static String routeName = 'Heartbeat_wait';
  static String routePath = '/heartbeatWait';

  @override
  State<HeartbeatWaitWidget> createState() => _HeartbeatWaitWidgetState();
}

class _HeartbeatWaitWidgetState extends State<HeartbeatWaitWidget> {
  late HeartbeatWaitModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HeartbeatWaitModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'Heartbeat_wait'});
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
        backgroundColor: Color(0xFF1A1A2E),
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
                      gradient: LinearGradient(
                        colors: [
                          Color(0x9112051A),
                          Color(0x4B2B0F3D),
                          Color(0x8312051A)
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
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 30.0, 0.0, 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0x194220E1),
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                  color: Color(0x44FFFFFF),
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    14.0, 8.0, 14.0, 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.favorite_rounded,
                                      color: Color(0xFFFFD6E0),
                                      size: 16.0,
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '6clytr63' /* Heartbeat */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelMediumFamily,
                                            color: Color(0xFFFFD6E0),
                                            fontSize: 13.0,
                                            letterSpacing: 1.0,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelMediumIsCustom,
                                          ),
                                    ),
                                  ].divide(SizedBox(width: 6.0)),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'glrqo173' /* You've completed today's heart... */,
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .headlineMediumFamily,
                                      color: Colors.white,
                                      fontSize: 26.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      lineHeight: 1.3,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .headlineMediumIsCustom,
                                    ),
                              ),
                              Text(
                                FFLocalizations.of(context).getText(
                                  '68pdvjyy' /* Your answers were saved. We're... */,
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: Color(0xCCFFFFFF),
                                      fontSize: 15.0,
                                      letterSpacing: 0.0,
                                      lineHeight: 1.5,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                              ),
                            ].divide(SizedBox(height: 10.0)),
                          ),
                        ].divide(SizedBox(height: 12.0)),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 28.0, 24.0, 28.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0x194220E1),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 24.0,
                                color: Color(0x33FF6B9D),
                              )
                            ],
                            borderRadius: BorderRadius.circular(28.0),
                            border: Border.all(
                              color: Color(0x44FFFFFF),
                              width: 1.5,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: StreamBuilder<
                                          List<PublicUsersRecord>>(
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
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Stack(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Container(
                                                      width: 72.0,
                                                      height: 72.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0x44FF6B9D),
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color:
                                                              Color(0xFFFFD6E0),
                                                          width: 2.5,
                                                        ),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(36.0),
                                                        child: Image.network(
                                                          columnPublicUsersRecord!
                                                              .photoUrl,
                                                          width: 72.0,
                                                          height: 72.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1.0, 1.0),
                                                    child: Container(
                                                      width: 22.0,
                                                      height: 22.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: Colors.white,
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Icon(
                                                          Icons.check_rounded,
                                                          color: Colors.white,
                                                          size: 12.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                valueOrDefault<String>(
                                                  columnPublicUsersRecord.name,
                                                  'Name',
                                                ),
                                                textAlign: TextAlign.center,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          color: Colors.white,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                              ),
                                            ].divide(SizedBox(height: 8.0)),
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Container(
                                              width: 52.0,
                                              height: 52.0,
                                              decoration: BoxDecoration(
                                                color: Color(0x33FF6B9D),
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Color(0x66FF6B9D),
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: Lottie.asset(
                                                'assets/jsons/Heartbeat_Soft.json',
                                                width: 200.0,
                                                height: 200.0,
                                                fit: BoxFit.contain,
                                                animate: true,
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 4.0)),
                                      ),
                                    ),
                                    Expanded(
                                      child: StreamBuilder<
                                          List<RelationshipViewsRecord>>(
                                        stream: queryRelationshipViewsRecord(
                                          queryBuilder:
                                              (relationshipViewsRecord) =>
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
                                              columnRelationshipViewsRecordList =
                                              snapshot.data!;
                                          final columnRelationshipViewsRecord =
                                              columnRelationshipViewsRecordList
                                                      .isNotEmpty
                                                  ? columnRelationshipViewsRecordList
                                                      .first
                                                  : null;

                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Stack(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Container(
                                                      width: 72.0,
                                                      height: 72.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0x44C44569),
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color:
                                                              Color(0x66FFFFFF),
                                                          width: 2.5,
                                                        ),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(36.0),
                                                        child: Image.network(
                                                          columnRelationshipViewsRecord!
                                                              .partnerPhotoUrl,
                                                          width: 72.0,
                                                          height: 72.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1.0, 1.0),
                                                    child: Container(
                                                      width: 22.0,
                                                      height: 22.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0x66FFFFFF),
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: Colors.white,
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Icon(
                                                          Icons
                                                              .hourglass_empty_rounded,
                                                          color: Colors.white,
                                                          size: 12.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                valueOrDefault<String>(
                                                  columnRelationshipViewsRecord
                                                      .partnerName,
                                                  'Name2',
                                                ),
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color: Color(0xCCFFFFFF),
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                              ),
                                            ].divide(SizedBox(height: 8.0)),
                                          );
                                        },
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 0.0)),
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: Color(0x33FFFFFF),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 6.0, 10.0, 6.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0x63F9F6FF),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(12.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    Icons.schedule_rounded,
                                                    color: Color(0xFFA55027),
                                                    size: 14.0,
                                                  ),
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'qpoead4r' /* Waiting for your partner… */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMediumIsCustom,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(width: 6.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                  ].divide(SizedBox(height: 12.0)),
                                ),
                              ].divide(SizedBox(height: 20.0)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 16.0, 24.0, 16.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0x194220E1),
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: Color(0x33FFFFFF),
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.lock_open_rounded,
                                  color: Color(0xFFFFD6E0),
                                  size: 18.0,
                                ),
                                Expanded(
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'ja78ikoh' /* As soon as your partner answer... */,
                                    ),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          lineHeight: 1.5,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 10.0)),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
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
                            child: Container(
                              width: double.infinity,
                              height: 54.0,
                              decoration: BoxDecoration(
                                color: Color(0x194220E1),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 16.0,
                                    color: Color(0x33FF6B9D),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(27.0),
                                border: Border.all(
                                  color: Color(0x66FFFFFF),
                                  width: 1.5,
                                ),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.home_rounded,
                                        color: Colors.white,
                                        size: 18.0,
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'uxmm41jw' /* Back to Home */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily,
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .titleSmallIsCustom,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 10.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'hbittgtw' /* You'll automatically see the r... */,
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodySmallFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    lineHeight: 1.4,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodySmallIsCustom,
                                  ),
                            ),
                          ),
                        ].divide(SizedBox(height: 12.0)),
                      ),
                    ]
                        .addToStart(SizedBox(height: 24.0))
                        .addToEnd(SizedBox(height: 40.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
