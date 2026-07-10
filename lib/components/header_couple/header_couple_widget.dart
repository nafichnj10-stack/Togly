import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:firebase_storagelibrary_2sa6k9/app_state.dart'
    as firebase_storagelibrary_2sa6k9_app_state;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'header_couple_model.dart';
export 'header_couple_model.dart';

class HeaderCoupleWidget extends StatefulWidget {
  const HeaderCoupleWidget({
    super.key,
    this.myIsSleeping,
    this.mySleepStartedAt,
    this.myMood,
    String? silentStatus,
    String? silentStatusText,
    this.partnerPhotoUrl,
    this.partnerIsSleeping,
    this.partnerSleepStartedAt,
    this.partnerMood,
    this.partnerName,
    this.partnerTimezoneOffsetMinutes,
    this.partnerCity,
    this.myTimezoneOffsetMinutes,
  })  : this.silentStatus = silentStatus ?? '',
        this.silentStatusText = silentStatusText ?? '';

  final bool? myIsSleeping;
  final DateTime? mySleepStartedAt;
  final String? myMood;
  final String silentStatus;
  final String silentStatusText;
  final String? partnerPhotoUrl;
  final bool? partnerIsSleeping;
  final DateTime? partnerSleepStartedAt;
  final String? partnerMood;
  final String? partnerName;
  final int? partnerTimezoneOffsetMinutes;
  final String? partnerCity;
  final int? myTimezoneOffsetMinutes;

  @override
  State<HeaderCoupleWidget> createState() => _HeaderCoupleWidgetState();
}

