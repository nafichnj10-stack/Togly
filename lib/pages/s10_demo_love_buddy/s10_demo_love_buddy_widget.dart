import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 's10_demo_love_buddy_model.dart';
export 's10_demo_love_buddy_model.dart';

/// Create a full-screen onboarding page with a custom background image.
///
/// Layout:
/// - Use a Stack with a full-screen background image (BoxFit.cover).
/// - Add a centered Column on top.
///
/// Top section:
/// - Large title text: "Grow your LoveBuddy together".
/// - Highlight the word "LoveBuddy" with a soft pink/purple color.
/// - Subtitle text below, centered, max 2 lines.
///
/// Middle section:
/// - Row with 3 rounded cards (equal size, horizontally aligned).
/// - Each card contains:
///   - Image placeholder
///   - Label text: "Happy", "Sad", "Angry"
/// - Cards have glassmorphism style:
///   - Slight transparency
///   - Soft blur
///   - Rounded corners
///   - Subtle shadow
///
/// Below cards:
/// - Progress bar with heart icons (custom container, not native slider).
/// - Text below: "1 / 2 Love Earned ❤️ Love Missing"
/// - Small helper text below.
///
/// Bottom section:
/// - Primary rounded button: "Okay, got it"
/// - Gradient pink/purple background
/// - Soft shadow
///
/// Style:
/// - Romantic pastel theme (purple/pink).
/// - Soft gradients.
/// - Rounded corners.
/// - Glassmorphism.
class S10DemoLoveBuddyWidget extends StatefulWidget {
  const S10DemoLoveBuddyWidget({super.key});

  static String routeName = 'S10_Demo_LoveBuddy';
  static String routePath = '/s10DemoLoveBuddy';

  @override
  State<S10DemoLoveBuddyWidget> createState() => _S10DemoLoveBuddyWidgetState();
}

class _S10DemoLoveBuddyWidgetState extends State<S10DemoLoveBuddyWidget> {
  late S10DemoLoveBuddyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => S10DemoLoveBuddyModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'S10_Demo_LoveBuddy'});
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
              Image.asset(
                'assets/images/background_home.webp',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Opacity(
                opacity: 0.1,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0x4D000000), Color(0x80000000)],
                      stops: [0.0, 1.0],
                      begin: AlignmentDirectional(0.0, -1.0),
                      end: AlignmentDirectional(0, 1.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 80.0, 24.0, 40.0),
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'm6yh2is4' /* Take care of your Companions */,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: FlutterFlowTheme.of(context)
                                    .displayMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .displayMediumFamily,
                                      fontSize: 30.0,
                                      letterSpacing: 0.0,
                                      shadows: [
                                        Shadow(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 2.0,
                                        )
                                      ],
                                      lineHeight: 1.4,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .displayMediumIsCustom,
                                    ),
                              ),
                            ].divide(SizedBox(height: 12.0)),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 20.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'yxhr3xwf' /* The more time you spend in Tog... */,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyLargeFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .accent1,
                                        letterSpacing: 0.0,
                                        lineHeight: 1.4,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyLargeIsCustom,
                                      ),
                                ),
                              ),
                            ].divide(SizedBox(height: 12.0)),
                          ),
                        ].divide(SizedBox(height: 24.0)),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 10.0),
                            child: Container(
                              width: 171.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.asset(
                                    'assets/images/happy.webp',
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
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0x33FFFFFF),
                                    Color(0x1AFFFFFF)
                                  ],
                                  stops: [0.0, 1.0],
                                  begin: AlignmentDirectional(1.0, -1.0),
                                  end: AlignmentDirectional(-1.0, 1.0),
                                ),
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                  color: Color(0x33FFFFFF),
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        child: Container(
                          width: 171.0,
                          height: 120.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.asset(
                                'assets/images/sad.webp',
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
                            gradient: LinearGradient(
                              colors: [Color(0x33FFFFFF), Color(0x1AFFFFFF)],
                              stops: [0.0, 1.0],
                              begin: AlignmentDirectional(1.0, -1.0),
                              end: AlignmentDirectional(-1.0, 1.0),
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: Color(0x33FFFFFF),
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 171.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.asset(
                              'assets/images/angry.webp',
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
                          gradient: LinearGradient(
                            colors: [Color(0x33FFFFFF), Color(0x1AFFFFFF)],
                            stops: [0.0, 1.0],
                            begin: AlignmentDirectional(1.0, -1.0),
                            end: AlignmentDirectional(-1.0, 1.0),
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: Color(0x33FFFFFF),
                            width: 1.0,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 20.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'rssi1xed' /* Show your Companions some love... */,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodySmallFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .accent1,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        shadows: [
                                          Shadow(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 2.0,
                                          )
                                        ],
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodySmallIsCustom,
                                      ),
                                ),
                              ),
                            ].divide(SizedBox(height: 12.0)),
                          ),
                        ].divide(SizedBox(height: 32.0)),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          context.goNamed(
                            S11MoreWaysScreenWidget.routeName,
                            extra: <String, dynamic>{
                              '__transition_info__': TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.fade,
                              ),
                            },
                          );
                        },
                        text: FFLocalizations.of(context).getText(
                          'evebd4b9' /* Okay, got it */,
                        ),
                        options: FFButtonOptions(
                          width: 280.0,
                          height: 56.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              32.0, 0.0, 32.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Color(0x869F7BFF),
                          textStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleMediumFamily,
                                color: Colors.white,
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                shadows: [
                                  Shadow(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 2.0,
                                  )
                                ],
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleMediumIsCustom,
                              ),
                          elevation: 8.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryText,
                            width: 0.0,
                          ),
                          borderRadius: BorderRadius.circular(28.0),
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
    );
  }
}
