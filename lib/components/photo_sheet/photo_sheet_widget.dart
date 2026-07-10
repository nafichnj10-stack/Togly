import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:firebase_storagelibrary_2sa6k9/custom_code/actions/index.dart'
    as firebase_storagelibrary_2sa6k9_actions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'photo_sheet_model.dart';
export 'photo_sheet_model.dart';

/// Create a dreamy, sweet, romantic mobile bottom sheet for recording a voice
/// note inside a couples app feature called “Love Treasure”.
///
/// The sheet should feel warm, playful, magical, and emotionally soft. Use
/// pastel pink, lilac, peach, and purple tones with rounded shapes, subtle
/// glow, and a frosted glass aesthetic.
///
/// Include:
/// - Rounded top corners
/// - A small drag handle
/// - Title: “Voice Note”
/// - Subtitle: “Record something your partner can keep forever 💜”
///
/// Main section:
/// - A large cute circular microphone button in the center
/// - The button should feel inviting and tappable
/// - Soft romantic gradient
/// - Glow effect around it
/// - Under it, a timer display like “00:00”
/// - Under the timer, helper text:
///   “Tap to start recording”
///
/// Controls:
/// - Start
/// - Stop
/// - Preview
///
/// Optional:
/// - A small title input with placeholder:
///   “Give this voice note a little title...”
///
/// Bottom:
/// - Main button: “Save to Treasure”
/// - Secondary action: “Cancel”
///
/// Make the whole sheet feel beautiful, emotionally special, and aligned with
/// a romantic treasure/chest themed couples app. It should feel like creating
/// a sweet hidden surprise for someone you love.
class PhotoSheetWidget extends StatefulWidget {
  const PhotoSheetWidget({
    super.key,
    required this.treasureRef,
  });

  final DocumentReference? treasureRef;

  @override
  State<PhotoSheetWidget> createState() => _PhotoSheetWidgetState();
}

