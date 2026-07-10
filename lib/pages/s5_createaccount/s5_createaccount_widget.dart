import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:firebase_storagelibrary_2sa6k9/app_state.dart'
    as firebase_storagelibrary_2sa6k9_app_state;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 's5_createaccount_model.dart';
export 's5_createaccount_model.dart';

/// Create a full screen sign up page with a romantic premium style.
///
/// Use a Stack as root.
///
/// Background:
/// Add a full screen background image placeholder.
/// Fill parent, BoxFit cover.
/// Add a subtle dark overlay so text stays readable.
///
/// Content:
/// Centered Column with horizontal padding.
///
/// Top:
/// Headline text: "Create an account"
/// White, bold, soft shadow.
/// Subtitle: "Enter your details to continue."
/// Smaller white text with low opacity.
///
/// Form:
/// Two rounded glass input fields (pill shape).
/// Semi transparent white background.
/// Soft border and subtle shadow.
/// Left icon inside each field.
/// Field 1 placeholder: "Your email"
/// Field 2 placeholder: "Your password"
/// Password field obscured.
///
/// Button:
/// Large rounded primary button.
/// Pink purple gradient, slight transparency.
/// Soft glow and shadow.
/// Text: "Create Account" in white.
///
/// Bottom:
/// Small text: "By signing up, you agree to Terms of Service and Privacy
/// Policy"
/// Low opacity white, centered.
/// Design only, no actions.
class S5CreateaccountWidget extends StatefulWidget {
  const S5CreateaccountWidget({super.key});

  static String routeName = 'S5_createaccount';
  static String routePath = '/s5Createaccount';

  @override
  State<S5CreateaccountWidget> createState() => _S5CreateaccountWidgetState();
}

