import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 's3_name_model.dart';
export 's3_name_model.dart';

/// Create a full screen onboarding page.
///
/// Use a Stack as the root widget.
///
/// Background:
/// Add a full screen background image placeholder.
/// Cover mode.
/// Soft dreamy romantic style.
///
/// Content:
/// Center everything vertically and horizontally.
///
/// Add a Column.
///
/// Top:
/// Large headline text.
/// White.
/// Semi bold.
/// Center aligned.
///
/// Below:
/// Smaller subtitle text.
/// White with reduced opacity.
/// Center aligned.
///
/// Spacing should feel open and calm.
///
/// Middle:
/// Add a rounded input field container.
/// Pill shape.
/// Light transparent background.
/// Soft glow.
/// Subtle border.
/// Place a TextField inside.
/// Placeholder text: "Your name here"
/// White text.
///
/// Below:
/// Primary button.
/// Pill shape.
/// Soft gradient.
/// Slight transparency.
/// Subtle shadow.
/// Text: "Continue →"
///
/// Design:
/// Modern.
/// Premium.
/// Romantic.
/// Clean.
/// No clutter.
/// No logic.
/// No actions.
/// Design only.
class S3NameWidget extends StatefulWidget {
  const S3NameWidget({super.key});

  static String routeName = 'S3_name';
  static String routePath = '/s3Name';

  @override
  State<S3NameWidget> createState() => _S3NameWidgetState();
}

class _S3NameWidgetState extends State<S3NameWidget> {
  late S3NameModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => S3NameModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'S3_name'});
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/background_name.webp',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Opacity(
              opacity: 0.2,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0x4D000000), Color(0x1A000000)],
                    stops: [0.0, 1.0],
                    begin: AlignmentDirectional(0.14, -1.0),
                    end: AlignmentDirectional(-0.14, 1.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          't8z127ru' /* How should we call you? */,
                        ),
                        textAlign: TextAlign.center,
                        style:
                            FlutterFlowTheme.of(context).displayMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .displayMediumFamily,
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  lineHeight: 1.2,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .displayMediumIsCustom,
                                ),
                      ),
                      Text(
                        FFLocalizations.of(context).getText(
                          'vqw14zvl' /* This is how you’ll appear in T... */,
                        ),
                        textAlign: TextAlign.center,
                        style:
                            FlutterFlowTheme.of(context).displaySmall.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .displaySmallFamily,
                                  color: FlutterFlowTheme.of(context).accent1,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  lineHeight: 1.2,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .displaySmallIsCustom,
                                ),
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  ),
                  Form(
                    key: _model.formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 25.0),
                          child: Container(
                            width: double.infinity,
                            height: 56.0,
                            decoration: BoxDecoration(
                              color: Color(0x80FFFFFF),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 18.0,
                                  color: Color(0x40000000),
                                  offset: Offset(
                                    0.0,
                                    6.0,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(28.0),
                              border: Border.all(
                                color: Color(0x99FFFFFF),
                                width: 1.5,
                              ),
                            ),
                            child: TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: FFLocalizations.of(context).getText(
                                  '2ixt4gdw' /*     Your name here... */,
                                ),
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                              cursorColor: Colors.white,
                              validator: _model.textControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 24.0)),
                    ),
                  ),
                  Opacity(
                    opacity: 0.8,
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                if (_model.formKey.currentState == null ||
                                    !_model.formKey.currentState!.validate()) {
                                  return;
                                }
                                FFAppState().draftName =
                                    _model.textController.text;
                                safeSetState(() {});

                                context.pushNamed(
                                  S4PartnerWidget.routeName,
                                  extra: <String, dynamic>{
                                    '__transition_info__': TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                    ),
                                  },
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 24.0,
                                      color: Color(0x66000000),
                                      offset: Offset(
                                        0.0,
                                        6.0,
                                      ),
                                    )
                                  ],
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFC084FC),
                                      Color(0xFFD946EF),
                                      Color(0xFFF472B6)
                                    ],
                                    stops: [0.0, 0.5, 1.0],
                                    begin: AlignmentDirectional(0.0, -1.0),
                                    end: AlignmentDirectional(0, 1.0),
                                  ),
                                  borderRadius: BorderRadius.circular(999.0),
                                  border: Border.all(
                                    width: 1.0,
                                  ),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'd94zc2dp' /* Continue ➡️ */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              offset: Offset(2.0, 2.0),
                                              blurRadius: 2.0,
                                            )
                                          ],
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .titleMediumIsCustom,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ].divide(SizedBox(height: 48.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
