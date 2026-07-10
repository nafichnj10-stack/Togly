import '/auth/firebase_auth/auth_util.dart';
import '/components/photo_sheet/photo_sheet_widget.dart';
import '/components/voice_note_sheet/voice_note_sheet_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'surprise_sheet_model.dart';
export 'surprise_sheet_model.dart';

/// Create a viral-looking 9:16 social media share card component for a
/// couples app called Togly.
///
/// The design should feel emotional, trendy, modern, and optimized for TikTok
/// and Instagram Story sharing.
///
/// Visual style:
/// - romantic pastel pink and purple gradient
/// - dreamy glowing background
/// - subtle floating hearts or sparkles
/// - soft glassmorphism or translucent card sections
/// - modern rounded UI with a premium emotional aesthetic
///
/// Component layout:
/// - top branding: "Togly"
/// - headline: "Our Heartbeat Today"
/// - date below headline
/// - two partner profile photos in circles with a glowing heart icon between
/// them
/// - big central score section with a large percentage like "73%"
/// - subtitle below percentage like "Needs a little more closeness"
/// - short emotional message below like "Today you may need a little more
/// closeness and intentional connection."
/// - bottom call to action text: "What’s your heartbeat today?"
///
/// Design goals:
/// - must look like a polished shareable social media story
/// - focus on emotional connection and couple identity
/// - clean spacing
/// - high visual impact
/// - elegant, warm, and engaging
/// - should feel like content people would want to post publicly
///
/// Use placeholder values and make the percentage result the strongest visual
/// element.
class SurpriseSheetWidget extends StatefulWidget {
  const SurpriseSheetWidget({
    super.key,
    required this.treasureRef,
    required this.relationshipRef,
  });

  final DocumentReference? treasureRef;
  final DocumentReference? relationshipRef;

  @override
  State<SurpriseSheetWidget> createState() => _SurpriseSheetWidgetState();
}

