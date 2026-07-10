import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_note_sticky/empty_note_sticky_widget.dart';
import '/components/post_it_sheet/post_it_sheet_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math' as math;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'sticy_wall_create_model.dart';
export 'sticy_wall_create_model.dart';

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
class SticyWallCreateWidget extends StatefulWidget {
  const SticyWallCreateWidget({
    super.key,
    required this.relationshipId,
    required this.relationshipRef,
    required this.treasureId,
    required this.treasureRef,
  });

  final String? relationshipId;
  final DocumentReference? relationshipRef;
  final String? treasureId;
  final DocumentReference? treasureRef;

  static String routeName = 'sticy_wall_create';
  static String routePath = '/sticyWallCreate';

  @override
  State<SticyWallCreateWidget> createState() => _SticyWallCreateWidgetState();
}

class _SticyWallCreateWidgetState extends State<SticyWallCreateWidget> {
  late SticyWallCreateModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SticyWallCreateModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'sticy_wall_create'});
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
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
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFCE4EF),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Color(0xFFD4607A),
                      size: 20.0,
                    ),
                  ),
                ),
              ),
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
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFFF0F5),
                      Color(0xFFFFF8F0),
                      Color(0xFFFFF0F8)
                    ],
                    stops: [0.0, 0.5, 1.0],
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
                                  0.0, 8.0, 0.0, 20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'psoqdk4w' /* Your Love Wall */,
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
                                                  'mb60z21m' /* All the little reasons why you... */,
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
                                      StreamBuilder<
                                          List<TreasureSurprisesRecord>>(
                                        stream: queryTreasureSurprisesRecord(
                                          queryBuilder:
                                              (treasureSurprisesRecord) =>
                                                  treasureSurprisesRecord
                                                      .where(
                                                        'treasureRef',
                                                        isEqualTo:
                                                            widget.treasureRef,
                                                      )
                                                      .where(
                                                        'type',
                                                        isEqualTo: 'reason',
                                                      ),
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 40.0,
                                                height: 40.0,
                                                child: SpinKitPumpingHeart(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 40.0,
                                                ),
                                              ),
                                            );
                                          }
                                          List<TreasureSurprisesRecord>
                                              containerTreasureSurprisesRecordList =
                                              snapshot.data!;

                                          return Container(
                                            height: 28.0,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFCE4EF),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 6.0, 12.0, 6.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.favorite_rounded,
                                                    color: Color(0xFFD4607A),
                                                    size: 14.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(4.0, 0.0,
                                                                4.0, 0.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        containerTreasureSurprisesRecordList
                                                            .length
                                                            .toString(),
                                                        'reasons',
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
                                                                0xFFD4607A),
                                                            fontSize: 12.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmallIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '2a7p3bzu' /* Reasons */,
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
                                                              Color(0xFFD4607A),
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ].divide(SizedBox(height: 4.0)),
                              ),
                            ),
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
                                          isEqualTo: currentUserUid,
                                        )
                                        .orderBy('createdAt'),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return EmptyNoteStickyWidget();
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
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
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
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        var confirmDialogResponse =
                                                            await showDialog<
                                                                    bool>(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (alertDialogContext) {
                                                                    return AlertDialog(
                                                                      title: Text(
                                                                          'Delete this reason?'),
                                                                      content: Text(
                                                                          'This note will be removed from your Love Wall.'),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed: () => Navigator.pop(
                                                                              alertDialogContext,
                                                                              false),
                                                                          child:
                                                                              Text('Cancel'),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed: () => Navigator.pop(
                                                                              alertDialogContext,
                                                                              true),
                                                                          child:
                                                                              Text('Confirm'),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                ) ??
                                                                false;
                                                        if (confirmDialogResponse) {
                                                          await staggeredViewTreasureSurprisesRecord
                                                              .reference
                                                              .delete();
                                                          safeSetState(() {});
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                'Reason removed',
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .more_horiz_rounded,
                                                        color:
                                                            Color(0xFFB7A3B3),
                                                        size: 16.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ].divide(SizedBox(height: 10.0)),
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
                              .divide(SizedBox(height: 0.0))
                              .addToStart(SizedBox(height: 8.0))
                              .addToEnd(SizedBox(height: 120.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Container(
                  width: double.infinity,
                  height: 130.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0x00FFF5F0),
                        Color(0xFFFFF5F0),
                        Color(0xFFFFF5F0)
                      ],
                      stops: [0.0, 0.45, 1.0],
                      begin: AlignmentDirectional(0.0, -1.0),
                      end: AlignmentDirectional(0, 1.0),
                    ),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20.0,
                                  color: Color(0x40D4607A),
                                  offset: Offset(
                                    0.0,
                                    8.0,
                                  ),
                                )
                              ],
                              gradient: LinearGradient(
                                colors: [Color(0xFFD4607A), Color(0xFFE8829A)],
                                stops: [0.0, 1.0],
                                begin: AlignmentDirectional(0.0, -1.0),
                                end: AlignmentDirectional(0, 1.0),
                              ),
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                            child: FFButtonWidget(
                              onPressed: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      child: Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: PostItSheetWidget(
                                          relationshipId:
                                              widget.relationshipId!,
                                          relationshipRef:
                                              widget.relationshipRef!,
                                          treasureId: widget.treasureId!,
                                          treasureRef: widget.treasureRef!,
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              text: FFLocalizations.of(context).getText(
                                'bqcrj9z6' /* Add a Reason */,
                              ),
                              icon: Icon(
                                Icons.favorite_rounded,
                                size: 20.0,
                              ),
                              options: FFButtonOptions(
                                height: 56.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    32.0, 0.0, 32.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconColor: Colors.white,
                                color: Colors.transparent,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleMediumFamily,
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .titleMediumIsCustom,
                                    ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 0.0,
                                ),
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                          ),
                        ],
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
