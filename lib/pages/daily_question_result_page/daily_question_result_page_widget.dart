import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'daily_question_result_page_model.dart';
export 'daily_question_result_page_model.dart';

/// Create a clean and elegant mobile app page called "Daily Question Result
/// Page".
///
/// This page is part of a relationship-focused app called “Togetherly”, where
/// two partners answer a shared daily question. The purpose of this page is
/// to display both the user’s own answer and their partner’s answer
/// side-by-side (or one after the other).
///
/// 🧩 Page Structure:
/// Title (Centered):
/// Text: “Today’s Answers”
/// Style: Bold, modern, readable (e.g. size 24, font weight 700, color
/// #111111)
///
/// Question Display:
/// A rounded container with subtle shadow that displays the question answered
/// today.
/// Text Example: “What made you smile today?”
/// Style: Soft background (e.g. light grey or off-white), medium font size
///
/// Two Answer Sections (Stacked vertically):
///
/// Section 1 (Your Answer):
/// Title: “You said”
/// Content: The user’s answer in a clean text box
/// Background color: Light lavender or soft blue to distinguish
///
/// Section 2 (Your Partner’s Answer):
/// Title: “Your partner said”
/// Content: Partner’s answer in a separate box
/// Background color: Light yellow or soft peach tone
/// ⚠️ If the partner has not answered yet, display a placeholder text:
/// “Waiting for your partner’s answer…” in italic grey text
///
/// Back or Close Button:
/// A button at the bottom with text like “Back to Home” or an icon button.
/// Rounded, centered, using brand color (e.g. purple or gold)
///
/// 🧠 Additional:
/// Make sure everything is mobile-optimized.
///
/// Use padding and spacing for a soft, elegant flow.
///
/// Match the visual style to the previous DailyQuestionPage: same fonts,
/// colors, button style.
///
/// The design should feel friendly, calm, and loving – ideal for couples.
class DailyQuestionResultPageWidget extends StatefulWidget {
  const DailyQuestionResultPageWidget({
    super.key,
    required this.finalAnswerDocPath,
  });

  final String? finalAnswerDocPath;

  static String routeName = 'DailyQuestionResultPage';
  static String routePath = '/dailyQuestionResultPage';

  @override
  State<DailyQuestionResultPageWidget> createState() =>
      _DailyQuestionResultPageWidgetState();
}

