import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'celebrate_model.dart';
export 'celebrate_model.dart';

/// Design a joyful, high-energy celebration screen for a relationship app
/// after two partners reconnect.
///
/// Use a vibrant pink–purple gradient background with depth and motion. Add
/// animated confetti, floating hearts, and subtle light particles moving
/// upward to create a feeling of celebration and relief.
///
/// In the center, place a large bold headline: “You’re together again 💕”
/// with playful typography and a soft glow.
///
/// Below it, add a very short message (1–2 lines max) about love finding its
/// way back — no long paragraphs.
///
/// Include a big animated heart or two hearts merging together, slightly
/// bouncing or pulsing.
///
/// Avoid cards with long text blocks. The screen should feel light,
/// emotional, and exciting — like a victory moment.
///
/// At the bottom, show a minimal animated loader or sparkle to indicate a
/// short transition.
class CelebrateWidget extends StatefulWidget {
  const CelebrateWidget({super.key});

  static String routeName = 'celebrate';
  static String routePath = '/celebrate';

  @override
  State<CelebrateWidget> createState() => _CelebrateWidgetState();
}

class _CelebrateWidgetState extends State<CelebrateWidget> {
  late CelebrateModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CelebrateModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'celebrate'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await currentUserReference!.update(createUsersRecordData(
        celebrateReconnect: false,
        restoreRequired: false,
      ));
      _model.soundPlayer ??= AudioPlayer();
      if (_model.soundPlayer!.playing) {
        await _model.soundPlayer!.stop();
      }
      _model.soundPlayer!.setVolume(1.0);
      _model.soundPlayer!
          .setAsset('assets/audios/love-is-in-the-air-cutmp3.mp3')
          .then((_) => _model.soundPlayer!.play());

      await Future.delayed(
        Duration(
          milliseconds: 3500,
        ),
      );

      context.goNamed(
        HomeWidget.routeName,
        extra: <String, dynamic>{
          '__transition_info__': TransitionInfo(
            hasTransition: true,
            transitionType: PageTransitionType.fade,
          ),
        },
      );
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
        backgroundColor: FlutterFlowTheme.of(context).secondary,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF1493), Color(0xFF9932CC), Color(0xFF8A2BE2)],
              stops: [0.0, 0.5, 1.0],
              begin: AlignmentDirectional(1.0, -1.0),
              end: AlignmentDirectional(-1.0, 1.0),
            ),
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            32.0, 0.0, 32.0, 30.0),
                        child: Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 20.0,
                                color: Color(0x66FF1493),
                                offset: Offset(
                                  0.0,
                                  0.0,
                                ),
                              )
                            ],
                            gradient: LinearGradient(
                              colors: [Color(0xFFFF69B4), Color(0xFFFF1493)],
                              stops: [0.0, 1.0],
                              begin: AlignmentDirectional(1.0, -1.0),
                              end: AlignmentDirectional(-1.0, 1.0),
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 40.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            32.0, 0.0, 32.0, 20.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'ouu566oc' /* You’re together again 💕 */,
                          ),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .displayLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .displayLargeFamily,
                                color: Colors.white,
                                fontSize: 30.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w800,
                                lineHeight: 1.2,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .displayLargeIsCustom,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            32.0, 0.0, 32.0, 40.0),
                        child: Lottie.asset(
                          'assets/jsons/Tenor.json',
                          width: 264.4,
                          height: 164.8,
                          fit: BoxFit.contain,
                          animate: true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            32.0, 0.0, 32.0, 60.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'zprfbobu' /* Love always finds a way back ✨ */,
                          ),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleMediumFamily,
                                color: Color(0xFFE6E6FA),
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                lineHeight: 1.3,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleMediumIsCustom,
                              ),
                        ),
                      ),
                      Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15.0,
                              color: Color(0x80FF69B4),
                              offset: Offset(
                                0.0,
                                5.0,
                              ),
                            )
                          ],
                          gradient: LinearGradient(
                            colors: [Color(0xFFFF69B4), Color(0xFFDA70D6)],
                            stops: [0.0, 1.0],
                            begin: AlignmentDirectional(1.0, 0.0),
                            end: AlignmentDirectional(-1.0, 0),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.7, -0.3),
                  child: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Color(0x80FF69B4),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.8, -0.4),
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      color: Color(0x80DA70D6),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 15.0,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.8, 0.6),
                  child: Container(
                    width: 35.0,
                    height: 35.0,
                    decoration: BoxDecoration(
                      color: Color(0x80FF1493),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 18.0,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.7, 0.7),
                  child: Container(
                    width: 25.0,
                    height: 25.0,
                    decoration: BoxDecoration(
                      color: Color(0x80FF69B4),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 12.0,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.5, -0.7),
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: Color(0x80FFFFFF),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.9, -0.1),
                  child: Container(
                    width: 15.0,
                    height: 15.0,
                    decoration: BoxDecoration(
                      color: Color(0x80FFFFFF),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.9, 0.2),
                  child: Container(
                    width: 18.0,
                    height: 18.0,
                    decoration: BoxDecoration(
                      color: Color(0x80FFFFFF),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
