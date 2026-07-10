import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/components/pair_required_sheet/pair_required_sheet_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:firebase_storagelibrary_2sa6k9/app_state.dart'
    as firebase_storagelibrary_2sa6k9_app_state;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'daily_question_pagee_model.dart';
export 'daily_question_pagee_model.dart';

/// Erstelle eine Seite namens DailyQuestionPage.
///
/// 📌 Sie enthält:
///
/// Überschrift (Text): „Today's Question“ (zentriert, groß, fett)
///
/// Frage-Feld (Textfeld / Container): Platzhaltertext wie „What made you
/// smile today?“ (mittig, eingerahmt, mit Schatten)
///
/// Antwortfeld (TextInput): Ein großes Textfeld, in das der Benutzer seine
/// Antwort eingeben kann (mit Padding, abgerundeten Ecken)
///
/// Button: „Submit“ (z. B. mit Icon „paper plane“)
///
/// Hinweistext unter dem Button: „After you answer, you’ll see your partner’s
/// response here.“
///
/// 🎨 Stil:
///
/// Hintergrundfarbe: Hell (z. B. soft beige oder helles Grau)
///
/// Runde Ecken für Container und Eingabefeld
///
/// Moderner, klarer Look
///
/// Padding: nicht zu eng, mobile-optimiert
///
/// ⚙️ Responsiveness:
/// Alles soll auch bei kleineren Displays gut lesbar und ansprechend sein.
class DailyQuestionPageeWidget extends StatefulWidget {
  const DailyQuestionPageeWidget({
    super.key,
    required this.finalAnswerDocPath,
    required this.questionText,
    required this.questionId,
    required this.dayKey,
  });

  final String? finalAnswerDocPath;
  final String? questionText;
  final String? questionId;
  final String? dayKey;

  static String routeName = 'DailyQuestionPagee';
  static String routePath = '/dailyQuestionPagee';

  @override
  State<DailyQuestionPageeWidget> createState() =>
      _DailyQuestionPageeWidgetState();
}