class _HeaderCoupleWidgetState extends State<HeaderCoupleWidget> {
  late HeaderCoupleModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HeaderCoupleModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    context.watch<firebase_storagelibrary_2sa6k9_app_state.FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0x002D1F3D),
          boxShadow: [
            BoxShadow(
              blurRadius: 12.0,
              color: Color(0x1A000000),
              offset: Offset(
                0.0,
                2.0,
              ),
              spreadRadius: 0.0,
            )
          ],
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
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
                  List<PublicUsersRecord> columnPublicUsersRecordList =
                      snapshot.data!;
                  // Return an empty Container when the item does not exist.
                  if (snapshot.data!.isEmpty) {
                    return Container();
                  }
                  final columnPublicUsersRecord =
                      columnPublicUsersRecordList.isNotEmpty
                          ? columnPublicUsersRecordList.first
                          : null;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0x00F8F6FF),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (widget.myIsSleeping == true)
                                        Container(
                                          width: 120.0,
                                          height: 54.0,
                                          child:
                                              custom_widgets.SleepTimerWidget(
                                            width: 120.0,
                                            height: 54.0,
                                            isSleeping: widget.myIsSleeping!,
                                            sleepStartedAt:
                                                widget.mySleepStartedAt,
                                            isMe: true,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0x00F8F6FF),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 1.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (widget.partnerIsSleeping == true)
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 1.0),
                                            child: Container(
                                              width: 120.0,
                                              height: 54.0,
                                              child: custom_widgets
                                                  .SleepTimerWidget(
                                                width: 120.0,
                                                height: 54.0,
                                                isSleeping:
                                                    widget.partnerIsSleeping!,
                                                sleepStartedAt: widget
                                                    .partnerSleepStartedAt,
                                                isMe: false,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF0EEFF),
                                    borderRadius: BorderRadius.circular(40.0),
                                    border: Border.all(
                                      color: Color(0xFFE6D9FF),
                                      width: 2.0,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(38.0),
                                    child: Image.network(
                                      columnPublicUsersRecord!.photoUrl,
                                      width: 76.0,
                                      height: 76.0,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                        'assets/images/error_image.png',
                                        width: 76.0,
                                        height: 76.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    () {
                                      if (widget.myMood == 'happy') {
                                        return '😁';
                                      } else if (widget.myMood == 'excited') {
                                        return '😏';
                                      } else if (widget.myMood == 'cool') {
                                        return '😎';
                                      } else if (widget.myMood == 'inlove') {
                                        return '😍';
                                      } else if (widget.myMood == 'strong') {
                                        return '💪';
                                      } else if (widget.myMood == 'shit') {
                                        return '💩';
                                      } else if (widget.myMood == 'sick') {
                                        return '🤒';
                                      } else if (widget.myMood == 'sad') {
                                        return '😭';
                                      } else if (widget.myMood == 'angry') {
                                        return '😡';
                                      } else if (widget.myMood == 'tired') {
                                        return '😓';
                                      } else {
                                        return '🙂';
                                      }
                                    }(),
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .headlineMediumFamily,
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .headlineMediumIsCustom,
                                        ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    columnPublicUsersRecord.name,
                                    'name',
                                  ).maybeHandleOverflow(
                                    maxChars: 12,
                                    replacement: '…',
                                  ),
                                  maxLines: 1,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
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
                                                .bodyMediumIsCustom,
                                      ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Text(
                                    dateTimeFormat(
                                      "jm",
                                      functions.nowWithOffset(valueOrDefault(
                                          currentUserDocument?.tzOffsetMinutes,
                                          0)),
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmallFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
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
                                                  .bodySmallIsCustom,
                                        ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0.0, -1.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 2.0, 0.0),
                                      child: Text(
                                        valueOrDefault<String>(
                                          functions.countryCodeToFlag(
                                              columnPublicUsersRecord
                                                  .countryCode),
                                          'Flag',
                                        ).maybeHandleOverflow(
                                          maxChars: 12,
                                        ),
                                        maxLines: 2,
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmallFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              shadows: [
                                                Shadow(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  offset: Offset(2.0, 2.0),
                                                  blurRadius: 2.0,
                                                )
                                              ],
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodySmallIsCustom,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, -1.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        columnPublicUsersRecord.city,
                                        'city',
                                      ).maybeHandleOverflow(
                                        maxChars: 12,
                                      ),
                                      maxLines: 2,
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
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
                                                    .bodySmallIsCustom,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ].divide(SizedBox(height: 8.0)),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFE6F2),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10.0,
                                      color: Color(0x69000000),
                                      offset: Offset(
                                        0.0,
                                        2.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all(
                                    color: Color(0xFFFFB3D9),
                                    width: 1.0,
                                  ),
                                ),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    try {
                                      final result =
                                          await FirebaseFunctions.instanceFor(
                                                  region: 'europe-west3')
                                              .httpsCallable(
                                                  'sendSilentCheckIn')
                                              .call({
                                        "mode": 'send',
                                        "type": 'normal',
                                      });
                                      _model.cfResult =
                                          SendSilentCheckInCloudFunctionCallResponse(
                                        data:
                                            CFResultStruct.fromMap(result.data),
                                        succeeded: true,
                                        resultAsString: result.data.toString(),
                                        jsonBody: result.data,
                                      );
                                    } on FirebaseFunctionsException catch (error) {
                                      _model.cfResult =
                                          SendSilentCheckInCloudFunctionCallResponse(
                                        errorCode: error.code,
                                        succeeded: false,
                                      );
                                    }

                                    _model.silentStatus =
                                        _model.cfResult?.data?.status;
                                    _model.silentStatusText =
                                        _model.cfResult?.data?.statusText;
                                    _model.silentSnackText =
                                        _model.cfResult?.data?.snackText;
                                    safeSetState(() {});
                                    _model.silentWaitMinutes =
                                        _model.cfResult?.data?.waitMinutes;
                                    _model.silentCooldownUntilMs =
                                        _model.cfResult?.data?.cooldownUntilMs;
                                    safeSetState(() {});
                                    if (_model.cfResult?.data?.ok == true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            _model.cfResult!.data!.snackText,
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            _model.cfResult!.data!.snackText,
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
                                    }

                                    safeSetState(() {});
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    color: Color(0xFFD63384),
                                    size: 40.0,
                                  ),
                                ),
                              ),
                              Text(
                                FFLocalizations.of(context).getText(
                                  'alb6wlqu' /* Send love */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelSmallFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
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
                                              .labelSmallIsCustom,
                                    ),
                              ),
                              if (widget.silentStatusText != '')
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 8.0,
                                      height: 8.0,
                                      decoration: BoxDecoration(
                                        color: () {
                                          if (widget.silentStatus == 'OK') {
                                            return FlutterFlowTheme.of(context)
                                                .success;
                                          } else if (widget.silentStatus ==
                                              'COOLDOWN') {
                                            return FlutterFlowTheme.of(context)
                                                .warning;
                                          } else if (widget.silentStatus ==
                                              'DAILY_LIMIT') {
                                            return FlutterFlowTheme.of(context)
                                                .accent3;
                                          } else if (widget.silentStatus ==
                                              'ERROR') {
                                            return FlutterFlowTheme.of(context)
                                                .error;
                                          } else {
                                            return FlutterFlowTheme.of(context)
                                                .success;
                                          }
                                        }(),
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                    ),
                                    Text(
                                      valueOrDefault<String>(
                                        _model.cfResult?.data?.statusText,
                                        'Ready',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelSmallIsCustom,
                                          ),
                                    ),
                                  ].divide(SizedBox(width: 8.0)),
                                ),
                            ].divide(SizedBox(height: 12.0)),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF0EEFF),
                                    borderRadius: BorderRadius.circular(40.0),
                                    border: Border.all(
                                      color: Color(0xFFE6D9FF),
                                      width: 2.0,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(38.0),
                                    child: Image.network(
                                      widget.partnerPhotoUrl!,
                                      width: 76.0,
                                      height: 76.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    () {
                                      if (widget.partnerMood == 'happy') {
                                        return '😁';
                                      } else if (widget.partnerMood ==
                                          'excited') {
                                        return '😏';
                                      } else if (widget.partnerMood ==
                                          'cool') {
                                        return '😎';
                                      } else if (widget.partnerMood ==
                                          'inlove') {
                                        return '😍';
                                      } else if (widget.partnerMood ==
                                          'strong') {
                                        return '💪';
                                      } else if (widget.partnerMood ==
                                          'shit') {
                                        return '💩';
                                      } else if (widget.partnerMood ==
                                          'sick') {
                                        return '😢';
                                      } else if (widget.partnerMood ==
                                          'angry') {
                                        return '😡';
                                      } else if (widget.partnerMood ==
                                          'tired') {
                                        return '😓';
                                      } else {
                                        return '🙂';
                                      }
                                    }(),
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .headlineMediumFamily,
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .headlineMediumIsCustom,
                                        ),
                                  ),
                                ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  widget.partnerName,
                                  'name',
                                ).maybeHandleOverflow(
                                  maxChars: 12,
                                  replacement: '…',
                                ),
                                maxLines: 1,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
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
                                              .bodyMediumIsCustom,
                                    ),
                              ),
                              Text(
                                dateTimeFormat(
                                  "jm",
                                  functions.nowWithOffset(
                                      widget.partnerTimezoneOffsetMinutes!),
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodySmallFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
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
                                              .bodySmallIsCustom,
                                    ),
                              ),
                              AuthUserStreamWidget(
                                builder: (context) => StreamBuilder<
                                    List<RelationshipViewsRecord>>(
                                  stream: queryRelationshipViewsRecord(
                                    queryBuilder: (relationshipViewsRecord) =>
                                        relationshipViewsRecord.where(
                                      'relationship_id',
                                      isEqualTo: valueOrDefault(
                                          currentUserDocument?.relationshipId,
                                          ''),
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
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<RelationshipViewsRecord>
                                        rowRelationshipViewsRecordList =
                                        snapshot.data!;
                                    final rowRelationshipViewsRecord =
                                        rowRelationshipViewsRecordList
                                                .isNotEmpty
                                            ? rowRelationshipViewsRecordList
                                                .first
                                            : null;

                                    return Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            widget.partnerCity,
                                            'City',
                                          ).maybeHandleOverflow(
                                            maxChars: 12,
                                            replacement: '…',
                                          ),
                                          maxLines: 3,
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                shadows: [
                                                  Shadow(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    offset: Offset(2.0, 2.0),
                                                    blurRadius: 2.0,
                                                  )
                                                ],
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmallIsCustom,
                                              ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  2.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              functions.countryCodeToFlag(
                                                  rowRelationshipViewsRecord!
                                                      .partnerCountryCode),
                                              'Flag',
                                            ).maybeHandleOverflow(
                                              maxChars: 12,
                                              replacement: '…',
                                            ),
                                            maxLines: 3,
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  shadows: [
                                                    Shadow(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      offset: Offset(2.0, 2.0),
                                                      blurRadius: 2.0,
                                                    )
                                                  ],
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallIsCustom,
                                                ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ].divide(SizedBox(height: 8.0)),
                          ),
                        ].divide(SizedBox(width: 32.0)),
                      ),
                    ].divide(SizedBox(height: 20.0)),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
              child: StreamBuilder<List<RelationshipViewsRecord>>(
                stream: queryRelationshipViewsRecord(
                  queryBuilder: (relationshipViewsRecord) =>
                      relationshipViewsRecord.where(
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
                  List<RelationshipViewsRecord>
                      containerRelationshipViewsRecordList = snapshot.data!;
                  final containerRelationshipViewsRecord =
                      containerRelationshipViewsRecordList.isNotEmpty
                          ? containerRelationshipViewsRecordList.first
                          : null;

                  return Container(
                    decoration: BoxDecoration(),
                    child: AuthUserStreamWidget(
                      builder: (context) =>
                          StreamBuilder<List<RelationshipsRecord>>(
                        stream: queryRelationshipsRecord(
                          queryBuilder: (relationshipsRecord) =>
                              relationshipsRecord.where(
                            'relationship_id',
                            isEqualTo: valueOrDefault(
                                currentUserDocument?.relationshipId, ''),
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
                          List<RelationshipsRecord>
                              columnRelationshipsRecordList = snapshot.data!;
                          final columnRelationshipsRecord =
                              columnRelationshipsRecordList.isNotEmpty
                                  ? columnRelationshipsRecordList.first
                                  : null;

                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              StreamBuilder<List<CalendarEventsRecord>>(
                                stream: queryCalendarEventsRecord(
                                  queryBuilder: (calendarEventsRecord) =>
                                      calendarEventsRecord
                                          .where(
                                            'relationship_id',
                                            isEqualTo: valueOrDefault(
                                                currentUserDocument
                                                    ?.relationshipId,
                                                ''),
                                          )
                                          .where(
                                            'category_key',
                                            isEqualTo: 'next_meeting',
                                          )
                                          .where(
                                            'start',
                                            isGreaterThanOrEqualTo:
                                                currentUserDocument
                                                    ?.createdTime,
                                          )
                                          .orderBy('start'),
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
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  List<CalendarEventsRecord>
                                      relationshipStatsCounterWidgetV2CalendarEventsRecordList =
                                      snapshot.data!;
                                  final relationshipStatsCounterWidgetV2CalendarEventsRecord =
                                      relationshipStatsCounterWidgetV2CalendarEventsRecordList
                                              .isNotEmpty
                                          ? relationshipStatsCounterWidgetV2CalendarEventsRecordList
                                              .first
                                          : null;

                                  return Container(
                                    width: 320.0,
                                    height: 330.0,
                                    child: custom_widgets
                                        .RelationshipStatsCounterWidgetV2(
                                      width: 320.0,
                                      height: 330.0,
                                      milesText: functions.hoursApart(
                                          containerRelationshipViewsRecord
                                              ?.myTzOffsetMinutes,
                                          containerRelationshipViewsRecord
                                              ?.partnerTzOffsetMinutes,
                                          true),
                                      countdownText: functions.nextMeetingLabel(
                                          relationshipStatsCounterWidgetV2CalendarEventsRecord
                                              ?.start,
                                          relationshipStatsCounterWidgetV2CalendarEventsRecord
                                              ?.end,
                                          relationshipStatsCounterWidgetV2CalendarEventsRecord
                                              ?.allDay,
                                          containerRelationshipViewsRecord
                                              ?.myTzOffsetMinutes,
                                          FFAppState().serverNowUtcMillis),
                                      togetherText:
                                          functions.togetherSinceSmart(
                                              columnRelationshipsRecord
                                                  ?.togetherSince,
                                              valueOrDefault(
                                                  currentUserDocument
                                                      ?.appLanguage,
                                                  '')),
                                      appLanguage: valueOrDefault(
                                          currentUserDocument?.appLanguage, ''),
                                      togetherSinceConflict:
                                          columnRelationshipsRecord
                                              ?.togetherSinceConflict,
                                      loveBuddyCurrentDistanceKm:
                                          columnRelationshipsRecord
                                              ?.loveBuddiesCurrentDistanceKm,
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