class _S5CreateaccountWidgetState extends State<S5CreateaccountWidget> {
  late S5CreateaccountModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => S5CreateaccountModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'S5_createaccount'});
    _model.emailTextController ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.passwordTextController ??= TextEditingController();
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
    context.watch<FFAppState>();
    context.watch<firebase_storagelibrary_2sa6k9_app_state.FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/background_create_account.webp',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Opacity(
                opacity: 0.5,
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0x80000000),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
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
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  '07wreg8r' /* Create an account */,
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .displaySmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .displaySmallFamily,
                                      color: Colors.white,
                                      fontSize: 32.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 2.0,
                                        )
                                      ],
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .displaySmallIsCustom,
                                    ),
                              ),
                              Text(
                                FFLocalizations.of(context).getText(
                                  '0nm2gros' /* Enter your details to continue */,
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyLargeFamily,
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyLargeIsCustom,
                                    ),
                              ),
                            ].divide(SizedBox(height: 12.0)),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 56.0,
                                decoration: BoxDecoration(
                                  color: Color(0x40FFFFFF),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10.0,
                                      color: Color(0x20000000),
                                      offset: Offset(
                                        0.0,
                                        2.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(28.0),
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    width: 1.0,
                                  ),
                                ),
                                child: TextFormField(
                                  controller: _model.emailTextController,
                                  focusNode: _model.textFieldFocusNode1,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText:
                                        FFLocalizations.of(context).getText(
                                      'qk68vwo6' /* Your email */,
                                    ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: Color(0xCCFFFFFF),
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
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            56.0, 12.0, 16.0, 0.0),
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Color(0xCCFFFFFF),
                                      size: 20.0,
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: Colors.white,
                                  validator: _model.emailTextControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 56.0,
                                decoration: BoxDecoration(
                                  color: Color(0x40FFFFFF),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10.0,
                                      color: Color(0x20000000),
                                      offset: Offset(
                                        0.0,
                                        2.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(28.0),
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    width: 1.0,
                                  ),
                                ),
                                child: TextFormField(
                                  controller: _model.passwordTextController,
                                  focusNode: _model.textFieldFocusNode2,
                                  autofocus: false,
                                  obscureText: !_model.passwordVisibility,
                                  decoration: InputDecoration(
                                    hintText:
                                        FFLocalizations.of(context).getText(
                                      '8qanxd9r' /* Your password */,
                                    ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: Color(0xCCFFFFFF),
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
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            56.0, 12.0, 16.0, 0.0),
                                    prefixIcon: Icon(
                                      Icons.lock_outlined,
                                      color: Color(0xCCFFFFFF),
                                      size: 20.0,
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () async {
                                        safeSetState(() =>
                                            _model.passwordVisibility =
                                                !_model.passwordVisibility);
                                      },
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Icon(
                                        _model.passwordVisibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                  cursorColor: Colors.white,
                                  validator: _model
                                      .passwordTextControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                          Opacity(
                            opacity: 0.8,
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 20.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          GoRouter.of(context)
                                              .prepareAuthEvent();

                                          final user = await authManager
                                              .createAccountWithEmail(
                                            context,
                                            _model.emailTextController.text,
                                            _model.passwordTextController.text,
                                          );
                                          if (user == null) {
                                            return;
                                          }

                                          await UsersRecord.collection
                                              .doc(user.uid)
                                              .update(createUsersRecordData(
                                                onboardingCompleted: false,
                                                createdTime:
                                                    getCurrentTimestamp,
                                                onboardingStep: 'photo',
                                              ));

                                          var publicUsersRecordReference =
                                              PublicUsersRecord.collection
                                                  .doc(currentUserUid);
                                          await publicUsersRecordReference
                                              .set(createPublicUsersRecordData(
                                            uid: currentUserUid,
                                            name: FFAppState().draftName,
                                            photoUrl: '',
                                            city: '',
                                            localTime: getCurrentTimestamp,
                                            dummyGender: '',
                                            relationshipId: '',
                                            partnerUID: '',
                                            loveCode: '',
                                            onboardingCompleted: false,
                                          ));
                                          _model.users = PublicUsersRecord
                                              .getDocumentFromData(
                                                  createPublicUsersRecordData(
                                                    uid: currentUserUid,
                                                    name:
                                                        FFAppState().draftName,
                                                    photoUrl: '',
                                                    city: '',
                                                    localTime:
                                                        getCurrentTimestamp,
                                                    dummyGender: '',
                                                    relationshipId: '',
                                                    partnerUID: '',
                                                    loveCode: '',
                                                    onboardingCompleted: false,
                                                  ),
                                                  publicUsersRecordReference);
                                          if (FFAppState()
                                                  .draftHasPartnerCode ==
                                              true) {
                                            try {
                                              final result = await FirebaseFunctions
                                                      .instanceFor(
                                                          region:
                                                              'europe-west3')
                                                  .httpsCallable(
                                                      'sendRelationshipRequest')
                                                  .call({
                                                "lovecode": FFAppState()
                                                    .draftPartnerLoveCode,
                                              });
                                              _model.sendrep =
                                                  SendRelationshipRequestCloudFunctionCallResponse(
                                                data: CFResultStruct.fromMap(
                                                    result.data),
                                                succeeded: true,
                                                resultAsString:
                                                    result.data.toString(),
                                                jsonBody: result.data,
                                              );
                                            } on FirebaseFunctionsException catch (error) {
                                              _model.sendrep =
                                                  SendRelationshipRequestCloudFunctionCallResponse(
                                                errorCode: error.code,
                                                succeeded: false,
                                              );
                                            }

                                            FFAppState().draftPartnerLoveCode =
                                                '\"\"';
                                            FFAppState().draftHasPartnerCode =
                                                false;
                                            safeSetState(() {});

                                            context.goNamedAuth(
                                              S6PhotoWidget.routeName,
                                              context.mounted,
                                              extra: <String, dynamic>{
                                                '__transition_info__':
                                                    TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                      PageTransitionType.fade,
                                                ),
                                              },
                                            );
                                          } else {
                                            context.goNamedAuth(
                                              S6PhotoWidget.routeName,
                                              context.mounted,
                                              extra: <String, dynamic>{
                                                '__transition_info__':
                                                    TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                      PageTransitionType.fade,
                                                ),
                                              },
                                            );
                                          }

                                          safeSetState(() {});
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
                                              begin: AlignmentDirectional(
                                                  0.0, -1.0),
                                              end: AlignmentDirectional(0, 1.0),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(999.0),
                                            border: Border.all(
                                              width: 1.0,
                                            ),
                                          ),
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '56nr7xhv' /* Create Account 🩷 */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMediumFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 18.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    shadows: [
                                                      Shadow(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        offset:
                                                            Offset(2.0, 2.0),
                                                        blurRadius: 2.0,
                                                      )
                                                    ],
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .titleMediumIsCustom,
                                                  ),
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
                        ].divide(SizedBox(height: 32.0)),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 10.0, 16.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await launchURL('https://gettogly.com/privacy/');
                          },
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '2k3ozef6' /* By signing up, you agree to Te... */,
                            ),
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodySmallFamily,
                                  color: FlutterFlowTheme.of(context).accent1,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  decoration: TextDecoration.underline,
                                  shadows: [
                                    Shadow(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 2.0,
                                    ),
                                    Shadow(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 2.0,
                                    )
                                  ],
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodySmallIsCustom,
                                ),
                          ),
                        ),
                      ),
                    ],
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
