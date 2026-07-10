import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'love_note_page_model.dart';
export 'love_note_page_model.dart';

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
class LoveNotePageWidget extends StatefulWidget {
  const LoveNotePageWidget({super.key});

  static String routeName = 'LoveNotePage';
  static String routePath = '/loveNotePage';

  @override
  State<LoveNotePageWidget> createState() => _LoveNotePageWidgetState();
}

class _LoveNotePageWidgetState extends State<LoveNotePageWidget> {
  late LoveNotePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoveNotePageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'LoveNotePage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if ((valueOrDefault(currentUserDocument?.relationshipId, '') == '') ||
          (valueOrDefault(currentUserDocument?.relationshipId, '') == '')) {
        context.goNamed(
          PairRequiredPageWidget.routeName,
          extra: <String, dynamic>{
            '__transition_info__': TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF8F5F9),
        body: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image.asset(
                'assets/images/background_lovenote.webp',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0x20000000),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 35.0, 24.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            '80yil7ha' /* Love Notes */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineMediumFamily,
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 28.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 2.0,
                                  )
                                ],
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .headlineMediumIsCustom,
                              ),
                        ),
                        Text(
                          FFLocalizations.of(context).getText(
                            '25hu6edu' /* Little words. Big feelings
jus... */
                            ,
                          ),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
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
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 10.0, 0.0),
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
                                            .orderBy('timestamp',
                                                descending: true),
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
                                        listViewLoveNotesRecordList =
                                        snapshot.data!;

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          listViewLoveNotesRecordList.length,
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
                                                  List<
                                                      RelationshipViewsRecord>>(
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
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.85,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 8.0,
                                                          color:
                                                              Color(0x1A6B4E7D),
                                                          offset: Offset(
                                                            0.0,
                                                            2.0,
                                                          ),
                                                        )
                                                      ],
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Color(0xFFEADFFF),
                                                          valueOrDefault<Color>(
                                                            listViewLoveNotesRecord
                                                                        .fromUserId ==
                                                                    currentUserUid
                                                                ? Color(
                                                                    0xFFEADFFF)
                                                                : Color(
                                                                    0xFFE8F0FF),
                                                            Color(0xFFE8E1FF),
                                                          )
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
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: BackdropFilter(
                                                        filter:
                                                            ImageFilter.blur(
                                                          sigmaX: 10.0,
                                                          sigmaY: 10.0,
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
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
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      listViewLoveNotesRecord.fromUserId ==
                                                                              currentUserUid
                                                                          ? 'Your love note'
                                                                          : 'Your partner',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).labelMediumFamily,
                                                                            color:
                                                                                Color(0xFF8A7CA8),
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).labelMediumIsCustom,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            12.0,
                                                                            6.0,
                                                                            0.0),
                                                                    child: StreamBuilder<
                                                                        List<
                                                                            PublicUsersRecord>>(
                                                                      stream:
                                                                          queryPublicUsersRecord(
                                                                        queryBuilder:
                                                                            (publicUsersRecord) =>
                                                                                publicUsersRecord.where(
                                                                          'uid',
                                                                          isEqualTo:
                                                                              currentUserUid,
                                                                        ),
                                                                        singleRecord:
                                                                            true,
                                                                      ),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
                                                                              width: 50.0,
                                                                              height: 50.0,
                                                                              child: CircularProgressIndicator(
                                                                                valueColor: AlwaysStoppedAnimation<Color>(
                                                                                  FlutterFlowTheme.of(context).primary,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }
                                                                        List<PublicUsersRecord>
                                                                            containerPublicUsersRecordList =
                                                                            snapshot.data!;
                                                                        final containerPublicUsersRecord = containerPublicUsersRecordList.isNotEmpty
                                                                            ? containerPublicUsersRecordList.first
                                                                            : null;

                                                                        return Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.transparent,
                                                                          ),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                48.0,
                                                                            height:
                                                                                48.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              borderRadius: BorderRadius.circular(24.0),
                                                                              border: Border.all(
                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                width: 1.0,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(24.0),
                                                                              child: Image.network(
                                                                                listViewLoveNotesRecord.fromUserId == currentUserUid ? containerPublicUsersRecord!.photoUrl : containerRelationshipViewsRecord!.partnerPhotoUrl,
                                                                                width: 48.0,
                                                                                height: 48.0,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
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
                                                                          10.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      listViewLoveNotesRecord
                                                                          .text,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                            color:
                                                                                Color(0xFF4A3B5C),
                                                                            fontSize:
                                                                                15.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            lineHeight:
                                                                                1.5,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            5.0),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'jb7t97h7' /* 💕 */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).bodySmallFamily,
                                                                            fontSize:
                                                                                16.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          10.0,
                                                                          5.0),
                                                                  child: Text(
                                                                    dateTimeFormat(
                                                                      "yMd",
                                                                      listViewLoveNotesRecord
                                                                          .timestamp!,
                                                                      locale: FFLocalizations.of(
                                                                              context)
                                                                          .languageCode,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).bodySmallFamily,
                                                                          color:
                                                                              Color(0xFF9D8FB5),
                                                                          fontSize:
                                                                              11.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 8.0)),
                                                        ),
                                                      ),
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
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 20.0, 20.0, 32.0),
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
                                  controller:
                                      _model.loveNoteInputTextController,
                                  focusNode: _model.loveNoteInputFocusNode,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    '_model.loveNoteInputTextController',
                                    Duration(milliseconds: 2000),
                                    () async {
                                      _model.noteText = _model
                                          .loveNoteInputTextController.text;
                                      safeSetState(() {});
                                    },
                                  ),
                                  autofocus: false,
                                  textInputAction: TextInputAction.done,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText:
                                        FFLocalizations.of(context).getText(
                                      '30nu5io8' /* Write your daily love note her... */,
                                    ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
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
                                        onPressed: () async {
                                          try {
                                            final result =
                                                await FirebaseFunctions
                                                        .instanceFor(
                                                            region:
                                                                'europe-west3')
                                                    .httpsCallable(
                                                        'submitLoveNote')
                                                    .call({
                                              "text": _model
                                                  .loveNoteInputTextController
                                                  .text,
                                            });
                                            _model.cloudFunction4ra =
                                                SubmitLoveNoteCloudFunctionCallResponse(
                                              data: CFResultStruct.fromMap(
                                                  result.data),
                                              succeeded: true,
                                              resultAsString:
                                                  result.data.toString(),
                                              jsonBody: result.data,
                                            );
                                          } on FirebaseFunctionsException catch (error) {
                                            _model.cloudFunction4ra =
                                                SubmitLoveNoteCloudFunctionCallResponse(
                                              errorCode: error.code,
                                              succeeded: false,
                                            );
                                          }

                                          safeSetState(() {
                                            _model.loveNoteInputTextController
                                                ?.clear();
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                _model.cloudFunction4ra!.data!
                                                    .message,
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          );

                                          safeSetState(() {});
                                        },
                                        text:
                                            FFLocalizations.of(context).getText(
                                          '72pfl6w0' /* 💌 Send Note */,
                                        ),
                                        options: FFButtonOptions(
                                          width: double.infinity,
                                          height: 52.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: Color(0xFF8A7CA8),
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
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
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .titleMediumIsCustom,
                                              ),
                                          elevation: 0.0,
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
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
          ],
        ),
      ),
    );
  }
}
