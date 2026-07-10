import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/components/pair_required_sheet/pair_required_sheet_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:firebase_storagelibrary_2sa6k9/app_state.dart'
    as firebase_storagelibrary_2sa6k9_app_state;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'love_note_page_copy_model.dart';
export 'love_note_page_copy_model.dart';

/// Design a heartfelt, elegant Love Notes screen for a mobile relationship
/// app called Togetherly.
///
/// This page allows couples to exchange short love messages or letters – like
/// a shared digital memory box of affection.
/// Focus on clean, emotional visual design only. No functionality required.
///
/// 🧱 Page Structure:
/// 1. Page Title (Top Center):
/// Love Notes
/// Subtitle:
/// “Little words. Big feelings – just for the two of you.”
///
/// 2. Love Notes Feed (main area):
/// A vertical scrollable list of note cards that alternate sides, like a soft
/// chat layout – but stylized:
///
/// Each card includes:
///
/// Sender label: You said or Your partner said
///
/// The note text (short or long)
///
/// Optional small icons/emojis for emotion (💖, 💌, 🌙, 🌸)
///
/// Date & time in small text below
///
/// Cards are soft pastel with slight drop shadow (lavender, rose, peach, sky
/// blue)
///
/// Notes from the partner appear aligned right with different color tone
///
/// Example:
///
/// perl
/// Kopieren
/// Bearbeiten
/// You said
/// “I still smile when I think of our beach walk last summer.”
/// 💖 July 25, 2025 – 10:21 PM
/// 3. Add New Note Section (bottom of screen):
/// Sticky bottom panel with:
///
/// Multiline input box: Write your love note here…
///
/// Button: ➕ Send Note (pastel purple button with soft animation)
///
/// 4. Empty State (if no notes yet):
/// Illustration of a paper plane or envelope with text:
/// “No notes yet – send your first heartful message today 💌”
///
/// Design Guidelines:
/// Color Palette: Soft lavender, blush pink, warm beige, gentle pastels
///
/// Typography: Rounded and emotional (Poppins, Nunito)
///
/// Layout Mood: Calm, romantic, private, like a shared diary
///
/// Aesthetic: Minimalistic elegance with heartfelt atmosphere
///
/// Rounded containers, soft shadows, gentle gradients
///
/// Encourages emotion and intimacy in visual tone
class LoveNotePageCopyWidget extends StatefulWidget {
  const LoveNotePageCopyWidget({super.key});

  static String routeName = 'LoveNotePageCopy';
  static String routePath = '/loveNotePageCopy';

  @override
  State<LoveNotePageCopyWidget> createState() => _LoveNotePageCopyWidgetState();
}

