import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_state_voicenote/empty_state_voicenote_widget.dart';
import '/flutter_flow/flutter_flow_audio_player.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'voice_notes_results_model.dart';
export 'voice_notes_results_model.dart';

/// Create a premium romantic mobile page for a couples app called Togly where
/// users can create a Love Coupon for their partner.
///
/// This page should feel emotional, warm, elegant, and premium. It should not
/// feel like a form, but like creating a meaningful gift.
///
/// Core concept:
/// The user can either choose a beautifully designed preset coupon template
/// OR optionally upload their own photo for personalization.
///
/// Design style:
/// - romantic and emotionally warm
/// - modern premium mobile UI
/// - soft gradients or dreamy background
/// - elegant rounded cards
/// - clean and uncluttered layout
/// - not childish, not a productivity app
///
/// Layout:
/// - top back button
/// - page title: "Create Love Coupon"
/// - subtitle: "Create a sweet and meaningful coupon for your partner"
///
/// Main content inside a rounded premium card:
///
/// 1. Template Selection Section (PRIMARY FOCUS)
/// - horizontal scrollable list of preset coupon templates
/// - each template should have:
///   - soft background design or image
///   - icon or illustration (e.g. movie, heart, massage)
///   - short label (e.g. "Movie Night", "Massage", "Date Night")
/// - templates should look visually rich and attractive
/// - selected template should be highlighted
///
/// 2. Optional Custom Photo Section (SECONDARY)
/// - below templates, show a smaller section:
///   "Add your own photo (optional)"
/// - allow user to upload an image
/// - show preview if selected
/// - clearly communicate that this is optional
///
/// 3. Coupon Content Inputs
/// - input field: "Coupon Title"
/// - multiline input: "Your Message"
/// - prefill suggestions based on selected template (optional)
///
/// 4. Category Selection
/// - rounded selectable chips
/// - examples:
///   Romance, Relaxation, Adventure, Surprise, Quality Time
///
/// 5. Helper Text
/// - small emotional hint like:
///   "Make it personal and create something your partner will love"
///
/// Bottom Area:
/// - large rounded button: "Create Coupon"
/// - visually prominent but elegant
///
/// Interaction logic:
/// - selecting a template updates the visual preview
/// - uploading a photo overrides or enhances the template visually
/// - user can still create coupon without uploading a photo
///
/// Visual tone:
/// - warm, soft, emotional
/// - premium and polished
/// - feels like creating a romantic gift
///
/// Avoid:
/// - forcing the user to upload an image
/// - cluttered UI
/// - dashboard or form-like appearance
/// - overly technical layout
///
/// Make the experience feel simple, emotional, and beautiful.
class VoiceNotesResultsWidget extends StatefulWidget {
  const VoiceNotesResultsWidget({
    super.key,
    required this.treasureRef,
    required this.relationshipId,
  });

  final DocumentReference? treasureRef;
  final String? relationshipId;

  static String routeName = 'voice_notes_results';
  static String routePath = '/voiceNotesResults';

  @override
  State<VoiceNotesResultsWidget> createState() =>
      _VoiceNotesResultsWidgetState();
}

