import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_state_coupons/empty_state_coupons_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:firebase_storagelibrary_2sa6k9/flutter_flow/custom_functions.dart'
    as firebase_storagelibrary_2sa6k9_functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'coupon_treasure_model.dart';
export 'coupon_treasure_model.dart';

/// Create a beautiful premium mobile page for a romantic couples app called
/// Togly where users can manage all Love Coupons that exist between them and
/// their partner.
///
/// This page should feel emotionally warm, elegant, modern, soft, and
/// premium. It must match the style of a romantic relationship app, not a
/// productivity app or dashboard. The design should feel intimate, polished,
/// dreamy, and app-store ready.
///
/// Page purpose:
/// This page is a shared Love Coupon management page. It shows all coupons
/// exchanged between the two partners across all treasure boxes. The user
/// should be able to see both:
/// 1. coupons they received from their partner
/// 2. coupons they created for their partner
///
/// Important UX logic:
/// - use a segmented control or tab switcher near the top with two tabs:
///   - "Received"
///   - "Given"
/// - in the "Received" tab, the user sees coupons they have received and can
/// manage them
/// - in the "Given" tab, the user sees coupons they created for their
/// partner, but these should be visually read-only
/// - both tabs should display live coupon statuses clearly
///
/// Design direction:
/// - romantic premium mobile UI
/// - soft and dreamy but clean
/// - warm colors
/// - elegant rounded cards
/// - subtle shadows
/// - modern typography
/// - soft romantic background or gradient that fits a couples app
/// - highly polished visual hierarchy
///
/// Layout:
/// - top area with back button
/// - page title: "Love Coupons"
/// - subtitle: "See the sweet coupons you and your partner have shared"
/// - segmented control / tab selector with "Received" and "Given"
/// - below that, a scrollable list of coupon cards
///
/// Coupon card design:
/// Each coupon should appear as a beautiful rounded card that feels premium
/// and emotionally warm. Cards should include:
/// - coupon title
/// - short description or message
/// - category chip or small label
/// - status badge
/// - optional small metadata such as created date
/// - soft decorative icon or subtle romantic accent
///
/// Status system:
/// Visually support these coupon statuses:
/// - Available
/// - Active
/// - Completed
///
/// Behavior by tab:
/// In the "Received" tab:
/// - show action buttons when appropriate
/// - for available coupons, show a primary button like "Use Now"
/// - for active coupons, show buttons like "Not Now" and "Completed"
/// - for completed coupons, show a finished state with no active actions
///
/// In the "Given" tab:
/// - show the same coupon cards, but read-only
/// - no action buttons
/// - visually communicate that these are coupons you gave to your partner
/// - show their current status live
///
/// Visual tone:
/// The page should feel like a shared romantic space, not a transactional
/// wallet. It should communicate love, connection, and thoughtful gestures.
///
/// Avoid:
/// - dashboard style
/// - business app UI
/// - harsh colors
/// - childish visuals
/// - cluttered card layouts
/// - overly technical labels
///
/// Make the final page feel premium, emotional, modern, and fully consistent
/// with a romantic couples app experience.
class CouponTreasureWidget extends StatefulWidget {
  const CouponTreasureWidget({
    super.key,
    required this.relationshipId,
    required this.treasureRef,
  });

  final String? relationshipId;
  final DocumentReference? treasureRef;

  static String routeName = 'coupon_treasure';
  static String routePath = '/coupon_treasure';

  @override
  State<CouponTreasureWidget> createState() => _CouponTreasureWidgetState();
}

