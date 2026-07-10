import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'connect_v2_model.dart';
export 'connect_v2_model.dart';

/// Design a visually warm, inviting, and modern screen called “Partner
/// Connect” for the relationship app Togetherly.
///
/// The layout should match the app’s design system: soft gradients (lavender,
/// pastel purple, beige), rounded elements, soft shadows, and an emotionally
/// friendly tone. Do not include any backend logic – focus on design only.
///
/// 🔝 Top Section
/// Title centered at the top: "Connect with Your Partner"
///
/// Subtitle:
/// “Enter your partner’s code or share yours to connect”
///
/// 🤝 Partner Connection Section
/// Use a centered card or container with the following layout (vertical
/// stack):
///
/// ➤ Your Code Box
/// Rounded container with light background
///
/// Label: “Your Code”
///
/// Inside: Display a generated code (placeholder like 8H2K9P)
///
/// Include a copy icon button next to the code field
/// (e.g. to allow the user to copy their code)
///
/// ➤ Divider Line
/// Horizontal line or text divider: “or” with subtle styling
///
/// ➤ Partner Code Input Field
/// Label: “Enter Partner's Code”
///
/// Rounded text input box with placeholder: Enter code here...
///
/// 🔘 Connect Button
/// Large, rounded CTA button
/// Text: “Connect Now”
///
/// Use Togetherly’s primary accent color (lavender or soft purple)
///
/// 💡 Optional Info Box
/// Below the button, show a small note with icon (i.e. info or question
/// mark):
/// “Once connected, you’ll both appear on each other’s dashboard.”
///
/// 🎨 Style Guidelines
/// Background: soft beige or lavender gradient
///
/// Use rounded cards/containers with gentle shadows
///
/// Fonts: Poppins, Nunito, or Inter
///
/// Icons: minimal, modern (copy icon, info icon)
///
/// Spacing: well-padded layout with centered alignment
///
/// Maintain UI consistency with the rest of the app (e.g. buttons, colors,
/// borders)
///
/// This page should feel minimal but emotionally engaging – clear, welcoming,
/// and intuitive for couples to start their Togetherly journey.
class ConnectV2Widget extends StatefulWidget {
  const ConnectV2Widget({super.key});

  static String routeName = 'ConnectV2';
  static String routePath = '/connectV2';

  @override
  State<ConnectV2Widget> createState() => _ConnectV2WidgetState();
}

