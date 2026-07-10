import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:firebase_storagelibrary_2sa6k9/app_state.dart'
    as firebase_storagelibrary_2sa6k9_app_state;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'restore_copy_model.dart';
export 'restore_copy_model.dart';

/// Design a modern "Restore Relationship" page matching the app’s clean
/// purple/pink gradient style.
///
/// Content centered on white background with subtle heart icons. Top: bold
/// headline “Don’t lose your story.” Below: image (heart hands), then short
/// description of the 14-day window. Add placeholder [remainingTime] in bold.
/// Show different states: (1) Initiator: card with “Send a reconnect
/// request”, button **Send request**, after sending show “Request sent —
/// waiting…” with **Cancel**. (2) Partner: card “Reconnect request”, text
/// “Your partner asked… Accept?”, buttons side by side: **Reject** (outlined
/// red) and **Accept** (filled purple). (3) Expired: card with clock icon,
/// text “Window expired. Start fresh.” + button **Start new connection**. (4)
/// Rejected: card with broken heart, text “Partner rejected request.” +
/// button **Back to Home**. (5) Restored: card with heart, text “Relationship
/// restored ❤️” + button **Go to Home**. Use rounded corners, shadows,
/// consistent fonts, centered layout.
class RestoreCopyWidget extends StatefulWidget {
  const RestoreCopyWidget({super.key});

  static String routeName = 'RestoreCopy';
  static String routePath = '/restoreCopy';

  @override
  State<RestoreCopyWidget> createState() => _RestoreCopyWidgetState();
}

