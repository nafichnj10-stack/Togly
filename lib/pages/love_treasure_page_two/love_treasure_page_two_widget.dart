import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/components/love_treasure_share_sheet_widget/love_treasure_share_sheet_widget_widget.dart';
import '/components/surprise_sheet/surprise_sheet_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'love_treasure_page_two_model.dart';
export 'love_treasure_page_two_model.dart';

/// Create a mobile app screen for a romantic couples app feature called "Love
/// Treasure".
///
/// Design Style:
/// The UI should feel dreamy, romantic, magical and soft. Use pastel colors,
/// elegant spacing, and a premium emotional feel. Avoid game-like designs.
/// Use glassmorphism containers instead of solid white cards. Containers
/// should look translucent with frosted glass effect, subtle blur, light
/// borders and soft shadows. Rounded corners should be used everywhere.
///
/// This page must support multiple states of the same feature by using
/// separate containers that can later be controlled with conditional
/// visibility.
///
/// Page Layout:
/// Create a vertically centered mobile layout with the following sections:
///
/// 1. Top Bar
/// 2. Treasure Illustration Area
/// 3. Status Message Area
/// 4. State Containers
/// 5. Action Buttons
///
/// Top Bar:
/// Create a row at the top containing:
/// - a circular glass back button on the left
/// - centered page title: "Love Treasure"
///
/// Treasure Illustration Section:
/// Below the top bar create a large centered image placeholder for the Love
/// Treasure illustration.
///
/// This image area should be visually dominant and centered. It will later
/// show different treasure images depending on the state (locked, glowing,
/// opening, opened).
///
/// Status Message Area:
/// Below the treasure image create a centered text area that will show status
/// messages like countdown, ready message or reveal message.
///
/// Use a larger headline text style for main messages and a smaller
/// supporting text below if needed.
///
/// State Container Architecture:
/// Below the status message area create four different glass containers
/// representing different states of the feature. These containers will later
/// be shown or hidden using conditional visibility.
///
/// Create the following containers:
///
/// ActiveTreasureStateContainer
/// ReadyToOpenStateContainer
/// OpeningTreasureStateContainer
/// OpenedTreasureStateContainer
///
/// All containers should use a glassmorphism style:
/// - translucent frosted background
/// - subtle blur
/// - light white border
/// - rounded corners
/// - soft glow
/// - pastel design
///
/// Active Treasure State Container:
/// This state represents when the treasure countdown is still running.
///
/// Inside this container include:
///
/// Headline text:
/// "Treasure unlocks in"
///
/// Large countdown text example:
/// "5 days 12:45:27"
///
/// Below that add an info section containing:
///
/// "You added 3 surprises"
///
/// and a second line:
///
/// "Your partner added a surprise ✨"
///
/// Below this information create a secondary action button.
///
/// Button text:
/// "+ Add Surprise"
///
/// The button should be rounded with soft gradient or translucent glass
/// effect.
///
/// Ready To Open State Container:
/// This state represents when the treasure countdown has finished but the
/// treasure has not yet been opened.
///
/// Inside this container include:
///
/// Headline text:
/// "Your Love Treasure is ready ✨"
///
/// Below the headline keep the treasure image visible.
///
/// Below the treasure image add a large primary action button.
///
/// Button text:
/// "Open Treasure"
///
/// Button style:
/// Large pill shaped button with pink to purple gradient and soft glow.
///
/// Below the Open Treasure button add a secondary share button.
///
/// Button text:
/// "Share our Treasure"
///
/// This button allows users to share the current treasure status with friends
/// or on social media.
///
/// This button should look like a secondary glass button with rounded
/// corners.
///
/// Opening Treasure State Container:
/// This state represents the moment when the treasure is opening.
///
/// Inside this container include:
///
/// Headline text:
/// "Opening..."
///
/// Supporting text below:
/// "Your surprise is being revealed"
///
/// Display the treasure illustration in a slightly opened glowing state.
///
/// Hide action buttons in this state to prevent interaction.
///
/// Opened Treasure State Container:
/// This state represents the final state after the treasure has been opened.
///
/// Inside this container include:
///
/// Headline text:
/// "Your partner prepared 6 surprises for you ❤️"
///
/// Below the headline create a vertical list of revealed treasure items.
///
/// Create example glass cards for the revealed items such as:
///
/// Love Note
/// Photo Memory
/// Love Coupon
/// Reason I Love You
///
/// Each item card should contain:
/// - small icon or image placeholder
/// - item title
/// - short preview text
///
/// All item cards should use glassmorphism styling.
///
/// Below the revealed items list create a sharing button.
///
/// Button text:
/// "Share this moment"
///
/// This button allows users to share the treasure reveal with others.
///
/// The share button should be rounded with soft gradient and subtle glow.
///
/// Spacing and Layout Rules:
/// Keep the screen centered and clean. Use comfortable vertical spacing
/// between sections. Do not overcrowd the screen.
///
/// The treasure illustration should remain in the same location for all
/// states so that transitions between states feel smooth.
///
/// Design Rules:
/// Do not use solid white cards.
/// Use translucent glass containers.
/// Maintain a romantic dreamy atmosphere.
/// Use pastel colors and soft lighting.
///
/// Goal of this screen:
/// Allow couples to
///
/// - see their treasure countdown
/// - add surprises to the treasure
/// - open the treasure when ready
/// - reveal the surprises
/// - share the moment with others
///
/// All of this should happen inside one elegant screen layout.
class LoveTreasurePageTwoWidget extends StatefulWidget {
  const LoveTreasurePageTwoWidget({
    super.key,
    required this.treasurePath,
    required this.currentRelationshipRef,
    required this.treasureId,
  });

