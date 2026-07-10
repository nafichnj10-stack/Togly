import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:firebase_storagelibrary_2sa6k9/custom_code/actions/index.dart'
    as firebase_storagelibrary_2sa6k9_actions;
import 'package:firebase_storagelibrary_2sa6k9/flutter_flow/custom_functions.dart'
    as firebase_storagelibrary_2sa6k9_functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'coupon_page_model.dart';
export 'coupon_page_model.dart';

/// Create a premium romantic mobile page for a couples app called Togly where
/// users can create and manage their personal "Reasons I Love You" wall.
///
/// This page is the editable version of the Love Wall. It should feel warm,
/// emotional, and beautiful, but also structured and easy to use. The design
/// must balance romance and usability.
///
/// Important distinction:
/// This is NOT the chaotic reveal wall. This is the user's personal creation
/// and management space. Sticky notes should feel organic but still be easy
/// to read, tap, and manage.
///
/// Layout:
/// - top back button
/// - page title: "Your Love Wall"
/// - subtitle: "All the little reasons why you love your partner"
/// - optional small counter text: "23 reasons so far"
/// - main content: a scrollable grid of sticky notes
/// - bottom or floating button: "Add Reason"
///
/// Sticky layout:
/// - use a 2-column layout (mobile optimized)
/// - allow slight variation in vertical spacing (masonry style)
/// - NO overlapping between sticky notes
/// - keep layout clean and readable
/// - introduce small imperfections:
///   - very subtle rotation (1–2 degrees)
///   - slight variation in position
/// - maintain clear spacing between notes
///
/// Sticky note design:
/// - soft pastel colors (light pink, beige, soft yellow, blush tones)
/// - rounded corners
/// - subtle soft shadows
/// - paper-like aesthetic
/// - each note contains:
///   - short emotional text (1–3 lines)
///   - small subtle icon (heart or emoji)
///
/// Interaction:
/// - sticky notes must look clearly tappable
/// - tapping a sticky can open a detail or edit view
/// - allow long press or menu icon for edit/delete options (visually
/// suggested)
///
/// Button:
/// - large rounded button labeled "Add Reason"
/// - warm, romantic color
/// - visually prominent but elegant
///
/// Visual style:
/// - premium couples app design
/// - warm, soft, romantic
/// - clean and structured
/// - modern typography
/// - calm background (soft gradient or subtle tone)
///
/// Avoid:
/// - overlapping sticky notes
/// - chaotic layouts
/// - dashboard or productivity app feel
/// - harsh colors
/// - clutter
///
/// Make the page feel like a personal, growing collection of love notes that
/// is easy to manage but still emotionally meaningful.
class CouponPageWidget extends StatefulWidget {
  const CouponPageWidget({
    super.key,
    required this.currentTreasureId,
    required this.currentTreasureRef,
    required this.currentRelationshipRef,
  });

  final String? currentTreasureId;
  final DocumentReference? currentTreasureRef;
  final DocumentReference? currentRelationshipRef;

  static String routeName = 'coupon_page';
  static String routePath = '/couponPage';

  @override
  State<CouponPageWidget> createState() => _CouponPageWidgetState();
}