class _SurpriseSheetWidgetState extends State<SurpriseSheetWidget> {
  late SurpriseSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SurpriseSheetModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 30.0,
                color: Color(0x809B59B6),
                offset: Offset(
                  0.0,
                  -4.0,
                ),
                spreadRadius: 0.0,
              )
            ],
            gradient: LinearGradient(
              colors: [
                Color(0xFFF8E1F4),
                Color(0xFFE8D5F5),
                Color(0xFFDDD0F0),
                Color(0xFFF0E6FA)
              ],
              stops: [0.0, 0.4, 0.7, 1.0],
              begin: AlignmentDirectional(1.0, 1.0),
              end: AlignmentDirectional(-1.0, -1.0),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFC9A8E0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: AlignmentDirectional(0.0, 0.0),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        '7a8we55z' /* Add a Surprise */,
                      ),
                      textAlign: TextAlign.center,
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineMediumFamily,
                                color: Color(0xFF3B1F5E),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .headlineMediumIsCustom,
                              ),
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        'feh16ik7' /* Choose something special to hi... */,
                      ),
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: Color(0xFF9B6BB5),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                  ].divide(SizedBox(height: 6.0)),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5EEFF),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12.0,
                            color: Color(0xFFC39BD3),
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                            spreadRadius: 0.0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Color(0xFFE0C8F5),
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 16.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            Navigator.pop(context);
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              enableDrag: false,
                              useSafeArea: true,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: VoiceNoteSheetWidget(
                                    treasureRef: widget.treasureRef!,
                                  ),
                                );
                              },
                            ).then((value) => safeSetState(() {}));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 52.0,
                                height: 52.0,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFC471ED),
                                      Color(0xFFF64F59)
                                    ],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(1.0, 1.0),
                                    end: AlignmentDirectional(-1.0, -1.0),
                                  ),
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                child: Icon(
                                  Icons.mic_rounded,
                                  color: Colors.white,
                                  size: 26.0,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'p76os17p' /* Voice Notes */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily,
                                            color: Color(0xFF3B1F5E),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .titleSmallIsCustom,
                                          ),
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'qsctfqno' /* A voice message for your partn... */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: Color(0xFF9B6BB5),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodySmallIsCustom,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 3.0)),
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: Color(0xFFC39BD3),
                                size: 22.0,
                              ),
                            ].divide(SizedBox(width: 14.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5EEFF),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12.0,
                            color: Color(0xFFC39BD3),
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                            spreadRadius: 0.0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Color(0xFFE0C8F5),
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 16.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            Navigator.pop(context);
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              enableDrag: false,
                              useSafeArea: true,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: PhotoSheetWidget(
                                    treasureRef: widget.treasureRef!,
                                  ),
                                );
                              },
                            ).then((value) => safeSetState(() {}));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 52.0,
                                height: 52.0,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFF093FB),
                                      Color(0xFFF5576C)
                                    ],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(1.0, 1.0),
                                    end: AlignmentDirectional(-1.0, -1.0),
                                  ),
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                child: Icon(
                                  Icons.photo_library_rounded,
                                  color: Colors.white,
                                  size: 26.0,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'zi7h0tqi' /* Photos */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily,
                                            color: Color(0xFF3B1F5E),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .titleSmallIsCustom,
                                          ),
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '0hwkohw8' /* Photos captured just for your ... */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: Color(0xFF9B6BB5),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodySmallIsCustom,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 3.0)),
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: Color(0xFFC39BD3),
                                size: 22.0,
                              ),
                            ].divide(SizedBox(width: 14.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5EEFF),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12.0,
                            color: Color(0xFFC39BD3),
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                            spreadRadius: 0.0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Color(0xFFE0C8F5),
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 16.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(
                              CouponPageWidget.routeName,
                              queryParameters: {
                                'currentTreasureId': serializeParam(
                                  widget.treasureRef?.id,
                                  ParamType.String,
                                ),
                                'currentTreasureRef': serializeParam(
                                  widget.treasureRef,
                                  ParamType.DocumentReference,
                                ),
                                'currentRelationshipRef': serializeParam(
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
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 52.0,
                                height: 52.0,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFFCCB90),
                                      Color(0xFFD57EEB)
                                    ],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(1.0, 1.0),
                                    end: AlignmentDirectional(-1.0, -1.0),
                                  ),
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                child: Icon(
                                  Icons.card_giftcard_rounded,
                                  color: Colors.white,
                                  size: 26.0,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'drm9b1kb' /* Love Coupons */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily,
                                            color: Color(0xFF3B1F5E),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .titleSmallIsCustom,
                                          ),
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'b9upn8zf' /* Use it anytime for something s... */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: Color(0xFF9B6BB5),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodySmallIsCustom,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 3.0)),
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: Color(0xFFC39BD3),
                                size: 22.0,
                              ),
                            ].divide(SizedBox(width: 14.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5EEFF),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12.0,
                            color: Color(0xFFC39BD3),
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                            spreadRadius: 0.0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Color(0xFFE0C8F5),
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 16.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(
                              SticyWallCreateWidget.routeName,
                              queryParameters: {
                                'relationshipId': serializeParam(
                                  valueOrDefault(
                                      currentUserDocument?.relationshipId, ''),
                                  ParamType.String,
                                ),
                                'relationshipRef': serializeParam(
                                  widget.relationshipRef,
                                  ParamType.DocumentReference,
                                ),
                                'treasureId': serializeParam(
                                  widget.treasureRef?.id,
                                  ParamType.String,
                                ),
                                'treasureRef': serializeParam(
                                  widget.treasureRef,
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
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 52.0,
                                height: 52.0,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFA18CD1),
                                      Color(0xFFFBC2EB)
                                    ],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(1.0, 1.0),
                                    end: AlignmentDirectional(-1.0, -1.0),
                                  ),
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                child: Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.white,
                                  size: 26.0,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'aek7273a' /* Reason I Love You */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily,
                                            color: Color(0xFF3B1F5E),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .titleSmallIsCustom,
                                          ),
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'zk4v75y4' /* Little reminders of why you lo... */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: Color(0xFF9B6BB5),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodySmallIsCustom,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 3.0)),
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: Color(0xFFC39BD3),
                                size: 22.0,
                              ),
                            ].divide(SizedBox(width: 14.0)),
                          ),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 12.0)),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 35.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'b2fpjj4s' /* Your partner won't see it unti... */,
                        ),
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).labelSmall.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).labelSmallFamily,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .labelSmallIsCustom,
                            ),
                      ),
                    ),
                  ].divide(SizedBox(height: 4.0)),
                ),
              ].divide(SizedBox(height: 20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
