import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:firebase_storagelibrary_2sa6k9/app_state.dart'
    as firebase_storagelibrary_2sa6k9_app_state;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 's12_founder_page_model.dart';
export 's12_founder_page_model.dart';

/// Create an onboarding page called FounderPage.
///
/// The page should have a full screen background image and a SafeArea layout.
///
/// Structure the page with a vertical Column inside a SingleChildScrollView.
///
/// Layout order:
///
/// Top spacing (around 40–60px)
///
/// Centered circular profile image (large avatar with rounded border and soft
/// glow)
///
/// Headline text below the image:
/// "Hi, I'm [Name] — founder of Togly 👋"
///
/// Long description text section explaining the story behind the app
/// (multiple paragraphs, centered text).
///
/// Add generous spacing between paragraphs for readability.
///
/// Primary CTA button at the bottom saying:
/// "Start our journey 💗"
///
/// The entire content should stay centered and scrollable if needed.
///
/// The page should feel like a personal message from the founder.
class S12FounderPageWidget extends StatefulWidget {
  const S12FounderPageWidget({super.key});

  static String routeName = 'S_12FounderPage';
  static String routePath = '/s12FounderPage';

  @override
  State<S12FounderPageWidget> createState() => _S12FounderPageWidgetState();
}

class _S12FounderPageWidgetState extends State<S12FounderPageWidget> {
  late S12FounderPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => S12FounderPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'S_12FounderPage'});
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

    return StreamBuilder<List<PublicUsersRecord>>(
      stream: queryPublicUsersRecord(
        queryBuilder: (publicUsersRecord) => publicUsersRecord.where(
          'uid',
          isEqualTo: currentUserUid,
        ),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0x8F1A1A2E),
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
        List<PublicUsersRecord> s12FounderPagePublicUsersRecordList =
            snapshot.data!;
        final s12FounderPagePublicUsersRecord =
            s12FounderPagePublicUsersRecordList.isNotEmpty
                ? s12FounderPagePublicUsersRecordList.first
                : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0x8F1A1A2E),
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0x9E1A1A2E),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/background_founder.webp',
                      ).image,
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0x4E000000),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: 50.0,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            28.0, 0.0, 28.0, 48.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Container(
                                    width: 210.0,
                                    height: 210.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.asset(
                                          'assets/images/profile_founder.webp',
                                        ).image,
                                      ),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 3.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 28.0, 10.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  '6cuzpuro' /* Hi, I’m the founder
 of Togly ... */
                                  ,
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .headlineMediumFamily,
                                      color: Colors.white,
                                      fontSize: 24.0,
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
                                  24.0, 16.0, 24.0, 0.0),
                              child: Container(
                                width: 60.0,
                                height: 3.0,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      FlutterFlowTheme.of(context).primary,
                                      FlutterFlowTheme.of(context).tertiary
                                    ],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(1.0, 0.0),
                                    end: AlignmentDirectional(-1.0, 0),
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 28.0, 24.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  '0ibnlsu8' /* A few years ago, I realized so... */,
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyLargeFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      lineHeight: 1.7,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyLargeIsCustom,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 20.0, 24.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'r20neehk' /* I wanted to create something t... */,
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyLargeFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      lineHeight: 1.7,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyLargeIsCustom,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 20.0, 24.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'as160ll4' /* That’s why I built Togly
a sm... */
                                  ,
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyLargeFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      lineHeight: 1.7,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyLargeIsCustom,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 20.0, 24.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'h78sx8l5' /* Thank you for being here.
I h... */
                                  ,
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyLargeFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      lineHeight: 1.7,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyLargeIsCustom,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 36.0, 24.0, 30.0),
                              child: Container(
                                width: double.infinity,
                                height: 56.0,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 20.0,
                                      color: Color(0x80E040FB),
                                      offset: Offset(
                                        0.0,
                                        8.0,
                                      ),
                                    )
                                  ],
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFE040FB),
                                      Color(0xFFCE93D8)
                                    ],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(0.0, -1.0),
                                    end: AlignmentDirectional(0, 1.0),
                                  ),
                                  borderRadius: BorderRadius.circular(28.0),
                                ),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    FFAppState().loveCodeGen =
                                        functions.generateLoveCode();
                                    safeSetState(() {});

                                    await currentUserReference!
                                        .update(createUsersRecordData(
                                      messagesEnabled: true,
                                      dailyQuestionPartnerAlertsEnabled: true,
                                      relationshipAlertsEnabled: true,
                                      sharedMomentsEnabled: true,
                                      dailyQuestionRemindersEnabled: true,
                                      stayConnectedRemindersEnabled: true,
                                      muteAllNotifications: false,
                                      onboardingCompleted: true,
                                      tzOffsetMinutes:
                                          functions.deviceOffsetMinutes(),
                                      loveCode: functions.generateLoveCode(),
                                      isAdmin: false,
                                      appLanguage: FFLocalizations.of(context)
                                          .languageCode,
                                      appLanguageUpdatedAt: getCurrentTimestamp,
                                      onboardingStep: 'done',
                                    ));

                                    await s12FounderPagePublicUsersRecord!
                                        .reference
                                        .update(createPublicUsersRecordData(
                                      uid: currentUserUid,
                                      localTime: getCurrentTimestamp,
                                      relationshipId: '',
                                      partnerUID: '',
                                      loveCode: valueOrDefault(
                                          currentUserDocument?.loveCode, ''),
                                      onboardingCompleted: true,
                                      name: FFAppState().draftName,
                                    ));
                                    logFirebaseEvent(
                                      'onboarding_page',
                                      parameters: {
                                        'completed': true,
                                      },
                                    );

                                    context.goNamed(
                                      HomeWidget.routeName,
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
                                    '9phl2hr4' /* Start your journey 💗 */,
                                  ),
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 56.0,
                                    padding: EdgeInsets.all(8.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: Colors.transparent,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleMediumFamily,
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              offset: Offset(2.0, 2.0),
                                              blurRadius: 2.0,
                                            )
                                          ],
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .titleMediumIsCustom,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 0.0,
                                    ),
                                    borderRadius: BorderRadius.circular(28.0),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
