import '/backend/backend.dart';
import '/components/empty_treasure_archive/empty_treasure_archive_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'treasures_archive_model.dart';
export 'treasures_archive_model.dart';

/// Create a romantic mobile page design for a couples app called Togly.
///
/// The page is called Treasure Memory and is opened when a user selects a
/// past Love Treasure from their archive.
///
/// This page should feel like opening a saved emotional moment, not just
/// viewing data. The design must be dreamy, warm, nostalgic, and premium. Use
/// soft pink, purple, and sunset gradient tones with subtle glow, rounded
/// shapes, elegant shadows, and a gentle magical atmosphere.
///
/// Top section:
/// - Back button on the left
/// - Centered title: “Treasure Memory”
/// - Optional small decorative icon like a heart or sparkle
/// - Below the title, display the treasure name (for example: “Valentine’s
/// Surprise ❤️”)
/// - Show a small date text like “Opened on February 14”
/// - Add a short emotional subtitle like “A moment you shared together”
///
/// Header area:
/// - Add a soft, rounded hero card with a treasure chest illustration or
/// symbolic visual
/// - Use a translucent glass-style container with soft blur
/// - Inside the card, include a short emotional line like “Every memory
/// inside this treasure still belongs to you”
///
/// Main content:
/// Create a vertical layout of content sections. Each section represents a
/// type of surprise inside the treasure.
///
/// Each section should be designed as a rounded card with soft glow and
/// elegant spacing.
///
/// Sections to include:
///
/// 1. Voice Notes section:
/// - Small icon (microphone or heart)
/// - Title: “Voice Notes”
/// - Short description like “Listen to the messages your partner left for
/// you”
/// - Show a small count (for example: “3 voice notes”)
/// - Optional preview of one item
/// - Subtle arrow or indicator that it is tappable
///
/// 2. Photos section:
/// - Small icon (camera or photo)
/// - Title: “Photos”
/// - Show 2–4 small preview thumbnails in a row
/// - Short description like “Captured moments just for you”
/// - Show count (for example: “5 photos”)
///
/// 3. Love Coupons section:
/// - Gift icon
/// - Title: “Love Coupons”
/// - Short description like “Special surprises you can use anytime”
/// - Show count
///
/// 4. Reason I Love You section:
/// - Sparkle or heart icon
/// - Title: “Reasons I Love You”
/// - Short description like “Words that made this treasure special”
/// - Show count
///
/// Design requirements for sections:
/// - Rounded corners
/// - Soft border or glow
/// - Slight elevation
/// - Clear spacing between sections
/// - Minimal but emotional text
/// - Cards should clearly feel tappable
///
/// Bottom section:
/// - Add a soft “Share this memory” button
/// - Keep it consistent with the app’s romantic button style
///
/// Empty handling:
/// - If a section has no items, it should still appear but look softer or
/// slightly faded
///
/// Visual style:
/// - No harsh colors
/// - Clean layout, not crowded
/// - Strong emotional tone
/// - Feels like a memory book or scrapbook
/// - Consistent with Love Treasure, Voice Notes, and Photos pages
///
/// Important:
/// Focus only on visual design and layout.
/// Do not include backend logic.
/// The page should feel like revisiting a meaningful shared memory, not
/// browsing content.
class TreasuresArchiveWidget extends StatefulWidget {
  const TreasuresArchiveWidget({
    super.key,
    required this.relationshipId,
  });

  final String? relationshipId;

  static String routeName = 'treasures_archive';
  static String routePath = '/treasuresArchive';

  @override
  State<TreasuresArchiveWidget> createState() => _TreasuresArchiveWidgetState();
}

