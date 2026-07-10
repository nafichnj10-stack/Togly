import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'pair_required_sheet_model.dart';
export 'pair_required_sheet_model.dart';

/// Create a reusable Bottom Sheet component named "PairRequiredSheet" that
/// matches the visual style of the Togetherly app.
///
/// Design guidelines:
/// - Soft pastel background (light lavender or white) with rounded top
/// corners (radius 24px or similar).
/// - Use the same typography and color scheme as the rest of the app (primary
/// color: soft purple #A88BEB, secondary: light pink #FDCBFA, text in dark
/// gray/black).
/// - Padding: 20px all around.
/// - Layout: vertical column, center-aligned content, with spacing between
/// elements.
/// - Include a friendly icon at the top (heart icon or linked hands) inside a
/// circular background in the primary purple color, size around 48px.
/// - Title text (H2): “Only for Connected Couples”
///   - Bold, large font size (20–22px), primary text color.
/// - Subtitle text (Body): “Connect with your partner to unlock this
/// feature.”
///   - Medium size (14–16px), centered, soft gray color.
/// - Primary button: “Connect Now”
///   - Full width, rounded corners (radius 16px), background in primary
/// purple, white text, bold.
///   - On tap → Navigate to ConnectV2 page.
/// - Secondary text button below: “Maybe Later”
///   - No background, primary purple text.
///   - On tap → Close Bottom Sheet.
///
/// Overall feel: clean, modern, romantic, and friendly, consistent with the
/// Togetherly design system.
class PairRequiredSheetWidget extends StatefulWidget {
  const PairRequiredSheetWidget({super.key});

  @override
  State<PairRequiredSheetWidget> createState() =>
      _PairRequiredSheetWidgetState();
}

class _PairRequiredSheetWidgetState extends State<PairRequiredSheetWidget> {
  late PairRequiredSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PairRequiredSheetModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFE8E3F0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 64.0,
                  height: 64.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFA88BEB),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 32.0,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        'ye4r1e8o' /* Connect with your partner 💜 */,
                      ),
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleLargeFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 22.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .titleLargeIsCustom,
                          ),
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        'kv3jok0y' /* to unlock this feature. */,
                      ),
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: FlutterFlowTheme.of(context).accent4,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                  ].divide(SizedBox(height: 12.0)),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        if (valueOrDefault<bool>(
                                currentUserDocument?.restoreRequired, false) ==
                            true) {
                          context.pushNamed(
                            RestoreWidget.routeName,
                            extra: <String, dynamic>{
                              '__transition_info__': TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.fade,
                              ),
                            },
                          );
                        } else {
                          context.pushNamed(
                            ConnectV2Widget.routeName,
                            extra: <String, dynamic>{
                              '__transition_info__': TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.fade,
                              ),
                            },
                          );
                        }
                      },
                      text: FFLocalizations.of(context).getText(
                        'z6ugpr9y' /* Connect Now */,
                      ),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 48.0,
                        padding: EdgeInsets.all(8.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Color(0xFFA88BEB),
                        textStyle:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleMediumFamily,
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleMediumIsCustom,
                                ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          Navigator.pop(context);

                          context.goNamed(
                            HomeWidget.routeName,
                            extra: <String, dynamic>{
                              '__transition_info__': TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.fade,
                                duration: Duration(milliseconds: 0),
                              ),
                            },
                          );
                        },
                        text: FFLocalizations.of(context).getText(
                          'wmffofz6' /* Maybe Later */,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40.0,
                          padding: EdgeInsets.all(8.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Colors.transparent,
                          textStyle: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyLargeFamily,
                                color: FlutterFlowTheme.of(context).primary,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyLargeIsCustom,
                              ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 16.0)),
                ),
              ].divide(SizedBox(height: 24.0)),
            ),
          ),
        ),
      ),
    );
  }
}
