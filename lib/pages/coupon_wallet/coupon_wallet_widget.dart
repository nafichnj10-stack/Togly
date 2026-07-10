import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/components/empty_state_coupons/empty_state_coupons_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:firebase_storagelibrary_2sa6k9/flutter_flow/custom_functions.dart'
    as firebase_storagelibrary_2sa6k9_functions;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'coupon_wallet_model.dart';
export 'coupon_wallet_model.dart';

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
class CouponWalletWidget extends StatefulWidget {
  const CouponWalletWidget({
    super.key,
    required this.relationshipRef,
  });

  final DocumentReference? relationshipRef;

  static String routeName = 'coupon_wallet';
  static String routePath = '/couponWallet';

  @override
  State<CouponWalletWidget> createState() => _CouponWalletWidgetState();
}

class _CouponWalletWidgetState extends State<CouponWalletWidget> {
  late CouponWalletModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CouponWalletModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'coupon_wallet'});
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
                        '9xfp9jph' /* 💕 */,
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
                        '1xsbksik' /* Togly */,
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
                              '3lhx70oj' /* Love Coupons */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .displaySmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .displaySmallFamily,
                                  color: Color(0xFF3D1A2E),
                                  fontSize: 28.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .displaySmallIsCustom,
                                ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              '7narxddu' /* Sweet gestures you and your pa... */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: Color(0xFF9B6B85),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                  lineHeight: 1.4,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                          ),
                        ].divide(SizedBox(height: 6.0)),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFFCE8F3),
                          borderRadius: BorderRadius.circular(50.0),
                          border: Border.all(
                            color: Color(0xFFFAD4E8),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        _model.walletTab = 'received';
                                        safeSetState(() {});
                                      },
                                      child: Container(
                                        height: 44.0,
                                        decoration: BoxDecoration(
                                          color: _model.walletTab == 'received'
                                              ? Color(0xFFE8547A)
                                              : Color(0x00000000),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 12.0,
                                              color: Color(0x33E8547A),
                                              offset: Offset(
                                                0.0,
                                                4.0,
                                              ),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '4lq0q5eu' /* 💌  Received */,
                                              ),
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: Colors.white,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        _model.walletTab = 'given';
                                        safeSetState(() {});
                                      },
                                      child: Container(
                                        height: 44.0,
                                        decoration: BoxDecoration(
                                          color: _model.walletTab == 'given'
                                              ? Color(0xFFE8547A)
                                              : Color(0x00000000),
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              'hostvw94' /* 🎁  Given */,
                                            ),
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 0.0)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  context.pushNamed(
                                    CouponArchiveWidget.routeName,
                                    queryParameters: {
                                      'relationshipRef': serializeParam(
                                        widget.relationshipRef,
                                        ParamType.DocumentReference,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      '__transition_info__': TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                      ),
                                    },
                                  );
                                },
                                text: FFLocalizations.of(context).getText(
                                  'g1sdcncn' /* Coupon Archive */,
                                ),
                                options: FFButtonOptions(
                                  height: 40.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: Color(0xFFC0507A),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleSmallIsCustom,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0.0,
                                  ),
                                  borderRadius: BorderRadius.circular(28.0),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                parent: widget.relationshipRef,
                                queryBuilder: (loveCouponsRecord) =>
                                    loveCouponsRecord
                                        .where(
                                          'created_for_user_id',
                                          isEqualTo: currentUserUid,
                                        )
                                        .where(
                                          'is_visible_in_wallet',
                                          isEqualTo: true,
                                        )
                                        .where(
                                          'status',
                                          isEqualTo: 'active',
                                        )
                                        .orderBy('created_at',
                                            descending: true),
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
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          if ((columnLoveCouponsRecord
                                                                      .status ==
                                                                  'active') &&
                                                              (_model.walletTab ==
                                                                  'received'))
                                                            FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                var confirmDialogResponse =
                                                                    await showDialog<
                                                                            bool>(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (alertDialogContext) {
                                                                            return AlertDialog(
                                                                              title: Text(FFLocalizations.of(context).getVariableText(
                                                                                enText: 'Redeem Coupon',
                                                                                deText: 'Gutschein einlösen',
                                                                                esText: 'Canjear cupón',
                                                                              )),
                                                                              content: Text(FFLocalizations.of(context).getVariableText(
                                                                                enText: 'Use this coupon now?',
                                                                                deText: 'Diesen Gutschein jetzt einlösen?',
                                                                                esText: '¿Canjear este cupón ahora?',
                                                                              )),
                                                                              actions: [
                                                                                TextButton(
                                                                                  onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                  child: Text(FFLocalizations.of(context).getVariableText(
                                                                                    enText: 'Cancel',
                                                                                    deText: 'Abbrechen',
                                                                                    esText: 'Cancelar',
                                                                                  )),
                                                                                ),
                                                                                TextButton(
                                                                                  onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                  child: Text(FFLocalizations.of(context).getVariableText(
                                                                                    enText: 'Redeem Now!',
                                                                                    deText: 'Jetzt einlösen!',
                                                                                    esText: 'Canjear ahora!',
                                                                                  )),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        ) ??
                                                                        false;
                                                                try {
                                                                  final result = await FirebaseFunctions.instanceFor(
                                                                          region:
                                                                              'europe-west3')
                                                                      .httpsCallable(
                                                                          'redeemLoveCoupon')
                                                                      .call({
                                                                    "relationshipId":
                                                                        widget
                                                                            .relationshipRef
                                                                            ?.id,
                                                                    "couponId":
                                                                        columnLoveCouponsRecord
                                                                            .reference
                                                                            .id,
                                                                  });
                                                                  _model.lovecoup =
                                                                      RedeemLoveCouponCloudFunctionCallResponse(
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
                                                                  _model.lovecoup =
                                                                      RedeemLoveCouponCloudFunctionCallResponse(
                                                                    errorCode:
                                                                        error
                                                                            .code,
                                                                    succeeded:
                                                                        false,
                                                                  );
                                                                }

                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getVariableText(
                                                                        enText:
                                                                            'Coupon redeemed 💝 Your partner was notified',
                                                                        deText:
                                                                            'Gutschein eingelöst 💝 Partner wurde benachrichtigt',
                                                                        esText:
                                                                            'Cupón canjeado 💝 Tu pareja ha sido notificada',
                                                                      ),
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

                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              text: FFLocalizations
                                                                      .of(context)
                                                                  .getText(
                                                                '5szdzj8q' /* Use Now */,
                                                              ),
                                                              options:
                                                                  FFButtonOptions(
                                                                height: 36.0,
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        18.0,
                                                                        0.0,
                                                                        18.0,
                                                                        0.0),
                                                                iconPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                color: Color(
                                                                    0xFFE8547A),
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleSmallFamily,
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          13.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .titleSmallIsCustom,
                                                                    ),
                                                                elevation: 0.0,
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .transparent,
                                                                  width: 0.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0),
                                                              ),
                                                            ),
                                                        ].divide(SizedBox(
                                                            width: 8.0)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
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
                                                    BorderRadius.circular(20.0),
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
                                                      return FFLocalizations.of(
                                                              context)
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
                                                      return FFLocalizations.of(
                                                              context)
                                                          .getVariableText(
                                                        enText: 'Redeemed 🎉',
                                                        deText: 'Eingelöst 🎉',
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
                    if (_model.walletTab == 'given')
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 24.0, 24.0, 20.0),
                        child: StreamBuilder<List<LoveCouponsRecord>>(
                          stream: queryLoveCouponsRecord(
                            parent: widget.relationshipRef,
                            queryBuilder: (loveCouponsRecord) =>
                                loveCouponsRecord
                                    .where(
                                      'created_by_user_id',
                                      isEqualTo: currentUserUid,
                                    )
                                    .where(
                                      'is_visible_in_wallet',
                                      isEqualTo: true,
                                    )
                                    .where(
                                      'status',
                                      isEqualTo: 'active',
                                    )
                                    .orderBy('created_at', descending: true),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return EmptyStateCouponsWidget();
                            }
                            List<LoveCouponsRecord>
                                columnLoveCouponsRecordList = snapshot.data!;

                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  columnLoveCouponsRecordList.length,
                                  (columnIndex) {
                                final columnLoveCouponsRecord =
                                    columnLoveCouponsRecordList[columnIndex];
                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: () {
                                      if (columnLoveCouponsRecord.category ==
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
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if ((columnLoveCouponsRecord
                                                      .photoUrl !=
                                                  '') &&
                                          (columnLoveCouponsRecord.isTemplate ==
                                              false))
                                        Container(
                                          width: double.infinity,
                                          height: 100.0,
                                          decoration: BoxDecoration(),
                                          child: Visibility(
                                            visible: columnLoveCouponsRecord
                                                        .photoUrl !=
                                                    '',
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
                                                    : '',
                                                width: double.infinity,
                                                height: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
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
                                              mainAxisSize: MainAxisSize.max,
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
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFFCE8F3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14.0),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
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
                                                                  'romance') {
                                                                return '🌹';
                                                              } else if (columnLoveCouponsRecord
                                                                      .category ==
                                                                  'quality_time') {
                                                                return '💑';
                                                              } else if (columnLoveCouponsRecord
                                                                      .category ==
                                                                  'breakfast') {
                                                                return '🍳';
                                                              } else {
                                                                return '🎟️';
                                                              }
                                                            }(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  fontSize:
                                                                      22.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
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
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMediumFamily,
                                                                color: Color(
                                                                    0xFF3D1A2E),
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                                                } else if (columnLoveCouponsRecord
                                                                        .category ==
                                                                    'breakfast') {
                                                                  return 'Breakfast';
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
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodySmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallFamily,
                                                                  color: Color(
                                                                      0xFFCC7AA0),
                                                                  fontSize:
                                                                      11.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmallIsCustom,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 10.0)),
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
                                                      color: Color(0xFF7A5068),
                                                      fontSize: 13.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      lineHeight: 1.5,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
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
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
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
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmall
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmallFamily,
                                                          color:
                                                              Color(0xFFCC7AA0),
                                                          fontSize: 11.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmallIsCustom,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
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
                                                BorderRadius.circular(20.0),
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              () {
                                                if (columnLoveCouponsRecord
                                                        .status ==
                                                    'active') {
                                                  return FFLocalizations.of(
                                                          context)
                                                      .getVariableText(
                                                    enText: 'Waiting ⏳',
                                                    deText: 'Wartend ⏳',
                                                    esText: 'En espera ⏳',
                                                  );
                                                } else if (columnLoveCouponsRecord
                                                        .status ==
                                                    'redeemed') {
                                                  return FFLocalizations.of(
                                                          context)
                                                      .getVariableText(
                                                    enText: 'Redeemed 🎉',
                                                    deText: 'Eingelöst 🎉',
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
                                                    color: Color(0xFF2E7D4F),
                                                    fontSize: 11.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallIsCustom,
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
