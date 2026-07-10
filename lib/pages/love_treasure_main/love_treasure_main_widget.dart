import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'love_treasure_main_model.dart';
export 'love_treasure_main_model.dart';

/// Create a mobile app screen for a relationship app feature called
/// **“Heartbeat”**.
///
/// This screen appears after the user has answered all questions and is now
/// waiting for their partner to finish the daily check-in.
///
/// STYLE
/// Use the same romantic gradient background as the other Heartbeat screens
/// (soft pink, purple, and lavender tones with subtle glowing hearts or
/// shapes).
/// The UI should feel calm, supportive, and emotionally warm.
///
/// LAYOUT STRUCTURE
///
/// TOP SECTION
/// At the top show a small label with an icon:
///
/// "Heartbeat"
///
/// Below it show a title:
///
/// "You've completed today's heartbeat"
///
/// SUBTITLE
/// Below the title show a friendly message:
///
/// "Your answers were saved. We're now waiting for your partner to finish."
///
/// PARTNER STATUS CARD
/// Create a rounded glass-style card in the center of the screen.
///
/// Inside the card show:
///
/// • Left: circular profile image of the current user
/// • Center: glowing heart icon
/// • Right: circular profile image of the partner
///
/// Below the avatars show their names.
///
/// Under the names show a status indicator:
///
/// For the current user:
///
/// ✓ You answered today
///
/// For the partner:
///
/// Waiting for your partner…
///
/// Use a subtle animated loading indicator (like three pulsing dots or a soft
/// glow).
///
/// INFO TEXT
/// Below the card show a short centered message:
///
/// "As soon as your partner answers, your shared heartbeat result will
/// unlock."
///
/// OPTIONAL DECORATION
/// Add a soft glowing heart animation or floating heart shapes in the
/// background to keep the screen visually alive.
///
/// BOTTOM ACTION
/// Add a rounded secondary button:
///
/// "Back to Home"
///
/// Style:
/// • glass or soft outline button
/// • rounded corners
/// • subtle glow
///
/// Below the button show a small caption:
///
/// "You'll automatically see the result once your partner answers."
///
/// STYLE DETAILS
///
/// • Soft glassmorphism containers
/// • Romantic gradients
/// • Rounded corners
/// • Gentle glow effects
/// • Calm and supportive atmosphere
/// • Mobile-first layout
///
/// The screen should feel reassuring and emotionally warm while the user
/// waits for their partner.
class LoveTreasureMainWidget extends StatefulWidget {
  const LoveTreasureMainWidget({
    super.key,
    required this.currentRelationshipRef,
  });

  final DocumentReference? currentRelationshipRef;

  static String routeName = 'love_treasure_main';
  static String routePath = '/loveTreasureMain';

  @override
  State<LoveTreasureMainWidget> createState() => _LoveTreasureMainWidgetState();
}