class _CouponTreasureWidgetState extends State<CouponTreasureWidget> {
  late CouponTreasureModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CouponTreasureModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'coupon_treasure'});
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
        backgroundColor: Color(0xFFF8F0F5),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      color: Color(0xFFFCE8F3),
                      borderRadius: BorderRadius.circular(14.0),
                      border: Border.all(
                        color: Color(0xFFFAD4E8),
                        width: 1.0,
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color(0xFFE8547A),
                        size: 20.0,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        '9d154gag' /* 💕 */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        'lbnp56tb' /* Togly */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: Color(0xFFE8547A),
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                  ].divide(SizedBox(width: 6.0)),
                ),
              ],
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: MediaQuery.sizeOf(context).height * 1.0,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, -1.0),
                child: Container(
                  width: double.infinity,
                  height: 320.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFF9E4EE),
                        Color(0xFFFCE8F3),
                        Color(0xFFF8F0F5)
                      ],
                      stops: [0.0, 0.5, 1.0],
                      begin: AlignmentDirectional(0.0, 1.0),
                      end: AlignmentDirectional(0, -1.0),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 300.0,
                      height: 70.0,
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '9e99gwvc' /* Coupons from this Treasure */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .displaySmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .displaySmallFamily,
                                  color: Color(0xFF3D1A2E),
                                  fontSize: 22.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .displaySmallIsCustom,
                                ),
                          ),
                        ].divide(SizedBox(height: 6.0)),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Visibility(
                          visible: _model.walletTab == 'received',
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 24.0, 24.0, 0.0),
                            child: StreamBuilder<List<LoveCouponsRecord>>(
                              stream: queryLoveCouponsRecord(
                                queryBuilder: (loveCouponsRecord) =>
                                    loveCouponsRecord
                                        .where(
                                          'relationship_id',
                                          isEqualTo: widget.relationshipId,
                                        )
                                        .where(
                                          'source_treasure_id',
                                          isEqualTo: widget.treasureRef?.id,
                                        )
                                        .where(
                                          'created_for_user_id',
                                          isEqualTo: currentUserUid,
                                        ),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return EmptyStateCouponsWidget();
                                }
                                List<LoveCouponsRecord>
                                    columnLoveCouponsRecordList =
                                    snapshot.data!;

                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      columnLoveCouponsRecordList.length,
                                      (columnIndex) {
                                    final columnLoveCouponsRecord =
                                        columnLoveCouponsRecordList[
                                            columnIndex];
                                    return Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: () {
                                          if (columnLoveCouponsRecord
                                                  .category ==
                                              'movie_night') {
                                            return Color(0xFFF1ECFF);
                                          } else if (columnLoveCouponsRecord
                                                  .category ==
                                              'massage') {
                                            return Color(0xFFFFF1F5);
                                          } else if (columnLoveCouponsRecord
                                                  .category ==
                                              'date') {
                                            return Color(0xFFFFD6E0);
                                          } else if (columnLoveCouponsRecord
                                                  .category ==
                                              'adventure') {
                                            return Color(0xFFEEF2F8);
                                          } else if (columnLoveCouponsRecord
                                                  .category ==
                                              'surprise') {
                                            return Color(0xFFFFF7E8);
                                          } else {
                                            return Colors.white;
                                          }
                                        }(),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 20.0,
                                            color: Color(0x1AE8547A),
                                            offset: Offset(
                                              0.0,
                                              6.0,
                                            ),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .accent1,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          if ((columnLoveCouponsRecord
                                                          .photoUrl !=
                                                      '') &&
                                              (columnLoveCouponsRecord
                                                      .isTemplate ==
                                                  false))
                                            Container(
                                              width: double.infinity,
                                              height: 100.0,
                                              decoration: BoxDecoration(),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                child: Image.network(
                                                  columnLoveCouponsRecord
                                                                  .photoUrl !=
                                                              ''
                                                      ? firebase_storagelibrary_2sa6k9_functions
                                                          .convertStringToImagePath(
                                                              columnLoveCouponsRecord
                                                                  .photoUrl)!
                                                      : 'xd',
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Container(
                                                          width: 44.0,
                                                          height: 44.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: () {
                                                              if ((columnLoveCouponsRecord
                                                                          .isTemplate ==
                                                                      true) &&
                                                                  (columnLoveCouponsRecord
                                                                          .designKey ==
                                                                      'movie_night')) {
                                                                return Color(
                                                                    0xFFE3D9FF);
                                                              } else if ((columnLoveCouponsRecord
                                                                          .isTemplate ==
                                                                      true) &&
                                                                  (columnLoveCouponsRecord
                                                                          .designKey ==
                                                                      'massage')) {
                                                                return Color(
                                                                    0xFFFFDCE8);
                                                              } else if ((columnLoveCouponsRecord
                                                                          .isTemplate ==
                                                                      true) &&
                                                                  (columnLoveCouponsRecord
                                                                          .designKey ==
                                                                      'adventure')) {
                                                                return Color(
                                                                    0xFFD9F2E1);
                                                              } else if ((columnLoveCouponsRecord
                                                                          .isTemplate ==
                                                                      true) &&
                                                                  (columnLoveCouponsRecord
                                                                          .designKey ==
                                                                      'date_night')) {
                                                                return Color(
                                                                    0xFFFFDCD1);
                                                              } else if ((columnLoveCouponsRecord
                                                                          .isTemplate ==
                                                                      true) &&
                                                                  (columnLoveCouponsRecord
                                                                          .designKey ==
                                                                      'surprise')) {
                                                                return Color(
                                                                    0xFFFFE9B8);
                                                              } else {
                                                                return Colors
                                                                    .white;
                                                              }
                                                            }(),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        14.0),
                                                          ),
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                () {
                                                                  if (columnLoveCouponsRecord
                                                                          .category ==
                                                                      'movie_night') {
                                                                    return '🎬';
                                                                  } else if (columnLoveCouponsRecord
                                                                          .category ==
                                                                      'massage') {
                                                                    return '💆';
                                                                  } else if (columnLoveCouponsRecord
                                                                          .category ==
                                                                      'date') {
                                                                    return '🌹';
                                                                  } else if (columnLoveCouponsRecord
                                                                          .category ==
                                                                      'adventure') {
                                                                    return '🗺️';
                                                                  } else if (columnLoveCouponsRecord
                                                                          .category ==
                                                                      'surprise') {
                                                                    return '🎁';
                                                                  } else if (columnLoveCouponsRecord
                                                                          .category ==
                                                                      'quality_time') {
                                                                    return '👩‍❤️‍👨';
                                                                  } else if (columnLoveCouponsRecord
                                                                          .category ==
                                                                      'breakfast') {
                                                                    return '🍳';
                                                                  } else if (columnLoveCouponsRecord
                                                                          .category ==
                                                                      'romance') {
                                                                    return '🌹';
                                                                  } else {
                                                                    return '🎟️';
                                                                  }
                                                                }(),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      fontSize:
                                                                          22.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyMediumIsCustom,
                                                                    ),
                                                              ),
                                                            ),
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
                                                              columnLoveCouponsRecord
                                                                  .title,
                                                              maxLines: 1,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleMediumFamily,
                                                                    color: Color(
                                                                        0xFF3D1A2E),
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .titleMediumIsCustom,
                                                                  ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          2.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getVariableText(
                                                                  enText: () {
                                                                    if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'movie_night') {
                                                                      return 'Movie night';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'massage') {
                                                                      return 'Massage';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'adventure') {
                                                                      return 'Adventure';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'date') {
                                                                      return 'Date Night';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'surprise') {
                                                                      return 'Surprise';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'quality_time') {
                                                                      return 'Quality Time';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'romance') {
                                                                      return 'Romance';
                                                                    } else {
                                                                      return '';
                                                                    }
                                                                  }(),
                                                                  deText: () {
                                                                    if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'movie_night') {
                                                                      return 'Filmabend';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'massage') {
                                                                      return 'Massage';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'adventure') {
                                                                      return 'Abenteuer';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'date') {
                                                                      return 'Date Night';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'surprise') {
                                                                      return 'Überraschung';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'quality_time') {
                                                                      return 'Gemeinsame Zeit';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'romance') {
                                                                      return 'Romantik';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'breakfast') {
                                                                      return 'Frühstück';
                                                                    } else {
                                                                      return '';
                                                                    }
                                                                  }(),
                                                                  esText: () {
                                                                    if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'movie_night') {
                                                                      return 'Noche de cine';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'massage') {
                                                                      return 'Masaje';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'adventure') {
                                                                      return 'Aventura';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'date') {
                                                                      return 'Cita romántica';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'surprise') {
                                                                      return 'Sorpresa';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'quality_time') {
                                                                      return 'Tiempo de calidad';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'romance') {
                                                                      return 'Romance';
                                                                    } else if (columnLoveCouponsRecord
                                                                            .category ==
                                                                        'breakfast') {
                                                                      return 'Desayuno';
                                                                    } else {
                                                                      return '';
                                                                    }
                                                                  }(),
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodySmallFamily,
                                                                      color:
                                                                          () {
                                                                        if (columnLoveCouponsRecord.category ==
                                                                            'movie_night') {
                                                                          return Color(
                                                                              0xFF8F73D9);
                                                                        } else if (columnLoveCouponsRecord.category ==
                                                                            'massage') {
                                                                          return Color(
                                                                              0xFFD46A93);
                                                                        } else if (columnLoveCouponsRecord.category ==
                                                                            'date') {
                                                                          return Color(
                                                                              0xFFD8755F);
                                                                        } else if (columnLoveCouponsRecord.category ==
                                                                            'adventure') {
                                                                          return Color(
                                                                              0xFF4D9A68);
                                                                        } else if (columnLoveCouponsRecord.category ==
                                                                            'surprise') {
                                                                          return Color(
                                                                              0xFFC99020);
                                                                        } else {
                                                                          return Color(
                                                                              0xFFE85A8A);
                                                                        }
                                                                      }(),
                                                                      fontSize:
                                                                          11.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodySmallIsCustom,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 10.0)),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 12.0, 0.0, 0.0),
                                                  child: Text(
                                                    columnLoveCouponsRecord
                                                        .description,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          color:
                                                              Color(0xFF7A5068),
                                                          fontSize: 13.0,
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
                                                ),
                                                Divider(
                                                  height: 1.0,
                                                  thickness: 1.0,
                                                  indent: 0.0,
                                                  endIndent: 0.0,
                                                  color: Color(0xFFF5E6EF),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 12.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'n62fc0fc' /* Created at */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMediumIsCustom,
                                                                ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 8.0)),
                                                      ),
                                                      Text(
                                                        dateTimeFormat(
                                                          "yMd",
                                                          columnLoveCouponsRecord
                                                              .createdAt!,
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
                                                                  0xFFCC7AA0),
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
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 5.0, 10.0, 5.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: () {
                                                    if (columnLoveCouponsRecord
                                                            .status ==
                                                        'active') {
                                                      return Color(0xFFE8F8EE);
                                                    } else if (columnLoveCouponsRecord
                                                            .status ==
                                                        'redeemed') {
                                                      return Color(0xFFF8F5E8);
                                                    } else {
                                                      return Color(0x00000000);
                                                    }
                                                  }(),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    () {
                                                      if (columnLoveCouponsRecord
                                                              .status ==
                                                          'active') {
                                                        return FFLocalizations
                                                                .of(context)
                                                            .getVariableText(
                                                          enText:
                                                              'Ready to redeem 💚',
                                                          deText:
                                                              'Bereit zum Einlösen 💚',
                                                          esText:
                                                              'Listo para canjear 💚',
                                                        );
                                                      } else if (columnLoveCouponsRecord
                                                              .status ==
                                                          'redeemed') {
                                                        return FFLocalizations
                                                                .of(context)
                                                            .getVariableText(
                                                          enText: 'Redeemed 🎉',
                                                          deText:
                                                              'Eingelöst 🎉',
                                                          esText: 'Canjeado 🎉',
                                                        );
                                                      } else {
                                                        return '';
                                                      }
                                                    }(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmall
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmallFamily,
                                                          color:
                                                              Color(0xFF25876A),
                                                          fontSize: 11.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmallIsCustom,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).divide(SizedBox(height: 16.0)),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
                      .addToStart(SizedBox(height: 0.0))
                      .addToEnd(SizedBox(height: 40.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