  final String? treasurePath;
  final DocumentReference? currentRelationshipRef;
  final String? treasureId;

  static String routeName = 'love_treasure_page_two';
  static String routePath = '/loveTreasurePageTwo';

  @override
  State<LoveTreasurePageTwoWidget> createState() =>
      _LoveTreasurePageTwoWidgetState();
}

class _LoveTreasurePageTwoWidgetState extends State<LoveTreasurePageTwoWidget> {
  late LoveTreasurePageTwoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoveTreasurePageTwoModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'love_treasure_page_two'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.pathToTreasureRef = await actions.pathToTreasureRef(
        widget.treasurePath!,
      );
      _model.currentTreasureRef = _model.pathToTreasureRef;
      safeSetState(() {});
      try {
        final result =
            await FirebaseFunctions.instanceFor(region: 'europe-west3')
                .httpsCallable('getLoveTreasureById')
                .call({
          "treasureId": _model.currentTreasureRef!.id,
        });
        _model.treasureData = GetLoveTreasureByIdCloudFunctionCallResponse(
          data: GetLoveTreasureByIdResponseStruct.fromMap(result.data),
          succeeded: true,
          resultAsString: result.data.toString(),
          jsonBody: result.data,
        );
      } on FirebaseFunctionsException catch (error) {
        _model.treasureData = GetLoveTreasureByIdCloudFunctionCallResponse(
          errorCode: error.code,
          succeeded: false,
        );
      }