class _LoveTreasureMainWidgetState extends State<LoveTreasureMainWidget> {
  late LoveTreasureMainModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoveTreasureMainModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'love_treasure_main'});
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
        backgroundColor: Color(0xFFF0E6F6),
        body: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image.asset(
                'assets/images/lovetreasure_bg.webp',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                      child: Container(
                        width: 300.0,
                        height: 250.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/lt_close.webp',
                            fit: BoxFit.cover,
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
                            'vt7p5o9s' /* Create a Love Treasure */,
                          ),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineMediumFamily,
                                color: Color(0xFF7B2D8B),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .headlineMediumIsCustom,
                              ),
                        ),
                        Text(
                          FFLocalizations.of(context).getText(
                            'w7ifkp6y' /* Create a secret treasure for y... */,
                          ),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color: Color(0xFF9E6AAA),
                                letterSpacing: 0.0,
                                lineHeight: 1.6,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyMediumIsCustom,
                              ),
                        ),
                      ].divide(SizedBox(height: 10.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            'jhakkc6x' /* Choose Duration */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: Color(0xFF7B2D8B),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleSmallIsCustom,
                              ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.selectedDurationDays = 3;
                                safeSetState(() {});
                              },
                              child: Container(
                                width: 100.0,
                                decoration: BoxDecoration(
                                  color: Color(0xCCFDF0FF),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 12.0,
                                      color: Color(0x22C084E0),
                                      offset: Offset(
                                        0.0,
                                        4.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(18.0),
                                  border: Border.all(
                                    color: _model.selectedDurationDays == 3
                                        ? FlutterFlowTheme.of(context).tertiary
                                        : Color(0x66E0B0F0),
                                    width: 1.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'hcjohf93' /* 3 Days */,
                                        ),
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMediumFamily,
                                              color: Color(0xFF9B59B6),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .titleMediumIsCustom,
                                            ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'r0l0wn1v' /* up to 10 surprises per person */,
                                        ),
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmallFamily,
                                              color: Color(0xFFB07CC8),
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelSmallIsCustom,
                                            ),
                                      ),
                                    ].divide(SizedBox(height: 6.0)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.selectedDurationDays = 7;
                                  safeSetState(() {});
                                },
                                child: Container(
                                  width: 110.0,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 16.0,
                                        color: Color(0x44D070C8),
                                        offset: Offset(
                                          0.0,
                                          6.0,
                                        ),
                                      )
                                    ],
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFE8C8F8),
                                        Color(0xFFFFD6F0)
                                      ],
                                      stops: [0.0, 1.0],
                                      begin: AlignmentDirectional(1.0, 1.0),
                                      end: AlignmentDirectional(-1.0, -1.0),
                                    ),
                                    borderRadius: BorderRadius.circular(18.0),
                                    border: Border.all(
                                      color: _model.selectedDurationDays == 7
                                          ? FlutterFlowTheme.of(context)
                                              .tertiary
                                          : Color(0x66E0B0F0),
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'hnnpv5bm' /* Most popular ✨ */,
                                          ),
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .labelSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmallFamily,
                                                color: Color(0xFFEE82C3),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .labelSmallIsCustom,
                                              ),
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            '7o22bojh' /* 7 Days */,
                                          ),
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMediumFamily,
                                                color: Color(0xFF7B2D8B),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .titleMediumIsCustom,
                                              ),
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            '3tju6cvi' /* up to 15 surprises per person */,
                                          ),
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .labelSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmallFamily,
                                                color: Color(0xFF9B59B6),
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .labelSmallIsCustom,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 6.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.selectedDurationDays = 14;
                                  safeSetState(() {});
                                },
                                child: Container(
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xCCFDF0FF),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 12.0,
                                        color: Color(0x22C084E0),
                                        offset: Offset(
                                          0.0,
                                          4.0,
                                        ),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(18.0),
                                    border: Border.all(
                                      color: _model.selectedDurationDays == 14
                                          ? FlutterFlowTheme.of(context)
                                              .tertiary
                                          : Color(0x66E0B0F0),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'ata3lbf4' /* 14 Days */,
                                          ),
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMediumFamily,
                                                color: Color(0xFF9B59B6),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .titleMediumIsCustom,
                                              ),
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'h5qn3ghe' /* up to 20 surprises per person */,
                                          ),
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .labelSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmallFamily,
                                                color: Color(0xFFB07CC8),
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .labelSmallIsCustom,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 6.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ].divide(SizedBox(height: 12.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: double.infinity,
                            height: 58.0,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20.0,
                                  color: Color(0x55D070C8),
                                  offset: Offset(
                                    0.0,
                                    8.0,
                                  ),
                                )
                              ],
                              gradient: LinearGradient(
                                colors: [Color(0xFFEE82C3), Color(0xFF9B59B6)],
                                stops: [0.0, 1.0],
                                begin: AlignmentDirectional(1.0, 1.0),
                                end: AlignmentDirectional(-1.0, -1.0),
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
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
                                          .httpsCallable('loveTreasureStart')
                                          .call({
                                    "durationDays": _model.selectedDurationDays,
                                  });
                                  _model.cloudFunction5j7 =
                                      LoveTreasureStartCloudFunctionCallResponse(
                                    data:
                                        CFStartLoveTreasureResultStruct.fromMap(
                                            result.data),
                                    succeeded: true,
                                    resultAsString: result.data.toString(),
                                    jsonBody: result.data,
                                  );
                                } on FirebaseFunctionsException catch (error) {
                                  _model.cloudFunction5j7 =
                                      LoveTreasureStartCloudFunctionCallResponse(
                                    errorCode: error.code,
                                    succeeded: false,
                                  );
                                }

                                if (_model.cloudFunction5j7?.data?.ok == true) {
                                  context.pushNamed(
                                    LoveTreasurePageTwoWidget.routeName,
                                    queryParameters: {
                                      'treasurePath': serializeParam(
                                        _model.cloudFunction5j7?.data
                                            ?.treasurePath,
                                        ParamType.String,
                                      ),
                                      'currentRelationshipRef': serializeParam(
                                        widget.currentRelationshipRef,
                                        ParamType.DocumentReference,
                                      ),
                                      'treasureId': serializeParam(
                                        _model
                                            .cloudFunction5j7?.data?.treasureId,
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        _model.cloudFunction5j7!.data!.message,
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondary,
                                    ),
                                  );
                                }

                                safeSetState(() {});
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.card_giftcard_rounded,
                                    color: Colors.white,
                                    size: 22.0,
                                  ),
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      '4jr512js' /* Create Treasure */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleMediumFamily,
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .titleMediumIsCustom,
                                        ),
                                  ),
                                ].divide(SizedBox(width: 10.0)),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          FFLocalizations.of(context).getText(
                            'vo74xn59' /* Your partner won't see the sur... */,
                          ),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                lineHeight: 1.5,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
                              ),
                        ),
                      ].divide(SizedBox(height: 14.0)),
                    ),
                  ]
                      .divide(SizedBox(height: 24.0))
                      .addToStart(SizedBox(height: 16.0))
                      .addToEnd(SizedBox(height: 40.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
