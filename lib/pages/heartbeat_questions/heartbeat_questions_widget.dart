import '/auth/firebase_auth/auth_util.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/index.dart';
import 'package:firebase_storagelibrary_2sa6k9/app_state.dart'
    as firebase_storagelibrary_2sa6k9_app_state;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'heartbeat_questions_model.dart';
export 'heartbeat_questions_model.dart';

/// Create a romantic relationship app screen called “Heartbeat”.
///
/// The screen should feel soft, emotional, and intimate. Use a dreamy
/// gradient background with soft pink, lavender, and warm purple tones. The
/// design should feel modern, calm, and slightly glowing.
///
/// Layout structure:
///
/// TOP SECTION
/// Show a small date label at the top:
/// "Monday, June 10"
///
/// Below it a large title:
/// "Your Heartbeat Today"
///
/// Under the title show a small subtitle:
/// "A daily emotional check-in for you and your partner."
///
/// PARTNER CARD
/// Create a rounded glass-style card in the center with soft shadow and blur
/// effect.
///
/// Inside the card show:
/// • Left: circular profile image for Partner 1
/// • Center: small heart icon with subtle glow
/// • Right: circular profile image for Partner 2
///
/// Below the avatars show their names:
/// "Sophia" and "Liam"
///
/// Make the avatars slightly elevated with a soft border glow.
///
/// INFO SECTION
/// Below the partner card show a short explanation text:
///
/// "Take a moment to answer three quick questions.
/// Your answers will reveal how emotionally connected you feel today."
///
/// This text should be centered and soft grey/purple.
///
/// START BUTTON
/// Add a large rounded gradient button:
///
/// Text:
/// "Start Heartbeat"
///
/// Style:
/// • pink → purple gradient
/// • soft glow
/// • large rounded corners
/// • heart icon on the left
///
/// SECONDARY INFO
/// Below the button show a small caption:
///
/// "Takes less than 30 seconds"
///
/// OPTIONAL DECOR
/// Add soft floating heart shapes or glowing circles in the background for
/// atmosphere.
///
/// STYLE
/// • Romantic
/// • Calm
/// • Minimal
/// • Rounded corners everywhere
/// • Soft shadows
/// • Gentle gradients
/// • Mobile-first design
///
/// The screen should feel like a premium relationship wellness app.
class HeartbeatQuestionsWidget extends StatefulWidget {
  const HeartbeatQuestionsWidget({
    super.key,
    required this.sessionId,
  });

  final String? sessionId;

  static String routeName = 'Heartbeat_questions';
  static String routePath = '/heartbeatQuestions';

  @override
  State<HeartbeatQuestionsWidget> createState() =>
      _HeartbeatQuestionsWidgetState();
}