class _CouponPageWidgetState extends State<CouponPageWidget> {
  late CouponPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CouponPageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'coupon_page'});
    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

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
        backgroundColor: Color(0xFFF5F0F8),
        body: Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: MediaQuery.sizeOf(context).height * 1.0,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, -1.0),
                child: Container(
                  width: double.infinity,
                  height: 340.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFF9E8F0),
                        Color(0xFFEFD6F5),
                        Color(0xFFD6E8F9)
                      ],
                      stops: [0.0, 0.5, 1.0],
                      begin: AlignmentDirectional(0.64, 1.0),
                      end: AlignmentDirectional(-0.64, -1.0),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100.0,
                      child: Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 56.0, 20.0, 0.0),
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
                                  width: 42.0,
                                  height: 42.0,
                                  decoration: BoxDecoration(
                                    color: Color(0x33FFFFFF),
                                    borderRadius: BorderRadius.circular(14.0),
                                    border: Border.all(
                                      color: Color(0x22FFFFFF),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Color(0xFF8B5E9E),
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'pv86j85g' /* Create Love Coupon */,
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .headlineMediumFamily,
                                    color: Color(0xFF4A2060),
                                    fontSize: 26.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    lineHeight: 1.2,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .headlineMediumIsCustom,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 6.0, 0.0, 0.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'tupmhft3' /* Craft a sweet and meaningful C... */,
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: Color(0xFF9B7AB0),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    lineHeight: 1.4,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 28.0, 24.0, 28.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 24.0,
                                color: Color(0x18C084C8),
                                offset: Offset(
                                  0.0,
                                  8.0,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(28.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 4.0,
                                          height: 20.0,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFE91E8C),
                                                Colors.purple
                                              ],
                                              stops: [0.0, 1.0],
                                              begin: AlignmentDirectional(
                                                  0.0, 1.0),
                                              end:
                                                  AlignmentDirectional(0, -1.0),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'zbktei63' /* Choose a Template */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMediumFamily,
                                                color: Color(0xFF4A2060),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .titleMediumIsCustom,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '4y3u3w16' /* Pick a beautifully designed co... */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: Color(0xFF9B7AB0),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodySmallIsCustom,
                                          ),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model.selectedTemplateId =
                                                  'movie_night_01';
                                              _model.selectedDesignKey =
                                                  'sunset_movie';
                                              _model.selectedIconKey = 'movie';
                                              _model.selectedCategory =
                                                  'movie_night';
                                              _model.couponTitle =
                                                  _model.textController1.text;
                                              _model.couponDescription =
                                                  _model.textController2.text;
                                              _model.isTemplateSelected = true;
                                              _model.uploadedPhotoUrl = '\"\"';
                                              _model.uploadedPhotoPath = '\"\"';
                                              _model.generatedCouponPhotoFileName =
                                                  null;
                                              _model.selectedCouponPhoto = null;
                                              safeSetState(() {});
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Container(
                                                width: 110.0,
                                                height: 140.0,
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 12.0,
                                                      color: Color(0x40FF6B9D),
                                                      offset: Offset(
                                                        0.0,
                                                        4.0,
                                                      ),
                                                    )
                                                  ],
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xFFFF6B9D),
                                                      Color(0xFFFF8E53)
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
                                                  border: Border.all(
                                                    color:
                                                        _model.selectedTemplateId ==
                                                                'movie_night_01'
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .vibrantColor
                                                            : Color(0x00000000),
                                                    width:
                                                        _model.selectedTemplateId ==
                                                                'movie_night_01'
                                                            ? 2.0
                                                            : 0.0,
                                                  ),
                                                ),
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0x20FFFFFF),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: 48.0,
                                                          height: 48.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x33FFFFFF),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Icon(
                                                              Icons
                                                                  .movie_outlined,
                                                              color:
                                                                  Colors.white,
                                                              size: 26.0,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'dmrh1jyx' /* Movie Night */,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMediumIsCustom,
                                                              ),
                                                        ),
                                                        Container(
                                                          width: 24.0,
                                                          height: 4.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x66FFFFFF),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.0),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 8.0)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Container(
                                              width: 110.0,
                                              height: 140.0,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 6.0,
                                                    color: Color(0x20B06AB3),
                                                    offset: Offset(
                                                      0.0,
                                                      3.0,
                                                    ),
                                                  )
                                                ],
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFFB06AB3),
                                                    Color(0xFFEE0979)
                                                  ],
                                                  stops: [0.0, 1.0],
                                                  begin: AlignmentDirectional(
                                                      1.0, 1.0),
                                                  end: AlignmentDirectional(
                                                      -1.0, -1.0),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                border: Border.all(
                                                  color: _model
                                                              .selectedTemplateId ==
                                                          'massage_01'
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .vibrantColor
                                                      : Color(0x00000000),
                                                  width:
                                                      _model.selectedTemplateId ==
                                                              'massage_01'
                                                          ? 2.0
                                                          : 0.0,
                                                ),
                                              ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.selectedTemplateId =
                                                      'massage_01';
                                                  _model.selectedDesignKey =
                                                      'soft_spa';
                                                  _model.selectedIconKey =
                                                      'massage';
                                                  _model.selectedCategory =
                                                      'massage';
                                                  _model.couponTitle = _model
                                                      .textController1.text;
                                                  _model.couponDescription =
                                                      _model
                                                          .textController2.text;
                                                  _model.isTemplateSelected =
                                                      true;
                                                  _model.uploadedPhotoUrl =
                                                      '\"\"';
                                                  _model.uploadedPhotoPath =
                                                      '\"\"';
                                                  _model.generatedCouponPhotoFileName =
                                                      null;
                                                  _model.selectedCouponPhoto =
                                                      null;
                                                  safeSetState(() {});
                                                },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 48.0,
                                                      height: 48.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0x33FFFFFF),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Icon(
                                                          Icons.spa_outlined,
                                                          color: Colors.white,
                                                          size: 26.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '61kh0jzo' /* Massage */,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                    ),
                                                    Container(
                                                      width: 24.0,
                                                      height: 4.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0x33FFFFFF),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.0),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 8.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Container(
                                              width: 110.0,
                                              height: 140.0,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 6.0,
                                                    color: Color(0x20FF758C),
                                                    offset: Offset(
                                                      0.0,
                                                      3.0,
                                                    ),
                                                  )
                                                ],
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFFFF758C),
                                                    Color(0xFFFF7EB3)
                                                  ],
                                                  stops: [0.0, 1.0],
                                                  begin: AlignmentDirectional(
                                                      1.0, 1.0),
                                                  end: AlignmentDirectional(
                                                      -1.0, -1.0),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                border: Border.all(
                                                  color:
                                                      _model.selectedTemplateId ==
                                                              'date_night_01'
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .vibrantColor
                                                          : Color(0x00000000),
                                                  width:
                                                      _model.selectedTemplateId ==
                                                              'date_night_01'
                                                          ? 2.0
                                                          : 0.0,
                                                ),
                                              ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.selectedTemplateId =
                                                      'date_night_01';
                                                  _model.selectedDesignKey =
                                                      'romantic_date';
                                                  _model.selectedIconKey =
                                                      'date';
                                                  _model.selectedCategory =
                                                      'date';
                                                  _model.couponTitle = _model
                                                      .textController1.text;
                                                  _model.couponDescription =
                                                      _model
                                                          .textController2.text;
                                                  _model.isTemplateSelected =
                                                      true;
                                                  _model.uploadedPhotoUrl =
                                                      '\"\"';
                                                  _model.uploadedPhotoPath =
                                                      '\"\"';
                                                  _model.generatedCouponPhotoFileName =
                                                      null;
                                                  _model.selectedCouponPhoto =
                                                      null;
                                                  safeSetState(() {});
                                                },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 48.0,
                                                      height: 48.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0x33FFFFFF),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Icon(
                                                          Icons
                                                              .restaurant_outlined,
                                                          color: Colors.white,
                                                          size: 26.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'y5i6glpv' /* Date Night */,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                    ),
                                                    Container(
                                                      width: 24.0,
                                                      height: 4.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0x33FFFFFF),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.0),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 8.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Container(
                                              width: 110.0,
                                              height: 140.0,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 6.0,
                                                    color: Color(0x2043C6AC),
                                                    offset: Offset(
                                                      0.0,
                                                      3.0,
                                                    ),
                                                  )
                                                ],
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFF43C6AC),
                                                    Color(0xFF191654)
                                                  ],
                                                  stops: [0.0, 1.0],
                                                  begin: AlignmentDirectional(
                                                      1.0, 1.0),
                                                  end: AlignmentDirectional(
                                                      -1.0, -1.0),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                border: Border.all(
                                                  color:
                                                      _model.selectedTemplateId ==
                                                              'adventure_01'
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .vibrantColor
                                                          : Color(0x00000000),
                                                  width:
                                                      _model.selectedTemplateId ==
                                                              'adventure_01'
                                                          ? 2.0
                                                          : 0.0,
                                                ),
                                              ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.selectedTemplateId =
                                                      'adventure_01';
                                                  _model.selectedDesignKey =
                                                      'adventure_trip';
                                                  _model.selectedIconKey =
                                                      'adventure';
                                                  _model.selectedCategory =
                                                      'adventure';
                                                  _model.couponTitle = _model
                                                      .textController1.text;
                                                  _model.couponDescription =
                                                      _model
                                                          .textController2.text;
                                                  _model.isTemplateSelected =
                                                      true;
                                                  _model.uploadedPhotoUrl =
                                                      '\"\"';
                                                  _model.uploadedPhotoPath =
                                                      '\"\"';
                                                  _model.generatedCouponPhotoFileName =
                                                      null;
                                                  _model.selectedCouponPhoto =
                                                      null;
                                                  safeSetState(() {});
                                                },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 48.0,
                                                      height: 48.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0x33FFFFFF),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Icon(
                                                          Icons
                                                              .explore_outlined,
                                                          color: Colors.white,
                                                          size: 26.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'ammbzmdv' /* Adventure */,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                    ),
                                                    Container(
                                                      width: 24.0,
                                                      height: 4.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0x33FFFFFF),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.0),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 8.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Container(
                                              width: 110.0,
                                              height: 140.0,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 6.0,
                                                    color: Color(0x20FFD89B),
                                                    offset: Offset(
                                                      0.0,
                                                      3.0,
                                                    ),
                                                  )
                                                ],
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFFFFD89B),
                                                    Color(0xFF19547B)
                                                  ],
                                                  stops: [0.0, 1.0],
                                                  begin: AlignmentDirectional(
                                                      1.0, 1.0),
                                                  end: AlignmentDirectional(
                                                      -1.0, -1.0),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                border: Border.all(
                                                  width:
                                                      _model.selectedTemplateId ==
                                                              'surprise_01'
                                                          ? 2.0
                                                          : 0.0,
                                                ),
                                              ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.selectedTemplateId =
                                                      'surprise_01';
                                                  _model.selectedDesignKey =
                                                      'sweet_surprise';
                                                  _model.selectedIconKey =
                                                      'surprise';
                                                  _model.selectedCategory =
                                                      'surprise';
                                                  _model.couponTitle = _model
                                                      .textController1.text;
                                                  _model.couponDescription =
                                                      _model
                                                          .textController2.text;
                                                  _model.isTemplateSelected =
                                                      true;
                                                  _model.uploadedPhotoUrl =
                                                      '\"\"';
                                                  _model.uploadedPhotoPath =
                                                      '\"\"';
                                                  _model.generatedCouponPhotoFileName =
                                                      null;
                                                  _model.selectedCouponPhoto =
                                                      null;
                                                  safeSetState(() {});
                                                },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 48.0,
                                                      height: 48.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0x33FFFFFF),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Icon(
                                                          Icons
                                                              .star_border_rounded,
                                                          color: Colors.white,
                                                          size: 26.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'ptrm1lgt' /* Surprise */,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                    ),
                                                    Container(
                                                      width: 24.0,
                                                      height: 4.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0x33FFFFFF),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.0),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 8.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]
                                            .divide(SizedBox(width: 12.0))
                                            .addToStart(SizedBox(width: 2.0))
                                            .addToEnd(SizedBox(width: 2.0)),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 14.0)),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'ck10eznz' /* Or... */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.network(
                                          firebase_storagelibrary_2sa6k9_functions
                                              .convertStringToImagePath(
                                                  _model.uploadedPhotoUrl)!,
                                        ).image,
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFFFF0F8),
                                          Color(0xFFF8F0FF)
                                        ],
                                        stops: [0.0, 1.0],
                                        begin: AlignmentDirectional(1.0, 1.0),
                                        end: AlignmentDirectional(-1.0, -1.0),
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(
                                        color: Color(0xFFE8D5F5),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons
                                                  .add_photo_alternate_outlined,
                                              color: Color(0xFFCE93D8),
                                              size: 18.0,
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'efeoa678' /* Add your own photo */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: Color(0xFF7B4F9E),
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                            ),
                                            Container(
                                              width: 1.0,
                                              height: 14.0,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFE0C8F0),
                                              ),
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'udc1vegd' /* optional */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallFamily,
                                                    color: Color(0xFFCE93D8),
                                                    fontSize: 11.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallIsCustom,
                                                  ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              'kzkv9714' /* Upload a personal photo to mak... */,
                                            ),
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallFamily,
                                                  color: Color(0xFF9B7AB0),
                                                  fontSize: 12.0,
                                                  letterSpacing: 0.0,
                                                  lineHeight: 1.4,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallIsCustom,
                                                ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              final selectedMedia =
                                                  await selectMediaWithSourceBottomSheet(
                                                context: context,
                                                allowPhoto: true,
                                              );
                                              if (selectedMedia != null &&
                                                  selectedMedia.every((m) =>
                                                      validateFileFormat(
                                                          m.storagePath,
                                                          context))) {
                                                safeSetState(() => _model
                                                        .isDataUploading_uploadDataWgn =
                                                    true);
                                                var selectedUploadedFiles =
                                                    <FFUploadedFile>[];

                                                try {
                                                  selectedUploadedFiles =
                                                      selectedMedia
                                                          .map((m) =>
                                                              FFUploadedFile(
                                                                name: m
                                                                    .storagePath
                                                                    .split('/')
                                                                    .last,
                                                                bytes: m.bytes,
                                                                height: m
                                                                    .dimensions
                                                                    ?.height,
                                                                width: m
                                                                    .dimensions
                                                                    ?.width,
                                                                blurHash:
                                                                    m.blurHash,
                                                                originalFilename:
                                                                    m.originalFilename,
                                                              ))
                                                          .toList();
                                                } finally {
                                                  _model.isDataUploading_uploadDataWgn =
                                                      false;
                                                }
                                                if (selectedUploadedFiles
                                                        .length ==
                                                    selectedMedia.length) {
                                                  safeSetState(() {
                                                    _model.uploadedLocalFile_uploadDataWgn =
                                                        selectedUploadedFiles
                                                            .first;
                                                  });
                                                } else {
                                                  safeSetState(() {});
                                                  return;
                                                }
                                              }

                                              _model.selectedCouponPhoto = _model
                                                  .uploadedLocalFile_uploadDataWgn;
                                              _model.selectedTemplateId =
                                                  '\"\"';
                                              _model.selectedDesignKey = '\"\"';
                                              _model.selectedIconKey = '\"\"';
                                              _model.isTemplateSelected = false;
                                              _model.selectedCategory = '\"\"';
                                              safeSetState(() {});
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'mawe353h' /* Tap to upload a photo */,
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
                                                            Color(0xFFCE93D8),
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodySmallIsCustom,
                                                      ),
                                                ),
                                                Icon(
                                                  Icons.cloud_upload_outlined,
                                                  color: Color(0xFFCE93D8),
                                                  size: 32.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 120.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF9F0FF),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                            border: Border.all(
                                              color: Color(0xFFCE93D8),
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Visibility(
                                            visible:
                                                _model.selectedCouponPhoto !=
                                                        null &&
                                                    (_model
                                                            .selectedCouponPhoto
                                                            ?.bytes
                                                            ?.isNotEmpty ??
                                                        false),
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                child: custom_widgets
                                                    .TreasurePhotoPreview(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  uploadedFile: _model
                                                      .selectedCouponPhoto,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 12.0)),
                                    ),
                                  ),
                                ),
                                Form(
                                  key: _model.formKey,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: 4.0,
                                            height: 20.0,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFFE91E8C),
                                                  Colors.purple
                                                ],
                                                stops: [0.0, 1.0],
                                                begin: AlignmentDirectional(
                                                    0.0, 1.0),
                                                end: AlignmentDirectional(
                                                    0, -1.0),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              '5jsl5f7l' /* Coupon Details */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMediumFamily,
                                                  color: Color(0xFF4A2060),
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .titleMediumIsCustom,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 8.0)),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 54.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF9F0FF),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          border: Border.all(
                                            color: Color(0xFFE8D5F5),
                                            width: 1.5,
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: _model.textController1,
                                          focusNode: _model.textFieldFocusNode1,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.textController1',
                                            Duration(milliseconds: 2000),
                                            () async {
                                              _model.couponTitle =
                                                  _model.textController1.text;
                                              safeSetState(() {});
                                            },
                                          ),
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText:
                                                FFLocalizations.of(context)
                                                    .getText(
                                              'vk3jfrmd' /* e.g. A Cozy Movie Night Just f... */,
                                            ),
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color: Color(0xFFCE93D8),
                                                      fontSize: 15.0,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            focusedErrorBorder:
                                                InputBorder.none,
                                            filled: true,
                                            fillColor: Colors.transparent,
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    18.0, 0.0, 18.0, 0.0),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color: Color(0xFF4A2060),
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                          validator: _model
                                              .textController1Validator
                                              .asValidator(context),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF9F0FF),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          border: Border.all(
                                            color: Color(0xFFE8D5F5),
                                            width: 1.5,
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: _model.textController2,
                                          focusNode: _model.textFieldFocusNode2,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.textController2',
                                            Duration(milliseconds: 2000),
                                            () async {
                                              _model.couponDescription =
                                                  _model.textController2.text;
                                              safeSetState(() {});
                                            },
                                          ),
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText:
                                                FFLocalizations.of(context)
                                                    .getText(
                                              'jai1g633' /* Write a heartfelt message your... */,
                                            ),
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color: Color(0xFFCE93D8),
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            focusedErrorBorder:
                                                InputBorder.none,
                                            filled: true,
                                            fillColor: Colors.transparent,
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    18.0, 12.0, 18.0, 12.0),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color: Color(0xFF4A2060),
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                lineHeight: 1.5,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                          maxLines: 4,
                                          minLines: 4,
                                          keyboardType: TextInputType.multiline,
                                          validator: _model
                                              .textController2Validator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 10.0)),
                                  ),
                                ),
                                if (_model.isTemplateSelected == false)
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: 4.0,
                                            height: 20.0,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFFE91E8C),
                                                  Colors.purple
                                                ],
                                                stops: [0.0, 1.0],
                                                begin: AlignmentDirectional(
                                                    0.0, 1.0),
                                                end: AlignmentDirectional(
                                                    0, -1.0),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              '0pak0b45' /* Category */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMediumFamily,
                                                  color: Color(0xFF4A2060),
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .titleMediumIsCustom,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 8.0)),
                                      ),
                                      Wrap(
                                        spacing: 8.0,
                                        runSpacing: 10.0,
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        direction: Axis.horizontal,
                                        runAlignment: WrapAlignment.start,
                                        verticalDirection:
                                            VerticalDirection.down,
                                        clipBehavior: Clip.none,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        _model.selectedCategory =
                                                            'quality_time';
                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        height: 52.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _model
                                                                      .selectedCategory ==
                                                                  'quality_time'
                                                              ? Color(
                                                                  0xFFF8BBD0)
                                                              : Color(
                                                                  0xFFFCE4EC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      26.0),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFF48FB1),
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      0.0,
                                                                      12.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'c88jassz' /* 👩‍❤️‍👨 */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyLargeFamily,
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyLargeIsCustom,
                                                                    ),
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'j8uj3sx5' /* Quality 
Time */
                                                                  ,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      color: _model.selectedCategory ==
                                                                              'quality_time'
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .primaryText
                                                                          : Color(
                                                                              0xFFAD1457),
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyMediumIsCustom,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 8.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        _model.selectedCategory =
                                                            'romance';
                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        height: 52.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _model
                                                                      .selectedCategory ==
                                                                  'romance'
                                                              ? Color(
                                                                  0xFFF8BBD0)
                                                              : Color(
                                                                  0xFFFCE4EC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      26.0),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFF48FB1),
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      0.0,
                                                                      12.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'fk0c834x' /* 🌹 */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyLargeFamily,
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyLargeIsCustom,
                                                                    ),
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'qzo9llsy' /* Romance */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      color: _model.selectedCategory ==
                                                                              'romance'
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .primaryText
                                                                          : Color(
                                                                              0xFFAD1457),
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyMediumIsCustom,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 8.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 12.0)),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        _model.selectedCategory =
                                                            'breakfast_in_bed';
                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        height: 52.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _model
                                                                      .selectedCategory ==
                                                                  'breakfast_in_bed'
                                                              ? Color(
                                                                  0xFFF8BBD0)
                                                              : Color(
                                                                  0xFFFCE4EC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      26.0),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFF48FB1),
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      0.0,
                                                                      12.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'll1qi1f0' /* 🍳 */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyLargeFamily,
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyLargeIsCustom,
                                                                    ),
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  '933jepr3' /* Breakfast */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      color: _model.selectedCategory ==
                                                                              'breakfast_in_bed'
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .primaryText
                                                                          : Color(
                                                                              0xFFAD1457),
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyMediumIsCustom,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 8.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        _model.selectedCategory =
                                                            'massage';
                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        height: 52.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _model
                                                                      .selectedCategory ==
                                                                  'massage'
                                                              ? Color(
                                                                  0xFFF8BBD0)
                                                              : Color(
                                                                  0xFFFCE4EC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      26.0),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFF48FB1),
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      0.0,
                                                                      12.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'atln1quu' /* 💆 */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyLargeFamily,
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyLargeIsCustom,
                                                                    ),
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'zq9vbt10' /* Massage */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      color: _model.selectedCategory ==
                                                                              'massage'
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .primaryText
                                                                          : Color(
                                                                              0xFFAD1457),
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyMediumIsCustom,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 8.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 12.0)),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        _model.selectedCategory =
                                                            'movie_night';
                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        height: 52.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _model
                                                                      .selectedCategory ==
                                                                  'movie_night'
                                                              ? Color(
                                                                  0xFFF8BBD0)
                                                              : Color(
                                                                  0xFFFCE4EC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      26.0),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFF48FB1),
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      0.0,
                                                                      12.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'rwvi11ga' /* 🎬 */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyLargeFamily,
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyLargeIsCustom,
                                                                    ),
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'wcpi4zbk' /* Movie Night */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      color: _model.selectedCategory ==
                                                                              'movie_night'
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .primaryText
                                                                          : Color(
                                                                              0xFFAD1457),
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyMediumIsCustom,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 8.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        _model.selectedCategory =
                                                            'date_night';
                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        height: 52.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _model
                                                                      .selectedCategory ==
                                                                  'date_night'
                                                              ? Color(
                                                                  0xFFF8BBD0)
                                                              : Color(
                                                                  0xFFFCE4EC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      26.0),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFF48FB1),
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      0.0,
                                                                      12.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'rzlrrwwo' /* 🍷 */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyLargeFamily,
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyLargeIsCustom,
                                                                    ),
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'iqx6p8mc' /* Date Night */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      color: _model.selectedCategory ==
                                                                              'date_night'
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .primaryText
                                                                          : Color(
                                                                              0xFFAD1457),
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyMediumIsCustom,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 8.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 12.0)),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        _model.selectedCategory =
                                                            'adventure';
                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        height: 52.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _model
                                                                      .selectedCategory ==
                                                                  'adventure'
                                                              ? Color(
                                                                  0xFFF8BBD0)
                                                              : Color(
                                                                  0xFFFCE4EC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      26.0),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFF48FB1),
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      0.0,
                                                                      12.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  '7eum1qjk' /* ✈️ */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyLargeFamily,
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyLargeIsCustom,
                                                                    ),
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'xdownjih' /* Adventure */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      color: _model.selectedCategory ==
                                                                              'adventure'
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .primaryText
                                                                          : Color(
                                                                              0xFFAD1457),
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyMediumIsCustom,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 8.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        _model.selectedCategory =
                                                            'surprise';
                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        height: 52.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _model
                                                                      .selectedCategory ==
                                                                  'surprise'
                                                              ? Color(
                                                                  0xFFF8BBD0)
                                                              : Color(
                                                                  0xFFFCE4EC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      26.0),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFF48FB1),
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      0.0,
                                                                      12.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'prnzgshl' /* 🎁 */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyLargeFamily,
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyLargeIsCustom,
                                                                    ),
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'g7qjbei8' /* Surprise */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      color: _model.selectedCategory ==
                                                                              'surprise'
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .primaryText
                                                                          : Color(
                                                                              0xFFAD1457),
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyMediumIsCustom,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 8.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 12.0)),
                                              ),
                                            ].divide(SizedBox(height: 12.0)),
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 12.0)),
                                  ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      if (_model.formKey.currentState == null ||
                                          !_model.formKey.currentState!
                                              .validate()) {
                                        return;
                                      }
                                      if ((_model.isTemplateSelected ==
                                              false) &&
                                          (_model.selectedCouponPhoto == null ||
                                              (_model.selectedCouponPhoto?.bytes
                                                      ?.isEmpty ??
                                                  true))) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                                enText:
                                                    'Please choose a template or upload your own photo',
                                                deText:
                                                    'Bitte wähle eine Vorlage aus oder lade dein eigenes Foto hoch',
                                                esText:
                                                    'Elige una plantilla o sube tu propia foto',
                                              ),
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                                      } else {
                                        if ((_model.isTemplateSelected ==
                                                false) &&
                                            (_model.selectedCategory ==
                                                '\"\"')) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                FFLocalizations.of(context)
                                                    .getVariableText(
                                                  enText:
                                                      'Please choose a template or upload your own photo',
                                                  deText:
                                                      'Bitte wähle eine Vorlage aus oder lade dein eigenes Foto hoch',
                                                  esText:
                                                      'Elige una plantilla o sube tu propia foto',
                                                ),
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
                                        } else {
                                          if (_model.selectedCouponPhoto !=
                                                  null &&
                                              (_model.selectedCouponPhoto?.bytes
                                                      ?.isNotEmpty ??
                                                  false)) {
                                            _model.generatedCouponPhotoFileName =
                                                'cp_${currentUserUid}_${getCurrentTimestamp.millisecondsSinceEpoch.toString()}';
                                            safeSetState(() {});
                                            await firebase_storagelibrary_2sa6k9_actions
                                                .uploadFileToBucket(
                                              '',
                                              'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/love_coupons/photos/${_model.generatedCouponPhotoFileName}.jpg',
                                              _model.selectedCouponPhoto!,
                                              '',
                                            );
                                            _model.couponPhotoDownloadUrl =
                                                await actions
                                                    .getStorageDownloadUrlV2(
                                              'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/love_coupons/photos/${_model.generatedCouponPhotoFileName}.jpg',
                                              '',
                                            );
                                            _model.uploadedPhotoUrl =
                                                _model.couponPhotoDownloadUrl;
                                            _model.uploadedPhotoPath =
                                                'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/love_coupons/photos/${_model.generatedCouponPhotoFileName}.jpg';
                                            safeSetState(() {});
                                          } else {
                                            _model.uploadedPhotoUrl = '\"\"';
                                            _model.uploadedPhotoPath = '\"\"';
                                            _model.generatedCouponPhotoFileName =
                                                null;
                                            safeSetState(() {});
                                          }

                                          var loveCouponsRecordReference =
                                              LoveCouponsRecord.createDoc(
                                                  widget
                                                      .currentRelationshipRef!);
                                          await loveCouponsRecordReference
                                              .set(createLoveCouponsRecordData(
                                            relationshipId: valueOrDefault(
                                                currentUserDocument
                                                    ?.relationshipId,
                                                ''),
                                            title: _model.textController1.text,
                                            description:
                                                _model.textController2.text,
                                            createdAt: getCurrentTimestamp,
                                            createdByUserId:
                                                currentUserReference?.id,
                                            category: _model.selectedCategory,
                                            createdForUserId: valueOrDefault(
                                                currentUserDocument?.partnerUID,
                                                ''),
                                            updatedAt: getCurrentTimestamp,
                                            isTemplate:
                                                _model.isTemplateSelected ==
                                                        true
                                                    ? true
                                                    : false,
                                            couponId: '',
                                            status: 'active',
                                            isRedeemed: false,
                                            photoUrl: _model.uploadedPhotoUrl,
                                            photoPath: _model
                                                        .isTemplateSelected ==
                                                    true
                                                ? ''
                                                : 'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/love_coupons/photos/${_model.generatedCouponPhotoFileName}.jpg',
                                            templateId:
                                                _model.isTemplateSelected ==
                                                        true
                                                    ? _model.selectedTemplateId
                                                    : '\"\"',
                                            designKey:
                                                _model.isTemplateSelected ==
                                                        true
                                                    ? _model.selectedDesignKey
                                                    : '\"\"',
                                            iconKey:
                                                _model.isTemplateSelected ==
                                                        true
                                                    ? _model.selectedIconKey
                                                    : '\"\"',
                                            createdFromTreasure: true,
                                            sourceTreasureId:
                                                widget.currentTreasureId,
                                            isUnlimited: true,
                                            isVisibleInWallet: false,
                                          ));
                                          _model.createDoc = LoveCouponsRecord
                                              .getDocumentFromData(
                                                  createLoveCouponsRecordData(
                                                    relationshipId:
                                                        valueOrDefault(
                                                            currentUserDocument
                                                                ?.relationshipId,
                                                            ''),
                                                    title: _model
                                                        .textController1.text,
                                                    description: _model
                                                        .textController2.text,
                                                    createdAt:
                                                        getCurrentTimestamp,
                                                    createdByUserId:
                                                        currentUserReference
                                                            ?.id,
                                                    category:
                                                        _model.selectedCategory,
                                                    createdForUserId:
                                                        valueOrDefault(
                                                            currentUserDocument
                                                                ?.partnerUID,
                                                            ''),
                                                    updatedAt:
                                                        getCurrentTimestamp,
                                                    isTemplate:
                                                        _model.isTemplateSelected ==
                                                                true
                                                            ? true
                                                            : false,
                                                    couponId: '',
                                                    status: 'active',
                                                    isRedeemed: false,
                                                    photoUrl:
                                                        _model.uploadedPhotoUrl,
                                                    photoPath: _model
                                                                .isTemplateSelected ==
                                                            true
                                                        ? ''
                                                        : 'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/love_coupons/photos/${_model.generatedCouponPhotoFileName}.jpg',
                                                    templateId: _model
                                                                .isTemplateSelected ==
                                                            true
                                                        ? _model
                                                            .selectedTemplateId
                                                        : '\"\"',
                                                    designKey:
                                                        _model.isTemplateSelected ==
                                                                true
                                                            ? _model
                                                                .selectedDesignKey
                                                            : '\"\"',
                                                    iconKey:
                                                        _model.isTemplateSelected ==
                                                                true
                                                            ? _model
                                                                .selectedIconKey
                                                            : '\"\"',
                                                    createdFromTreasure: true,
                                                    sourceTreasureId: widget
                                                        .currentTreasureId,
                                                    isUnlimited: true,
                                                    isVisibleInWallet: false,
                                                  ),
                                                  loveCouponsRecordReference);

                                          await _model.createDoc!.reference
                                              .update(
                                                  createLoveCouponsRecordData(
                                            couponId:
                                                _model.createDoc?.reference.id,
                                          ));

                                          await TreasureSurprisesRecord
                                              .collection
                                              .doc()
                                              .set(
                                                  createTreasureSurprisesRecordData(
                                                createdBy: currentUserReference,
                                                type: 'coupon',
                                                text: _model.couponDescription,
                                                title: _model.couponTitle,
                                                createdAt: getCurrentTimestamp,
                                                revealOrder: 0,
                                                revealed: false,
                                                treasureRef:
                                                    widget.currentTreasureRef,
                                                relationshipId: valueOrDefault(
                                                    currentUserDocument
                                                        ?.relationshipId,
                                                    ''),
                                                createdByUid: currentUserUid,
                                                couponId: _model
                                                    .createDoc?.reference.id,
                                              ));
                                          context.safePop();
                                          await showDialog(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                title: Text(
                                                    FFLocalizations.of(context)
                                                        .getVariableText(
                                                  enText: 'Love Coupon',
                                                  deText: 'Liebesgutschein',
                                                  esText: 'Cupón de amor',
                                                )),
                                                content: Text(
                                                    FFLocalizations.of(context)
                                                        .getVariableText(
                                                  enText:
                                                      'Love Coupon created 💝',
                                                  deText:
                                                      'Liebesgutschein erstellt 💝',
                                                  esText:
                                                      'Cupón de amor creado 💝',
                                                )),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext),
                                                    child: Text('Ok'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      }

                                      safeSetState(() {});
                                    },
                                    text: FFLocalizations.of(context).getText(
                                      'r187zona' /* Create Coupon 💝 */,
                                    ),
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 58.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Color(0xFFC0507A),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily,
                                            color: Colors.white,
                                            fontSize: 16.0,
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
                              ].divide(SizedBox(height: 24.0)),
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