class _LoveNotePageCopyWidgetState extends State<LoveNotePageCopyWidget> {
  late LoveNotePageCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoveNotePageCopyModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'LoveNotePageCopy'});
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

        context.goNamed(ConnectWidget.routeName);
      } else {
        _model.todayKey = dateTimeFormat(
          "yyyy-MM-dd",
          getCurrentTimestamp,
          locale: FFLocalizations.of(context).languageCode,
        );
        _model.docIdToday =
            '${valueOrDefault(currentUserDocument?.relationshipId, '')}_${currentUserUid}_${_model.todayKey}';
        _model.noteText = null;
        _model.todayNotes = await queryLoveNotesRecordOnce(
          queryBuilder: (loveNotesRecord) => loveNotesRecord
              .where(
                'relationship_id',
                isEqualTo:
                    valueOrDefault(currentUserDocument?.relationshipId, ''),
              )
              .where(
                'from_user_id',
                isEqualTo: currentUserUid,
              )
              .where(
                'day_key',
                isEqualTo: _model.todayKey,
              ),
        );
        _model.sentToday =
            _model.todayNotes != null && (_model.todayNotes)!.isNotEmpty
                ? true
                : false;
        safeSetState(() {});
      }
    });

    _model.loveNoteInputTextController ??= TextEditingController();
    _model.loveNoteInputFocusNode ??= FocusNode();

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
        backgroundColor: Color(0xFFF8F5F9),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        'p666hy4u' /* Love Notes */,
                      ),
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineMediumFamily,
                                color: Color(0xFF6B4E7D),
                                fontSize: 28.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .headlineMediumIsCustom,
                              ),
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        'wh89nv5w' /* Little words. Big feelings
jus... */
                        ,
                      ),
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: Color(0xFF8A7CA8),
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            lineHeight: 1.4,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                  ].divide(SizedBox(height: 8.0)),
                ),
              ),
              if (_model.todayKey != null && _model.todayKey != '')
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          AuthUserStreamWidget(
                            builder: (context) =>
                                StreamBuilder<List<LoveNotesRecord>>(
                              stream: queryLoveNotesRecord(
                                queryBuilder: (loveNotesRecord) =>
                                    loveNotesRecord
                                        .where(
                                          'relationship_id',
                                          isEqualTo: valueOrDefault(
                                              currentUserDocument
                                                  ?.relationshipId,
                                              ''),
                                        )
                                        .where(
                                          'day_key',
                                          isEqualTo: _model.todayKey,
                                        )
                                        .orderBy('timestamp', descending: true),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<LoveNotesRecord>
                                    listViewLoveNotesRecordList =
                                    snapshot.data!;

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: listViewLoveNotesRecordList.length,
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewLoveNotesRecord =
                                        listViewLoveNotesRecordList[
                                            listViewIndex];
                                    return Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: StreamBuilder<
                                              List<RelationshipViewsRecord>>(
                                            stream:
                                                queryRelationshipViewsRecord(
                                              queryBuilder:
                                                  (relationshipViewsRecord) =>
                                                      relationshipViewsRecord
                                                          .where(
                                                'relationship_id',
                                                isEqualTo: valueOrDefault(
                                                    currentUserDocument
                                                        ?.relationshipId,
                                                    ''),
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
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              List<RelationshipViewsRecord>
                                                  containerRelationshipViewsRecordList =
                                                  snapshot.data!;
                                              final containerRelationshipViewsRecord =
                                                  containerRelationshipViewsRecordList
                                                          .isNotEmpty
                                                      ? containerRelationshipViewsRecordList
                                                          .first
                                                      : null;

                                              return Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.85,
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 8.0,
                                                      color: Color(0x1A6B4E7D),
                                                      offset: Offset(
                                                        0.0,
                                                        2.0,
                                                      ),
                                                    )
                                                  ],
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xFFF0EBFF),
                                                      valueOrDefault<Color>(
                                                        listViewLoveNotesRecord
                                                                    .fromUserId ==
                                                                currentUserUid
                                                            ? Color(0xFFE8E1FF)
                                                            : Color(0xFFE8F0FF),
                                                        Color(0xFFE8E1FF),
                                                      )
                                                    ],
                                                    stops: [0.0, 1.0],
                                                    begin: AlignmentDirectional(
                                                        1.0, 1.0),
                                                    end: AlignmentDirectional(
                                                        -1.0, -1.0),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, 0.0),
                                                            child: Text(
                                                              listViewLoveNotesRecord
                                                                          .fromUserId ==
                                                                      currentUserUid
                                                                  ? 'Your love note'
                                                                  : 'Your partner',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .labelMediumFamily,
                                                                    color: Color(
                                                                        0xFF8A7CA8),
                                                                    fontSize:
                                                                        12.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .labelMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                          if (listViewLoveNotesRecord
                                                                  .fromUserId !=
                                                              currentUserUid)
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          12.0,
                                                                          6.0,
                                                                          0.0),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .transparent,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: 48.0,
                                                                  height: 48.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            24.0),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            24.0),
                                                                    child: Image
                                                                        .network(
                                                                      containerRelationshipViewsRecord!
                                                                          .partnerPhotoUrl,
                                                                      width:
                                                                          48.0,
                                                                      height:
                                                                          48.0,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          if (listViewLoveNotesRecord
                                                                  .fromUserId ==
                                                              currentUserUid)
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          12.0,
                                                                          6.0,
                                                                          0.0),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .transparent,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: 48.0,
                                                                  height: 48.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            24.0),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            24.0),
                                                                    child: Image
                                                                        .network(
                                                                      containerRelationshipViewsRecord!
                                                                          .myPhotoUrl,
                                                                      width:
                                                                          48.0,
                                                                      height:
                                                                          48.0,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, 0.0),
                                                            child: Text(
                                                              listViewLoveNotesRecord
                                                                  .text,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    color: Color(
                                                                        0xFF4A3B5C),
                                                                    fontSize:
                                                                        15.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    lineHeight:
                                                                        1.5,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .bodyMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child: Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              '9pq8wawg' /* 💕 */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodySmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallFamily,
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmallIsCustom,
                                                                ),
                                                          ),
                                                        ),
                                                        Text(
                                                          dateTimeFormat(
                                                            "yMd",
                                                            listViewLoveNotesRecord
                                                                .timestamp!,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmallFamily,
                                                                color: Color(
                                                                    0xFF9D8FB5),
                                                                fontSize: 11.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmallIsCustom,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 8.0)),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ]
                            .divide(SizedBox(height: 16.0))
                            .addToStart(SizedBox(height: 24.0))
                            .addToEnd(SizedBox(height: 120.0)),
                      ),
                    ),
                  ),
                ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0x00FFFFFF), Colors.white],
                      stops: [0.0, 1.0],
                      begin: AlignmentDirectional(0.0, -1.0),
                      end: AlignmentDirectional(0, 1.0),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 32.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12.0,
                            color: Color(0x1A6B4E7D),
                            offset: Offset(
                              0.0,
                              -4.0,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextFormField(
                              controller: _model.loveNoteInputTextController,
                              focusNode: _model.loveNoteInputFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.loveNoteInputTextController',
                                Duration(milliseconds: 2000),
                                () async {
                                  _model.noteText =
                                      _model.loveNoteInputTextController.text;
                                  safeSetState(() {});
                                },
                              ),
                              autofocus: false,
                              textInputAction: TextInputAction.done,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: FFLocalizations.of(context).getText(
                                  'bk0dol8g' /* Write your daily love note her... */,
                                ),
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: Color(0xFFB5A68B),
                                      fontSize: 15.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE8E1FF),
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF8A7CA8),
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                filled: true,
                                fillColor: Color(0xFFF8F5F9),
                                contentPadding: EdgeInsets.all(16.0),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: Color(0xFF4A3B5C),
                                    fontSize: 15.0,
                                    letterSpacing: 0.0,
                                    lineHeight: 1.4,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                              maxLines: 4,
                              cursorColor: Color(0xFF6B4E7D),
                              validator: _model
                                  .loveNoteInputTextControllerValidator
                                  .asValidator(context),
                            ),
                            AuthUserStreamWidget(
                              builder: (context) =>
                                  StreamBuilder<List<LoveNotesRecord>>(
                                stream: queryLoveNotesRecord(
                                  queryBuilder: (loveNotesRecord) =>
                                      loveNotesRecord
                                          .where(
                                            'relationship_id',
                                            isEqualTo: valueOrDefault(
                                                currentUserDocument
                                                    ?.relationshipId,
                                                ''),
                                          )
                                          .where(
                                            'from_user_id',
                                            isEqualTo: currentUserUid,
                                          )
                                          .where(
                                            'day_key',
                                            isEqualTo: _model.todayKey,
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
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  List<LoveNotesRecord>
                                      buttonLoveNotesRecordList =
                                      snapshot.data!;
                                  final buttonLoveNotesRecord =
                                      buttonLoveNotesRecordList.isNotEmpty
                                          ? buttonLoveNotesRecordList.first
                                          : null;

                                  return FFButtonWidget(
                                    onPressed: ((_model.sentToday == true) ||
                                            (_model.noteText == null ||
                                                _model.noteText == ''))
                                        ? null
                                        : () async {
                                            if (_model.sentToday == true) {
                                              if (valueOrDefault(
                                                      currentUserDocument
                                                          ?.appLanguage,
                                                      '') ==
                                                  'en') {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Write a love note 💜',
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
                                              } else if (valueOrDefault(
                                                      currentUserDocument
                                                          ?.appLanguage,
                                                      '') ==
                                                  'de') {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Schreibe eine Liebesbotschaft 💜',
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
                                              } else if (valueOrDefault(
                                                      currentUserDocument
                                                          ?.appLanguage,
                                                      '') ==
                                                  'es') {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Escribe una nota de amor 💜',
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
                                            } else {
                                              if (!(_model.noteText == null ||
                                                  _model.noteText == '')) {
                                                _model.todayKey =
                                                    dateTimeFormat(
                                                  "yyyy-MM-dd",
                                                  getCurrentTimestamp,
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
                                                );
                                                _model.docIdToday =
                                                    '${valueOrDefault(currentUserDocument?.relationshipId, '')}_${currentUserUid}_${_model.todayKey}';
                                                safeSetState(() {});
                                                _model.todayQuery =
                                                    await queryLoveNotesRecordOnce(
                                                  queryBuilder:
                                                      (loveNotesRecord) =>
                                                          loveNotesRecord
                                                              .where(
                                                                'relationship_id',
                                                                isEqualTo: valueOrDefault(
                                                                    currentUserDocument
                                                                        ?.relationshipId,
                                                                    ''),
                                                              )
                                                              .where(
                                                                'from_user_id',
                                                                isEqualTo:
                                                                    currentUserUid,
                                                              )
                                                              .where(
                                                                'day_key',
                                                                isEqualTo: _model
                                                                    .todayKey,
                                                              ),
                                                );
                                                if (_model.todayQuery?.length ==
                                                    0) {
                                                  await LoveNotesRecord
                                                      .collection
                                                      .doc(_model.docIdToday!)
                                                      .set(
                                                          createLoveNotesRecordData(
                                                        relationshipId: valueOrDefault(
                                                            currentUserDocument
                                                                ?.relationshipId,
                                                            ''),
                                                        fromUserId:
                                                            currentUserUid,
                                                        toUserId: FFAppState()
                                                            .appPartnerUID,
                                                        text: _model.noteText,
                                                        timestamp:
                                                            getCurrentTimestamp,
                                                        dayKey: _model.todayKey,
                                                        pinned: false,
                                                      ));
                                                  logFirebaseEvent(
                                                    'love_note',
                                                    parameters: {
                                                      'note': _model
                                                          .loveNoteInputTextController
                                                          .text,
                                                    },
                                                  );
                                                  if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.appLanguage,
                                                          '') ==
                                                      'en') {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Sent 💌',
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
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
                                                  } else if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.appLanguage,
                                                          '') ==
                                                      'de') {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Gesendet 💌',
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
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
                                                  } else if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.appLanguage,
                                                          '') ==
                                                      'es') {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Enviado 💌',
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
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

                                                  safeSetState(() {
                                                    _model
                                                        .loveNoteInputTextController
                                                        ?.clear();
                                                  });
                                                  try {
                                                    final result =
                                                        await FirebaseFunctions
                                                                .instanceFor(
                                                                    region:
                                                                        'europe-west3')
                                                            .httpsCallable(
                                                                'sendPartnerPush')
                                                            .call({
                                                      "type": 'love_note_sent',
                                                      "route": 'loveNotePage',
                                                      "audience": 'partner',
                                                    });
                                                    _model.fas =
                                                        SendPartnerPushCloudFunctionCallResponse(
                                                      data: result.data,
                                                      succeeded: true,
                                                      resultAsString: result
                                                          .data
                                                          .toString(),
                                                      jsonBody: result.data,
                                                    );
                                                  } on FirebaseFunctionsException catch (error) {
                                                    _model.fas =
                                                        SendPartnerPushCloudFunctionCallResponse(
                                                      errorCode: error.code,
                                                      succeeded: false,
                                                    );
                                                  }
                                                } else {
                                                  if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.appLanguage,
                                                          '') ==
                                                      'en') {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'You have already sent your love note today 💌',
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
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
                                                  } else if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.appLanguage,
                                                          '') ==
                                                      'de') {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Du kannst nur eine Liebesnachricht pro Tag verschicken 💌',
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
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
                                                  } else if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.appLanguage,
                                                          '') ==
                                                      'es') {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Solo puedes enviar una nota de amor por día 💌',
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
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
                                                }
                                              }
                                            }

                                            safeSetState(() {});
                                          },
                                    text: FFLocalizations.of(context).getText(
                                      'oiy3vr8e' /* 💌 Send Note */,
                                    ),
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 52.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Color(0xFF8A7CA8),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleMediumFamily,
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .titleMediumIsCustom,
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                      ),
                    ),
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