class _ConnectV2WidgetState extends State<ConnectV2Widget> {
  late ConnectV2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConnectV2Model());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'ConnectV2'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.pendingRequest = await queryRelationshipRequestsRecordOnce(
        queryBuilder: (relationshipRequestsRecord) => relationshipRequestsRecord
            .where(
              'target_id',
              isEqualTo: currentUserUid,
            )
            .where(
              'status',
              isEqualTo: 'pending',
            ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      _model.initiatorUserData = await queryPublicUsersRecordOnce(
        queryBuilder: (publicUsersRecord) => publicUsersRecord.where(
          'uid',
          isEqualTo: _model.pendingRequest?.initiatorId,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      if (_model.pendingRequest != null) {
        _model.hasPendingRequest = true;
        safeSetState(() {});
      } else {
        _model.hasPendingRequest = false;
        safeSetState(() {});
      }
    });

    _model.partnerCodeInputTextController ??= TextEditingController();
    _model.partnerCodeInputFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UsersRecord>>(
      stream: queryUsersRecord(
        queryBuilder: (usersRecord) => usersRecord.where(
          'uid',
          isEqualTo: currentUserUid,
        ),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFFF8F6F3),
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<UsersRecord> connectV2UsersRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final connectV2UsersRecord = connectV2UsersRecordList.isNotEmpty
            ? connectV2UsersRecordList.first
            : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFFF8F6F3),
            appBar: AppBar(
              backgroundColor: Color(0x00FFFFFF),
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 12.0,
                  borderWidth: 1.0,
                  buttonSize: 44.0,
                  fillColor: Color(0xFFF5F3F8),
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Color(0xFF6B5B95),
                    size: 20.0,
                  ),
                  onPressed: () async {
                    context.pushNamed(ProfilePageWidget.routeName);
                  },
                ),
              ),
              title: Text(
                FFLocalizations.of(context).getText(
                  'juxtj1mh' /* Partner Connect */,
                ),
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                      color: Color(0xFF4A4458),
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).titleLargeIsCustom,
                    ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: StreamBuilder<List<PublicUsersRecord>>(
                stream: queryPublicUsersRecord(
                  queryBuilder: (publicUsersRecord) => publicUsersRecord.where(
                    'uid',
                    isEqualTo: currentUserUid,
                  ),
                  singleRecord: true,
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    );
                  }
                  List<PublicUsersRecord> containerPublicUsersRecordList =
                      snapshot.data!;
                  final containerPublicUsersRecord =
                      containerPublicUsersRecordList.isNotEmpty
                          ? containerPublicUsersRecordList.first
                          : null;

                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFF8F6F3),
                          Color(0xFFE8E4F0),
                          Color(0xFFF0EBF5)
                        ],
                        stops: [0.0, 0.3, 1.0],
                        begin: AlignmentDirectional(1.0, 1.0),
                        end: AlignmentDirectional(-1.0, -1.0),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 32.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    '9d7myf4t' /* Connect with Your Partner */,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .headlineLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .headlineLargeFamily,
                                        color: Color(0xFF4A4458),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .headlineLargeIsCustom,
                                      ),
                                ),
                                if (valueOrDefault(
                                            currentUserDocument?.relationshipId,
                                            '') ==
                                        '')
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: AuthUserStreamWidget(
                                      builder: (context) => Text(
                                        FFLocalizations.of(context).getText(
                                          'ucodv1h9' /* Send a connection request by e... */,
                                        ),
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLargeFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              letterSpacing: 0.0,
                                              lineHeight: 1.4,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyLargeIsCustom,
                                            ),
                                      ),
                                    ),
                                  ),
                              ].divide(SizedBox(height: 12.0)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(28.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 20.0,
                                      color: Color(0x1A9B8FB5),
                                      offset: Offset(
                                        0.0,
                                        8.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (valueOrDefault<bool>(
                                            (_model.pendingRequest?.status !=
                                                        null &&
                                                    _model.pendingRequest
                                                            ?.status !=
                                                        '') &&
                                                (valueOrDefault(
                                                            currentUserDocument
                                                                ?.relationshipId,
                                                            '') ==
                                                        ''),
                                            false,
                                          ))
                                            AuthUserStreamWidget(
                                              builder: (context) => Container(
                                                width: 273.0,
                                                height: 335.2,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                                child: StreamBuilder<
                                                    List<
                                                        RelationshipViewsRecord>>(
                                                  stream:
                                                      queryRelationshipViewsRecord(
                                                    queryBuilder:
                                                        (relationshipViewsRecord) =>
                                                            relationshipViewsRecord
                                                                .where(
                                                      'uid',
                                                      isEqualTo: currentUserUid,
                                                    ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50.0,
                                                          height: 50.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<RelationshipViewsRecord>
                                                        columnRelationshipViewsRecordList =
                                                        snapshot.data!;
                                                    final columnRelationshipViewsRecord =
                                                        columnRelationshipViewsRecordList
                                                                .isNotEmpty
                                                            ? columnRelationshipViewsRecordList
                                                                .first
                                                            : null;

                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            '4j6lwr0m' /* Status */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMediumFamily,
                                                                color: Color(
                                                                    0xFF4A4458),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMediumIsCustom,
                                                              ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        10.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                '804633h6' /* request received from: */,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    fontSize:
                                                                        13.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .bodyMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        if (containerPublicUsersRecord
                                                                    ?.photoUrl !=
                                                                null &&
                                                            containerPublicUsersRecord
                                                                    ?.photoUrl !=
                                                                '')
                                                          Container(
                                                            width: 58.0,
                                                            height: 58.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24.0),
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                                width: 1.0,
                                                              ),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24.0),
                                                              child:
                                                                  Image.network(
                                                                _model
                                                                    .initiatorUserData!
                                                                    .photoUrl,
                                                                width: 58.0,
                                                                height: 58.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  16.0),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFF5F3F8),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0),
                                                              border:
                                                                  Border.all(
                                                                color: Color(
                                                                    0xFFE8E4F0),
                                                                width: 1.0,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          12.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        _model
                                                                            .initiatorUserData
                                                                            ?.name,
                                                                        'StatusName',
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).bodyMediumIsCustom,
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
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      15.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              try {
                                                                final result = await FirebaseFunctions
                                                                        .instanceFor(
                                                                            region:
                                                                                'europe-west3')
                                                                    .httpsCallable(
                                                                        'acceptRelationshipRequest')
                                                                    .call({
                                                                  "requestid": _model
                                                                      .pendingRequest
                                                                      ?.reference
                                                                      .id,
                                                                });
                                                                _model.cloudFunctionq9k =
                                                                    AcceptRelationshipRequestCloudFunctionCallResponse(
                                                                  data: CFResultStruct
                                                                      .fromMap(
                                                                          result
                                                                              .data),
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
                                                                _model.cloudFunctionq9k =
                                                                    AcceptRelationshipRequestCloudFunctionCallResponse(
                                                                  errorCode:
                                                                      error
                                                                          .code,
                                                                  succeeded:
                                                                      false,
                                                                );
                                                              }

                                                              if (_model
                                                                  .cloudFunctionq9k!
                                                                  .data!
                                                                  .ok) {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      _model
                                                                          .cloudFunctionz3i!
                                                                          .data!
                                                                          .message,
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
                                                              }

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              '50hdwxzl' /* Accept */,
                                                            ),
                                                            options:
                                                                FFButtonOptions(
                                                              width: double
                                                                  .infinity,
                                                              height: 56.0,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).titleMediumFamily,
                                                                        color: Colors
                                                                            .white,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        useGoogleFonts:
                                                                            !FlutterFlowTheme.of(context).titleMediumIsCustom,
                                                                      ),
                                                              elevation: 0.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                          ),
                                                        ),
                                                        FFButtonWidget(
                                                          onPressed: () async {
                                                            _model.incomingRequest =
                                                                await queryRelationshipRequestsRecordOnce(
                                                              queryBuilder:
                                                                  (relationshipRequestsRecord) =>
                                                                      relationshipRequestsRecord
                                                                          .where(
                                                                            'target_id',
                                                                            isEqualTo:
                                                                                currentUserUid,
                                                                          )
                                                                          .where(
                                                                            'status',
                                                                            isEqualTo:
                                                                                'pending',
                                                                          ),
                                                              singleRecord:
                                                                  true,
                                                            ).then((s) => s
                                                                    .firstOrNull);
                                                            if (_model.incomingRequest
                                                                        ?.status !=
                                                                    null &&
                                                                _model.incomingRequest
                                                                        ?.status !=
                                                                    '') {
                                                              await _model
                                                                  .incomingRequest!
                                                                  .reference
                                                                  .delete();
                                                              if (valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.appLanguage,
                                                                      '') ==
                                                                  'en') {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Request was rejected and removed!',
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
                                                              } else if (valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.appLanguage,
                                                                      '') ==
                                                                  'de') {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Die Anfrage wurde abgelehnt und entfernt!',
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
                                                              } else if (valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.appLanguage,
                                                                      '') ==
                                                                  'es') {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      '¡La solicitud fue rechazada y eliminada!',
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
                                                              }

                                                              context.pushNamed(
                                                                  ProfilePageWidget
                                                                      .routeName);
                                                            } else {
                                                              if (valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.appLanguage,
                                                                      '') ==
                                                                  'en') {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'No requests to reject found!',
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
                                                              } else if (valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.appLanguage,
                                                                      '') ==
                                                                  'de') {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Es wurde keine aktive Anfrage gefunden!',
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
                                                              } else if (valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.appLanguage,
                                                                      '') ==
                                                                  'es') {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'No se encontró nada!',
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
                                                              }
                                                            }

                                                            safeSetState(() {});
                                                          },
                                                          text: FFLocalizations
                                                                  .of(context)
                                                              .getText(
                                                            'mk44q5u7' /* Reject */,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            width:
                                                                double.infinity,
                                                            height: 56.0,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .tertiary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleMediumFamily,
                                                                      color: Colors
                                                                          .white,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .titleMediumIsCustom,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                        ].divide(SizedBox(height: 12.0)),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Container(
                                          width: 120.0,
                                          height: 1.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFE8E4F0),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 40.0,
                                                  height: 1.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFE8E4F0),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 12.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'he7cuxiu' /* or */,
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
                                                              Color(0xFF9A9AAA),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 40.0,
                                                  height: 1.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFE8E4F0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (valueOrDefault(
                                                  currentUserDocument
                                                      ?.relationshipId,
                                                  '') !=
                                              '')
                                        AuthUserStreamWidget(
                                          builder: (context) => StreamBuilder<
                                              List<RelationshipViewsRecord>>(
                                            stream:
                                                queryRelationshipViewsRecord(
                                              queryBuilder:
                                                  (relationshipViewsRecord) =>
                                                      relationshipViewsRecord
                                                          .where(
                                                'uid',
                                                isEqualTo: currentUserUid,
                                              ),
                                              singleRecord: true,
                                            ),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 50.0,
                                                    height: 50.0,
                                                    child:
                                                        CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              List<RelationshipViewsRecord>
                                                  columnRelationshipViewsRecordList =
                                                  snapshot.data!;
                                              final columnRelationshipViewsRecord =
                                                  columnRelationshipViewsRecordList
                                                          .isNotEmpty
                                                      ? columnRelationshipViewsRecordList
                                                          .first
                                                      : null;

                                              return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 80.0,
                                                    height: 80.0,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Color(0xFFB794D1),
                                                          Color(0xFF9B7BC7)
                                                        ],
                                                        stops: [0.0, 1.0],
                                                        begin:
                                                            AlignmentDirectional(
                                                                1.0, -1.0),
                                                        end:
                                                            AlignmentDirectional(
                                                                -1.0, 1.0),
                                                      ),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Icon(
                                                        Icons.favorite_rounded,
                                                        color: Colors.white,
                                                        size: 40.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'vmxm8g2w' /* you are currently connected wi... */,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleLargeFamily,
                                                          color:
                                                              Color(0xFF6B4E8A),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLargeIsCustom,
                                                        ),
                                                  ),
                                                  if (columnRelationshipViewsRecord
                                                              ?.partnerPhotoUrl !=
                                                          null &&
                                                      columnRelationshipViewsRecord
                                                              ?.partnerPhotoUrl !=
                                                          '')
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.network(
                                                        columnRelationshipViewsRecord!
                                                            .partnerPhotoUrl,
                                                        width: 120.0,
                                                        height: 120.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFF5F3F8),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.0),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFE8E4F0),
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    12.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      columnRelationshipViewsRecord
                                                                          ?.partnerName,
                                                                      'loading....',
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(32.0, 0.0,
                                                                32.0, 40.0),
                                                    child: Lottie.asset(
                                                      'assets/jsons/Happy_International_Polar_Bear_Day!.json',
                                                      width: 119.26,
                                                      height: 116.3,
                                                      fit: BoxFit.contain,
                                                      animate: true,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 15.0),
                                                    child: FFButtonWidget(
                                                      onPressed: () async {
                                                        context.goNamed(
                                                          HomeWidget.routeName,
                                                          extra: <String,
                                                              dynamic>{
                                                            '__transition_info__':
                                                                TransitionInfo(
                                                              hasTransition:
                                                                  true,
                                                              transitionType:
                                                                  PageTransitionType
                                                                      .fade,
                                                            ),
                                                          },
                                                        );

                                                        await Future.delayed(
                                                          Duration(
                                                            milliseconds: 300,
                                                          ),
                                                        );
                                                      },
                                                      text: FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '4eb0i0ss' /* Back to home */,
                                                      ),
                                                      options: FFButtonOptions(
                                                        width: 150.0,
                                                        height: 30.0,
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .success,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily,
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMediumIsCustom,
                                                                ),
                                                        elevation: 0.0,
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 16.0)),
                                              );
                                            },
                                          ),
                                        ),
                                      if (valueOrDefault(
                                                  currentUserDocument
                                                      ?.relationshipId,
                                                  '') ==
                                              '')
                                        AuthUserStreamWidget(
                                          builder: (context) => Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'qe2eex57' /* Your love code */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .titleMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMediumFamily,
                                                      color: Color(0xFF4A4458),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMediumIsCustom,
                                                    ),
                                              ),
                                              if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.relationshipId,
                                                          '') ==
                                                      '')
                                                Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFF5F3F8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xFFE8E4F0),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(12.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          AutoSizeText(
                                                            valueOrDefault(
                                                                currentUserDocument
                                                                    ?.loveCode,
                                                                ''),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineSmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmallFamily,
                                                                  color: Color(
                                                                      0xFF6B5B95),
                                                                  letterSpacing:
                                                                      2.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmallIsCustom,
                                                                ),
                                                          ),
                                                          FlutterFlowIconButton(
                                                            borderRadius: 12.0,
                                                            buttonSize: 44.0,
                                                            fillColor: Color(
                                                                0xFFE8E4F0),
                                                            icon: Icon(
                                                              Icons
                                                                  .content_copy_rounded,
                                                              color: Color(
                                                                  0xFF6B5B95),
                                                              size: 20.0,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              await Clipboard.setData(
                                                                  ClipboardData(
                                                                      text: valueOrDefault(
                                                                          currentUserDocument
                                                                              ?.loveCode,
                                                                          '')));
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ].divide(SizedBox(height: 12.0)),
                                          ),
                                        ),
                                      if (valueOrDefault(
                                                  currentUserDocument
                                                      ?.relationshipId,
                                                  '') ==
                                              '')
                                        AuthUserStreamWidget(
                                          builder: (context) => Text(
                                            FFLocalizations.of(context).getText(
                                              'kdzt0v8q' /*  Tap the copy icon to copy you... */,
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
                                                      .primary,
                                                  fontSize: 12.0,
                                                  letterSpacing: 0.0,
                                                  fontStyle: FontStyle.italic,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Container(
                                          width: 120.0,
                                          height: 1.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFE8E4F0),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 40.0,
                                                  height: 1.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFE8E4F0),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 12.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '452v68fq' /* or */,
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
                                                              Color(0xFF9A9AAA),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 40.0,
                                                  height: 1.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFE8E4F0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (valueOrDefault(
                                                  currentUserDocument
                                                      ?.relationshipId,
                                                  '') ==
                                              '')
                                        AuthUserStreamWidget(
                                          builder: (context) => Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.relationshipId,
                                                          '') ==
                                                      '')
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'vef9gagv' /* Enter the full Partners love c... */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMediumFamily,
                                                        color:
                                                            Color(0xFF4A4458),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleMediumIsCustom,
                                                      ),
                                                ),
                                              Form(
                                                key: _model.formKey,
                                                autovalidateMode:
                                                    AutovalidateMode.disabled,
                                                child: TextFormField(
                                                  controller: _model
                                                      .partnerCodeInputTextController,
                                                  focusNode: _model
                                                      .partnerCodeInputFocusNode,
                                                  autofocus: false,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      '0u59vxie' /* Enter code here... */,
                                                    ),
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          color:
                                                              Color(0xFFB8B8C8),
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFE8E4F0),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFF9B8FB5),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Color(0xFFF5F3F8),
                                                    contentPadding:
                                                        EdgeInsets.all(16.0),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLargeFamily,
                                                        color:
                                                            Color(0xFF4A4458),
                                                        fontSize: 16.0,
                                                        letterSpacing: 1.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyLargeIsCustom,
                                                      ),
                                                  cursorColor:
                                                      Color(0xFF9B8FB5),
                                                  validator: _model
                                                      .partnerCodeInputTextControllerValidator
                                                      .asValidator(context),
                                                  inputFormatters: [
                                                    if (!isAndroid && !isiOS)
                                                      TextInputFormatter
                                                          .withFunction(
                                                              (oldValue,
                                                                  newValue) {
                                                        return TextEditingValue(
                                                          selection: newValue
                                                              .selection,
                                                          text: newValue.text
                                                              .toCapitalization(
                                                                  TextCapitalization
                                                                      .characters),
                                                        );
                                                      }),
                                                  ],
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 12.0)),
                                          ),
                                        ),
                                      if (valueOrDefault(
                                                  currentUserDocument
                                                      ?.relationshipId,
                                                  '') ==
                                              '')
                                        AuthUserStreamWidget(
                                          builder: (context) => FFButtonWidget(
                                            onPressed: () async {
                                              try {
                                                final result = await FirebaseFunctions
                                                        .instanceFor(
                                                            region:
                                                                'europe-west3')
                                                    .httpsCallable(
                                                        'sendRelationshipRequest')
                                                    .call({
                                                  "lovecode": _model
                                                      .partnerCodeInputTextController
                                                      .text,
                                                });
                                                _model.cloudFunctionz3i =
                                                    SendRelationshipRequestCloudFunctionCallResponse(
                                                  data: CFResultStruct.fromMap(
                                                      result.data),
                                                  succeeded: true,
                                                  resultAsString:
                                                      result.data.toString(),
                                                  jsonBody: result.data,
                                                );
                                              } on FirebaseFunctionsException catch (error) {
                                                _model.cloudFunctionz3i =
                                                    SendRelationshipRequestCloudFunctionCallResponse(
                                                  errorCode: error.code,
                                                  succeeded: false,
                                                );
                                              }

                                              if (_model
                                                  .cloudFunctionz3i!.data!.ok) {
                                                safeSetState(() {
                                                  _model
                                                      .partnerCodeInputTextController
                                                      ?.clear();
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      _model.cloudFunctionz3i!
                                                          .data!.message,
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      _model.cloudFunctionz3i!
                                                          .data!.message,
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              }

                                              safeSetState(() {});
                                            },
                                            text: FFLocalizations.of(context)
                                                .getText(
                                              'ncbyil95' /* Send request */,
                                            ),
                                            options: FFButtonOptions(
                                              width: double.infinity,
                                              height: 56.0,
                                              padding: EdgeInsets.all(8.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color: Color(0xFF9B8FB5),
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .titleMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMediumFamily,
                                                    color: Colors.white,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .titleMediumIsCustom,
                                                  ),
                                              elevation: 0.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                          ),
                                        ),
                                      if (valueOrDefault(
                                                  currentUserDocument
                                                      ?.relationshipId,
                                                  '') ==
                                              '')
                                        AuthUserStreamWidget(
                                          builder: (context) => FFButtonWidget(
                                            onPressed: () async {
                                              _model.pendingRequestToCancel =
                                                  await queryRelationshipRequestsRecordOnce(
                                                queryBuilder:
                                                    (relationshipRequestsRecord) =>
                                                        relationshipRequestsRecord
                                                            .where(
                                                              'initiator_id',
                                                              isEqualTo:
                                                                  currentUserUid,
                                                            )
                                                            .where(
                                                              'status',
                                                              isEqualTo:
                                                                  'pending',
                                                            ),
                                                singleRecord: true,
                                              ).then((s) => s.firstOrNull);
                                              try {
                                                final result = await FirebaseFunctions
                                                        .instanceFor(
                                                            region:
                                                                'europe-west3')
                                                    .httpsCallable(
                                                        'cancelRelationshipRequest')
                                                    .call({
                                                  "requestid": _model
                                                      .pendingRequestToCancel!
                                                      .reference
                                                      .id,
                                                });
                                                _model.cloudFunctionzlw =
                                                    CancelRelationshipRequestCloudFunctionCallResponse(
                                                  data: CFResultStruct.fromMap(
                                                      result.data),
                                                  succeeded: true,
                                                  resultAsString:
                                                      result.data.toString(),
                                                  jsonBody: result.data,
                                                );
                                              } on FirebaseFunctionsException catch (error) {
                                                _model.cloudFunctionzlw =
                                                    CancelRelationshipRequestCloudFunctionCallResponse(
                                                  errorCode: error.code,
                                                  succeeded: false,
                                                );
                                              }

                                              if (_model
                                                  .cloudFunctionzlw!.data!.ok) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      _model.cloudFunctionzlw!
                                                          .data!.message,
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              }

                                              safeSetState(() {});
                                            },
                                            text: FFLocalizations.of(context)
                                                .getText(
                                              'cskwlg9s' /* Cancel request */,
                                            ),
                                            options: FFButtonOptions(
                                              width: double.infinity,
                                              height: 56.0,
                                              padding: EdgeInsets.all(8.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiary,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .titleMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMediumFamily,
                                                    color: Colors.white,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .titleMediumIsCustom,
                                                  ),
                                              elevation: 0.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                          ),
                                        ),
                                    ].divide(SizedBox(height: 24.0)),
                                  ),
                                ),
                              ),
                            ),
                            if (valueOrDefault(
                                        currentUserDocument?.relationshipId,
                                        '') ==
                                    '')
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF0EBF5),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 24.0,
                                            height: 24.0,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF9B8FB5),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Icon(
                                                Icons.info_rounded,
                                                color: Colors.white,
                                                size: 14.0,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'w2qeqfh5' /* Once connected, you'll both ap... */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: Color(0xFF6A6A7A),
                                                    letterSpacing: 0.0,
                                                    lineHeight: 1.4,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 12.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ]
                              .divide(SizedBox(height: 32.0))
                              .addToStart(SizedBox(height: 40.0)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