class _VoiceNotesResultsWidgetState extends State<VoiceNotesResultsWidget> {
  late VoiceNotesResultsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VoiceNotesResultsModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'voice_notes_results'});
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
        backgroundColor: Color(0xFF1A0A1E),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2D0A3E),
                    Color(0xFF1A0A1E),
                    Color(0xFF0D1A2E)
                  ],
                  stops: [0.0, 0.4, 1.0],
                  begin: AlignmentDirectional(0.64, 1.0),
                  end: AlignmentDirectional(-0.64, -1.0),
                ),
              ),
            ),
            Opacity(
              opacity: 0.15,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF69B4), Colors.transparent],
                    stops: [0.0, 0.5],
                    begin: AlignmentDirectional(1.0, 1.0),
                    end: AlignmentDirectional(-1.0, -1.0),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: 110.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF3D1A4E), Colors.transparent],
                      stops: [0.0, 1.0],
                      begin: AlignmentDirectional(0.0, 1.0),
                      end: AlignmentDirectional(0, -1.0),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.safePop();
                                  },
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x33FFFFFF),
                                      borderRadius: BorderRadius.circular(14.0),
                                      border: Border.all(
                                        color: Color(0x44FFFFFF),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        color: Colors.white,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'sefj9w0h' /* Voice Notes */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMediumFamily,
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .headlineMediumIsCustom,
                                              ),
                                        ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          '4z1q0tl6' /* 🎙️ */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 6.0)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '7garehy3' /* Listen to the voice messages y... */,
                            ),
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodySmallFamily,
                                  color: Color(0xCCFFFFFF),
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodySmallIsCustom,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 20.0,
                                    color: Color(0x33FF69B4),
                                    offset: Offset(
                                      0.0,
                                      4.0,
                                    ),
                                  )
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0x44FF69B4),
                                    Color(0x22C084E8)
                                  ],
                                  stops: [0.0, 1.0],
                                  begin: AlignmentDirectional(0.0, -1.0),
                                  end: AlignmentDirectional(0, 1.0),
                                ),
                                borderRadius: BorderRadius.circular(18.0),
                                border: Border.all(
                                  color: Color(0x55FF69B4),
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 36.0,
                                    height: 36.0,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFFF69B4),
                                          Color(0xFFC084E8)
                                        ],
                                        stops: [0.0, 1.0],
                                        begin: AlignmentDirectional(1.0, 1.0),
                                        end: AlignmentDirectional(-1.0, -1.0),
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Icon(
                                        Icons.lock_open_rounded,
                                        color: Colors.white,
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
                                          FFLocalizations.of(context).getText(
                                            'ha7vc06m' /* Saved from your opened treasur... */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color: Colors.white,
                                                fontSize: 13.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'ji433e5t' /* These messages were left just ... */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily,
                                                color: Color(0xCCFFFFFF),
                                                fontSize: 11.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmallIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ].divide(SizedBox(width: 10.0)),
                              ),
                            ),
                          ),
                          AuthUserStreamWidget(
                            builder: (context) =>
                                StreamBuilder<List<TreasureSurprisesRecord>>(
                              stream: queryTreasureSurprisesRecord(
                                queryBuilder: (treasureSurprisesRecord) =>
                                    treasureSurprisesRecord
                                        .where(
                                          'treasureRef',
                                          isEqualTo: widget.treasureRef,
                                        )
                                        .where(
                                          'type',
                                          isEqualTo: 'voice_note',
                                        )
                                        .where(
                                          'createdByUid',
                                          isEqualTo: valueOrDefault(
                                              currentUserDocument?.partnerUID,
                                              ''),
                                        )
                                        .orderBy('createdAt', descending: true),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: EmptyStateVoicenoteWidget(),
                                  );
                                }
                                List<TreasureSurprisesRecord>
                                    listViewTreasureSurprisesRecordList =
                                    snapshot.data!;

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: listViewTreasureSurprisesRecordList
                                      .length,
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewTreasureSurprisesRecord =
                                        listViewTreasureSurprisesRecordList[
                                            listViewIndex];
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 16.0, 16.0, 16.0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 24.0,
                                              color: Color(0x22FF69B4),
                                              offset: Offset(
                                                0.0,
                                                6.0,
                                              ),
                                            )
                                          ],
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0x33FFFFFF),
                                              Color(0x1AFFFFFF)
                                            ],
                                            stops: [0.0, 1.0],
                                            begin:
                                                AlignmentDirectional(0.0, -1.0),
                                            end: AlignmentDirectional(0, 1.0),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(22.0),
                                          border: Border.all(
                                            color: Color(0x33FFFFFF),
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                FlutterFlowAudioPlayer(
                                                  audio: Audio.network(
                                                    listViewTreasureSurprisesRecord
                                                        .audioPath,
                                                    metas: Metas(
                                                      title:
                                                          listViewTreasureSurprisesRecord
                                                              .title,
                                                    ),
                                                  ),
                                                  titleTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeFamily,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeIsCustom,
                                                          ),
                                                  playbackDurationTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumIsCustom,
                                                          ),
                                                  fillColor: Color(0x00000000),
                                                  playbackButtonColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  activeTrackColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  inactiveTrackColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                  elevation: 0.0,
                                                  playInBackground: PlayInBackground
                                                      .disabledRestoreOnForeground,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 2.0, 0.0, 5.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .calendar_today_rounded,
                                                            color: Color(
                                                                0x99FFFFFF),
                                                            size: 12.0,
                                                          ),
                                                          Text(
                                                            dateTimeFormat(
                                                              "yMd",
                                                              listViewTreasureSurprisesRecord
                                                                  .createdAt!,
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
                                                                      0x99FFFFFF),
                                                                  fontSize:
                                                                      11.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmallIsCustom,
                                                                ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 4.0)),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 10.0)),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 6.0)),
                                            ),
                                          ].divide(SizedBox(height: 12.0)),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ]
                            .divide(SizedBox(height: 14.0))
                            .addToStart(SizedBox(height: 16.0))
                            .addToEnd(SizedBox(height: 40.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