class _TreasuresArchiveWidgetState extends State<TreasuresArchiveWidget> {
  late TreasuresArchiveModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TreasuresArchiveModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'treasures_archive'});
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
        backgroundColor: Color(0xFFF5F0FF),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: Container(
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.safePop();
                },
                child: Container(
                  width: 38.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).accent2,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12.0,
                        color: Color(0x18C084B0),
                        offset: Offset(
                          0.0,
                          3.0,
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Color(0xFF9E7AAE),
                      size: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          title: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                FFLocalizations.of(context).getText(
                  'ga6lipn2' /* Treasure Archive */,
                ),
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).headlineMediumFamily,
                      color: Color(0xFF5D3A6A),
                      fontSize: 20.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).headlineMediumIsCustom,
                    ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: Container(),
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFF0F8),
                    Color(0xFFF5F0FF),
                    Color(0xFFEEE8FF),
                    Color(0xFFFCE4EC)
                  ],
                  stops: [0.0, 0.4, 0.7, 1.0],
                  begin: AlignmentDirectional(0.64, 1.0),
                  end: AlignmentDirectional(-0.64, -1.0),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: 120.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFCE4EC), Color(0x00FFF0F8)],
                      stops: [0.0, 1.0],
                      begin: AlignmentDirectional(0.0, 1.0),
                      end: AlignmentDirectional(0, -1.0),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              32.0, 0.0, 32.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'eu2yjmyh' /* Revisit the treasures you open... */,
                            ),
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: Color(0xFFB39DBC),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              32.0, 0.0, 32.0, 0.0),
                          child: Container(
                            width: double.infinity,
                            height: 1.0,
                            decoration: BoxDecoration(
                              color: Color(0x1FD4A0C8),
                            ),
                          ),
                        ),
                        StreamBuilder<List<LoveTreasuresRecord>>(
                          stream: queryLoveTreasuresRecord(
                            queryBuilder: (loveTreasuresRecord) =>
                                loveTreasuresRecord
                                    .where(
                                      'relationship_id',
                                      isEqualTo: widget.relationshipId,
                                    )
                                    .where(
                                      'status',
                                      isEqualTo: 'opened',
                                    )
                                    .orderBy('openedAt', descending: true),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: EmptyTreasureArchiveWidget(),
                              );
                            }
                            List<LoveTreasuresRecord>
                                listViewLoveTreasuresRecordList =
                                snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: listViewLoveTreasuresRecordList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewLoveTreasuresRecord =
                                    listViewLoveTreasuresRecordList[
                                        listViewIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      32.0, 0.0, 32.0, 15.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        TreasureMemorysWidget.routeName,
                                        queryParameters: {
                                          'treasureRef': serializeParam(
                                            listViewLoveTreasuresRecord
                                                .reference,
                                            ParamType.DocumentReference,
                                          ),
                                          'relationshipId': serializeParam(
                                            widget.relationshipId,
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          '__transition_info__': TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                          ),
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 120.0,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 20.0,
                                            color: Color(0x18C084B0),
                                            offset: Offset(
                                              0.0,
                                              6.0,
                                            ),
                                          )
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.white,
                                            Color(0xFFF9F0FF)
                                          ],
                                          stops: [0.0, 1.0],
                                          begin:
                                              AlignmentDirectional(0.0, -1.0),
                                          end: AlignmentDirectional(0, 1.0),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(18.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 48.0,
                                              height: 48.0,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFFFCE4EC),
                                                    Color(0xFFE8D5F5)
                                                  ],
                                                  stops: [0.0, 1.0],
                                                  begin: AlignmentDirectional(
                                                      1.0, 1.0),
                                                  end: AlignmentDirectional(
                                                      -1.0, -1.0),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(14.0),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '865j4srr' /* 💎 */,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            fontSize: 23.0,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        14.0, 0.0, 14.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'znrdad42' /* Opened Treasure ✨ */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .titleMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMediumFamily,
                                                            color: Color(
                                                                0xFF5D3A6A),
                                                            fontSize: 15.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMediumIsCustom,
                                                          ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  3.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        dateTimeFormat(
                                                          "yMd",
                                                          listViewLoveTreasuresRecord
                                                              .openedAt!,
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodySmall
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallFamily,
                                                              color: Color(
                                                                  0xFFB39DBC),
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallIsCustom,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  5.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '0jtqemkx' /* Tap to revisit your memories �... */,
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodySmall
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallFamily,
                                                              color: Color(
                                                                  0xFFC4A8D4),
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallIsCustom,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Icon(
                                              Icons.chevron_right_rounded,
                                              color: Color(0xFFD4A8C8),
                                              size: 16.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ]
                          .divide(SizedBox(height: 16.0))
                          .addToStart(SizedBox(height: 8.0))
                          .addToEnd(SizedBox(height: 48.0)),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional(0.0, -1.0),
              child: Container(
                width: double.infinity,
                height: 120.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: Image.asset(
                      'assets/images/lt_background_1_v2.webp',
                    ).image,
                  ),
                  gradient: LinearGradient(
                    colors: [Color(0xFFFCE4EC), Color(0x00FFF0F8)],
                    stops: [0.0, 1.0],
                    begin: AlignmentDirectional(0.0, -1.0),
                    end: AlignmentDirectional(0, 1.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