class _DailyQuestionPageeWidgetState extends State<DailyQuestionPageeWidget> {
  late DailyQuestionPageeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DailyQuestionPageeModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'DailyQuestionPagee'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if ((valueOrDefault(currentUserDocument?.relationshipId, '') == '') ||
          (valueOrDefault(currentUserDocument?.relationshipId, '') == '')) {
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          isDismissible: false,
          enableDrag: false,
          useSafeArea: true,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: PairRequiredSheetWidget(),
              ),
            );
          },
        ).then((value) => safeSetState(() {}));
      } else {
        // relationshipQueryA
        _model.relationshipDocA = await queryRelationshipsRecordOnce(
          queryBuilder: (relationshipsRecord) => relationshipsRecord
              .where(
                'userA_id',
                isEqualTo: FFAppState().uid,
              )
              .where(
                'userB_id',
                isEqualTo: FFAppState().appPartnerUID,
              ),
        );
        // relationshipQueryB
        _model.relationshipDocB = await queryRelationshipsRecordOnce(
          queryBuilder: (relationshipsRecord) => relationshipsRecord
              .where(
                'userA_id',
                isEqualTo: FFAppState().appPartnerUID,
              )
              .where(
                'userB_id',
                isEqualTo: FFAppState().uid,
              ),
        );
        _model.todayKey = dateTimeFormat(
          "yyyyMMdd",
          functions.startOfTodayUtc(),
          locale: FFLocalizations.of(context).languageCode,
        );
        safeSetState(() {});
      }
    });

    _model.textController ??= TextEditingController(text: _model.answerInput);
    _model.textFieldFocusNode ??= FocusNode();

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

    return StreamBuilder<List<DailyQuestionsRecord>>(
      stream: queryDailyQuestionsRecord(
        queryBuilder: (dailyQuestionsRecord) => dailyQuestionsRecord.where(
          'date',
          isEqualTo: FFAppState().todayDate,
        ),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFFF8F6F0),
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
        List<DailyQuestionsRecord> dailyQuestionPageeDailyQuestionsRecordList =
            snapshot.data!;
        final dailyQuestionPageeDailyQuestionsRecord =
            dailyQuestionPageeDailyQuestionsRecordList.isNotEmpty
                ? dailyQuestionPageeDailyQuestionsRecordList.first
                : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFFF8F6F0),
            appBar: AppBar(
              backgroundColor: Color(0xFFE6DFFF),
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Color(0xFF6B46C1),
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                FFLocalizations.of(context).getText(
                  'evtpu0ey' /* Daily question */,
                ),
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).headlineMediumFamily,
                      color: Color(0xFF6B46C1),
                      fontSize: 22.0,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).headlineMediumIsCustom,
                    ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 2.0,
            ),
            body: Stack(
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
                Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0x184220E1),
                      borderRadius: BorderRadius.only(),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Color(0x34FFFFFF),
                        width: 1.0,
                      ),
                    ),
                    alignment: AlignmentDirectional(0.0, -1.0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          20.0, 100.0, 20.0, 0.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 10.0,
                            sigmaY: 10.0,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 32.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      '2h1uz91m' /* Today's Question */,
                                    ),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .displaySmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .displaySmallFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 28.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .displaySmallIsCustom,
                                        ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(24.0),
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
                                              color: Color(0x5C9B7BFF),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 8.0,
                                                  color: Color(0x1A000000),
                                                  offset: Offset(
                                                    0.0,
                                                    4.0,
                                                  ),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
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
                                    if (valueOrDefault(
                                            currentUserDocument?.appLanguage,
                                            '') !=
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0x0000000E),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallIsCustom,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiary,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 32.0, 16.0, 0.0),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Color(0x00F8F6F0),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 320.9,
                                                    height: 188.6,
                                                    decoration: BoxDecoration(
                                                      color: Color(0x00F8F6F0),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            child:
                                                                TextFormField(
                                                              controller: _model
                                                                  .textController,
                                                              focusNode: _model
                                                                  .textFieldFocusNode,
                                                              autofocus: false,
                                                              textCapitalization:
                                                                  TextCapitalization
                                                                      .sentences,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .done,
                                                              obscureText:
                                                                  false,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                  'x2xobpyy' /* Share your thoughts here... */,
                                                                ),
                                                                hintStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyMediumIsCustom,
                                                                    ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0xFFE0E0E0),
                                                                    width: 2.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    width: 2.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                ),
                                                                errorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 2.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                ),
                                                                focusedErrorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 2.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                ),
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            16.0),
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .accent4,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    lineHeight:
                                                                        1.5,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .bodyMediumIsCustom,
                                                                  ),
                                                              maxLines: 6,
                                                              minLines: 4,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              cursorColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                              validator: _model
                                                                  .textControllerValidator
                                                                  .asValidator(
                                                                      context),
                                                              inputFormatters: [
                                                                if (!isAndroid &&
                                                                    !isiOS)
                                                                  TextInputFormatter
                                                                      .withFunction(
                                                                          (oldValue,
                                                                              newValue) {
                                                                    return TextEditingValue(
                                                                      selection:
                                                                          newValue
                                                                              .selection,
                                                                      text: newValue
                                                                          .text
                                                                          .toCapitalization(
                                                                              TextCapitalization.sentences),
                                                                    );
                                                                  }),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      24.0,
                                                                      16.0,
                                                                      0.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              try {
                                                                final result = await FirebaseFunctions
                                                                        .instanceFor(
                                                                            region:
                                                                                'europe-west3')
                                                                    .httpsCallable(
                                                                        'submitDailyAnswer')
                                                                    .call({
                                                                  "answerText":
                                                                      _model
                                                                          .textController
                                                                          .text,
                                                                });
                                                                _model.answersoutput =
                                                                    SubmitDailyAnswerCloudFunctionCallResponse(
                                                                  data: DailyQuestionCFResultStruct
                                                                      .fromMap(
                                                                          result
                                                                              .data),
                                                                  succeeded:
                                                                      true,
                                                                  resultAsString:
                                                                      result
                                                                          .data
                                                                          .toString(),
                                                                  jsonBody:
                                                                      result
                                                                          .data,
                                                                );
                                                              } on FirebaseFunctionsException catch (error) {
                                                                _model.answersoutput =
                                                                    SubmitDailyAnswerCloudFunctionCallResponse(
                                                                  errorCode:
                                                                      error
                                                                          .code,
                                                                  succeeded:
                                                                      false,
                                                                );
                                                              }

                                                              if (_model
                                                                      .answersoutput
                                                                      ?.data
                                                                      ?.ok ==
                                                                  true) {
                                                                logFirebaseEvent(
                                                                    'daily_question_answered');
                                                                try {
                                                                  final result = await FirebaseFunctions.instanceFor(
                                                                          region:
                                                                              'europe-west3')
                                                                      .httpsCallable(
                                                                          'sendPartnerPush')
                                                                      .call({
                                                                    "type":
                                                                        'daily_question_partner_answered',
                                                                    "route":
                                                                        'dailyQuestionPagee',
                                                                    "audience":
                                                                        'partner',
                                                                  });
                                                                  _model.fa =
                                                                      SendPartnerPushCloudFunctionCallResponse(
                                                                    data: result
                                                                        .data,
                                                                    succeeded:
                                                                        true,
                                                                    resultAsString:
                                                                        result
                                                                            .data
                                                                            .toString(),
                                                                    jsonBody:
                                                                        result
                                                                            .data,
                                                                  );
                                                                } on FirebaseFunctionsException catch (error) {
                                                                  _model.fa =
                                                                      SendPartnerPushCloudFunctionCallResponse(
                                                                    errorCode:
                                                                        error
                                                                            .code,
                                                                    succeeded:
                                                                        false,
                                                                  );
                                                                }

                                                                context.goNamed(
                                                                  DailyQuestionResultPageWidget
                                                                      .routeName,
                                                                  queryParameters:
                                                                      {
                                                                    'finalAnswerDocPath':
                                                                        serializeParam(
                                                                      _model
                                                                          .answersoutput
                                                                          ?.data
                                                                          ?.answerDocPath,
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                  }.withoutNulls,
                                                                  extra: <String,
                                                                      dynamic>{
                                                                    '__transition_info__':
                                                                        TransitionInfo(
                                                                      hasTransition:
                                                                          true,
                                                                      transitionType:
                                                                          PageTransitionType
                                                                              .fade,
                                                                    ),
                                                                  },
                                                                );
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      _model
                                                                          .answersoutput!
                                                                          .data!
                                                                          .message,
                                                                      style:
                                                                          TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                      ),
                                                                    ),
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            4000),
                                                                    backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                  ),
                                                                );
                                                              }

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              'v1qh04wl' /* Send answer */,
                                                            ),
                                                            icon: Icon(
                                                              Icons.send,
                                                              size: 20.0,
                                                            ),
                                                            options:
                                                                FFButtonOptions(
                                                              width: 200.0,
                                                              height: 50.0,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          32.0,
                                                                          0.0,
                                                                          32.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              iconColor:
                                                                  Colors.white,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .tertiary,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).titleMediumFamily,
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        useGoogleFonts:
                                                                            !FlutterFlowTheme.of(context).titleMediumIsCustom,
                                                                      ),
                                                              elevation: 3.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25.0),
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
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 16.0, 16.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'fm23psl8' /* After you have answered, you w... */,
                                    ),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmallFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          lineHeight: 1.3,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodySmallIsCustom,
                                        ),
                                  ),
                                ),
                              ],
                            ),
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
      },
    );
  }
}
