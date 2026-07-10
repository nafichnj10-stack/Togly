import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/languagesheet/languagesheet_widget.dart';
import '/components/pair_required_sheet/pair_required_sheet_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_place_picker.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_page_model.dart';
export 'profile_page_model.dart';

/// Design a clean, user-friendly and emotionally warm **Profile Settings
/// Page** for a mobile relationship app called "Togetherly".
///
/// The page should follow the same aesthetic as the rest of the app: soft
/// pastel gradients (lavender, light beige, soft purple), rounded cards,
/// gentle shadows, and calming visual hierarchy.
///
/// **General Layout**:
/// - Use a vertical scroll layout with soft background tones.
/// - Section titles should be subtle and clean (e.g. gray text with light
/// dividers).
/// - The design should feel modern, romantic, and elegant.
///
/// **Top Section**:
/// - Large circular **Profile Picture** at the top, with a small "Edit"
/// icon/button to upload or change the profile photo.
///
/// **Editable Fields (Form-style)**:
/// Include the following editable fields, each inside a soft card or outlined
/// input field:
/// 1. **Name** – Text field
/// 2. **Email Address** – Text field
/// 3. **City / Location** – Autocomplete or text field (used to determine
/// local time)
/// 4. **Current Local Time (Auto-calculated)** – Read-only display
/// 5. **Change Password** – A "Change Password" button opens a modal or
/// separate view.
/// 6. **Notification Preferences** – Toggle switches for:
///    - New message alerts
///    - Daily question reminders
///    - Partner activity notifications
/// 7. **App Theme** – Dropdown or toggle for Light / Dark Mode
/// 8. **Delete or Change Partner Connection** – A button labeled:
///    - “Disconnect from Partner”
///    → With a heart-broken icon and a confirmation dialog. Use clear warning
/// styling (e.g. soft red tone).
///
/// **Other Actions (Lower Section)**:
/// - **Terms & Privacy Policy** – Button or link to view in-app
/// - **Logout Button** – Styled clearly, but soft in tone
/// - **Delete Account** – Optional, in soft red or gray, with confirmation
/// step
///
/// **Design Elements**:
/// - Use elegant fonts like Poppins, Nunito, or Inter
/// - Apply subtle animations to section transitions
/// - Use heart icons or soft couple-themed visuals where appropriate
/// - Ensure full mobile optimization and proper spacing
///
/// This profile page should allow users to manage their identity, location,
/// connection, and preferences in a safe and emotional space, while
/// maintaining the soft aesthetic of the Togetherly brand.
class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({super.key});

  static String routeName = 'ProfilePage';
  static String routePath = '/profilePage';

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  late ProfilePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilePageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'ProfilePage'});

    _model.textFieldProfileNameFocusNode ??= FocusNode();

    _model.textFieldProfileCityTextController ??= TextEditingController(
        text: valueOrDefault(currentUserDocument?.city, ''));
    _model.textFieldProfileCityFocusNode ??= FocusNode();

    _model.textFieldProfileCountryFocusNode ??= FocusNode();

    _model.switchValue1 =
        valueOrDefault<bool>(currentUserDocument?.messagesEnabled, false);
    _model.switchValue2 = valueOrDefault<bool>(
        currentUserDocument?.dailyQuestionPartnerAlertsEnabled, false);
    _model.switchValue3 = valueOrDefault<bool>(
        currentUserDocument?.relationshipAlertsEnabled, false);
    _model.switchValue4 =
        valueOrDefault<bool>(currentUserDocument?.sharedMomentsEnabled, false);
    _model.switchValue5 = valueOrDefault<bool>(
        currentUserDocument?.dailyQuestionRemindersEnabled, false);
    _model.switchValue6 = valueOrDefault<bool>(
        currentUserDocument?.stayConnectedRemindersEnabled, false);
    _model.switchValue7 = valueOrDefault<bool>(
        currentUserDocument?.liveTravelTrackingEnabled, false);
    _model.switchValue8 =
        valueOrDefault<bool>(currentUserDocument?.muteAllNotifications, false);
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
        backgroundColor: Color(0xFFF8F5F9),
        appBar: AppBar(
          backgroundColor: Color(0xFFF8F5F9),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderRadius: 12.0,
            buttonSize: 44.0,
            fillColor: Color(0xFFEDE7F6),
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF8E7CC3),
              size: 20.0,
            ),
            onPressed: () async {
              if (Navigator.of(context).canPop()) {
                context.pop();
              }
              context.pushNamed(
                HomeWidget.routeName,
                extra: <String, dynamic>{
                  '__transition_info__': TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                  ),
                },
              );
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              '9hvj740b' /* Profile Settings */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).headlineMediumFamily,
                  color: Color(0xFF6B5B95),
                  fontSize: 20.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).headlineMediumIsCustom,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<List<PublicUsersRecord>>(
                    stream: queryPublicUsersRecord(
                      queryBuilder: (publicUsersRecord) =>
                          publicUsersRecord.where(
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
                      final columnPublicUsersRecord =
                          columnPublicUsersRecordList.isNotEmpty
                              ? columnPublicUsersRecordList.first
                              : null;

                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 120.0,
                                height: 120.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFEDE7F6),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.network(
                                      columnPublicUsersRecord!.photoUrl,
                                    ).image,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 15.0,
                                      color: Color(0x33D1C4E9),
                                      offset: Offset(
                                        0.0,
                                        5.0,
                                      ),
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Opacity(
                                opacity: 0.6,
                                child: Align(
                                  alignment: AlignmentDirectional(-0.33, -1.31),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      // UploadData_Profilbild2
                                      final selectedMedia =
                                          await selectMediaWithSourceBottomSheet(
                                        context: context,
                                        imageQuality: 50,
                                        allowPhoto: true,
                                      );
                                      if (selectedMedia != null &&
                                          selectedMedia.every((m) =>
                                              validateFileFormat(
                                                  m.storagePath, context))) {
                                        safeSetState(() =>
                                            _model.isDataUploading_uploadData1 =
                                                true);
                                        var selectedUploadedFiles =
                                            <FFUploadedFile>[];

                                        var downloadUrls = <String>[];
                                        try {
                                          selectedUploadedFiles = selectedMedia
                                              .map((m) => FFUploadedFile(
                                                    name: m.storagePath
                                                        .split('/')
                                                        .last,
                                                    bytes: m.bytes,
                                                    height:
                                                        m.dimensions?.height,
                                                    width: m.dimensions?.width,
                                                    blurHash: m.blurHash,
                                                    originalFilename:
                                                        m.originalFilename,
                                                  ))
                                              .toList();

                                          downloadUrls = (await Future.wait(
                                            selectedMedia.map(
                                              (m) async => await uploadData(
                                                  m.storagePath, m.bytes),
                                            ),
                                          ))
                                              .where((u) => u != null)
                                              .map((u) => u!)
                                              .toList();
                                        } finally {
                                          _model.isDataUploading_uploadData1 =
                                              false;
                                        }
                                        if (selectedUploadedFiles.length ==
                                                selectedMedia.length &&
                                            downloadUrls.length ==
                                                selectedMedia.length) {
                                          safeSetState(() {
                                            _model.uploadedLocalFile_uploadData1 =
                                                selectedUploadedFiles.first;
                                            _model.uploadedFileUrl_uploadData1 =
                                                downloadUrls.first;
                                          });
                                        } else {
                                          safeSetState(() {});
                                          return;
                                        }
                                      }

                                      if (_model.uploadedFileUrl_uploadData1 !=
                                              '') {
                                        if (valueOrDefault(
                                                currentUserDocument
                                                    ?.appLanguage,
                                                '') ==
                                            'en') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Your profile picture has been uploaded',
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
                                        } else if (valueOrDefault(
                                                currentUserDocument
                                                    ?.appLanguage,
                                                '') ==
                                            'de') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Dein Profilbild wurde hochgeladen.',
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
                                        } else if (valueOrDefault(
                                                currentUserDocument
                                                    ?.appLanguage,
                                                '') ==
                                            'es') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Tu foto de perfil ha sido subida',
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
                                        }

                                        // BackendCall2

                                        await columnPublicUsersRecord.reference
                                            .update(createPublicUsersRecordData(
                                          photoUrl: _model
                                              .uploadedFileUrl_uploadData1,
                                        ));
                                        _model.partnerUserRecord =
                                            await queryUsersRecordOnce(
                                          queryBuilder: (usersRecord) =>
                                              usersRecord.where(
                                            'uid',
                                            isEqualTo: valueOrDefault(
                                                currentUserDocument?.partnerUID,
                                                ''),
                                          ),
                                          singleRecord: true,
                                        ).then((s) => s.firstOrNull);
                                        if ((_model.partnerUserRecord
                                                    ?.muteAllNotifications ==
                                                false) &&
                                            (_model.partnerUserRecord
                                                    ?.sharedMomentsEnabled ==
                                                true)) {
                                          triggerPushNotification(
                                            notificationTitle:
                                                'New profile picture',
                                            notificationText:
                                                'Your partner has a new profile picture🥰',
                                            notificationSound: 'default',
                                            userRefs: [
                                              _model
                                                  .partnerUserRecord!.reference
                                            ],
                                            initialPageName: 'connect',
                                            parameterData: {},
                                          );
                                        }
                                      }

                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      width: 36.0,
                                      height: 36.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFB39DDB),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 8.0,
                                            color: Color(0x33B39DDB),
                                            offset: Offset(
                                              0.0,
                                              2.0,
                                            ),
                                          )
                                        ],
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Icon(
                                          Icons.add_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 32.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      );
                    },
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed(
                              DonationPageV1Widget.routeName,
                              extra: <String, dynamic>{
                                '__transition_info__': TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                ),
                              },
                            );
                          },
                          text: FFLocalizations.of(context).getText(
                            'pun6dy4o' /* 💜 Support Togly */,
                          ),
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleSmallFamily,
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleSmallIsCustom,
                                ),
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              context.pushNamed(
                                FeeeeedbackWidget.routeName,
                                extra: <String, dynamic>{
                                  '__transition_info__': TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.fade,
                                  ),
                                },
                              );
                            },
                            text: FFLocalizations.of(context).getText(
                              'jnc4thi7' /* 🤗 Give Feedback */,
                            ),
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).tertiary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleSmallFamily,
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .titleSmallIsCustom,
                                  ),
                              elevation: 4.0,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'm59cd4h5' /* Personal Information */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .labelLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelLargeFamily,
                                color: Color(0xFF8E7CC3),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelLargeIsCustom,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: StreamBuilder<List<PublicUsersRecord>>(
                          stream: queryPublicUsersRecord(
                            queryBuilder: (publicUsersRecord) =>
                                publicUsersRecord.where(
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
                            List<PublicUsersRecord>
                                containerPublicUsersRecordList = snapshot.data!;
                            final containerPublicUsersRecord =
                                containerPublicUsersRecordList.isNotEmpty
                                    ? containerPublicUsersRecordList.first
                                    : null;

                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 12.0,
                                    color: Color(0x1AD1C4E9),
                                    offset: Offset(
                                      0.0,
                                      3.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            TextFormField(
                                              controller: _model
                                                      .textFieldProfileNameTextController ??=
                                                  TextEditingController(
                                                text: containerPublicUsersRecord
                                                    ?.name,
                                              ),
                                              focusNode: _model
                                                  .textFieldProfileNameFocusNode,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'djnisdp5' /* Name */,
                                                ),
                                                labelStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumFamily,
                                                      color: Color(0xFF9E8FB3),
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumIsCustom,
                                                    ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xFFEDE7F6),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xFFB39DDB),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                filled: true,
                                                fillColor: Color(0xFFF8F5F9),
                                                contentPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(16.0, 16.0,
                                                            16.0, 16.0),
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: Color(0xFF6B5B95),
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                              maxLength: 15,
                                              maxLengthEnforcement:
                                                  MaxLengthEnforcement.enforced,
                                              cursorColor: Color(0xFFB39DDB),
                                              validator: _model
                                                  .textFieldProfileNameTextControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ],
                                        ),
                                        AuthUserStreamWidget(
                                          builder: (context) => TextFormField(
                                            controller: _model
                                                .textFieldProfileCityTextController,
                                            focusNode: _model
                                                .textFieldProfileCityFocusNode,
                                            readOnly: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText:
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                '72xer5tt' /* City / Location */,
                                              ),
                                              labelStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMediumFamily,
                                                    color: Color(0xFF9E8FB3),
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .labelMediumIsCustom,
                                                  ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFEDE7F6),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFB39DDB),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              filled: true,
                                              fillColor: Color(0xFFF8F5F9),
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 16.0,
                                                          16.0, 16.0),
                                              suffixIcon: Icon(
                                                Icons.location_city,
                                                color: Color(0xFF9E8FB3),
                                                size: 20.0,
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: Color(0xFF6B5B95),
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                            maxLength: 15,
                                            maxLengthEnforcement:
                                                MaxLengthEnforcement.enforced,
                                            cursorColor: Color(0xFFB39DDB),
                                            validator: _model
                                                .textFieldProfileCityTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: _model
                                                  .textFieldProfileCountryTextController ??=
                                              TextEditingController(
                                            text: containerPublicUsersRecord
                                                ?.countryName,
                                          ),
                                          focusNode: _model
                                              .textFieldProfileCountryFocusNode,
                                          readOnly: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText:
                                                FFLocalizations.of(context)
                                                    .getText(
                                              'yu0rlim0' /* Country */,
                                            ),
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumFamily,
                                                      color: Color(0xFF9E8FB3),
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumIsCustom,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFEDE7F6),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFB39DDB),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            filled: true,
                                            fillColor: Color(0xFFF8F5F9),
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 16.0, 16.0, 16.0),
                                            suffixIcon: Icon(
                                              Icons.location_on,
                                              color: Color(0xFF9E8FB3),
                                              size: 20.0,
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color: Color(0xFF6B5B95),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                          maxLength: 15,
                                          maxLengthEnforcement:
                                              MaxLengthEnforcement.enforced,
                                          cursorColor: Color(0xFFB39DDB),
                                          validator: _model
                                              .textFieldProfileCountryTextControllerValidator
                                              .asValidator(context),
                                        ),
                                        FlutterFlowPlacePicker(
                                          iOSGoogleMapsApiKey:
                                              '<placeholder_key>',
                                          androidGoogleMapsApiKey:
                                              'AIzaSyC2dwTu7CBJwgzU7ziDoMQEh2259PGefBg',
                                          webGoogleMapsApiKey:
                                              'AIzaSyC2dwTu7CBJwgzU7ziDoMQEh2259PGefBg',
                                          onSelect: (place) async {
                                            safeSetState(() => _model
                                                .placePickerValue = place);
                                          },
                                          defaultText:
                                              FFLocalizations.of(context)
                                                  .getText(
                                            '0edwarya' /* Change location */,
                                          ),
                                          icon: Icon(
                                            Icons.place,
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            size: 16.0,
                                          ),
                                          buttonOptions: FFButtonOptions(
                                            width: 200.0,
                                            height: 60.0,
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallIsCustom,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              final _datePickedDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate:
                                                    getCurrentTimestamp,
                                                firstDate: DateTime(1900),
                                                lastDate: getCurrentTimestamp,
                                                builder: (context, child) {
                                                  return wrapInMaterialDatePickerTheme(
                                                    context,
                                                    child!,
                                                    headerBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText,
                                                    headerForegroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    headerTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineLarge
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLargeFamily,
                                                              fontSize: 32.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLargeIsCustom,
                                                            ),
                                                    pickerBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText,
                                                    pickerForegroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    selectedDateTimeBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    selectedDateTimeForegroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                    actionButtonForegroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    iconSize: 24.0,
                                                  );
                                                },
                                              );

                                              if (_datePickedDate != null) {
                                                safeSetState(() {
                                                  _model.datePicked = DateTime(
                                                    _datePickedDate.year,
                                                    _datePickedDate.month,
                                                    _datePickedDate.day,
                                                  );
                                                });
                                              } else if (_model.datePicked !=
                                                  null) {
                                                safeSetState(() {
                                                  _model.datePicked =
                                                      getCurrentTimestamp;
                                                });
                                              }
                                              _model.togetherSinceOverride =
                                                  _model.datePicked;
                                              _model.hasTogetherOverride = true;
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              height: 120.0,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF8F5F9),
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                                border: Border.all(
                                                  color: Color(0xFFEDE7F6),
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(12.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        5.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'ocg1ozcq' /* Together since */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .bodyMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  AuthUserStreamWidget(
                                                                    builder:
                                                                        (context) =>
                                                                            Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        () {
                                                                          if (_model.togetherSinceOverride !=
                                                                              null) {
                                                                            return valueOrDefault<String>(
                                                                              dateTimeFormat(
                                                                                "MMMM",
                                                                                _model.togetherSinceOverride,
                                                                                locale: FFLocalizations.of(context).languageCode,
                                                                              ),
                                                                              'MMMM',
                                                                            );
                                                                          } else if (valueOrDefault(currentUserDocument?.relationshipId, '') != '') {
                                                                            return valueOrDefault<String>(
                                                                              dateTimeFormat(
                                                                                "MMMM",
                                                                                containerPublicUsersRecord?.togetherSince,
                                                                                locale: FFLocalizations.of(context).languageCode,
                                                                              ),
                                                                              'MMMM',
                                                                            );
                                                                          } else {
                                                                            return '–';
                                                                          }
                                                                        }(),
                                                                        'MMMM',
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).titleLargeFamily,
                                                                            color:
                                                                                Color(0xFF6B5B95),
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).titleLargeIsCustom,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Container(
                                                                width: 2.0,
                                                                height: 14.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  AuthUserStreamWidget(
                                                                    builder:
                                                                        (context) =>
                                                                            Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        () {
                                                                          if (_model.togetherSinceOverride !=
                                                                              null) {
                                                                            return valueOrDefault<String>(
                                                                              dateTimeFormat(
                                                                                "dd",
                                                                                _model.togetherSinceOverride,
                                                                                locale: FFLocalizations.of(context).languageCode,
                                                                              ),
                                                                              'dd',
                                                                            );
                                                                          } else if (valueOrDefault(currentUserDocument?.relationshipId, '') != '') {
                                                                            return valueOrDefault<String>(
                                                                              dateTimeFormat(
                                                                                "dd",
                                                                                containerPublicUsersRecord?.togetherSince,
                                                                                locale: FFLocalizations.of(context).languageCode,
                                                                              ),
                                                                              'dd',
                                                                            );
                                                                          } else {
                                                                            return '–';
                                                                          }
                                                                        }(),
                                                                        'dd',
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).titleLargeFamily,
                                                                            color:
                                                                                Color(0xFF6B5B95),
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).titleLargeIsCustom,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Container(
                                                                width: 2.0,
                                                                height: 14.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  AuthUserStreamWidget(
                                                                    builder:
                                                                        (context) =>
                                                                            Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        () {
                                                                          if (_model.togetherSinceOverride !=
                                                                              null) {
                                                                            return valueOrDefault<String>(
                                                                              dateTimeFormat(
                                                                                "yyyy",
                                                                                _model.togetherSinceOverride,
                                                                                locale: FFLocalizations.of(context).languageCode,
                                                                              ),
                                                                              'yyyy',
                                                                            );
                                                                          } else if (valueOrDefault(currentUserDocument?.relationshipId, '') != '') {
                                                                            return valueOrDefault<String>(
                                                                              dateTimeFormat(
                                                                                "yyyy",
                                                                                containerPublicUsersRecord?.togetherSince,
                                                                                locale: FFLocalizations.of(context).languageCode,
                                                                              ),
                                                                              'yyyy',
                                                                            );
                                                                          } else {
                                                                            return '–';
                                                                          }
                                                                        }(),
                                                                        'yyyy',
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).titleLargeFamily,
                                                                            color:
                                                                                Color(0xFF6B5B95),
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).titleLargeIsCustom,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF8F5F9),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              border: Border.all(
                                                color: Color(0xFFEDE7F6),
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(12.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '1pdr7b6t' /* Current Local Time */,
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumFamily,
                                                              color: Color(
                                                                  0xFF9E8FB3),
                                                              fontSize: 14.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumIsCustom,
                                                            ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    4.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          dateTimeFormat(
                                                            "jm",
                                                            getCurrentTimestamp,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                color: Color(
                                                                    0xFF6B5B95),
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMediumIsCustom,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(
                                                    Icons.access_time_rounded,
                                                    color: Color(0xFF9E8FB3),
                                                    size: 20.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                if (_model.placePickerValue
                                                            .address !=
                                                        '') {
                                                  _model.geocodeResult2 =
                                                      await GoogleGeocodeLocationCall
                                                          .call(
                                                    address: _model
                                                        .placePickerValue
                                                        .address,
                                                    language: valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        ''),
                                                  );

                                                  _model.parsegoogle = await actions
                                                      .parseGoogleGeocodeLocation(
                                                    (_model.geocodeResult2
                                                            ?.jsonBody ??
                                                        ''),
                                                  );
                                                  if (_model.parsegoogle !=
                                                      null) {
                                                    await currentUserReference!
                                                        .update(
                                                            createUsersRecordData(
                                                      displayName: _model
                                                          .textFieldProfileNameTextController
                                                          .text,
                                                      city: getJsonField(
                                                        _model.parsegoogle,
                                                        r'''$.city''',
                                                      ).toString(),
                                                      countryCode: getJsonField(
                                                        _model.parsegoogle,
                                                        r'''$.countryCode''',
                                                      ).toString(),
                                                      homeLat: getJsonField(
                                                        _model.parsegoogle,
                                                        r'''$.lat''',
                                                      ),
                                                      homeLng: getJsonField(
                                                        _model.parsegoogle,
                                                        r'''$.lng''',
                                                      ),
                                                      countryName: getJsonField(
                                                        _model.parsegoogle,
                                                        r'''$.countryName''',
                                                      ).toString(),
                                                    ));

                                                    await containerPublicUsersRecord!
                                                        .reference
                                                        .update(
                                                            createPublicUsersRecordData(
                                                      name: _model
                                                          .textFieldProfileNameTextController
                                                          .text,
                                                      city: getJsonField(
                                                        _model.parsegoogle,
                                                        r'''$.city''',
                                                      ).toString(),
                                                      countryName: getJsonField(
                                                        _model.parsegoogle,
                                                        r'''$.countryName''',
                                                      ).toString(),
                                                      countryCode: getJsonField(
                                                        _model.parsegoogle,
                                                        r'''$.countryCode''',
                                                      ).toString(),
                                                      homeLat: getJsonField(
                                                        _model.parsegoogle,
                                                        r'''$.lat''',
                                                      ),
                                                      homeLng: getJsonField(
                                                        _model.parsegoogle,
                                                        r'''$.lng''',
                                                      ),
                                                    ));
                                                    try {
                                                      final result =
                                                          await FirebaseFunctions
                                                                  .instanceFor(
                                                                      region:
                                                                          'europe-west3')
                                                              .httpsCallable(
                                                                  'updateProfileSettings')
                                                              .call({
                                                        "name": _model
                                                            .textFieldProfileNameTextController
                                                            .text,
                                                        "togetherSince": _model
                                                            .togetherSinceOverride
                                                            ?.toString(),
                                                      });
                                                      _model.cloudFunctionwai =
                                                          UpdateProfileSettingsCloudFunctionCallResponse(
                                                        data: CFResultStruct
                                                            .fromMap(
                                                                result.data),
                                                        succeeded: true,
                                                        resultAsString: result
                                                            .data
                                                            .toString(),
                                                        jsonBody: result.data,
                                                      );
                                                    } on FirebaseFunctionsException catch (error) {
                                                      _model.cloudFunctionwai =
                                                          UpdateProfileSettingsCloudFunctionCallResponse(
                                                        errorCode: error.code,
                                                        succeeded: false,
                                                      );
                                                    }

                                                    try {
                                                      final result =
                                                          await FirebaseFunctions
                                                                  .instanceFor(
                                                                      region:
                                                                          'europe-west3')
                                                              .httpsCallable(
                                                                  'syncRelationshipViewProfile')
                                                              .call({});
                                                      _model.sync =
                                                          SyncRelationshipViewProfileCloudFunctionCallResponse(
                                                        succeeded: true,
                                                      );
                                                    } on FirebaseFunctionsException catch (error) {
                                                      _model.sync =
                                                          SyncRelationshipViewProfileCloudFunctionCallResponse(
                                                        errorCode: error.code,
                                                        succeeded: false,
                                                      );
                                                    }

                                                    try {
                                                      final result =
                                                          await FirebaseFunctions
                                                                  .instanceFor(
                                                                      region:
                                                                          'europe-west3')
                                                              .httpsCallable(
                                                                  'syncLoveBuddyDistance')
                                                              .call({});
                                                      _model.anxlove =
                                                          SyncLoveBuddyDistanceCloudFunctionCallResponse(
                                                        data: result.data,
                                                        succeeded: true,
                                                        resultAsString: result
                                                            .data
                                                            .toString(),
                                                        jsonBody: result.data,
                                                      );
                                                    } on FirebaseFunctionsException catch (error) {
                                                      _model.anxlove =
                                                          SyncLoveBuddyDistanceCloudFunctionCallResponse(
                                                        errorCode: error.code,
                                                        succeeded: false,
                                                      );
                                                    }

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          _model
                                                              .cloudFunctionwai!
                                                              .data!
                                                              .snackText,
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
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
                                                    if (Navigator.of(context)
                                                        .canPop()) {
                                                      context.pop();
                                                    }
                                                    context.pushNamed(
                                                      ProfilePageWidget
                                                          .routeName,
                                                      extra: <String, dynamic>{
                                                        '__transition_info__':
                                                            TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType:
                                                              PageTransitionType
                                                                  .fade,
                                                          duration: Duration(
                                                              milliseconds: 0),
                                                        ),
                                                      },
                                                    );
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getVariableText(
                                                            enText:
                                                                'Please choose a city, not only a country.',
                                                            deText:
                                                                'Bitte wähle eine Stadt und nicht nur ein Land aus',
                                                            esText:
                                                                'Por favor, elige una ciudad y no solo un país',
                                                          ),
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
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
                                                } else {
                                                  try {
                                                    final result =
                                                        await FirebaseFunctions
                                                                .instanceFor(
                                                                    region:
                                                                        'europe-west3')
                                                            .httpsCallable(
                                                                'updateProfileSettings')
                                                            .call({
                                                      "name": _model
                                                          .textFieldProfileNameTextController
                                                          .text,
                                                      "togetherSince": _model
                                                          .togetherSinceOverride
                                                          ?.toString(),
                                                    });
                                                    _model.cloudFunctionwai1 =
                                                        UpdateProfileSettingsCloudFunctionCallResponse(
                                                      data: CFResultStruct
                                                          .fromMap(result.data),
                                                      succeeded: true,
                                                      resultAsString: result
                                                          .data
                                                          .toString(),
                                                      jsonBody: result.data,
                                                    );
                                                  } on FirebaseFunctionsException catch (error) {
                                                    _model.cloudFunctionwai1 =
                                                        UpdateProfileSettingsCloudFunctionCallResponse(
                                                      errorCode: error.code,
                                                      succeeded: false,
                                                    );
                                                  }

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        _model
                                                            .cloudFunctionwai1!
                                                            .data!
                                                            .snackText,
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                  if (Navigator.of(context)
                                                      .canPop()) {
                                                    context.pop();
                                                  }
                                                  context.pushNamed(
                                                    ProfilePageWidget.routeName,
                                                    extra: <String, dynamic>{
                                                      '__transition_info__':
                                                          TransitionInfo(
                                                        hasTransition: true,
                                                        transitionType:
                                                            PageTransitionType
                                                                .fade,
                                                        duration: Duration(
                                                            milliseconds: 0),
                                                      ),
                                                    },
                                                  );
                                                }

                                                safeSetState(() {});
                                              },
                                              text: FFLocalizations.of(context)
                                                  .getText(
                                                'ntem4azf' /* Update profile */,
                                              ),
                                              options: FFButtonOptions(
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmallFamily,
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleSmallIsCustom,
                                                        ),
                                                elevation: 0.0,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 20.0)),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  ),
                  Container(
                    width: 378.8,
                    height: 261.21,
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F5F9),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 12.0,
                                  color: Color(0x1AD1C4E9),
                                  offset: Offset(
                                    0.0,
                                    3.0,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '6ex66hwn' /* Change E-Mail */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: Color(0xFF6B5B95),
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 2.0, 0.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'mqwqijbp' /* Update your E-Mail-Adress */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodySmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallFamily,
                                                      color: Color(0xFF9E8FB3),
                                                      fontSize: 12.0,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallIsCustom,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      FlutterFlowIconButton(
                                        borderRadius: 10.0,
                                        buttonSize: 40.0,
                                        fillColor: Color(0xFFEDE7F6),
                                        icon: Icon(
                                          Icons.chevron_right_rounded,
                                          color: Color(0xFF8E7CC3),
                                          size: 18.0,
                                        ),
                                        onPressed: () async {
                                          context.pushNamed(
                                              NewEmailPageWidget.routeName);
                                        },
                                      ),
                                    ],
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 12.0,
                                  color: Color(0x1AD1C4E9),
                                  offset: Offset(
                                    0.0,
                                    3.0,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'd7xngh7q' /* Change Password */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: Color(0xFF6B5B95),
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 2.0, 0.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'u8u184jj' /* Update your account password */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodySmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallFamily,
                                                      color: Color(0xFF9E8FB3),
                                                      fontSize: 12.0,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallIsCustom,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      FlutterFlowIconButton(
                                        borderRadius: 10.0,
                                        buttonSize: 40.0,
                                        fillColor: Color(0xFFEDE7F6),
                                        icon: Icon(
                                          Icons.chevron_right_rounded,
                                          color: Color(0xFF8E7CC3),
                                          size: 18.0,
                                        ),
                                        onPressed: () async {
                                          context.pushNamed(
                                              NewPasswordPageWidget.routeName);
                                        },
                                      ),
                                    ],
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (valueOrDefault<bool>(
                          currentUserDocument?.isAdmin, false) ==
                      true)
                    AuthUserStreamWidget(
                      builder: (context) =>
                          StreamBuilder<List<PublicUsersRecord>>(
                        stream: queryPublicUsersRecord(
                          queryBuilder: (publicUsersRecord) =>
                              publicUsersRecord.where(
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
                          final columnPublicUsersRecord =
                              columnPublicUsersRecordList.isNotEmpty
                                  ? columnPublicUsersRecordList.first
                                  : null;

                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    4.0, 0.0, 4.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'o81rmyjv' /* Dummy and Language */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelLargeFamily,
                                        color: Color(0xFF8E7CC3),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelLargeIsCustom,
                                      ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'hjoiwnie' /* Change your dummy */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: Color(0xFF6B5B95),
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            await columnPublicUsersRecord!
                                                .reference
                                                .update(
                                                    createPublicUsersRecordData(
                                              dummyGender: 'male',
                                            ));
                                            FFAppState().dummyGender = 'male';
                                            safeSetState(() {});
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'm38smcbn' /* ♂️ Male */,
                                          ),
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    26.0, 0.0, 26.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallFamily,
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallIsCustom,
                                                    ),
                                            elevation: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            await columnPublicUsersRecord!
                                                .reference
                                                .update(
                                                    createPublicUsersRecordData(
                                              dummyGender: 'female',
                                            ));
                                            FFAppState().dummyGender = 'female';
                                            safeSetState(() {});
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'ky5ntja5' /* ♀️ Female */,
                                          ),
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    26.0, 0.0, 26.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallFamily,
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallIsCustom,
                                                    ),
                                            elevation: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          );
                        },
                      ),
                    ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        'qo2a9v89' /* Change your language */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: Color(0xFF6B5B95),
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            enableDrag: false,
                            context: context,
                            builder: (context) {
                              return GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                child: Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: LanguagesheetWidget(),
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        },
                        text: FFLocalizations.of(context).getText(
                          'b4b6qdup' /* 🗣️ Change language */,
                        ),
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).tertiary,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: Colors.white,
                                fontSize: 20.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleSmallIsCustom,
                              ),
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '1ibi3t8l' /* Notifications */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .labelLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelLargeFamily,
                                color: Color(0xFF8E7CC3),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelLargeIsCustom,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 12.0,
                                color: Color(0x1AD1C4E9),
                                offset: Offset(
                                  0.0,
                                  3.0,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'bvg35519' /* Messages & Notes */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color: Color(0xFF6B5B95),
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 2.0, 0.0, 0.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'maqhjqgt' /* Love Notes, Chat/Notes, “partn... */,
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
                                                            Color(0xFF9E8FB3),
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodySmallIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        AuthUserStreamWidget(
                                          builder: (context) => Switch(
                                            value: _model.switchValue1!,
                                            onChanged: (newValue) async {
                                              safeSetState(() => _model
                                                  .switchValue1 = newValue);
                                              if (newValue) {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  messagesEnabled: true,
                                                ));
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'en') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notification turned on ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'de') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Benachrichtigung aktiviert ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'es') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notificación activada ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              } else {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  messagesEnabled: false,
                                                ));
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'en') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notification disabled ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'de') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Benachrichtigung deaktiviert ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'es') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notificación deshabilitada ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              }
                                            },
                                            activeThumbColor: Color(0xFFB39DDB),
                                            activeTrackColor: Color(0xFFEDE7F6),
                                            inactiveTrackColor:
                                                Color(0xFFEDE7F6),
                                            inactiveThumbColor:
                                                Color(0xFF9E8FB3),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                      color: Color(0xFFEDE7F6),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'ldrdhaki' /* Daily Question Alerts */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color: Color(0xFF6B5B95),
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 2.0, 0.0, 0.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'ul5it5ti' /* Receive a message when your pa... */,
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
                                                            Color(0xFF9E8FB3),
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodySmallIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        AuthUserStreamWidget(
                                          builder: (context) => Switch(
                                            value: _model.switchValue2!,
                                            onChanged: (newValue) async {
                                              safeSetState(() => _model
                                                  .switchValue2 = newValue);
                                              if (newValue) {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  dailyQuestionPartnerAlertsEnabled:
                                                      true,
                                                ));
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'en') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notification turned on ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'de') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Benachrichtigung aktiviert ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'es') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notificación activada ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              } else {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  dailyQuestionPartnerAlertsEnabled:
                                                      false,
                                                ));
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'en') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notification disabled ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'de') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Benachrichtigung deaktiviert ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'es') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notificación deshabilitada ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              }
                                            },
                                            activeThumbColor: Color(0xFFB39DDB),
                                            activeTrackColor: Color(0xFFEDE7F6),
                                            inactiveTrackColor:
                                                Color(0xFFEDE7F6),
                                            inactiveThumbColor:
                                                Color(0xFF9E8FB3),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                      color: Color(0xFFEDE7F6),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '4blsi4wa' /* Relationship Alerts */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color: Color(0xFF6B5B95),
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 2.0, 0.0, 0.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'sf300sbe' /* Requests, accepts
and disconne... */
                                                    ,
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
                                                            Color(0xFF9E8FB3),
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodySmallIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        AuthUserStreamWidget(
                                          builder: (context) => Switch(
                                            value: _model.switchValue3!,
                                            onChanged: (newValue) async {
                                              safeSetState(() => _model
                                                  .switchValue3 = newValue);
                                              if (newValue) {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  relationshipAlertsEnabled:
                                                      true,
                                                ));
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'en') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notification turned on ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'de') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Benachrichtigung aktiviert ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'es') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notificación activada ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              } else {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  relationshipAlertsEnabled:
                                                      false,
                                                ));
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'en') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notification disabled ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'de') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Benachrichtigung deaktiviert ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'es') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notificación deshabilitada ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              }
                                            },
                                            activeThumbColor: Color(0xFFB39DDB),
                                            activeTrackColor: Color(0xFFEDE7F6),
                                            inactiveTrackColor:
                                                Color(0xFFEDE7F6),
                                            inactiveThumbColor:
                                                Color(0xFF9E8FB3),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(height: 16.0)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'toa9ygcq' /* Shared Moments & Plans */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color: Color(0xFF6B5B95),
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 2.0, 0.0, 0.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '0gucdcel' /* Get notified about shared memo... */,
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
                                                            Color(0xFF9E8FB3),
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodySmallIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        AuthUserStreamWidget(
                                          builder: (context) => Switch(
                                            value: _model.switchValue4!,
                                            onChanged: (newValue) async {
                                              safeSetState(() => _model
                                                  .switchValue4 = newValue);
                                              if (newValue) {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  sharedMomentsEnabled: true,
                                                ));
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'en') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notification turned on ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'de') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Benachrichtigung aktiviert ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'es') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notificación activada ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              } else {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  sharedMomentsEnabled: false,
                                                ));
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'en') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notification disabled ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'de') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Benachrichtigung deaktiviert ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'es') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notificación deshabilitada ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              }
                                            },
                                            activeThumbColor: Color(0xFFB39DDB),
                                            activeTrackColor: Color(0xFFEDE7F6),
                                            inactiveTrackColor:
                                                Color(0xFFEDE7F6),
                                            inactiveThumbColor:
                                                Color(0xFF9E8FB3),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                      color: Color(0xFFEDE7F6),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '8rg7k9a8' /* Daily Question Reminders */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color: Color(0xFF6B5B95),
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 2.0, 0.0, 0.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '8gvb4fa0' /* Daily prompts to strengthen yo... */,
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
                                                            Color(0xFF9E8FB3),
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodySmallIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        AuthUserStreamWidget(
                                          builder: (context) => Switch(
                                            value: _model.switchValue5!,
                                            onChanged: (newValue) async {
                                              safeSetState(() => _model
                                                  .switchValue5 = newValue);
                                              if (newValue) {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  dailyQuestionRemindersEnabled:
                                                      true,
                                                ));
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'en') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notification turned on ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'de') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Benachrichtigung aktiviert ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'es') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notificación activada ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              } else {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  dailyQuestionRemindersEnabled:
                                                      false,
                                                ));
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'en') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notification disabled ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'de') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Benachrichtigung deaktiviert ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'es') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notificación deshabilitada ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              }
                                            },
                                            activeThumbColor: Color(0xFFB39DDB),
                                            activeTrackColor: Color(0xFFEDE7F6),
                                            inactiveTrackColor:
                                                Color(0xFFEDE7F6),
                                            inactiveThumbColor:
                                                Color(0xFF9E8FB3),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                      color: Color(0xFFEDE7F6),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'c49q5jis' /* Stay Connected Reminder */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color: Color(0xFF6B5B95),
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 2.0, 0.0, 0.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'dd7c5stp' /* Keep your connection alive wit... */,
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
                                                            Color(0xFF9E8FB3),
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodySmallIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        AuthUserStreamWidget(
                                          builder: (context) => Switch(
                                            value: _model.switchValue6!,
                                            onChanged: (newValue) async {
                                              safeSetState(() => _model
                                                  .switchValue6 = newValue);
                                              if (newValue) {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  stayConnectedRemindersEnabled:
                                                      true,
                                                ));
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'en') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notification turned on ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'de') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Benachrichtigung aktiviert ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'es') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notificación activada ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              } else {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  stayConnectedRemindersEnabled:
                                                      false,
                                                ));
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'en') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notification disabled ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'de') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Benachrichtigung deaktiviert ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'es') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Notificación deshabilitada ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              }
                                            },
                                            activeThumbColor: Color(0xFFB39DDB),
                                            activeTrackColor: Color(0xFFEDE7F6),
                                            inactiveTrackColor:
                                                Color(0xFFEDE7F6),
                                            inactiveThumbColor:
                                                Color(0xFF9E8FB3),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                      color: Color(0xFFEDE7F6),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  's9hqatta' /* Travel Tracking */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color: Color(0xFF6B5B95),
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 2.0, 0.0, 0.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    't0wpsozx' /* Enables GPS travel tracking */,
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
                                                            Color(0xFF9E8FB3),
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodySmallIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        AuthUserStreamWidget(
                                          builder: (context) => Switch(
                                            value: _model.switchValue7!,
                                            onChanged: (newValue) async {
                                              safeSetState(() => _model
                                                  .switchValue7 = newValue);
                                              if (newValue) {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  liveTravelTrackingEnabled:
                                                      true,
                                                ));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getVariableText(
                                                        enText:
                                                            'Travel tracking activated',
                                                        deText:
                                                            'Reiseverfolgung aktiviert',
                                                        esText:
                                                            'Seguimiento del viaje activado',
                                                      ),
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
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  liveTravelTrackingEnabled:
                                                      false,
                                                ));
                                                _model.views =
                                                    await queryRelationshipViewsRecordOnce(
                                                  singleRecord: true,
                                                ).then((s) => s.firstOrNull);

                                                await _model.views!.reference
                                                    .update(
                                                        createRelationshipViewsRecordData(
                                                  liveTravelTrackingEnabled:
                                                      false,
                                                ));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getVariableText(
                                                        enText:
                                                            'Travel tracking disabled',
                                                        deText:
                                                            'Reiseverfolgung deaktiviert',
                                                        esText:
                                                            'Seguimiento del viaje desactivado',
                                                      ),
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

                                                safeSetState(() {});
                                              }
                                            },
                                            activeThumbColor: Color(0xFFB39DDB),
                                            activeTrackColor: Color(0xFFEDE7F6),
                                            inactiveTrackColor:
                                                Color(0xFFEDE7F6),
                                            inactiveThumbColor:
                                                Color(0xFF9E8FB3),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(height: 16.0)),
                                ),
                              ),
                              Divider(
                                thickness: 1.0,
                                color: Color(0xFFEDE7F6),
                              ),
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '4jypingt' /* Mute all */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color: Color(0xFF6B5B95),
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 2.0, 0.0, 0.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'je33r8tm' /* Turns off all notifications */,
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
                                                            Color(0xFF9E8FB3),
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodySmallIsCustom,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        AuthUserStreamWidget(
                                          builder: (context) => Switch(
                                            value: _model.switchValue8!,
                                            onChanged: (newValue) async {
                                              safeSetState(() => _model
                                                  .switchValue8 = newValue);
                                              if (newValue) {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  muteAllNotifications: true,
                                                ));
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'en') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'All notifications turned off ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'de') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Alle Benachrichtigungen deaktiviert ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'es') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Todas las notificaciones desactivadas ❌',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              } else {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  muteAllNotifications: false,
                                                ));
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'en') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'All notifications turned on ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'de') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Alle Benachrichtigungen aktiviert ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                } else if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.appLanguage,
                                                        '') ==
                                                    'es') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Todas las notificaciones activadas ✅',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              }
                                            },
                                            activeThumbColor: Color(0xFFB39DDB),
                                            activeTrackColor: Color(0xFFEDE7F6),
                                            inactiveTrackColor:
                                                Color(0xFFEDE7F6),
                                            inactiveThumbColor:
                                                Color(0xFF9E8FB3),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(height: 16.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '8j7ekbhz' /* Relationship */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .labelLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelLargeFamily,
                                color: Color(0xFF8E7CC3),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelLargeIsCustom,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 12.0,
                                color: Color(0x1AD1C4E9),
                                offset: Offset(
                                  0.0,
                                  3.0,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.favorite,
                                            color: Color(0xFFEF9A9A),
                                            size: 20.0,
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'cd0e8y1m' /* Connect to your Partner */,
                                            ),
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
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 8.0)),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 2.0, 0.0, 0.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            '2x5vw4m5' /* Make a connection to your Part... */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily,
                                                color: Color(0xFFBCAAA4),
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmallIsCustom,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                FlutterFlowIconButton(
                                  borderRadius: 10.0,
                                  buttonSize: 40.0,
                                  fillColor:
                                      FlutterFlowTheme.of(context).primary,
                                  icon: Icon(
                                    Icons.chevron_right_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    size: 18.0,
                                  ),
                                  onPressed: () async {
                                    if ((valueOrDefault(
                                                    currentUserDocument
                                                        ?.lastRelationshipId,
                                                    '') !=
                                                '') &&
                                        (valueOrDefault<bool>(
                                                currentUserDocument
                                                    ?.restoreRequired,
                                                false) ==
                                            true)) {
                                      context.pushNamed(
                                        RestoreWidget.routeName,
                                        extra: <String, dynamic>{
                                          '__transition_info__': TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                          ),
                                        },
                                      );
                                    } else {
                                      context.pushNamed(
                                        ConnectV2Widget.routeName,
                                        extra: <String, dynamic>{
                                          '__transition_info__': TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                          ),
                                        },
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 12.0,
                                color: Color(0x1AD1C4E9),
                                offset: Offset(
                                  0.0,
                                  3.0,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.heart_broken_rounded,
                                            color: Color(0xFFEF9A9A),
                                            size: 20.0,
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'awcdfas8' /* Disconnect from Partner */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: Color(0xFFEF9A9A),
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 8.0)),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 2.0, 0.0, 0.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            '82qs8obv' /* This will end your connection ... */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily,
                                                color: Color(0xFFBCAAA4),
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmallIsCustom,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                FlutterFlowIconButton(
                                  borderRadius: 10.0,
                                  buttonSize: 40.0,
                                  fillColor: Color(0xFFFCE4EC),
                                  icon: Icon(
                                    Icons.chevron_right_rounded,
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    size: 18.0,
                                  ),
                                  onPressed: () async {
                                    if ((valueOrDefault(
                                                currentUserDocument
                                                    ?.relationshipId,
                                                '') ==
                                            '') ||
                                        (valueOrDefault(
                                                    currentUserDocument
                                                        ?.relationshipId,
                                                    '') ==
                                                '')) {
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        isDismissible: false,
                                        enableDrag: false,
                                        useSafeArea: true,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: PairRequiredSheetWidget(),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    } else {
                                      context.pushNamed(
                                        BrakeUpPageWidget.routeName,
                                        extra: <String, dynamic>{
                                          '__transition_info__': TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                          ),
                                        },
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'ozoxyccy' /* Support & Legal */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .labelLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelLargeFamily,
                                color: Color(0xFF8E7CC3),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelLargeIsCustom,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 12.0,
                                color: Color(0x1AD1C4E9),
                                offset: Offset(
                                  0.0,
                                  3.0,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'fl6g6pmm' /* Terms & Privacy Policy */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: Color(0xFF6B5B95),
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                    FlutterFlowIconButton(
                                      borderRadius: 10.0,
                                      buttonSize: 40.0,
                                      fillColor: Color(0xFFEDE7F6),
                                      icon: Icon(
                                        Icons.chevron_right_rounded,
                                        color: Color(0xFF8E7CC3),
                                        size: 18.0,
                                      ),
                                      onPressed: () async {
                                        context.pushNamed(
                                            TermsPageWidget.routeName);
                                      },
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: Color(0xFFEDE7F6),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'ot59l0mc' /* Contact Support */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: Color(0xFF6B5B95),
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                    FlutterFlowIconButton(
                                      borderRadius: 10.0,
                                      buttonSize: 40.0,
                                      fillColor: Color(0xFFEDE7F6),
                                      icon: Icon(
                                        Icons.chevron_right_rounded,
                                        color: Color(0xFF8E7CC3),
                                        size: 18.0,
                                      ),
                                      onPressed: () async {
                                        context.pushNamed(
                                            SupportPageWidget.routeName);
                                      },
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: Color(0xFFEDE7F6),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '9lbklr2u' /* Tell your story */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: Color(0xFF6B5B95),
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                    FlutterFlowIconButton(
                                      borderRadius: 10.0,
                                      buttonSize: 40.0,
                                      fillColor: Color(0xFFEDE7F6),
                                      icon: Icon(
                                        Icons.chevron_right_rounded,
                                        color: Color(0xFF8E7CC3),
                                        size: 18.0,
                                      ),
                                      onPressed: () async {
                                        context.pushNamed(
                                            ShareYourStoryWidget.routeName);
                                      },
                                    ),
                                  ],
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            ),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          GoRouter.of(context).prepareAuthEvent();
                          await authManager.signOut();
                          GoRouter.of(context).clearRedirectLocation();

                          context.goNamedAuth(
                            S1HeroWidget.routeName,
                            context.mounted,
                            extra: <String, dynamic>{
                              '__transition_info__': TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.fade,
                              ),
                            },
                          );
                        },
                        text: FFLocalizations.of(context).getText(
                          '8wo9nu9b' /* Logout */,
                        ),
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: Colors.white,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleSmallIsCustom,
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          var confirmDialogResponse = await showDialog<bool>(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text(FFLocalizations.of(context)
                                        .getVariableText(
                                      enText: 'Delete account completely',
                                      deText: 'Konto vollständig löschen',
                                      esText: 'Eliminar la cuenta por completo',
                                    )),
                                    content: Text(FFLocalizations.of(context)
                                        .getVariableText(
                                      enText:
                                          'Are you sure you want to permanently delete your account?',
                                      deText:
                                          'Bist du sicher, dass du dein Konto dauerhaft löschen möchtest?',
                                      esText:
                                          '¿Estás seguro de que quieres eliminar tu cuenta de forma permanente?',
                                    )),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, false),
                                        child: Text(FFLocalizations.of(context)
                                            .getVariableText(
                                          enText: 'No, keep my account',
                                          deText: 'Nein, Konto behalten',
                                          esText: 'No, conservar mi cuenta',
                                        )),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, true),
                                        child: Text(FFLocalizations.of(context)
                                            .getVariableText(
                                          enText:
                                              'Yes, I want to delete my account.',
                                          deText:
                                              'Ja, ich möchte mein Konto löschen.',
                                          esText:
                                              'Sí, quiero eliminar mi cuenta.',
                                        )),
                                      ),
                                    ],
                                  );
                                },
                              ) ??
                              false;
                          if (confirmDialogResponse) {
                            logFirebaseEvent('deleted_user');
                            try {
                              final result =
                                  await FirebaseFunctions.instanceFor(
                                          region: 'europe-west3')
                                      .httpsCallable('deleteMyAccount')
                                      .call({});
                              _model.del =
                                  DeleteMyAccountCloudFunctionCallResponse(
                                succeeded: true,
                              );
                            } on FirebaseFunctionsException catch (error) {
                              _model.del =
                                  DeleteMyAccountCloudFunctionCallResponse(
                                errorCode: error.code,
                                succeeded: false,
                              );
                            }

                            if (_model.del!.succeeded!) {
                              GoRouter.of(context).prepareAuthEvent();
                              await authManager.signOut();
                              GoRouter.of(context).clearRedirectLocation();

                              context.goNamedAuth(
                                S1HeroWidget.routeName,
                                context.mounted,
                                extra: <String, dynamic>{
                                  '__transition_info__': TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 0),
                                  ),
                                },
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    FFLocalizations.of(context).getVariableText(
                                      enText: 'May the force be with you 🫂',
                                      deText: 'Möge die Macht mit dir sein 🫂',
                                      esText: 'Que la fuerza te acompañe 🫂',
                                    ),
                                    style: GoogleFonts.roboto(
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      fontSize: 14.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    FFLocalizations.of(context).getVariableText(
                                      enText: 'Please re-login and try again',
                                      deText:
                                          'Bitte melde dich erneut an und versuche es noch einmal',
                                      esText:
                                          'Por favor, vuelve a iniciar sesión e inténtalo de nuevo',
                                    ),
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).secondary,
                                ),
                              );
                            }
                          } else {
                            Navigator.pop(context);
                          }

                          safeSetState(() {});
                        },
                        text: FFLocalizations.of(context).getText(
                          '42k5einh' /* Delete account */,
                        ),
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).tertiary,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: Colors.white,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleSmallIsCustom,
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ],
                  ),
                ]
                    .divide(SizedBox(height: 24.0))
                    .addToStart(SizedBox(height: 20.0))
                    .addToEnd(SizedBox(height: 32.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