class _HeartbeatQuestionsWidgetState extends State<HeartbeatQuestionsWidget> {
  late HeartbeatQuestionsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HeartbeatQuestionsModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'Heartbeat_questions'});
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
        backgroundColor: Color(0xFF1A0A1E),
        body: Stack(
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
                        Color(0xC812051A),
                        Color(0x3F2B0F3D),
                        Color(0x6F12051A)
                      ],
                      stops: [0.0, 0.45, 1.0],
                      begin: AlignmentDirectional(0.0, -1.0),
                      end: AlignmentDirectional(0, 1.0),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 30.0, 24.0, 32.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    28.0, 20.0, 28.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 32.0,
                                              height: 32.0,
                                              decoration: BoxDecoration(
                                                color: Color(0x33FFFFFF),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Lottie.asset(
                                                'assets/jsons/Heartbeat_Soft.json',
                                                width: 200.0,
                                                height: 200.0,
                                                fit: BoxFit.contain,
                                                animate: true,
                                              ),
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '4wsuryp8' /* Heartbeat */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .tertiary,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(0x33EC407A),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 6.0, 12.0, 6.0),
                                            child: Text(
                                              () {
                                                if (FFAppState()
                                                        .heartbeatCurrentIndex ==
                                                    0) {
                                                  return '1';
                                                } else if (FFAppState()
                                                        .heartbeatCurrentIndex ==
                                                    1) {
                                                  return '2';
                                                } else {
                                                  return '3';
                                                }
                                              }(),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallIsCustom,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 6.0,
                                      decoration: BoxDecoration(
                                        color: Color(0x33FFFFFF),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.33,
                                        height: 6.0,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFFEC407A),
                                              Color(0xFFAB47BC)
                                            ],
                                            stops: [0.0, 1.0],
                                            begin:
                                                AlignmentDirectional(1.0, 0.0),
                                            end: AlignmentDirectional(-1.0, 0),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 10.0)),
                                ),
                              ),
                              if (FFAppState().heartbeatCurrentIndex == 0)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      28.0, 0.0, 28.0, 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x66EC407A),
                                          offset: Offset(
                                            0.0,
                                            8.0,
                                          ),
                                        )
                                      ],
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0x33FFFFFF),
                                          Color(0x1AFFFFFF)
                                        ],
                                        stops: [0.0, 1.0],
                                        begin: AlignmentDirectional(0.0, -1.0),
                                        end: AlignmentDirectional(0, 1.0),
                                      ),
                                      borderRadius: BorderRadius.circular(28.0),
                                      border: Border.all(
                                        color: Color(0x33FFFFFF),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Container(
                                              width: 56.0,
                                              height: 56.0,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFFEC407A),
                                                    Color(0xFFAB47BC)
                                                  ],
                                                  stops: [0.0, 1.0],
                                                  begin: AlignmentDirectional(
                                                      1.0, 1.0),
                                                  end: AlignmentDirectional(
                                                      -1.0, -1.0),
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: Colors.white,
                                                  size: 28.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: AuthUserStreamWidget(
                                              builder: (context) => Text(
                                                valueOrDefault<String>(
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
                                                  'Question',
                                                ),
                                                textAlign: TextAlign.center,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMediumFamily,
                                                          color: Colors.white,
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          lineHeight: 1.4,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMediumIsCustom,
                                                        ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'edt090dg' /* Take a moment to reflect on yo... */,
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .accent1,
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    lineHeight: 1.5,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 20.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              if (FFAppState().heartbeatCurrentIndex == 1)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      28.0, 0.0, 28.0, 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x66EC407A),
                                          offset: Offset(
                                            0.0,
                                            8.0,
                                          ),
                                        )
                                      ],
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0x33FFFFFF),
                                          Color(0x1AFFFFFF)
                                        ],
                                        stops: [0.0, 1.0],
                                        begin: AlignmentDirectional(0.0, -1.0),
                                        end: AlignmentDirectional(0, 1.0),
                                      ),
                                      borderRadius: BorderRadius.circular(28.0),
                                      border: Border.all(
                                        color: Color(0x33FFFFFF),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Container(
                                              width: 56.0,
                                              height: 56.0,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFFEC407A),
                                                    Color(0xFFAB47BC)
                                                  ],
                                                  stops: [0.0, 1.0],
                                                  begin: AlignmentDirectional(
                                                      1.0, 1.0),
                                                  end: AlignmentDirectional(
                                                      -1.0, -1.0),
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: Colors.white,
                                                  size: 28.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: AuthUserStreamWidget(
                                              builder: (context) => Text(
                                                valueOrDefault<String>(
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
                                                  'Question',
                                                ),
                                                textAlign: TextAlign.center,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMediumFamily,
                                                          color: Colors.white,
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          lineHeight: 1.4,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMediumIsCustom,
                                                        ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '18g0ihqf' /* Take a moment to reflect on yo... */,
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .accent1,
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    lineHeight: 1.5,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 20.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              if (FFAppState().heartbeatCurrentIndex == 2)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      28.0, 0.0, 28.0, 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x66EC407A),
                                          offset: Offset(
                                            0.0,
                                            8.0,
                                          ),
                                        )
                                      ],
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0x33FFFFFF),
                                          Color(0x1AFFFFFF)
                                        ],
                                        stops: [0.0, 1.0],
                                        begin: AlignmentDirectional(0.0, -1.0),
                                        end: AlignmentDirectional(0, 1.0),
                                      ),
                                      borderRadius: BorderRadius.circular(28.0),
                                      border: Border.all(
                                        color: Color(0x33FFFFFF),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Container(
                                              width: 56.0,
                                              height: 56.0,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFFEC407A),
                                                    Color(0xFFAB47BC)
                                                  ],
                                                  stops: [0.0, 1.0],
                                                  begin: AlignmentDirectional(
                                                      1.0, 1.0),
                                                  end: AlignmentDirectional(
                                                      -1.0, -1.0),
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: Colors.white,
                                                  size: 28.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: AuthUserStreamWidget(
                                              builder: (context) => Text(
                                                valueOrDefault<String>(
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
                                                  'Question',
                                                ),
                                                textAlign: TextAlign.center,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMediumFamily,
                                                          color: Colors.white,
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          lineHeight: 1.4,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMediumIsCustom,
                                                        ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                's1vjutsa' /* Take a moment to reflect on yo... */,
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .accent1,
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    lineHeight: 1.5,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 20.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'oef4v62l' /* Rate how strongly this applies... */,
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
                                            fontSize: 13.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.selectedAnswerThisPage =
                                                      1;
                                                  safeSetState(() {});
                                                  if (FFAppState()
                                                          .heartbeatCurrentIndex ==
                                                      0) {
                                                    FFAppState()
                                                        .heartbeatAnswer1 = 1;
                                                    safeSetState(() {});
                                                  } else {
                                                    if (FFAppState()
                                                            .heartbeatCurrentIndex ==
                                                        1) {
                                                      FFAppState()
                                                          .heartbeatAnswer2 = 1;
                                                      safeSetState(() {});
                                                    } else {
                                                      FFAppState()
                                                          .heartbeatAnswer3 = 1;
                                                      safeSetState(() {});
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  width:
                                                      _model.selectedAnswerThisPage ==
                                                              1
                                                          ? 60.0
                                                          : 54.0,
                                                  height:
                                                      _model.selectedAnswerThisPage ==
                                                              1
                                                          ? 60.0
                                                          : 54.0,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x445C6BC0),
                                                        offset: Offset(
                                                          0.0,
                                                          4.0,
                                                        ),
                                                      )
                                                    ],
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFF5C6BC0),
                                                        Color(0xFF3949AB)
                                                      ],
                                                      stops: [0.0, 1.0],
                                                      begin:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      end: AlignmentDirectional(
                                                          0, 1.0),
                                                    ),
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Color(0x665C6BC0),
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'lepkvocx' /* 1 */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            color: Colors.white,
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'vd163tw8' /* Very weak */,
                                                ),
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodySmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      fontSize: 10.0,
                                                      letterSpacing: 0.0,
                                                      lineHeight: 1.3,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallIsCustom,
                                                    ),
                                              ),
                                            ].divide(SizedBox(height: 8.0)),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.selectedAnswerThisPage =
                                                      2;
                                                  safeSetState(() {});
                                                  if (FFAppState()
                                                          .heartbeatCurrentIndex ==
                                                      0) {
                                                    FFAppState()
                                                        .heartbeatAnswer1 = 2;
                                                    safeSetState(() {});
                                                  } else {
                                                    if (FFAppState()
                                                            .heartbeatCurrentIndex ==
                                                        1) {
                                                      FFAppState()
                                                          .heartbeatAnswer2 = 2;
                                                      safeSetState(() {});
                                                    } else {
                                                      FFAppState()
                                                          .heartbeatAnswer3 = 2;
                                                      safeSetState(() {});
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  width:
                                                      _model.selectedAnswerThisPage ==
                                                              2
                                                          ? 60.0
                                                          : 54.0,
                                                  height:
                                                      _model.selectedAnswerThisPage ==
                                                              2
                                                          ? 60.0
                                                          : 54.0,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x447E57C2),
                                                        offset: Offset(
                                                          0.0,
                                                          4.0,
                                                        ),
                                                      )
                                                    ],
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFF7E57C2),
                                                        Color(0xFF5C35B5)
                                                      ],
                                                      stops: [0.0, 1.0],
                                                      begin:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      end: AlignmentDirectional(
                                                          0, 1.0),
                                                    ),
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Color(0x667E57C2),
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'dhzy63hb' /* 2 */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            color: Colors.white,
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'vw7lw76d' /* Weak */,
                                                ),
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodySmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      fontSize: 10.0,
                                                      letterSpacing: 0.0,
                                                      lineHeight: 1.3,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallIsCustom,
                                                    ),
                                              ),
                                            ].divide(SizedBox(height: 8.0)),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.selectedAnswerThisPage =
                                                      3;
                                                  safeSetState(() {});
                                                  if (FFAppState()
                                                          .heartbeatCurrentIndex ==
                                                      0) {
                                                    FFAppState()
                                                        .heartbeatAnswer1 = 3;
                                                    safeSetState(() {});
                                                  } else {
                                                    if (FFAppState()
                                                            .heartbeatCurrentIndex ==
                                                        1) {
                                                      FFAppState()
                                                          .heartbeatAnswer2 = 3;
                                                      safeSetState(() {});
                                                    } else {
                                                      FFAppState()
                                                          .heartbeatAnswer3 = 3;
                                                      safeSetState(() {});
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  width:
                                                      _model.selectedAnswerThisPage ==
                                                              3
                                                          ? 60.0
                                                          : 54.0,
                                                  height:
                                                      _model.selectedAnswerThisPage ==
                                                              3
                                                          ? 60.0
                                                          : 54.0,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFFEC407A),
                                                        Color(0xFFAB47BC)
                                                      ],
                                                      stops: [0.0, 1.0],
                                                      begin:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      end: AlignmentDirectional(
                                                          0, 1.0),
                                                    ),
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Color(0xAAEC407A),
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'gah7li8u' /* 3 */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            color: Colors.white,
                                                            fontSize: 22.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'z18j5vgi' /* Neutral */,
                                                ),
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodySmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      fontSize: 10.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallIsCustom,
                                                    ),
                                              ),
                                            ].divide(SizedBox(height: 8.0)),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.selectedAnswerThisPage =
                                                      4;
                                                  safeSetState(() {});
                                                  if (FFAppState()
                                                          .heartbeatCurrentIndex ==
                                                      0) {
                                                    FFAppState()
                                                        .heartbeatAnswer1 = 4;
                                                    safeSetState(() {});
                                                  } else {
                                                    if (FFAppState()
                                                            .heartbeatCurrentIndex ==
                                                        1) {
                                                      FFAppState()
                                                          .heartbeatAnswer2 = 4;
                                                      safeSetState(() {});
                                                    } else {
                                                      FFAppState()
                                                          .heartbeatAnswer3 = 4;
                                                      safeSetState(() {});
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  width:
                                                      _model.selectedAnswerThisPage ==
                                                              4
                                                          ? 60.0
                                                          : 54.0,
                                                  height:
                                                      _model.selectedAnswerThisPage ==
                                                              4
                                                          ? 60.0
                                                          : 54.0,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x44E91E8C),
                                                        offset: Offset(
                                                          0.0,
                                                          4.0,
                                                        ),
                                                      )
                                                    ],
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xDCE71180),
                                                        Color(0xFFEC407A)
                                                      ],
                                                      stops: [0.0, 1.0],
                                                      begin:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      end: AlignmentDirectional(
                                                          0, 1.0),
                                                    ),
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Color(0x66E91E8C),
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '16azjzzx' /* 4 */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            color: Colors.white,
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'og8ithsu' /* Strong */,
                                                ),
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodySmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      fontSize: 10.0,
                                                      letterSpacing: 0.0,
                                                      lineHeight: 1.3,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallIsCustom,
                                                    ),
                                              ),
                                            ].divide(SizedBox(height: 8.0)),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.selectedAnswerThisPage =
                                                      5;
                                                  safeSetState(() {});
                                                  if (FFAppState()
                                                          .heartbeatCurrentIndex ==
                                                      0) {
                                                    FFAppState()
                                                        .heartbeatAnswer1 = 5;
                                                    safeSetState(() {});
                                                  } else {
                                                    if (FFAppState()
                                                            .heartbeatCurrentIndex ==
                                                        1) {
                                                      FFAppState()
                                                          .heartbeatAnswer2 = 5;
                                                      safeSetState(() {});
                                                    } else {
                                                      FFAppState()
                                                          .heartbeatAnswer3 = 5;
                                                      safeSetState(() {});
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  width:
                                                      _model.selectedAnswerThisPage ==
                                                              5
                                                          ? 60.0
                                                          : 54.0,
                                                  height:
                                                      _model.selectedAnswerThisPage ==
                                                              5
                                                          ? 60.0
                                                          : 54.0,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x44FF4081),
                                                        offset: Offset(
                                                          0.0,
                                                          4.0,
                                                        ),
                                                      )
                                                    ],
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFFEE407B),
                                                        Color(0xFFFF008A)
                                                      ],
                                                      stops: [0.0, 1.0],
                                                      begin:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      end: AlignmentDirectional(
                                                          0, 1.0),
                                                    ),
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Color(0x66FF4081),
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'r8uipzub' /* 5 */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            color: Colors.white,
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'q90618so' /* Very strong */,
                                                ),
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodySmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      fontSize: 10.0,
                                                      letterSpacing: 0.0,
                                                      lineHeight: 1.3,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallIsCustom,
                                                    ),
                                              ),
                                            ].divide(SizedBox(height: 8.0)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 16.0)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: Color(0x00F2ECFF),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                          if (_model.selectedAnswerThisPage! > 0)
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    if (FFAppState().heartbeatCurrentIndex <
                                        2) {
                                      _model.selectedAnswerThisPage = 0;
                                      safeSetState(() {});
                                      FFAppState().heartbeatCurrentIndex =
                                          FFAppState().heartbeatCurrentIndex +
                                              1;
                                      safeSetState(() {});
                                    } else {
                                      try {
                                        final result =
                                            await FirebaseFunctions.instanceFor(
                                                    region: 'europe-west3')
                                                .httpsCallable(
                                                    'submitHeartbeatAnswers')
                                                .call({
                                          "sessionId":
                                              FFAppState().heartbeatSessionId,
                                          "answer1":
                                              FFAppState().heartbeatAnswer1,
                                          "answer2":
                                              FFAppState().heartbeatAnswer2,
                                          "answer3":
                                              FFAppState().heartbeatAnswer3,
                                        });
                                        _model.heartbeatSubmitResult =
                                            SubmitHeartbeatAnswersCloudFunctionCallResponse(
                                          data: HeartbeatSubmitCFResultStruct
                                              .fromMap(result.data),
                                          succeeded: true,
                                          resultAsString:
                                              result.data.toString(),
                                          jsonBody: result.data,
                                        );
                                      } on FirebaseFunctionsException catch (error) {
                                        _model.heartbeatSubmitResult =
                                            SubmitHeartbeatAnswersCloudFunctionCallResponse(
                                          errorCode: error.code,
                                          succeeded: false,
                                        );
                                      }

                                      FFAppState().heartbeatScorePercent =
                                          _model.heartbeatSubmitResult!.data!
                                              .heartbeatScorePercent;
                                      FFAppState().heartbeatConnectionLabelKey =
                                          _model.heartbeatSubmitResult!.data!
                                              .connectionLabelKey;
                                      FFAppState().heartbeatInsightEn = _model
                                          .heartbeatSubmitResult!
                                          .data!
                                          .insightTextEn;
                                      FFAppState().heartbeatInsightDe = _model
                                          .heartbeatSubmitResult!
                                          .data!
                                          .insightTextDe;
                                      FFAppState().heartbeatInsightEs = _model
                                          .heartbeatSubmitResult!
                                          .data!
                                          .insightTextEs;
                                      FFAppState().heartbeatPartnerAnswer1 =
                                          _model.heartbeatSubmitResult!.data!
                                              .partnerAnswer1
                                              .toDouble();
                                      FFAppState().heartbeatPartnerAnswer2 =
                                          _model.heartbeatSubmitResult!.data!
                                              .partnerAnswer2
                                              .toDouble();
                                      FFAppState().heartbeatPartnerAnswer3 =
                                          _model.heartbeatSubmitResult!.data!
                                              .partnerAnswer3
                                              .toDouble();
                                      safeSetState(() {});
                                      if (_model.heartbeatSubmitResult?.data
                                              ?.bothAnswered ==
                                          true) {
                                        context.goNamed(
                                          HeartbeatResultWidget.routeName,
                                          extra: <String, dynamic>{
                                            '__transition_info__':
                                                TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                            ),
                                          },
                                        );
                                      } else {
                                        context.goNamed(
                                          HeartbeatWaitWidget.routeName,
                                          extra: <String, dynamic>{
                                            '__transition_info__':
                                                TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                            ),
                                          },
                                        );
                                      }
                                    }

                                    safeSetState(() {});
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 58.0,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFEC407A),
                                          Color(0xFFAB47BC),
                                          Color(0xFF7C4DFF)
                                        ],
                                        stops: [0.0, 0.5, 1.0],
                                        begin: AlignmentDirectional(1.0, 0.0),
                                        end: AlignmentDirectional(-1.0, 0),
                                      ),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              '62qthx3f' /* Next */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMediumFamily,
                                                  color: Colors.white,
                                                  fontSize: 18.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .titleMediumIsCustom,
                                                ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Icon(
                                            Icons.arrow_forward_rounded,
                                            color: Colors.white,
                                            size: 20.0,
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 10.0)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 30.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.lock_outline,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 14.0,
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'yg7j4zqh' /* Your answers are private and s... */,
                                        ),
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmallFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 11.0,
                                              letterSpacing: 0.0,
                                              lineHeight: 1.4,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodySmallIsCustom,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 6.0)),
                                  ),
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
