import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'daily_questions_journal_model.dart';
export 'daily_questions_journal_model.dart';

/// Create a mobile page named “Daily Questions Journal (Simple)”.
///
/// Style:
/// - Clean, minimal, airy. Light background, large title, rounded-2xl cards,
/// subtle shadow.
/// - Use the app’s Primary color for small accents only.
///
/// Header:
/// - AppBar with back arrow and title: “Daily Questions”.
/// - Small subtitle below: “Your past questions and answers”.
///
/// Content:
/// - A vertical ListView of simple cards (use a reusable component if
/// possible).
/// - Each card shows:
///   • Date label (e.g., “Aug 11, 2025”) in a small neutral pill.
///   • The question text in medium weight (max 3 lines, ellipsis).
///   • A small label “You said” and the full user’s own answer (multi-line).
///   • A small label “Your partner said” and the partner answer (multi-line).
/// - If an answer is missing, show a soft placeholder: “Waiting for answer…”.
///
/// Empty / Loading:
/// - While loading: 4 skeleton cards.
/// - If empty: centered friendly message: “No entries yet”.
///
/// Create a reusable component named “JourneyCardSimple”.
///
/// Props:
/// - dateLabel (string)
/// - questionText (string)
/// - youAnswer (string)
/// - partnerAnswer (string)
///
/// Design:
/// - Rounded-2xl container with soft shadow and 14–16px padding.
/// - Top row: dateLabel in a small neutral chip on the left.
/// - Question text in semi-bold beneath (max 3 lines).
/// - Two blocks:
///    • Label “You said” (eyebrow style), body text below (wrap, multi-line).
///    • Label “Your partner said”, body text below.
/// - If any answer prop is empty, show “Waiting for answer…” in subtle gray.
/// - Whole card is non-interactive (no chevron).
class DailyQuestionsJournalWidget extends StatefulWidget {
  const DailyQuestionsJournalWidget({super.key});

  static String routeName = 'DailyQuestionsJournal';
  static String routePath = '/dailyQuestionsJournal';

  @override
  State<DailyQuestionsJournalWidget> createState() =>
      _DailyQuestionsJournalWidgetState();
}