class _PhotoSheetWidgetState extends State<PhotoSheetWidget> {
  late PhotoSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PhotoSheetModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFF8F9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.0),
            topRight: Radius.circular(32.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 24.0),
          child: SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 48.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFE0C8E8),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        'wc3knxz6' /* Add Photos */,
                      ),
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineMediumFamily,
                                color: Color(0xFF6B3FA0),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .headlineMediumIsCustom,
                              ),
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        'jynlfp8w' /* Choose a special photo to hide... */,
                      ),
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelMediumFamily,
                            color: Color(0xFFB07CC6),
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .labelMediumIsCustom,
                          ),
                    ),
                  ].divide(SizedBox(height: 6.0)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        final selectedMedia = await selectMedia(
                          imageQuality: 80,
                          multiImage: false,
                        );
                        if (selectedMedia != null &&
                            selectedMedia.every((m) =>
                                validateFileFormat(m.storagePath, context))) {
                          safeSetState(
                              () => _model.isDataUploading_photoCamera = true);
                          var selectedUploadedFiles = <FFUploadedFile>[];

                          try {
                            selectedUploadedFiles = selectedMedia
                                .map((m) => FFUploadedFile(
                                      name: m.storagePath.split('/').last,
                                      bytes: m.bytes,
                                      height: m.dimensions?.height,
                                      width: m.dimensions?.width,
                                      blurHash: m.blurHash,
                                      originalFilename: m.originalFilename,
                                    ))
                                .toList();
                          } finally {
                            _model.isDataUploading_photoCamera = false;
                          }
                          if (selectedUploadedFiles.length ==
                              selectedMedia.length) {
                            safeSetState(() {
                              _model.uploadedLocalFile_photoCamera =
                                  selectedUploadedFiles.first;
                            });
                          } else {
                            safeSetState(() {});
                            return;
                          }
                        }

                        _model.selectedTreasurePhoto =
                            _model.uploadedLocalFile_photoCamera;
                        safeSetState(() {});
                      },
                      child: Container(
                        width: 140.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFF3E8FF),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8.0,
                              color: Color(0xFFD8B4FE),
                              offset: Offset(
                                0.0,
                                2.0,
                              ),
                              spreadRadius: 0.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Color(0xFFD8B4FE),
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                color: Color(0xFF7C3AED),
                                size: 28.0,
                              ),
                              Text(
                                FFLocalizations.of(context).getText(
                                  'bt4uzokv' /* Take Photo */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelLargeFamily,
                                      color: Color(0xFF7C3AED),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .labelLargeIsCustom,
                                    ),
                              ),
                            ].divide(SizedBox(height: 8.0)),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        final selectedMedia = await selectMedia(
                          imageQuality: 80,
                          mediaSource: MediaSource.photoGallery,
                          multiImage: false,
                        );
                        if (selectedMedia != null &&
                            selectedMedia.every((m) =>
                                validateFileFormat(m.storagePath, context))) {
                          safeSetState(
                              () => _model.isDataUploading_photoGalerie = true);
                          var selectedUploadedFiles = <FFUploadedFile>[];

                          try {
                            selectedUploadedFiles = selectedMedia
                                .map((m) => FFUploadedFile(
                                      name: m.storagePath.split('/').last,
                                      bytes: m.bytes,
                                      height: m.dimensions?.height,
                                      width: m.dimensions?.width,
                                      blurHash: m.blurHash,
                                      originalFilename: m.originalFilename,
                                    ))
                                .toList();
                          } finally {
                            _model.isDataUploading_photoGalerie = false;
                          }
                          if (selectedUploadedFiles.length ==
                              selectedMedia.length) {
                            safeSetState(() {
                              _model.uploadedLocalFile_photoGalerie =
                                  selectedUploadedFiles.first;
                            });
                          } else {
                            safeSetState(() {});
                            return;
                          }
                        }

                        _model.selectedTreasurePhoto =
                            _model.uploadedLocalFile_photoGalerie;
                        safeSetState(() {});
                      },
                      child: Container(
                        width: 140.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFFDF2F8),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8.0,
                              color: Color(0xFFF9A8D4),
                              offset: Offset(
                                0.0,
                                2.0,
                              ),
                              spreadRadius: 0.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Color(0xFFF9A8D4),
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo_library_rounded,
                                color: FlutterFlowTheme.of(context).tertiary,
                                size: 28.0,
                              ),
                              Text(
                                FFLocalizations.of(context).getText(
                                  'f97nq024' /* From Gallery */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelLargeFamily,
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .labelLargeIsCustom,
                                    ),
                              ),
                            ].divide(SizedBox(height: 8.0)),
                          ),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(width: 12.0)),
                ),
                if (_model.selectedTreasurePhoto != null &&
                    (_model.selectedTreasurePhoto?.bytes?.isNotEmpty ?? false))
                  Container(
                    width: double.infinity,
                    height: 220.0,
                    child: custom_widgets.TreasurePhotoPreview(
                      width: double.infinity,
                      height: 220.0,
                      borderRadius: 28.0,
                      uploadedFile: _model.selectedTreasurePhoto,
                    ),
                  ),
                if (_model.selectedTreasurePhoto == null ||
                    (_model.selectedTreasurePhoto?.bytes?.isEmpty ?? true))
                  Container(
                    width: double.infinity,
                    height: 220.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFFDF4FF),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 16.0,
                          color: Color(0xFFE9D5FF),
                          offset: Offset(
                            0.0,
                            4.0,
                          ),
                          spreadRadius: 0.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(24.0),
                      border: Border.all(
                        color: Color(0xFFE9D5FF),
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          24.0, 24.0, 24.0, 24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 72.0,
                            height: 72.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFF3E8FF),
                              borderRadius: BorderRadius.circular(36.0),
                            ),
                            child: Icon(
                              Icons.image_search_rounded,
                              color: Color(0xFFA855F7),
                              size: 36.0,
                            ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'lp7n1trd' /* No photo selected yet */,
                            ),
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleSmallFamily,
                                  color: Color(0xFF9333EA),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleSmallIsCustom,
                                ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'obcsc800' /* Choose or take a photo to prev... */,
                            ),
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  color: Color(0xFFC084FC),
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _model.textController,
                        focusNode: _model.textFieldFocusNode,
                        autofocus: false,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: FFLocalizations.of(context).getText(
                            'seij3wbi' /* Title of the image */,
                          ),
                          hintStyle: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyMediumIsCustom,
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          filled: true,
                          fillColor: FlutterFlowTheme.of(context).accent1,
                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 16.0),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                        minLines: 1,
                        validator:
                            _model.textControllerValidator.asValidator(context),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock_outline_rounded,
                            color: Color(0xFFC084FC),
                            size: 14.0,
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'm5x3mduw' /* Your partner won't see it unti... */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelSmallFamily,
                                  color: Color(0xFFC084FC),
                                  fontSize: 10.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelSmallIsCustom,
                                ),
                          ),
                        ].divide(SizedBox(width: 6.0)),
                      ),
                    ].divide(SizedBox(height: 8.0)),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 100.0,
                          height: 55.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFF3E8FF),
                            borderRadius: BorderRadius.circular(26.0),
                            border: Border.all(
                              color: Color(0xFFD8B4FE),
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 12.0, 12.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'nvwyd8yl' /* Cancel */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                        color: Color(0xFF7C3AED),
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleSmallIsCustom,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
                          if (_model.selectedTreasurePhoto != null &&
                              (_model.selectedTreasurePhoto?.bytes
                                      ?.isNotEmpty ??
                                  false)) {
                            _model.generatedTreasurePhotoFileName =
                                'tp_${currentUserUid}_${getCurrentTimestamp.millisecondsSinceEpoch.toString()}';
                            safeSetState(() {});
                            _model.treasurePhotoDownloadUrl1 =
                                await firebase_storagelibrary_2sa6k9_actions
                                    .uploadFileToBucket(
                              '',
                              'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/love_treasures/${widget.treasureRef?.id}/photos/${_model.generatedTreasurePhotoFileName}.jpg',
                              _model.selectedTreasurePhoto!,
                              '',
                            );
                            _model.treasurePhotoDownloadUrl =
                                await actions.getStorageDownloadUrlV2(
                              'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/love_treasures/${widget.treasureRef?.id}/photos/${_model.generatedTreasurePhotoFileName}.jpg',
                              '',
                            );

                            await TreasureSurprisesRecord.collection
                                .doc()
                                .set(createTreasureSurprisesRecordData(
                                  type: 'photo',
                                  image: _model.treasurePhotoDownloadUrl,
                                  title: _model.textController.text,
                                  createdAt: getCurrentTimestamp,
                                  createdByUid: currentUserUid,
                                  relationshipId: valueOrDefault(
                                      currentUserDocument?.relationshipId, ''),
                                  createdBy: currentUserReference,
                                  storagePath:
                                      'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/love_treasures/${widget.treasureRef?.id}/photos/${_model.generatedTreasurePhotoFileName}.jpg',
                                  revealed: false,
                                  revealOrder: 0,
                                  treasureRef: widget.treasureRef,
                                ));
                            Navigator.pop(context);
                            if (valueOrDefault(
                                    currentUserDocument?.appLanguage, '') ==
                                'en') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Photo has been added',
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
                            } else if (valueOrDefault(
                                    currentUserDocument?.appLanguage, '') ==
                                'de') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Foto wurde hinzugefügt',
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
                            } else if (valueOrDefault(
                                    currentUserDocument?.appLanguage, '') ==
                                'es') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'La foto ha sido añadida',
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
                            if (valueOrDefault(
                                    currentUserDocument?.appLanguage, '') ==
                                'en') {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('No Image found'),
                                    content:
                                        Text('No image was captured/selected'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (valueOrDefault(
                                    currentUserDocument?.appLanguage, '') ==
                                'de') {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Kein Bild gefunden'),
                                    content: Text(
                                        'Kein Bild aufgenommen oder ausgewählt'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (valueOrDefault(
                                    currentUserDocument?.appLanguage, '') ==
                                'es') {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title:
                                        Text('No se encontró ninguna imagen'),
                                    content: Text(
                                        'No se capturó ni se seleccionó ninguna imagen'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
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
                        child: Container(
                          width: 200.0,
                          height: 52.0,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 16.0,
                                color: Color(0xFFC084FC),
                                offset: Offset(
                                  0.0,
                                  4.0,
                                ),
                                spreadRadius: 0.0,
                              )
                            ],
                            gradient: LinearGradient(
                              colors: [Color(0xFF7C3AED), Color(0xFFDB2777)],
                              stops: [0.0, 1.0],
                              begin: AlignmentDirectional(1.0, 1.0),
                              end: AlignmentDirectional(-1.0, -1.0),
                            ),
                            borderRadius: BorderRadius.circular(26.0),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 12.0, 12.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.white,
                                  size: 18.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'gy3atfo5' /* Put it in the Treasure */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleSmallIsCustom,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(width: 12.0)),
                  ),
                ),
              ].divide(SizedBox(height: 20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