class _DailyQuestionResultPageWidgetState
    extends State<DailyQuestionResultPageWidget> {
  late DailyQuestionResultPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DailyQuestionResultPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'DailyQuestionResultPage'});
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AnswersRecord>(
      stream: AnswersRecord.getDocument(
          functions.docRefFromPath(widget.finalAnswerDocPath)!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).accent1,
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

        final dailyQuestionResultPageAnswersRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).accent1,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).accent1,
              automaticallyImplyLeading: false,
              title: Text(
                FFLocalizations.of(context).getText(
                  's0xm194p' /* Answers */,
                ),
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                      color: Color(0xFF6B46C1),
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).titleLargeIsCustom,
                    ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.asset(
                      'assets/images/background_sites.webp',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                '33sosmv7' /* Today's Answers */,
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .headlineMediumFamily,
                                    color: Color(0xFF6B46C1),
                                    fontSize: 24.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .headlineMediumIsCustom,
                                  ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 22.0,
                                        sigmaY: 22.0,
                                      ),
                                      child: StreamBuilder<
                                          List<DailyQuestionsRecord>>(
                                        stream: queryDailyQuestionsRecord(
                                          queryBuilder:
                                              (dailyQuestionsRecord) =>
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
                                                  blurRadius: 4.0,
                                                  color: Color(0x1B000000),
                                                  offset: Offset(
                                                    0.0,
                                                    2.0,
                                                  ),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              border: Border.all(
                                                color: Color(0x34FFFFFF),
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: AuthUserStreamWidget(
                                                builder: (context) => Text(
                                                  valueOrDefault<String>(
                                                    () {
                                                      if (_model
                                                              .showOriginalEN ==
                                                          true) {
                                                        return containerDailyQuestionsRecord
                                                            ?.questionTextEn;
                                                      } else if (valueOrDefault(
                                                              currentUserDocument
                                                                  ?.appLanguage,
                                                              '') ==
                                                          'en') {
                                                        return containerDailyQuestionsRecord
                                                            ?.questionTextEn;
                                                      } else if (valueOrDefault(
                                                              currentUserDocument
                                                                  ?.appLanguage,
                                                              '') ==
                                                          'de') {
                                                        return containerDailyQuestionsRecord
                                                            ?.questionTextDe;
                                                      } else if (valueOrDefault(
                                                              currentUserDocument
                                                                  ?.appLanguage,
                                                              '') ==
                                                          'es') {
                                                        return containerDailyQuestionsRecord
                                                            ?.questionTextEs;
                                                      } else {
                                                        return containerDailyQuestionsRecord
                                                            ?.questionTextEn;
                                                      }
                                                    }(),
                                                    'Daily question',
                                                  ),
                                                  textAlign: TextAlign.center,
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
                                                            FontWeight.w500,
                                                        lineHeight: 1.4,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleMediumIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                if (valueOrDefault(
                                        currentUserDocument?.appLanguage, '') !=
                                    'en')
                                  AuthUserStreamWidget(
                                    builder: (context) => FFButtonWidget(
                                      onPressed: () async {
                                        _model.showOriginalEN =
                                            !_model.showOriginalEN;
                                        safeSetState(() {});
                                      },
                                      text: _model.showOriginalEN == true
                                          ? () {
                                              if (valueOrDefault(
                                                      currentUserDocument
                                                          ?.appLanguage,
                                                      '') ==
                                                  'de') {
                                                return 'Zurück';
                                              } else if (valueOrDefault(
                                                      currentUserDocument
                                                          ?.appLanguage,
                                                      '') ==
                                                  'es') {
                                                return 'Volver';
                                              } else {
                                                return 'Back';
                                              }
                                            }()
                                          : 'Original (EN)',
                                      options: FFButtonOptions(
                                        height: 22.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: Color(0x0000000E),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .titleSmallIsCustom,
                                            ),
                                        elevation: 0.0,
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0x194220E1),
                                  borderRadius: BorderRadius.circular(24.0),
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
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'g9r2ayf2' /* You said */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmallFamily,
                                                        color:
                                                            Color(0xA76B46C1),
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleSmallIsCustom,
                                                      ),
                                                ),
                                                Text(
                                                  currentUserUid ==
                                                          dailyQuestionResultPageAnswersRecord
                                                              .userAId
                                                      ? dailyQuestionResultPageAnswersRecord
                                                          .userAAnswer
                                                      : dailyQuestionResultPageAnswersRecord
                                                          .userBAnswer,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        color:
                                                            Color(0xFF2D3748),
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        lineHeight: 1.5,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMediumIsCustom,
                                                      ),
                                                ),
                                              ].divide(SizedBox(height: 8.0)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0x194220E1),
                                  borderRadius: BorderRadius.circular(24.0),
                                  border: Border.all(
                                    color: Color(0x34FFFFFF),
                                    width: 1.0,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'xg39cgr7' /* Your partner said */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmallFamily,
                                                    color: Color(0xB7DD783F),
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmallIsCustom,
                                                  ),
                                            ),
                                            Builder(
                                              builder: (context) {
                                                if (true) {
                                                  return Text(
                                                    currentUserUid ==
                                                            dailyQuestionResultPageAnswersRecord
                                                                .userAId
                                                        ? dailyQuestionResultPageAnswersRecord
                                                            .userBAnswer
                                                        : dailyQuestionResultPageAnswersRecord
                                                            .userAAnswer,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .poppins(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color:
                                                              Color(0xFF2D3748),
                                                          fontSize: 15.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                          lineHeight: 1.5,
                                                        ),
                                                  );
                                                } else {
                                                  return Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'mu4dsbbe' /* Waiting for your partner's ans... */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          color:
                                                              Color(0xFF9CA3AF),
                                                          fontSize: 15.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          lineHeight: 1.5,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                  );
                                                }
                                              },
                                            ),
                                          ].divide(SizedBox(height: 8.0)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (valueOrDefault<bool>(
                              dailyQuestionResultPageAnswersRecord
                                      .userAAnswered &&
                                  dailyQuestionResultPageAnswersRecord
                                      .userBAnswered,
                              true,
                            ))
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF3F0FF),
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(
                                      color: Color(0xFFE8E3FF),
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
                                          Icons.favorite,
                                          color: Color(0xFF6B46C1),
                                          size: 24.0,
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'po6tf5wv' /* Both answers saved
 to your re... */
                                            ,
                                          ),
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily,
                                                color: Color(0xFF6B46C1),
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmallIsCustom,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                  ),
                                ),
                              ),
                            FFButtonWidget(
                              onPressed: () async {
                                context.pushNamed(ConnectWidget.routeName);
                              },
                              text: FFLocalizations.of(context).getText(
                                '7cr262ik' /* Back to Home */,
                              ),
                              icon: Icon(
                                Icons.home_rounded,
                                size: 20.0,
                              ),
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 50.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    32.0, 0.0, 32.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconColor: Colors.white,
                                color: Color(0xFF6B46C1),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleMediumFamily,
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .titleMediumIsCustom,
                                    ),
                                elevation: 2.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ]
                              .divide(SizedBox(height: 24.0))
                              .addToStart(SizedBox(height: 32.0))
                              .addToEnd(SizedBox(height: 32.0)),
                        ),
                      ),
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
