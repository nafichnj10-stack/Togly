import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_note_sticky_view/empty_note_sticky_view_widget.dart';
import '/components/sticky_note_comp/sticky_note_comp_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:math' as math;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'sticky_wall_view_model.dart';
export 'sticky_wall_view_model.dart';

/// Design a romantic mobile page for a couples app where the user sees a
/// "Love Wall" made of sticky notes representing reasons why they love their
/// partner.
///
/// The wall should feel organic and imperfect, not structured like a grid.
/// The layout should simulate real sticky notes placed randomly on a wall.
///
/// Sticky note layout:
/// - use a loose grid as a base but break alignment intentionally
/// - each sticky note should have:
///   - slight random rotation (2–6 degrees)
///   - slight position offset (up/down/left/right)
/// - spacing should vary slightly between notes
/// - notes should not line up perfectly in rows or columns
///
/// Visual feeling:
/// - like a real wall covered in love notes
/// - emotional, personal, warm
/// - visually interesting and not repetitive
///
/// Sticky design:
/// - soft pastel tones (pink, cream, light yellow, blush)
/// - paper-like cards with soft shadows
/// - rounded edges
/// - subtle depth
///
/// Page structure:
/// - title: "Your Love Wall"
/// - subtitle explaining the purpose
/// - large scrollable wall area
/// - floating button: "Add Reason"
///
/// Make sure the wall feels alive and natural, not mechanical or grid-based.
class StickyWallViewWidget extends StatefulWidget {
  const StickyWallViewWidget({
    super.key,
    required this.relationshipId,
    this.relationshipRef,
    this.treasureId,
    required this.treasureRef,
  });

  final String? relationshipId;
  final DocumentReference? relationshipRef;
  final String? treasureId;
  final DocumentReference? treasureRef;

  static String routeName = 'sticky_wall_view';
  static String routePath = '/sticky_wall_view';

  @override
  State<StickyWallViewWidget> createState() => _StickyWallViewWidgetState();
}

class _StickyWallViewWidgetState extends State<StickyWallViewWidget> {
  late StickyWallViewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StickyWallViewModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'sticky_wall_view'});
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
        backgroundColor: Color(0xFFF5F0F5),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFECD2), Color(0xFFFCB69F)],
                  stops: [0.0, 1.0],
                  begin: AlignmentDirectional(1.0, 1.0),
                  end: AlignmentDirectional(-1.0, -1.0),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
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
                                          color: Color(0xFFFCE4EF),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Icon(
                                            Icons.arrow_back_ios_rounded,
                                            color: Color(0xFFD4607A),
                                            size: 20.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'icfj0ygl' /* Love Wall */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .headlineMedium
                                                  .override(
                                                    fontFamily: FlutterFlowTheme
                                                            .of(context)
                                                        .headlineMediumFamily,
                                                    color: Color(0xFF6B3D5E),
                                                    fontSize: 26.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .headlineMediumIsCustom,
                                                  ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 4.0, 0.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'dm4vn71l' /* All the little reasons why you... */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color: Color(0xFF9E7A8C),
                                                      fontSize: 13.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.normal,
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
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 0.0, 8.0, 0.0),
                                      child: Container(
                                        decoration: BoxDecoration(),
                                      ),
                                    ),
                                  ],
                                ),
                              ].divide(SizedBox(height: 4.0)),
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
                                          isEqualTo: 'reason',
                                        )
                                        .where(
                                          'createdByUid',
                                          isEqualTo: valueOrDefault(
                                              currentUserDocument?.partnerUID,
                                              ''),
                                        )
                                        .orderBy('createdAt'),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: EmptyNoteStickyViewWidget(),
                                  );
                                }
                                List<TreasureSurprisesRecord>
                                    staggeredViewTreasureSurprisesRecordList =
                                    snapshot.data!;

                                return MasonryGridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                                  crossAxisSpacing: 12.0,
                                  mainAxisSpacing: 14.0,
                                  itemCount:
                                      staggeredViewTreasureSurprisesRecordList
                                          .length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, staggeredViewIndex) {
                                    final staggeredViewTreasureSurprisesRecord =
                                        staggeredViewTreasureSurprisesRecordList[
                                            staggeredViewIndex];
                                    return Transform.rotate(
                                      angle: 1.5 * (math.pi / 180),
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
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
                                                    child: StickyNoteCompWidget(
                                                      noteText:
                                                          staggeredViewTreasureSurprisesRecord
                                                              .text,
                                                      noteIcon:
                                                          staggeredViewTreasureSurprisesRecord
                                                              .noteIcon,
                                                      noteStyle:
                                                          staggeredViewTreasureSurprisesRecord
                                                              .noteStyle,
                                                      reasonRef:
                                                          staggeredViewTreasureSurprisesRecord
                                                              .reference,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then(
                                                (value) => safeSetState(() {}));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: () {
                                                if (staggeredViewTreasureSurprisesRecord
                                                        .noteStyle ==
                                                    1) {
                                                  return Color(0xFFF8E8EE);
                                                } else if (staggeredViewTreasureSurprisesRecord
                                                        .noteStyle ==
                                                    2) {
                                                  return Color(0xFFF6F1DC);
                                                } else if (staggeredViewTreasureSurprisesRecord
                                                        .noteStyle ==
                                                    3) {
                                                  return Color(0xFFDCE6F5);
                                                } else if (staggeredViewTreasureSurprisesRecord
                                                        .noteStyle ==
                                                    4) {
                                                  return Color(0xFFE2F1E8);
                                                } else if (staggeredViewTreasureSurprisesRecord
                                                        .noteStyle ==
                                                    5) {
                                                  return Color(0xFFEADFF2);
                                                } else {
                                                  return Color(0xFFA5571B);
                                                }
                                              }(),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 18.0,
                                                  color: Color(0x1F6090D4),
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
                                              padding: EdgeInsets.all(16.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    staggeredViewTreasureSurprisesRecord
                                                        .noteIcon,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                  ),
                                                  Text(
                                                    staggeredViewTreasureSurprisesRecord
                                                        .text,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          color:
                                                              Color(0xFF5C4966),
                                                          fontSize: 13.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          lineHeight: 1.5,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 10.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ]
                            .divide(SizedBox(height: 0.0))
                            .addToStart(SizedBox(height: 8.0))
                            .addToEnd(SizedBox(height: 120.0)),
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