class _DailyQuestionsJournalWidgetState
    extends State<DailyQuestionsJournalWidget> {
  late DailyQuestionsJournalModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DailyQuestionsJournalModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'DailyQuestionsJournal'});
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthUserStreamWidget(
      builder: (context) => StreamBuilder<List<AnswersRecord>>(
        stream: queryAnswersRecord(
          queryBuilder: (answersRecord) => answersRecord
              .where(
                'relationship_id',
                isEqualTo:
                    valueOrDefault(currentUserDocument?.relationshipId, ''),
              )
              .orderBy('timestamp', descending: true),
        ),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: FlutterFlowTheme.of(context).primaryText,
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
          List<AnswersRecord> dailyQuestionsJournalAnswersRecordList =
              snapshot.data!;

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryText,
              appBar: AppBar(
                backgroundColor: Color(0xFFE6DFFF),
                automaticallyImplyLeading: false,
                leading: FlutterFlowIconButton(
                  borderRadius: 20.0,
                  buttonSize: 40.0,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    context.safePop();
                  },
                ),
                title: Text(
                  FFLocalizations.of(context).getText(
                    '1myaq7cm' /* Daily Questions */,
                  ),
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineMediumFamily,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        useGoogleFonts: !FlutterFlowTheme.of(context)
                            .headlineMediumIsCustom,
                      ),
                ),
                actions: [],
                centerTitle: false,
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
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 8.0, 24.0, 0.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'ymwiat57' /* Your past questions and answer... */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
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
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                          ),
                          SingleChildScrollView(
                            primary: false,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  child: Builder(
                                    builder: (context) {
                                      final answersList =
                                          dailyQuestionsJournalAnswersRecordList
                                              .toList()
                                              .take(30)
                                              .toList();

                                      return ListView.separated(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: answersList.length,
                                        separatorBuilder: (_, __) =>
                                            SizedBox(height: 16.0),
                                        itemBuilder:
                                            (context, answersListIndex) {
                                          final answersListItem =
                                              answersList[answersListIndex];
                                          return Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Color(0x239B7BFF),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 4.0,
                                                    color: Color(0x33000000),
                                                    offset: Offset(
                                                      0.0,
                                                      2.0,
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
                                              child: Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      8.0,
                                                                      0.0,
                                                                      8.0,
                                                                      0.0),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                dateTimeFormat(
                                                                  "yMMMd",
                                                                  answersListItem
                                                                      .timestamp!,
                                                                  locale: FFLocalizations.of(
                                                                          context)
                                                                      .languageCode,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .labelSmallFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .labelSmallIsCustom,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.appLanguage,
                                                                '') !=
                                                            'en')
                                                          FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              _model.showOriginalEN =
                                                                  !_model
                                                                      .showOriginalEN;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            text: _model.showOriginalEN ==
                                                                    true
                                                                ? () {
                                                                    if (valueOrDefault(
                                                                            currentUserDocument
                                                                                ?.appLanguage,
                                                                            '') ==
                                                                        'de') {
                                                                      return 'Zurück';
                                                                    } else if (valueOrDefault(
                                                                            currentUserDocument?.appLanguage,
                                                                            '') ==
                                                                        'es') {
                                                                      return 'Volver';
                                                                    } else {
                                                                      return 'Back';
                                                                    }
                                                                  }()
                                                                : 'Original (EN)',
                                                            options:
                                                                FFButtonOptions(
                                                              height: 22.0,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: Color(
                                                                  0x0000000E),
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).titleSmallFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        useGoogleFonts:
                                                                            !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                      ),
                                                              elevation: 0.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                    Text(
                                                      valueOrDefault<String>(
                                                        () {
                                                          if (_model
                                                                  .showOriginalEN ==
                                                              true) {
                                                            return answersListItem
                                                                .questionTextEn;
                                                          } else if (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.appLanguage,
                                                                  '') ==
                                                              'en') {
                                                            return answersListItem
                                                                .questionTextEn;
                                                          } else if (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.appLanguage,
                                                                  '') ==
                                                              'de') {
                                                            return answersListItem
                                                                .questionTextDe;
                                                          } else if (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.appLanguage,
                                                                  '') ==
                                                              'es') {
                                                            return answersListItem
                                                                .questionTextEs;
                                                          } else {
                                                            return answersListItem
                                                                .questionTextEn;
                                                          }
                                                        }(),
                                                        'Daily question',
                                                      ),
                                                      maxLines: 3,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeFamily,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeIsCustom,
                                                          ),
                                                    ),
                                                    Column(
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
                                                            '8wdzm0g0' /* You said */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMediumIsCustom,
                                                              ),
                                                        ),
                                                        if (answersListItem
                                                                .userAId ==
                                                            currentUserUid)
                                                          Text(
                                                            answersListItem
                                                                .userAAnswer,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  color: Color(
                                                                      0xFF2D3748),
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.4,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMediumIsCustom,
                                                                ),
                                                          ),
                                                        if (answersListItem
                                                                .userBId ==
                                                            currentUserUid)
                                                          Text(
                                                            answersListItem
                                                                .userBAnswer,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  color: Color(
                                                                      0xFF2D3748),
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.4,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMediumIsCustom,
                                                                ),
                                                          ),
                                                      ].divide(SizedBox(
                                                          height: 6.0)),
                                                    ),
                                                    Column(
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
                                                            'bbq5m6to' /* Your partner said */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .accent2,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMediumIsCustom,
                                                              ),
                                                        ),
                                                        if (answersListItem
                                                                .userAId ==
                                                            valueOrDefault(
                                                                currentUserDocument
                                                                    ?.partnerUID,
                                                                ''))
                                                          Text(
                                                            answersListItem
                                                                .userAAnswer,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  color: Color(
                                                                      0xFF2D3748),
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.4,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMediumIsCustom,
                                                                ),
                                                          ),
                                                        if (answersListItem
                                                                .userBId ==
                                                            valueOrDefault(
                                                                currentUserDocument
                                                                    ?.partnerUID,
                                                                ''))
                                                          Text(
                                                            answersListItem
                                                                .userBAnswer,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  color: Color(
                                                                      0xFF2D3748),
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.4,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMediumIsCustom,
                                                                ),
                                                          ),
                                                      ].divide(SizedBox(
                                                          height: 6.0)),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 12.0)),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [],
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
            ),
          );
        },
      ),
    );
  }
}