class _RestoreCopyWidgetState extends State<RestoreCopyWidget> {
  late RestoreCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RestoreCopyModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'RestoreCopy'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if ((valueOrDefault<bool>(currentUserDocument?.restoreRequired, false) ==
              true) &&
          (valueOrDefault(currentUserDocument?.relationshipId, '') != '')) {
        context.goNamed(
          CelebrateWidget.routeName,
          extra: <String, dynamic>{
            '__transition_info__': TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );
      }
    });

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

    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(currentUserReference!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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

        final restoreCopyUsersRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                child: FlutterFlowIconButton(
                  borderColor: FlutterFlowTheme.of(context).alternate,
                  borderRadius: 12.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 20.0,
                  ),
                  onPressed: () async {
                    context.safePop();
                  },
                ),
              ),
              title: Text(
                FFLocalizations.of(context).getText(
                  '3e967nip' /* Restore Relationship */,
                ),
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                      color: FlutterFlowTheme.of(context).primaryText,
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
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple, Color(0xFFE91E63)],
                    stops: [0.1, 0.1],
                    begin: AlignmentDirectional(1.0, -1.0),
                    end: AlignmentDirectional(-1.0, 1.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Opacity(
                              opacity: 0.3,
                              child: Icon(
                                Icons.favorite_rounded,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 48.0,
                              ),
                            ),
                            Text(
                              FFLocalizations.of(context).getText(
                                'myvotqjj' /* Don't lose your story. */,
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .displaySmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .displaySmallFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 28.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .displaySmallIsCustom,
                                  ),
                            ),
                          ].divide(SizedBox(height: 24.0)),
                        ),
                        Container(
                          width: 200.0,
                          height: 200.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.circular(100.0),
                            border: Border.all(
                              color: Color(0xFFFFE0E6),
                              width: 2.0,
                            ),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(80.0),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1520975408777-d189f6edc46d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxM3x8cmVsYXRpb25zaGlwfGVufDB8fHx8MTc1OTA5NzIwN3ww&ixlib=rb-4.1.0&q=80&w=1080',
                                width: 170.0,
                                height: 170.0,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'assets/images/error_image.png',
                                  width: 170.0,
                                  height: 170.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                '4g4x5pio' /* You have a 14 day window to re... */,
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyLargeFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 1.4,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyLargeIsCustom,
                                  ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 40.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'k40vuqyu' /* We believe relationships deser... */,
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyLargeFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      lineHeight: 1.4,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyLargeIsCustom,
                                    ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 20.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Text(
                                    valueOrDefault<String>(
                                      functions.remainingTimeCompact(
                                          currentUserDocument!
                                              .disconnectCooldownUntil!),
                                      'time',
                                    ),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                        Container(
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              AuthUserStreamWidget(
                                builder: (context) => StreamBuilder<
                                    List<ReconnectRequestsRecord>>(
                                  stream: queryReconnectRequestsRecord(
                                    queryBuilder: (reconnectRequestsRecord) =>
                                        reconnectRequestsRecord
                                            .where(
                                              'relationship_id',
                                              isEqualTo: valueOrDefault(
                                                  currentUserDocument
                                                      ?.lastRelationshipId,
                                                  ''),
                                            )
                                            .where(
                                              'initiator_id',
                                              isEqualTo: currentUserUid,
                                            )
                                            .whereIn('status', ['pending']),
                                    limit: 1,
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50.0,
                                          height: 50.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<ReconnectRequestsRecord>
                                        outgoingPendingReconnectRequestsRecordList =
                                        snapshot.data!;

                                    return Container(
                                      decoration: BoxDecoration(),
                                      child: StreamBuilder<
                                          List<ReconnectRequestsRecord>>(
                                        stream: queryReconnectRequestsRecord(
                                          queryBuilder:
                                              (reconnectRequestsRecord) =>
                                                  reconnectRequestsRecord
                                                      .where(
                                                        'relationship_id',
                                                        isEqualTo: valueOrDefault(
                                                            currentUserDocument
                                                                ?.lastRelationshipId,
                                                            ''),
                                                      )
                                                      .where(
                                                        'target_id',
                                                        isEqualTo:
                                                            currentUserUid,
                                                      )
                                                      .whereIn('status',
                                                          ['pending']),
                                          limit: 1,
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
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          List<ReconnectRequestsRecord>
                                              incomingPendingReconnectRequestsRecordList =
                                              snapshot.data!;

                                          return Container(
                                            decoration: BoxDecoration(),
                                            child: StreamBuilder<
                                                List<ReconnectRequestsRecord>>(
                                              stream:
                                                  queryReconnectRequestsRecord(
                                                queryBuilder:
                                                    (reconnectRequestsRecord) =>
                                                        reconnectRequestsRecord
                                                            .where(
                                                              'relationship_id',
                                                              isEqualTo: valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.lastRelationshipId,
                                                                  ''),
                                                            )
                                                            .where(
                                                              'initiator_id',
                                                              isEqualTo:
                                                                  currentUserUid,
                                                            )
                                                            .whereIn('status', [
                                                  'rejected'
                                                ]).orderBy('created_at',
                                                                descending:
                                                                    true),
                                                limit: 1,
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
                                                List<ReconnectRequestsRecord>
                                                    outgoingRejectedReconnectRequestsRecordList =
                                                    snapshot.data!;

                                                return Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20.0),
                                                      topRight:
                                                          Radius.circular(20.0),
                                                      bottomLeft:
                                                          Radius.circular(20.0),
                                                      bottomRight:
                                                          Radius.circular(20.0),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          if ((incomingPendingReconnectRequestsRecordList.length == 0) &&
                                                              (outgoingRejectedReconnectRequestsRecordList
                                                                      .length ==
                                                                  0) &&
                                                              (outgoingPendingReconnectRequestsRecordList
                                                                      .length ==
                                                                  0) &&
                                                              (currentUserDocument!
                                                                      .disconnectCooldownUntil!
                                                                      .secondsSinceEpoch >
                                                                  getCurrentTimestamp
                                                                      .secondsSinceEpoch))
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          24.0),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xFF121212),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                          8.0,
                                                                      color: Color(
                                                                          0x1A000000),
                                                                      offset:
                                                                          Offset(
                                                                        0.0,
                                                                        2.0,
                                                                      ),
                                                                    )
                                                                  ],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              24.0),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              16.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          Icon(
                                                                            Icons.arrow_forward_rounded,
                                                                            color:
                                                                                Colors.purple,
                                                                            size:
                                                                                28.0,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'nqwmstyb' /* Send a reconnect request */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                                                                                        color: Colors.white,
                                                                                        fontSize: 20.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).titleLargeIsCustom,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'dit29fn0' /* Let your partner know you woul... */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                        color: Color(0xFFAEB4C0),
                                                                                        fontSize: 15.0,
                                                                                        letterSpacing: 0.0,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                      ),
                                                                                ),
                                                                                ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                  child: Image.network(
                                                                                    'https://images.unsplash.com/photo-1600299637171-d174627135ee?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw3fHxodWd8ZW58MHx8fHwxNzU5MTA3MzM1fDA&ixlib=rb-4.1.0&q=80&w=1080',
                                                                                    width: 200.0,
                                                                                    height: 200.0,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ].divide(SizedBox(height: 8.0)),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 16.0)),
                                                                      ),
                                                                      FFButtonWidget(
                                                                        onPressed:
                                                                            () async {
                                                                          if (outgoingRejectedReconnectRequestsRecordList.length >
                                                                              0) {
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text(
                                                                                  'You’ve already sent a request.',
                                                                                  style: TextStyle(
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                  ),
                                                                                ),
                                                                                duration: Duration(milliseconds: 4000),
                                                                                backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                              ),
                                                                            );
                                                                          } else {
                                                                            try {
                                                                              final result = await FirebaseFunctions.instanceFor(region: 'europe-west3').httpsCallable('createReconnectRequest').call({
                                                                                "relationshipid": currentUserDocument!.lastRelationshipRef!.id,
                                                                              });
                                                                              _model.cloudFunctionni1 = CreateReconnectRequestCloudFunctionCallResponse(
                                                                                data: CFResultStruct.fromMap(result.data),
                                                                                succeeded: true,
                                                                                resultAsString: result.data.toString(),
                                                                                jsonBody: result.data,
                                                                              );
                                                                            } on FirebaseFunctionsException catch (error) {
                                                                              _model.cloudFunctionni1 = CreateReconnectRequestCloudFunctionCallResponse(
                                                                                errorCode: error.code,
                                                                                succeeded: false,
                                                                              );
                                                                            }

                                                                            if (_model.cloudFunctionni1?.data?.ok ==
                                                                                true) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  content: Text(
                                                                                    valueOrDefault<String>(
                                                                                      _model.cloudFunctionni1?.data?.message,
                                                                                      'Request sent',
                                                                                    ),
                                                                                    style: TextStyle(
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                    ),
                                                                                  ),
                                                                                  duration: Duration(milliseconds: 4000),
                                                                                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                ),
                                                                              );
                                                                              logFirebaseEvent(
                                                                                'relationship_restore_requested',
                                                                                parameters: {
                                                                                  'role': 'initiator',
                                                                                  'source': 'restore_page',
                                                                                  'method': 'cooldown_restore',
                                                                                },
                                                                              );
                                                                              _model.partnerUserRecord = await queryUsersRecordOnce(
                                                                                queryBuilder: (usersRecord) => usersRecord.where(
                                                                                  'uid',
                                                                                  isEqualTo: valueOrDefault(currentUserDocument?.partnerUID, ''),
                                                                                ),
                                                                                singleRecord: true,
                                                                              ).then((s) => s.firstOrNull);
                                                                              try {
                                                                                final result = await FirebaseFunctions.instanceFor(region: 'europe-west3').httpsCallable('sendPartnerPush').call({
                                                                                  "type": 'reconnect_request_received',
                                                                                  "route": 'restore',
                                                                                  "audience": 'partner',
                                                                                });
                                                                                _model.cloudFunction6oy = SendPartnerPushCloudFunctionCallResponse(
                                                                                  data: result.data,
                                                                                  succeeded: true,
                                                                                  resultAsString: result.data.toString(),
                                                                                  jsonBody: result.data,
                                                                                );
                                                                              } on FirebaseFunctionsException catch (error) {
                                                                                _model.cloudFunction6oy = SendPartnerPushCloudFunctionCallResponse(
                                                                                  errorCode: error.code,
                                                                                  succeeded: false,
                                                                                );
                                                                              }
                                                                            } else {
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  content: Text(
                                                                                    valueOrDefault<String>(
                                                                                      _model.cloudFunctionni1?.data?.message,
                                                                                      'Something went wrong',
                                                                                    ),
                                                                                    style: TextStyle(
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                    ),
                                                                                  ),
                                                                                  duration: Duration(milliseconds: 4000),
                                                                                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                ),
                                                                              );
                                                                            }
                                                                          }

                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        text: FFLocalizations.of(context)
                                                                            .getText(
                                                                          'q7vkhcp7' /* Send request */,
                                                                        ),
                                                                        options:
                                                                            FFButtonOptions(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              48.0,
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          color:
                                                                              Colors.purple,
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                color: Colors.white,
                                                                                fontSize: 16.0,
                                                                                letterSpacing: 0.0,
                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                              ),
                                                                          elevation:
                                                                              0.0,
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.transparent,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(12.0),
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            16.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          if (outgoingPendingReconnectRequestsRecordList
                                                                  .length >
                                                              0)
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          24.0),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xFF121212),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                          8.0,
                                                                      color: Color(
                                                                          0x1A000000),
                                                                      offset:
                                                                          Offset(
                                                                        0.0,
                                                                        2.0,
                                                                      ),
                                                                    )
                                                                  ],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              24.0),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              16.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          Icon(
                                                                            Icons.access_time_rounded,
                                                                            color:
                                                                                Color(0xFFFFC107),
                                                                            size:
                                                                                28.0,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'c9cqxckt' /* Request sent 
waiting… */
                                                                                    ,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                                                                                        color: Colors.white,
                                                                                        fontSize: 22.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).titleLargeIsCustom,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    '19gk1g9o' /* Your partner will be notified */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                        color: Color(0xFFAEB4C0),
                                                                                        fontSize: 15.0,
                                                                                        letterSpacing: 0.0,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                      ),
                                                                                ),
                                                                              ].divide(SizedBox(height: 8.0)),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 16.0)),
                                                                      ),
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        child: Image
                                                                            .network(
                                                                          'https://images.unsplash.com/photo-1506126944674-00c6c192e0a3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMnx8ZnVubnl8ZW58MHx8fHwxNzU5MTA4ODA3fDA&ixlib=rb-4.1.0&q=80&w=1080',
                                                                          width:
                                                                              200.0,
                                                                          height:
                                                                              200.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                      FFButtonWidget(
                                                                        onPressed:
                                                                            () async {
                                                                          var confirmDialogResponse = await showDialog<bool>(
                                                                                context: context,
                                                                                builder: (alertDialogContext) {
                                                                                  return AlertDialog(
                                                                                    title: Text('Cancel request?'),
                                                                                    content: Text('Your reconnect request will be withdrawn.'),
                                                                                    actions: [
                                                                                      TextButton(
                                                                                        onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                        child: Text('Keep waiting'),
                                                                                      ),
                                                                                      TextButton(
                                                                                        onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                        child: Text('Cancel request'),
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                },
                                                                              ) ??
                                                                              false;
                                                                          if (confirmDialogResponse) {
                                                                            try {
                                                                              final result = await FirebaseFunctions.instanceFor(region: 'europe-west3').httpsCallable('cancelReconnectRequest').call({
                                                                                "requestId": outgoingPendingReconnectRequestsRecordList.firstOrNull!.reference.id,
                                                                                "relationshipid": valueOrDefault(currentUserDocument?.lastRelationshipId, ''),
                                                                              });
                                                                              _model.cloudFunction4rw = CancelReconnectRequestCloudFunctionCallResponse(
                                                                                data: CFResultStruct.fromMap(result.data),
                                                                                succeeded: true,
                                                                                resultAsString: result.data.toString(),
                                                                                jsonBody: result.data,
                                                                              );
                                                                            } on FirebaseFunctionsException catch (error) {
                                                                              _model.cloudFunction4rw = CancelReconnectRequestCloudFunctionCallResponse(
                                                                                errorCode: error.code,
                                                                                succeeded: false,
                                                                              );
                                                                            }

                                                                            if (_model.cloudFunction4rw!.data!.ok) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  content: Text(
                                                                                    _model.cloudFunction4rw!.data!.message,
                                                                                    style: TextStyle(
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                    ),
                                                                                  ),
                                                                                  duration: Duration(milliseconds: 4000),
                                                                                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                ),
                                                                              );
                                                                              try {
                                                                                final result = await FirebaseFunctions.instanceFor(region: 'europe-west3').httpsCallable('sendPartnerPush').call({
                                                                                  "type": 'reconnect_request_withdrawn',
                                                                                  "route": 'restore',
                                                                                  "audience": 'partner',
                                                                                });
                                                                                _model.cloudFunction6oym = SendPartnerPushCloudFunctionCallResponse(
                                                                                  data: result.data,
                                                                                  succeeded: true,
                                                                                  resultAsString: result.data.toString(),
                                                                                  jsonBody: result.data,
                                                                                );
                                                                              } on FirebaseFunctionsException catch (error) {
                                                                                _model.cloudFunction6oym = SendPartnerPushCloudFunctionCallResponse(
                                                                                  errorCode: error.code,
                                                                                  succeeded: false,
                                                                                );
                                                                              }
                                                                            } else {
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  content: Text(
                                                                                    _model.cloudFunction4rw!.data!.message,
                                                                                    style: TextStyle(
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                    ),
                                                                                  ),
                                                                                  duration: Duration(milliseconds: 4000),
                                                                                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                ),
                                                                              );
                                                                            }
                                                                          } else {
                                                                            Navigator.pop(context);
                                                                          }

                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        text: FFLocalizations.of(context)
                                                                            .getText(
                                                                          'n5kmym38' /* Cancel */,
                                                                        ),
                                                                        options:
                                                                            FFButtonOptions(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              48.0,
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          color:
                                                                              Colors.transparent,
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                color: Colors.red,
                                                                                fontSize: 16.0,
                                                                                letterSpacing: 0.0,
                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                              ),
                                                                          elevation:
                                                                              0.0,
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.red,
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(12.0),
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            16.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          if (incomingPendingReconnectRequestsRecordList
                                                                  .length >
                                                              0)
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          24.0),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xFF121212),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                          8.0,
                                                                      color: Color(
                                                                          0x1A000000),
                                                                      offset:
                                                                          Offset(
                                                                        0.0,
                                                                        2.0,
                                                                      ),
                                                                    )
                                                                  ],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              24.0),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              16.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          Icon(
                                                                            Icons.favorite_rounded,
                                                                            color:
                                                                                Colors.purple,
                                                                            size:
                                                                                28.0,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    's1lrs7ym' /* Reconnect request */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                                                                                        color: Colors.white,
                                                                                        fontSize: 20.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).titleLargeIsCustom,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'mrl7t7jh' /* Accept the restore request fro... */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                        color: Color(0xFFAEB4C0),
                                                                                        fontSize: 15.0,
                                                                                        letterSpacing: 0.0,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                      ),
                                                                                ),
                                                                              ].divide(SizedBox(height: 8.0)),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 16.0)),
                                                                      ),
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        child: Image
                                                                            .network(
                                                                          'https://images.unsplash.com/photo-1453227588063-bb302b62f50b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMnx8Y3V0ZXxlbnwwfHx8fDE3NTkxMDg2NjJ8MA&ixlib=rb-4.1.0&q=80&w=1080',
                                                                          width:
                                                                              200.0,
                                                                          height:
                                                                              200.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          Expanded(
                                                                            child:
                                                                                FFButtonWidget(
                                                                              onPressed: () async {
                                                                                try {
                                                                                  final result = await FirebaseFunctions.instanceFor(region: 'europe-west3').httpsCallable('rejectReconnectRequest').call({
                                                                                    "requestId": incomingPendingReconnectRequestsRecordList.elementAtOrNull(0)!.reference.id,
                                                                                  });
                                                                                  _model.cloudFunctionved = RejectReconnectRequestCloudFunctionCallResponse(
                                                                                    data: CFResultStruct.fromMap(result.data),
                                                                                    succeeded: true,
                                                                                    resultAsString: result.data.toString(),
                                                                                    jsonBody: result.data,
                                                                                  );
                                                                                } on FirebaseFunctionsException catch (error) {
                                                                                  _model.cloudFunctionved = RejectReconnectRequestCloudFunctionCallResponse(
                                                                                    errorCode: error.code,
                                                                                    succeeded: false,
                                                                                  );
                                                                                }

                                                                                if (_model.cloudFunctionved!.data!.ok) {
                                                                                  logFirebaseEvent(
                                                                                    'relationship_restore_decision',
                                                                                    parameters: {
                                                                                      'role': 'receiver',
                                                                                      'result': 'rejected',
                                                                                      'source': 'restore_page',
                                                                                      'method': 'cooldown_restore',
                                                                                    },
                                                                                  );
                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                    SnackBar(
                                                                                      content: Text(
                                                                                        _model.cloudFunctionved!.data!.message,
                                                                                        style: TextStyle(
                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                        ),
                                                                                      ),
                                                                                      duration: Duration(milliseconds: 4000),
                                                                                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                    ),
                                                                                  );
                                                                                  _model.partnerUserRecord1 = await queryUsersRecordOnce(
                                                                                    queryBuilder: (usersRecord) => usersRecord.where(
                                                                                      'uid',
                                                                                      isEqualTo: valueOrDefault(currentUserDocument?.partnerUID, ''),
                                                                                    ),
                                                                                    singleRecord: true,
                                                                                  ).then((s) => s.firstOrNull);
                                                                                  try {
                                                                                    final result = await FirebaseFunctions.instanceFor(region: 'europe-west3').httpsCallable('sendPartnerPush').call({
                                                                                      "type": 'reconnect_request_rejected',
                                                                                      "route": 'restore',
                                                                                      "audience": 'partner',
                                                                                    });
                                                                                    _model.cloudFunction6oya = SendPartnerPushCloudFunctionCallResponse(
                                                                                      data: result.data,
                                                                                      succeeded: true,
                                                                                      resultAsString: result.data.toString(),
                                                                                      jsonBody: result.data,
                                                                                    );
                                                                                  } on FirebaseFunctionsException catch (error) {
                                                                                    _model.cloudFunction6oya = SendPartnerPushCloudFunctionCallResponse(
                                                                                      errorCode: error.code,
                                                                                      succeeded: false,
                                                                                    );
                                                                                  }
                                                                                } else {
                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                    SnackBar(
                                                                                      content: Text(
                                                                                        _model.cloudFunctionved!.data!.message,
                                                                                        style: TextStyle(
                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                        ),
                                                                                      ),
                                                                                      duration: Duration(milliseconds: 4000),
                                                                                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                    ),
                                                                                  );
                                                                                }

                                                                                safeSetState(() {});
                                                                              },
                                                                              text: FFLocalizations.of(context).getText(
                                                                                't82wh7n5' /* Reject */,
                                                                              ),
                                                                              options: FFButtonOptions(
                                                                                height: 48.0,
                                                                                padding: EdgeInsets.all(8.0),
                                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                color: Colors.transparent,
                                                                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                      color: Colors.red,
                                                                                      fontSize: 16.0,
                                                                                      letterSpacing: 0.0,
                                                                                      useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                                    ),
                                                                                elevation: 0.0,
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.red,
                                                                                  width: 2.0,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(12.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                FFButtonWidget(
                                                                              onPressed: () async {
                                                                                context.goNamed(
                                                                                  CelebrateWidget.routeName,
                                                                                  extra: <String, dynamic>{
                                                                                    '__transition_info__': TransitionInfo(
                                                                                      hasTransition: true,
                                                                                      transitionType: PageTransitionType.fade,
                                                                                    ),
                                                                                  },
                                                                                );

                                                                                await Future.delayed(
                                                                                  Duration(
                                                                                    milliseconds: 1000,
                                                                                  ),
                                                                                );
                                                                                try {
                                                                                  final result = await FirebaseFunctions.instanceFor(region: 'europe-west3').httpsCallable('acceptReconnectRequest').call({
                                                                                    "requestId": incomingPendingReconnectRequestsRecordList.elementAtOrNull(0)!.reference.id,
                                                                                  });
                                                                                  _model.cloudFunction2y4 = AcceptReconnectRequestCloudFunctionCallResponse(
                                                                                    data: CFResultStruct.fromMap(result.data),
                                                                                    succeeded: true,
                                                                                    resultAsString: result.data.toString(),
                                                                                    jsonBody: result.data,
                                                                                  );
                                                                                } on FirebaseFunctionsException catch (error) {
                                                                                  _model.cloudFunction2y4 = AcceptReconnectRequestCloudFunctionCallResponse(
                                                                                    errorCode: error.code,
                                                                                    succeeded: false,
                                                                                  );
                                                                                }

                                                                                if (_model.cloudFunction2y4!.data!.ok) {
                                                                                  logFirebaseEvent(
                                                                                    'relationship_restored',
                                                                                    parameters: {
                                                                                      'role': 'receiver',
                                                                                      'source': 'restore_page',
                                                                                      'method': 'cooldown_restore',
                                                                                      'result': 'accepted',
                                                                                    },
                                                                                  );
                                                                                  try {
                                                                                    final result = await FirebaseFunctions.instanceFor(region: 'europe-west3').httpsCallable('sendPartnerPush').call({
                                                                                      "type": 'reconnect_accepted',
                                                                                      "route": 'celebrate',
                                                                                      "audience": 'partner',
                                                                                    });
                                                                                    _model.cloudFunction6oyl = SendPartnerPushCloudFunctionCallResponse(
                                                                                      data: result.data,
                                                                                      succeeded: true,
                                                                                      resultAsString: result.data.toString(),
                                                                                      jsonBody: result.data,
                                                                                    );
                                                                                  } on FirebaseFunctionsException catch (error) {
                                                                                    _model.cloudFunction6oyl = SendPartnerPushCloudFunctionCallResponse(
                                                                                      errorCode: error.code,
                                                                                      succeeded: false,
                                                                                    );
                                                                                  }
                                                                                } else {
                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                    SnackBar(
                                                                                      content: Text(
                                                                                        _model.cloudFunction2y4!.data!.message,
                                                                                        style: TextStyle(
                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                        ),
                                                                                      ),
                                                                                      duration: Duration(milliseconds: 4000),
                                                                                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                    ),
                                                                                  );
                                                                                }

                                                                                safeSetState(() {});
                                                                              },
                                                                              text: FFLocalizations.of(context).getText(
                                                                                'r3szlvso' /* Accept */,
                                                                              ),
                                                                              options: FFButtonOptions(
                                                                                height: 48.0,
                                                                                padding: EdgeInsets.all(8.0),
                                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                color: Colors.purple,
                                                                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                      color: Colors.white,
                                                                                      fontSize: 16.0,
                                                                                      letterSpacing: 0.0,
                                                                                      useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                                    ),
                                                                                elevation: 0.0,
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.transparent,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(12.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 12.0)),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            16.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          if ((outgoingRejectedReconnectRequestsRecordList.length == 0) &&
                                                              (incomingPendingReconnectRequestsRecordList
                                                                      .length ==
                                                                  0) &&
                                                              (currentUserDocument!
                                                                      .disconnectCooldownUntil!
                                                                      .secondsSinceEpoch <
                                                                  getCurrentTimestamp
                                                                      .secondsSinceEpoch))
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          24.0),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xFF121212),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                          8.0,
                                                                      color: Color(
                                                                          0x1A000000),
                                                                      offset:
                                                                          Offset(
                                                                        0.0,
                                                                        2.0,
                                                                      ),
                                                                    )
                                                                  ],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              24.0),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              16.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          Icon(
                                                                            Icons.access_time_rounded,
                                                                            color:
                                                                                Color(0xFF757575),
                                                                            size:
                                                                                28.0,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    '2175xjag' /* Window expired */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                                                                                        color: Colors.white,
                                                                                        fontSize: 22.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).titleLargeIsCustom,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    '5bte1jue' /* 14-day window has passed */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                        color: Color(0xFFAEB4C0),
                                                                                        fontSize: 15.0,
                                                                                        letterSpacing: 0.0,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                      ),
                                                                                ),
                                                                              ].divide(SizedBox(height: 8.0)),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 16.0)),
                                                                      ),
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        child: Image
                                                                            .network(
                                                                          'https://images.unsplash.com/photo-1606103897759-4ea5eea942b2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw4fHxzb3JyeXxlbnwwfHx8fDE3NTkxMDc5OTd8MA&ixlib=rb-4.1.0&q=80&w=1080',
                                                                          width:
                                                                              200.0,
                                                                          height:
                                                                              200.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                      FFButtonWidget(
                                                                        onPressed:
                                                                            () async {
                                                                          try {
                                                                            final result =
                                                                                await FirebaseFunctions.instanceFor(region: 'europe-west3').httpsCallable('purgeRelationshipNow').call({});
                                                                            _model.delete =
                                                                                PurgeRelationshipNowCloudFunctionCallResponse(
                                                                              succeeded: true,
                                                                            );
                                                                          } on FirebaseFunctionsException catch (error) {
                                                                            _model.delete =
                                                                                PurgeRelationshipNowCloudFunctionCallResponse(
                                                                              errorCode: error.code,
                                                                              succeeded: false,
                                                                            );
                                                                          }

                                                                          context
                                                                              .goNamed(
                                                                            ConnectV2Widget.routeName,
                                                                            extra: <String,
                                                                                dynamic>{
                                                                              '__transition_info__': TransitionInfo(
                                                                                hasTransition: true,
                                                                                transitionType: PageTransitionType.fade,
                                                                              ),
                                                                            },
                                                                          );

                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        text: FFLocalizations.of(context)
                                                                            .getText(
                                                                          '3g3xav2l' /* Start new connection */,
                                                                        ),
                                                                        options:
                                                                            FFButtonOptions(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              48.0,
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          color:
                                                                              Colors.purple,
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                color: Colors.white,
                                                                                fontSize: 16.0,
                                                                                letterSpacing: 0.0,
                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                              ),
                                                                          elevation:
                                                                              0.0,
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.transparent,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(12.0),
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            16.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          if (outgoingRejectedReconnectRequestsRecordList
                                                                  .length >
                                                              0)
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          24.0),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xFF121212),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                          8.0,
                                                                      color: Color(
                                                                          0x1A000000),
                                                                      offset:
                                                                          Offset(
                                                                        0.0,
                                                                        2.0,
                                                                      ),
                                                                    )
                                                                  ],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              24.0),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              16.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          Icon(
                                                                            Icons.heart_broken_rounded,
                                                                            color:
                                                                                Colors.red,
                                                                            size:
                                                                                28.0,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'p08ent7o' /* Request rejected */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                                                                                        color: Colors.white,
                                                                                        fontSize: 22.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).titleLargeIsCustom,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'ngbjq12x' /* Your partner rejected the requ... */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                        color: Color(0xFFAEB4C0),
                                                                                        fontSize: 15.0,
                                                                                        letterSpacing: 0.0,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                      ),
                                                                                ),
                                                                              ].divide(SizedBox(height: 8.0)),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 16.0)),
                                                                      ),
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        child: Image
                                                                            .network(
                                                                          'https://images.unsplash.com/photo-1517423440428-a5a00ad493e8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8ZG9nfGVufDB8fHx8MTc1ODk4ODI3OHww&ixlib=rb-4.1.0&q=80&w=1080',
                                                                          width:
                                                                              200.0,
                                                                          height:
                                                                              200.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                      FFButtonWidget(
                                                                        onPressed:
                                                                            () async {
                                                                          try {
                                                                            final result =
                                                                                await FirebaseFunctions.instanceFor(region: 'europe-west3').httpsCallable('dismissRejectedReconnect').call({
                                                                              "requestId": outgoingRejectedReconnectRequestsRecordList.firstOrNull!.reference.id,
                                                                              "relationshipid": valueOrDefault(currentUserDocument?.lastRelationshipId, ''),
                                                                              "partnerUid": FFAppState().appPartnerUID,
                                                                            });
                                                                            _model.cloudFunctiono6h =
                                                                                DismissRejectedReconnectCloudFunctionCallResponse(
                                                                              data: CFResultStruct.fromMap(result.data),
                                                                              succeeded: true,
                                                                              resultAsString: result.data.toString(),
                                                                              jsonBody: result.data,
                                                                            );
                                                                          } on FirebaseFunctionsException catch (error) {
                                                                            _model.cloudFunctiono6h =
                                                                                DismissRejectedReconnectCloudFunctionCallResponse(
                                                                              errorCode: error.code,
                                                                              succeeded: false,
                                                                            );
                                                                          }

                                                                          if (_model
                                                                              .cloudFunctiono6h!
                                                                              .data!
                                                                              .ok) {
                                                                            Navigator.pop(context);
                                                                          }

                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        text: FFLocalizations.of(context)
                                                                            .getText(
                                                                          'rne9imso' /* Refresh */,
                                                                        ),
                                                                        options:
                                                                            FFButtonOptions(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              48.0,
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          color:
                                                                              Colors.purple,
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                                                                color: Colors.white,
                                                                                fontSize: 16.0,
                                                                                letterSpacing: 0.0,
                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                              ),
                                                                          elevation:
                                                                              0.0,
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.transparent,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(12.0),
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            16.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                        ].divide(SizedBox(
                                                            height: 16.0)),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 16.0)),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                          .divide(SizedBox(height: 32.0))
                          .addToStart(SizedBox(height: 40.0))
                          .addToEnd(SizedBox(height: 40.0)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