      safeSetState(() {});
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
    return StreamBuilder<List<LoveTreasuresRecord>>(
      stream: queryLoveTreasuresRecord(
        queryBuilder: (loveTreasuresRecord) => loveTreasuresRecord.where(
          'treasureId',
          isEqualTo: widget.treasureId,
        ),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFF1A0A1A),
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
        List<LoveTreasuresRecord> loveTreasurePageTwoLoveTreasuresRecordList =
            snapshot.data!;
        final loveTreasurePageTwoLoveTreasuresRecord =
            loveTreasurePageTwoLoveTreasuresRecordList.isNotEmpty
                ? loveTreasurePageTwoLoveTreasuresRecordList.first
                : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFF1A0A1A),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.asset(
                      'assets/images/background_main_connect2.webp',
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
                          color: Color(0x23000000),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 40.0, 24.0, 20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  width: 44.0,
                                  height: 44.0,
                                  decoration: BoxDecoration(
                                    color: Color(0x33FFFFFF),
                                    borderRadius: BorderRadius.circular(22.0),
                                    border: Border.all(
                                      color: Color(0x44FFFFFF),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Icon(
                                      Icons.chevron_left,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                FFLocalizations.of(context).getText(
                                  'w79tyk8m' /* Love Treasure */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleMediumFamily,
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .titleMediumIsCustom,
                                    ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    TreasuresArchiveWidget.routeName,
                                    queryParameters: {
                                      'relationshipId': serializeParam(
                                        widget.currentRelationshipRef?.id,
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                child: Container(
                                  width: 44.0,
                                  height: 44.0,
                                  decoration: BoxDecoration(
                                    color: Color(0x33FFFFFF),
                                    borderRadius: BorderRadius.circular(22.0),
                                    border: Border.all(
                                      color: Color(0x44FFFFFF),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.archive,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Container(
                              width: double.infinity,
                              height: 220.0,
                              child: Stack(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                children: [
                                  if (_model.treasureData?.data?.isOpened ==
                                      false)
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/lt_close.webp',
                                          width: 278.8,
                                          height: 248.9,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  if (_model.treasureData?.data?.isOpened ==
                                      true)
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/lt_open.webp',
                                          width: 280.0,
                                          height: 220.0,
                                          fit: BoxFit.cover,
                                          alignment: Alignment(0.0, 0.0),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if ((_model.treasureData?.data?.isUnlocked == true) &&
                            (_model.treasureData?.data?.isOpened == false))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 4.0, 24.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'uzr8o9io' /* Your Love Treasure is ready ✨ */,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .headlineSmallFamily,
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .headlineSmallIsCustom,
                                      ),
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'yp6c0zvp' /* The moment you've been waiting... */,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .accent1,
                                        letterSpacing: 0.0,
                                        lineHeight: 1.4,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                ),
                              ].divide(SizedBox(height: 6.0)),
                            ),
                          ),
                        if (_model.treasureData?.data?.isOpened == false)
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0x701D1C1C),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 24.0,
                                    color: Color(0x33FF69B4),
                                    offset: Offset(
                                      0.0,
                                      8.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(28.0),
                                border: Border.all(
                                  color: Color(0x44FFFFFF),
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    4.0, 24.0, 4.0, 24.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (_model.treasureData?.data?.isUnlocked ==
                                        false)
                                      Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'twvvphxz' /* Treasure unlocks in */,
                                          ),
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMediumFamily,
                                                color: Color(0xFFDA70D6),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .titleMediumIsCustom,
                                              ),
                                        ),
                                      ),
                                    if (_model.treasureData?.data?.isUnlocked ==
                                        false)
                                      AuthUserStreamWidget(
                                        builder: (context) => Container(
                                          width: 300.0,
                                          height: 110.0,
                                          child: custom_widgets
                                              .TreasureCountdownWidget(
                                            width: 300.0,
                                            height: 110.0,
                                            unlockAtMs: _model
                                                .treasureData?.data?.unlockAtMs,
                                            languageCode: valueOrDefault(
                                                currentUserDocument
                                                    ?.appLanguage,
                                                ''),
                                          ),
                                        ),
                                      ),
                                    if ((_model.treasureData!.data!
                                                .mySurprisesCount >
                                            0) &&
                                        (_model.treasureData?.data?.isOpened ==
                                            false))
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 16.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 1.0,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.transparent,
                                                Color(0xFFFF69B4),
                                                Colors.transparent
                                              ],
                                              stops: [0.0, 0.5, 1.0],
                                              begin: AlignmentDirectional(
                                                  0.0, -1.0),
                                              end: AlignmentDirectional(0, 1.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    if ((_model.treasureData!.data!
                                                .mySurprisesCount >
                                            0) &&
                                        (_model.treasureData?.data?.isOpened ==
                                            false))
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 12.0, 16.0, 12.0),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0x1AFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            border: Border.all(
                                              color: Color(0x33FFFFFF),
                                              width: 1.0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(12.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 36.0,
                                                  height: 36.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0x33FF69B4),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Icon(
                                                      Icons.favorite,
                                                      color: Color(0xFFFF69B4),
                                                      size: 18.0,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      AuthUserStreamWidget(
                                                        builder: (context) =>
                                                            Text(
                                                          valueOrDefault<
                                                              String>(
                                                            functions.formatMySurprisesText(
                                                                _model
                                                                    .treasureData
                                                                    ?.data
                                                                    ?.mySurprisesCount,
                                                                valueOrDefault(
                                                                    currentUserDocument
                                                                        ?.appLanguage,
                                                                    '')),
                                                            'Count',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                color: Colors
                                                                    .white,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMediumIsCustom,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 12.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 8.0, 16.0, 8.0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 1.0,
                                        decoration: BoxDecoration(
                                          color: Color(0x22FFFFFF),
                                        ),
                                      ),
                                    ),
                                    if ((_model.treasureData!.data!
                                                .partnerSurprisesCount >
                                            0) &&
                                        (_model.treasureData?.data?.isOpened ==
                                            false))
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 36.0,
                                              height: 36.0,
                                              decoration: BoxDecoration(
                                                color: Color(0x33DA70D6),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Icon(
                                                  Icons.auto_awesome,
                                                  color: Color(0xFFDA70D6),
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
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'rmgo2t81' /* Your partner added a surprise ... */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                  ),
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'rzk2sa84' /* Something special is waiting f... */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmall
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmallFamily,
                                                          color:
                                                              Color(0x99FFFFFF),
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmallIsCustom,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 12.0)),
                                        ),
                                      ),
                                    if ((_model.treasureData!.data!
                                                .partnerSurprisesCount >
                                            0) &&
                                        (_model.treasureData?.data?.isOpened ==
                                            false))
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 16.0, 16.0, 0.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 1.0,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.transparent,
                                                Color(0xFFFF69B4),
                                                Colors.transparent
                                              ],
                                              stops: [0.0, 0.5, 1.0],
                                              begin: AlignmentDirectional(
                                                  0.0, -1.0),
                                              end: AlignmentDirectional(0, 1.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    if ((_model.treasureData?.data
                                                ?.isUnlocked ==
                                            true) &&
                                        (_model.treasureData?.data?.isOpened ==
                                            false))
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 16.0, 16.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            await _model.currentTreasureRef!
                                                .update(
                                                    createLoveTreasuresRecordData(
                                              status: 'opened',
                                              openedAt: getCurrentTimestamp,
                                              openedBy: currentUserReference,
                                              isOpened: true,
                                            ));
                                            try {
                                              final result =
                                                  await FirebaseFunctions
                                                          .instanceFor(
                                                              region:
                                                                  'europe-west3')
                                                      .httpsCallable(
                                                          'unlockTreasureCoupons')
                                                      .call({
                                                "treasureId": _model
                                                    .currentTreasureRef?.id,
                                                "relationshipId":
                                                    valueOrDefault(
                                                        currentUserDocument
                                                            ?.relationshipId,
                                                        ''),
                                              });
                                              _model.cloudFunctionx7k =
                                                  UnlockTreasureCouponsCloudFunctionCallResponse(
                                                succeeded: true,
                                              );
                                            } on FirebaseFunctionsException catch (error) {
                                              _model.cloudFunctionx7k =
                                                  UnlockTreasureCouponsCloudFunctionCallResponse(
                                                errorCode: error.code,
                                                succeeded: false,
                                              );
                                            }

                                            try {
                                              final result = await FirebaseFunctions
                                                      .instanceFor(
                                                          region:
                                                              'europe-west3')
                                                  .httpsCallable(
                                                      'awardLoveTreasureOpened')
                                                  .call({
                                                "treasureId":
                                                    widget.treasureId,
                                              });
                                              _model.awardlove =
                                                  AwardLoveTreasureOpenedCloudFunctionCallResponse(
                                                data: result.data,
                                                succeeded: true,
                                                resultAsString:
                                                    result.data.toString(),
                                                jsonBody: result.data,
                                              );
                                            } on FirebaseFunctionsException catch (error) {
                                              _model.awardlove =
                                                  AwardLoveTreasureOpenedCloudFunctionCallResponse(
                                                errorCode: error.code,
                                                succeeded: false,
                                              );
                                            }

                                            _model.isTreasureOpenedLocal = true;
                                            safeSetState(() {});
                                            _model.soundPlayer ??=
                                                AudioPlayer();
                                            if (_model.soundPlayer!.playing) {
                                              await _model.soundPlayer!.stop();
                                            }
                                            _model.soundPlayer!.setVolume(0.4);
                                            _model.soundPlayer!
                                                .setAsset(
                                                    'assets/audios/treasure-opening.mp3')
                                                .then((_) =>
                                                    _model.soundPlayer!.play());

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  FFLocalizations.of(context)
                                                      .getVariableText(
                                                    enText:
                                                        'Treasure opened successfully ✨',
                                                    deText:
                                                        'Truhe erfolgreich geöffnet ✨',
                                                    esText:
                                                        'Tesoro abierto con éxito ✨',
                                                  ),
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                              ),
                                            );
                                            await Future.delayed(
                                              Duration(
                                                milliseconds: 300,
                                              ),
                                            );
                                            if (Navigator.of(context)
                                                .canPop()) {
                                              context.pop();
                                            }
                                            context.pushNamed(
                                              LoveTreasurePageTwoWidget
                                                  .routeName,
                                              queryParameters: {
                                                'treasurePath': serializeParam(
                                                  widget.treasurePath,
                                                  ParamType.String,
                                                ),
                                                'currentRelationshipRef':
                                                    serializeParam(
                                                  widget
                                                      .currentRelationshipRef,
                                                  ParamType.DocumentReference,
                                                ),
                                                'treasureId': serializeParam(
                                                  widget.treasureId,
                                                  ParamType.String,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                '__transition_info__':
                                                    TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                      PageTransitionType.fade,
                                                  duration:
                                                      Duration(milliseconds: 0),
                                                ),
                                              },
                                            );

                                            safeSetState(() {});
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            '4660pomf' /* Open Treasure */,
                                          ),
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 56.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFFB44FA0),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallFamily,
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallIsCustom,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                      ),
                                    if ((_model.treasureData?.data
                                                ?.isUnlocked ==
                                            false) &&
                                        (_model.treasureData?.data?.isOpened ==
                                            false))
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 10.0, 16.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            if (_model.pathToTreasureRef !=
                                                null) {
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                enableDrag: false,
                                                useSafeArea: true,
                                                context: context,
                                                builder: (context) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                    },
                                                    child: Padding(
                                                      padding: MediaQuery
                                                          .viewInsetsOf(
                                                              context),
                                                      child:
                                                          SurpriseSheetWidget(
                                                        treasureRef: _model
                                                            .pathToTreasureRef!,
                                                        relationshipRef: widget
                                                            .currentRelationshipRef!,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).then((value) =>
                                                  safeSetState(() {}));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Treasure is still loading. Please try again in a moment.',
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            }
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'sqvy8t86' /* Add a Surprise */,
                                          ),
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 50.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xD3FF6BB5),
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
                                                .titleSmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmallFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmallIsCustom,
                                                ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              width: 0.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                      ),
                                    if ((_model.treasureData?.data
                                                ?.isUnlocked ==
                                            true) &&
                                        (_model.treasureData?.data?.isOpened ==
                                            false))
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 10.0, 16.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              enableDrag: false,
                                              context: context,
                                              builder: (context) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                    child:
                                                        LoveTreasureShareSheetWidgetWidget(),
                                                  ),
                                                );
                                              },
                                            ).then(
                                                (value) => safeSetState(() {}));
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'a61f6fm5' /* Share our Treasure */,
                                          ),
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 50.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0x66020101),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallFamily,
                                                      color: Color(0xFFFF7ACD),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallIsCustom,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              width: 0.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                      ),
                                  ].divide(SizedBox(height: 0.0)),
                                ),
                              ),
                            ),
                          ),
                        if (_model.treasureData?.data?.isOpened == true)
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0x701D1C1C),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 20.0,
                                    color: Color(0x22DA70D6),
                                    offset: Offset(
                                      0.0,
                                      6.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(28.0),
                                border: Border.all(
                                  color: Color(0x44FFFFFF),
                                  width: 1.0,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        4.0, 24.0, 4.0, 24.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if ((_model.treasureData?.data
                                                    ?.status ==
                                                'opened') &&
                                            (_model.treasureData!.data!
                                                    .partnerSurprisesCount >=
                                                1))
                                          AuthUserStreamWidget(
                                            builder: (context) => Text(
                                              valueOrDefault<String>(
                                                functions
                                                    .formatPartnerSurprisesText(
                                                        _model
                                                            .treasureData
                                                            ?.data
                                                            ?.partnerSurprisesCount,
                                                        valueOrDefault(
                                                            currentUserDocument
                                                                ?.appLanguage,
                                                            '')),
                                                'counter',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMediumIsCustom,
                                                      ),
                                            ),
                                          ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  14.0, 4.0, 14.0, 16.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              'nsts1h6u' /* This treasure stays available ... */,
                                            ),
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallFamily,
                                                  color: Color(0xCCFFC0CB),
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallIsCustom,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  14.0, 14.0, 14.0, 14.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                VoiceNotesResultsWidget
                                                    .routeName,
                                                queryParameters: {
                                                  'treasureRef': serializeParam(
                                                    loveTreasurePageTwoLoveTreasuresRecord
                                                        ?.reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                  'relationshipId':
                                                      serializeParam(
                                                    loveTreasurePageTwoLoveTreasuresRecord
                                                        ?.relationshipId,
                                                    ParamType.String,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Color(0x1AFFFFFF),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                border: Border.all(
                                                  color: Color(0x33FF69B4),
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(12.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 44.0,
                                                      height: 44.0,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color(0xFFFF69B4),
                                                            Color(0xFFDA70D6)
                                                          ],
                                                          stops: [0.0, 1.0],
                                                          begin:
                                                              AlignmentDirectional(
                                                                  1.0, 1.0),
                                                          end:
                                                              AlignmentDirectional(
                                                                  -1.0, -1.0),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Icon(
                                                          Icons.favorite,
                                                          color: Colors.white,
                                                          size: 22.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'lms9qttn' /* Voice Note */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmallFamily,
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmallIsCustom,
                                                                ),
                                                          ),
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'waful2u5' /* A voice message recorded just ... */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodySmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallFamily,
                                                                  color: Color(
                                                                      0x99FFFFFF),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmallIsCustom,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 14.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  14.0, 10.0, 14.0, 10.0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 1.0,
                                            decoration: BoxDecoration(
                                              color: Color(0x22FFFFFF),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  14.0, 14.0, 14.0, 14.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                PhotoResultWidget.routeName,
                                                queryParameters: {
                                                  'treasureRef': serializeParam(
                                                    loveTreasurePageTwoLoveTreasuresRecord
                                                        ?.reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Color(0x1AFFFFFF),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                border: Border.all(
                                                  color: Color(0x33DA70D6),
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(12.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 44.0,
                                                      height: 44.0,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color(0xFF9B59B6),
                                                            Color(0xFFDA70D6)
                                                          ],
                                                          stops: [0.0, 1.0],
                                                          begin:
                                                              AlignmentDirectional(
                                                                  1.0, 1.0),
                                                          end:
                                                              AlignmentDirectional(
                                                                  -1.0, -1.0),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Icon(
                                                          Icons.photo_camera,
                                                          color: Colors.white,
                                                          size: 22.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'fsllfldn' /* Photos */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmallFamily,
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmallIsCustom,
                                                                ),
                                                          ),
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'w9txxtd9' /* Photos captured just for you �... */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodySmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallFamily,
                                                                  color: Color(
                                                                      0x99FFFFFF),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmallIsCustom,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 14.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  14.0, 10.0, 14.0, 10.0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 1.0,
                                            decoration: BoxDecoration(
                                              color: Color(0x22FFFFFF),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  14.0, 14.0, 14.0, 14.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                CouponTreasureWidget.routeName,
                                                queryParameters: {
                                                  'relationshipId':
                                                      serializeParam(
                                                    loveTreasurePageTwoLoveTreasuresRecord
                                                        ?.relationshipId,
                                                    ParamType.String,
                                                  ),
                                                  'treasureRef': serializeParam(
                                                    loveTreasurePageTwoLoveTreasuresRecord
                                                        ?.reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  '__transition_info__':
                                                      TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                        PageTransitionType.fade,
                                                  ),
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Color(0x1AFFFFFF),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                border: Border.all(
                                                  color: Color(0x33FFB6C1),
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(12.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 44.0,
                                                      height: 44.0,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color(0xFFFF8C69),
                                                            Color(0xFFFF69B4)
                                                          ],
                                                          stops: [0.0, 1.0],
                                                          begin:
                                                              AlignmentDirectional(
                                                                  1.0, 1.0),
                                                          end:
                                                              AlignmentDirectional(
                                                                  -1.0, -1.0),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Icon(
                                                          Icons.card_giftcard,
                                                          color: Colors.white,
                                                          size: 22.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              '9b6as0xj' /* Love Coupon */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmallFamily,
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmallIsCustom,
                                                                ),
                                                          ),
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'r95uof53' /* Use it anytime for something s... */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodySmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallFamily,
                                                                  color: Color(
                                                                      0x99FFFFFF),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmallIsCustom,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 14.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  14.0, 10.0, 14.0, 10.0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 1.0,
                                            decoration: BoxDecoration(
                                              color: Color(0x22FFFFFF),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  14.0, 14.0, 14.0, 14.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                StickyWallViewWidget.routeName,
                                                queryParameters: {
                                                  'relationshipId':
                                                      serializeParam(
                                                    valueOrDefault(
                                                        currentUserDocument
                                                            ?.relationshipId,
                                                        ''),
                                                    ParamType.String,
                                                  ),
                                                  'relationshipRef':
                                                      serializeParam(
                                                    widget
                                                        .currentRelationshipRef,
                                                    ParamType.DocumentReference,
                                                  ),
                                                  'treasureId': serializeParam(
                                                    widget.treasureId,
                                                    ParamType.String,
                                                  ),
                                                  'treasureRef': serializeParam(
                                                    loveTreasurePageTwoLoveTreasuresRecord
                                                        ?.reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  '__transition_info__':
                                                      TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                        PageTransitionType.fade,
                                                  ),
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Color(0x1AFFFFFF),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                border: Border.all(
                                                  color: Color(0x33FFD700),
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(12.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 44.0,
                                                      height: 44.0,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color(0xFFFFD700),
                                                            Color(0xFFFF69B4)
                                                          ],
                                                          stops: [0.0, 1.0],
                                                          begin:
                                                              AlignmentDirectional(
                                                                  1.0, 1.0),
                                                          end:
                                                              AlignmentDirectional(
                                                                  -1.0, -1.0),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Icon(
                                                          Icons.auto_awesome,
                                                          color: Colors.white,
                                                          size: 22.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              '7f2tloro' /* Reason I Love You */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmallFamily,
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmallIsCustom,
                                                                ),
                                                          ),
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'ij8z9w3f' /* Because you make every day mag... */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodySmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallFamily,
                                                                  color: Color(
                                                                      0x99FFFFFF),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmallIsCustom,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 14.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 10.0, 16.0, 10.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                enableDrag: false,
                                                context: context,
                                                builder: (context) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                    },
                                                    child: Padding(
                                                      padding: MediaQuery
                                                          .viewInsetsOf(
                                                              context),
                                                      child:
                                                          LoveTreasureShareSheetWidgetWidget(),
                                                    ),
                                                  );
                                                },
                                              ).then((value) =>
                                                  safeSetState(() {}));
                                            },
                                            text: FFLocalizations.of(context)
                                                .getText(
                                              'f2daqmrm' /* Share our Treasure */,
                                            ),
                                            options: FFButtonOptions(
                                              width: double.infinity,
                                              height: 50.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      24.0, 0.0, 24.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color: Color(0x66020101),
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmallFamily,
                                                    color: Color(0xFFFF7ACD),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmallIsCustom,
                                                  ),
                                              elevation: 0.0,
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                width: 0.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 1.0,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.transparent,
                                                Color(0xFFFF69B4),
                                                Colors.transparent
                                              ],
                                              stops: [0.0, 0.5, 1.0],
                                              begin: AlignmentDirectional(
                                                  0.0, -1.0),
                                              end: AlignmentDirectional(0, 1.0),
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
                      ]
                          .addToStart(SizedBox(height: 16.0))
                          .addToEnd(SizedBox(height: 40.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
