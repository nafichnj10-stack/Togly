import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 's6_photo_model.dart';
export 's6_photo_model.dart';

/// Create a full-screen onboarding page for uploading a profile photo.
///
/// Use a vertical column layout, centered, mobile-first and responsive.
///
/// Full-screen background image (placeholder, replaceable later).
///
/// Top: large headline text “Add your photo”.
/// Below: smaller subtitle “Upload a photo to personalize your profile.”
///
/// Center: large circular avatar container with rounded border and soft
/// glow/shadow.
/// Inside: placeholder profile icon with a small camera icon overlay.
/// This circle should later display the uploaded image.
///
/// Below: primary rounded gradient button labeled “Upload photo”.
/// Semi-transparent / glassmorphism style with subtle shadow.
///
/// Below it: secondary rounded outline button labeled “Skip”.
/// Smaller and less visually prominent.
///
/// Style: romantic pastel design, soft purple/pink tones, smooth gradients,
/// rounded corners, subtle shadows, modern premium feel.
///
/// Keep everything centered with clean spacing. Avoid overflow
class S6PhotoWidget extends StatefulWidget {
  const S6PhotoWidget({super.key});

  static String routeName = 'S6_photo';
  static String routePath = '/s6Photo';

  @override
  State<S6PhotoWidget> createState() => _S6PhotoWidgetState();
}

class _S6PhotoWidgetState extends State<S6PhotoWidget> {
  late S6PhotoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => S6PhotoModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'S6_photo'});
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PublicUsersRecord>>(
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
          return Scaffold(
            backgroundColor: Color(0xFFF5F0FF),
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
        List<PublicUsersRecord> s6PhotoPublicUsersRecordList = snapshot.data!;
        final s6PhotoPublicUsersRecord = s6PhotoPublicUsersRecordList.isNotEmpty
            ? s6PhotoPublicUsersRecordList.first
            : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFFF5F0FF),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/background_photoupload.webp',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Opacity(
                    opacity: 0.0,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0x4DF5F0FF),
                            Color(0x66E8D4F7),
                            Color(0x80F0E6FF)
                          ],
                          stops: [0.0, 0.3, 1.0],
                          begin: AlignmentDirectional(1.0, -1.0),
                          end: AlignmentDirectional(-1.0, 1.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
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
                                'im8qczu0' /* Add your photo */,
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .displayMedium
                                  .override(
                                font: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .displayMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 36.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .displayMedium
                                    .fontStyle,
                                shadows: [
                                  Shadow(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 2.0,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  '4vgxbdni' /* Upload a photo to personalize ... */,
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyLargeFamily,
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      lineHeight: 1.4,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyLargeIsCustom,
                                    ),
                              ),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                        Container(
                          width: 180.0,
                          height: 180.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.network(
                                s6PhotoPublicUsersRecord!.photoUrl,
                              ).image,
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 20.0,
                                color: Color(0x4DF5D4FF),
                                offset: Offset(
                                  0.0,
                                  8.0,
                                ),
                              )
                            ],
                            gradient: LinearGradient(
                              colors: [Colors.white, Color(0xCCFFFFFF)],
                              stops: [0.2, 0.8],
                              begin: AlignmentDirectional(0.0, -1.0),
                              end: AlignmentDirectional(0, 1.0),
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0x66FFFFFF),
                              width: 2.0,
                            ),
                          ),
                          child: Stack(
                            children: [
                              if (s6PhotoPublicUsersRecord.photoUrl == '')
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Icon(
                                    Icons.person_rounded,
                                    color: Color(0xFFB8A3D1),
                                    size: 80.0,
                                  ),
                                ),
                              Align(
                                alignment: AlignmentDirectional(0.7, 0.7),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    // UploadData_Profilbild
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
                                      safeSetState(() => _model
                                              .isDataUploading_uploadData2s71 =
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
                                                  height: m.dimensions?.height,
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
                                        _model.isDataUploading_uploadData2s71 =
                                            false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        safeSetState(() {
                                          _model.uploadedLocalFile_uploadData2s71 =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl_uploadData2s71 =
                                              downloadUrls.first;
                                        });
                                      } else {
                                        safeSetState(() {});
                                        return;
                                      }
                                    }

                                    if (_model.uploadedFileUrl_uploadData2s71 !=
                                            '') {
                                      if (valueOrDefault(
                                              currentUserDocument?.appLanguage,
                                              '') ==
                                          'en') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Your profile picture has been uploaded',
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
                                      } else if (valueOrDefault(
                                              currentUserDocument?.appLanguage,
                                              '') ==
                                          'de') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Dein Profilbild wurde hochgeladen.',
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
                                      } else if (valueOrDefault(
                                              currentUserDocument?.appLanguage,
                                              '') ==
                                          'es') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Tu foto de perfil ha sido subida',
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

                                      // BackendCall1

                                      await s6PhotoPublicUsersRecord.reference
                                          .update(createPublicUsersRecordData(
                                        photoUrl: _model
                                            .uploadedFileUrl_uploadData2s71,
                                      ));
                                    }
                                  },
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 8.0,
                                          color: Color(0x33D4B8E8),
                                          offset: Offset(
                                            0.0,
                                            4.0,
                                          ),
                                        )
                                      ],
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFE8D4F7),
                                          Color(0xFFD4B8E8)
                                        ],
                                        stops: [1.0, 1.0],
                                        begin: AlignmentDirectional(1.0, 1.0),
                                        end: AlignmentDirectional(-1.0, -1.0),
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Icon(
                                        Icons.camera_alt_rounded,
                                        color: Color(0xFF6B4A7A),
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                await s6PhotoPublicUsersRecord.reference
                                    .update(createPublicUsersRecordData(
                                  photoUrl: s6PhotoPublicUsersRecord.photoUrl,
                                ));

                                await currentUserReference!
                                    .update(createUsersRecordData(
                                  onboardingStep: 'birthday',
                                ));

                                context.pushNamed(
                                  S7BirthWidget.routeName,
                                  extra: <String, dynamic>{
                                    '__transition_info__': TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                    ),
                                  },
                                );
                              },
                              text: FFLocalizations.of(context).getText(
                                'd4w0hy1y' /* Continue */,
                              ),
                              options: FFButtonOptions(
                                width: 280.0,
                                height: 56.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    32.0, 0.0, 32.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Color(0x80FF7AC8),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleMediumFamily,
                                      color: Colors.white,
                                      fontSize: 18.0,
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
                                              .titleMediumIsCustom,
                                    ),
                                elevation: 8.0,
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  width: 0.0,
                                ),
                                borderRadius: BorderRadius.circular(28.0),
                              ),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                await currentUserReference!
                                    .update(createUsersRecordData(
                                  onboardingStep: 'birthday',
                                ));

                                context.pushNamed(
                                  S7BirthWidget.routeName,
                                  extra: <String, dynamic>{
                                    '__transition_info__': TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                    ),
                                  },
                                );
                              },
                              text: FFLocalizations.of(context).getText(
                                '3b76kzew' /* Skip */,
                              ),
                              options: FFButtonOptions(
                                width: 200.0,
                                height: 48.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Color(0x6F9F7BFF),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleMediumFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
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
                                              .titleMediumIsCustom,
                                    ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  width: 0.0,
                                ),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                      ].divide(SizedBox(height: 32.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
