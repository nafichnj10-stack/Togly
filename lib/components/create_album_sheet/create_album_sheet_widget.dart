import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:firebase_storagelibrary_2sa6k9/custom_code/actions/index.dart'
    as firebase_storagelibrary_2sa6k9_actions;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'create_album_sheet_model.dart';
export 'create_album_sheet_model.dart';

/// Create a modal bottom sheet named CreateAlbumSheet matching my
/// lilac/purple theme: light lilac background, white cards, large 20–24px
/// corners, subtle shadow, 16–20px spacing.
///
/// Height ~75%, safe area, scrollable.
/// Header: small drag handle, circular heart icon, title “Create Album”,
/// subtitle “Share your memories together.”
/// Form card:
///
/// Text field: label “Album title”, placeholder “E.g., Happy Laughs”, leading
/// album icon, visual counter “0/40”.
///
/// Cover image (optional): square 1:1 placeholder with dashed primary border,
/// plus/camera icon, caption “Add cover image (optional)”. Below: styled text
/// buttons “Choose image” and “Remove” (visual only).
/// Footer (sticky): pill “Create album” primary button (56px), and “Cancel”
/// text button.
/// Keep typography/colors consistent with Gallery/“Add Wish
class CreateAlbumSheetWidget extends StatefulWidget {
  const CreateAlbumSheetWidget({super.key});

  @override
  State<CreateAlbumSheetWidget> createState() => _CreateAlbumSheetWidgetState();
}

class _CreateAlbumSheetWidgetState extends State<CreateAlbumSheetWidget> {
  late CreateAlbumSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateAlbumSheetModel());

    _model.albumTitleFieldTextController ??= TextEditingController();
    _model.albumTitleFieldFocusNode ??= FocusNode();

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
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
        child: Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.75,
          decoration: BoxDecoration(
            color: Color(0xFFF8F5FF),
            boxShadow: [
              BoxShadow(
                blurRadius: 8.0,
                color: Color(0x33000000),
                offset: Offset(
                  0.0,
                  -2.0,
                ),
                spreadRadius: 0.0,
              )
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
            child: SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40.0,
                            height: 4.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFE0E3E7),
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 48.0,
                                height: 48.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primary,
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '6pj824vd' /* Create Album */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleLargeFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .titleLargeIsCustom,
                                          ),
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'xq0vhcxu' /* Share your memories together. */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ].divide(SizedBox(height: 12.0)),
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryText,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x1A000000),
                          offset: Offset(
                            0.0,
                            2.0,
                          ),
                          spreadRadius: 0.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          20.0, 20.0, 20.0, 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'xj1p4h8z' /* Album title */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelMediumFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .labelMediumIsCustom,
                                    ),
                              ),
                              Form(
                                key: _model.formKey,
                                autovalidateMode: AutovalidateMode.always,
                                child: TextFormField(
                                  controller:
                                      _model.albumTitleFieldTextController,
                                  focusNode: _model.albumTitleFieldFocusNode,
                                  autofocus: false,
                                  textInputAction: TextInputAction.next,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText:
                                        FFLocalizations.of(context).getText(
                                      'sge0bjwg' /* E.g., Happy Laughs */,
                                    ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    filled: true,
                                    fillColor:
                                        FlutterFlowTheme.of(context).primary,
                                    prefixIcon: Icon(
                                      Icons.album,
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                  minLines: 1,
                                  validator: _model
                                      .albumTitleFieldTextControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            ].divide(SizedBox(height: 8.0)),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  '73gfj4k6' /* Cover image */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelMediumFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .labelMediumIsCustom,
                                    ),
                              ),
                              Container(
                                width: 120.0,
                                height: 120.0,
                                decoration: BoxDecoration(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 2.0,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (_model.coverFile != null &&
                                        (_model.coverFile?.bytes?.isNotEmpty ??
                                            false))
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.memory(
                                          _model.coverFile?.bytes ??
                                              Uint8List.fromList([]),
                                          width: 116.0,
                                          height: 116.0,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            'assets/images/error_image.png',
                                            width: 116.0,
                                            height: 116.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    if (_model.coverFile == null ||
                                        (_model.coverFile?.bytes?.isEmpty ??
                                            true))
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 16.0, 16.0, 16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add_a_photo,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 32.0,
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'sfnwbcoq' /* Add cover */,
                                              ),
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelSmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmallFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmallIsCustom,
                                                  ),
                                            ),
                                          ].divide(SizedBox(height: 8.0)),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () async {
                                      final selectedMedia = await selectMedia(
                                        imageQuality: 75,
                                        mediaSource: MediaSource.photoGallery,
                                        multiImage: false,
                                      );
                                      if (selectedMedia != null &&
                                          selectedMedia.every((m) =>
                                              validateFileFormat(
                                                  m.storagePath, context))) {
                                        safeSetState(() => _model
                                                .isDataUploading_chooseCoverData =
                                            true);
                                        var selectedUploadedFiles =
                                            <FFUploadedFile>[];

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
                                        } finally {
                                          _model.isDataUploading_chooseCoverData =
                                              false;
                                        }
                                        if (selectedUploadedFiles.length ==
                                            selectedMedia.length) {
                                          safeSetState(() {
                                            _model.uploadedLocalFile_chooseCoverData =
                                                selectedUploadedFiles.first;
                                          });
                                        } else {
                                          safeSetState(() {});
                                          return;
                                        }
                                      }

                                      _model.coverFile = _model
                                          .uploadedLocalFile_chooseCoverData;
                                      safeSetState(() {});
                                    },
                                    text: FFLocalizations.of(context).getText(
                                      'o1krvt50' /* Choose cover */,
                                    ),
                                    options: FFButtonOptions(
                                      width: 120.0,
                                      height: 36.0,
                                      padding: EdgeInsets.all(8.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Color(0x00FFFFFF),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelMediumIsCustom,
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                            ].divide(SizedBox(height: 12.0)),
                          ),
                        ].divide(SizedBox(height: 20.0)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        text: FFLocalizations.of(context).getText(
                          'xgo6p9jr' /* Cancel */,
                        ),
                        options: FFButtonOptions(
                          width: 100.0,
                          height: 56.0,
                          padding: EdgeInsets.all(8.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Color(0x00FFFFFF),
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleSmallIsCustom,
                              ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                      ),
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            _model.albumForm = true;
                            if (_model.formKey.currentState == null ||
                                !_model.formKey.currentState!.validate()) {
                              safeSetState(() => _model.albumForm = false);
                              return;
                            }
                            if (_model.coverFile != null &&
                                (_model.coverFile?.bytes?.isNotEmpty ??
                                    false)) {
                              var albumsRecordReference =
                                  AlbumsRecord.collection.doc();
                              await albumsRecordReference
                                  .set(createAlbumsRecordData(
                                relationshipId: valueOrDefault(
                                    currentUserDocument?.relationshipId, ''),
                                title:
                                    _model.albumTitleFieldTextController.text,
                                coverUrl: '\"',
                                createdBy: currentUserUid,
                                createdAt: getCurrentTimestamp,
                                photoCount: 0,
                              ));
                              _model.newAlbumRef =
                                  AlbumsRecord.getDocumentFromData(
                                      createAlbumsRecordData(
                                        relationshipId: valueOrDefault(
                                            currentUserDocument?.relationshipId,
                                            ''),
                                        title: _model
                                            .albumTitleFieldTextController.text,
                                        coverUrl: '\"',
                                        createdBy: currentUserUid,
                                        createdAt: getCurrentTimestamp,
                                        photoCount: 0,
                                      ),
                                      albumsRecordReference);
                              logFirebaseEvent(
                                'gallery_album_created',
                                parameters: {
                                  'source': 'gallery',
                                  'role': 'initiator',
                                },
                              );
                              _model.coverUpload =
                                  await firebase_storagelibrary_2sa6k9_actions
                                      .uploadFileToBucket(
                                '',
                                'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/albums/${_model.newAlbumRef?.reference.id}/cover.jpg',
                                _model.coverFile!,
                                '',
                              );
                              _model.coverURL =
                                  await firebase_storagelibrary_2sa6k9_actions
                                      .getDownloadUrl(
                                '',
                                'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/albums/${_model.newAlbumRef?.reference.id}/cover.jpg',
                              );

                              await _model.newAlbumRef!.reference
                                  .update(createAlbumsRecordData(
                                coverUrl: _model.coverURL,
                                storagePath:
                                    'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/albums/${_model.newAlbumRef?.reference.id}/cover.jpg',
                              ));
                              Navigator.pop(context);
                              _model.partnerUserRecord =
                                  await queryUsersRecordOnce(
                                queryBuilder: (usersRecord) =>
                                    usersRecord.where(
                                  'uid',
                                  isEqualTo: valueOrDefault(
                                      currentUserDocument?.partnerUID, ''),
                                ),
                                singleRecord: true,
                              ).then((s) => s.firstOrNull);
                              try {
                                final result =
                                    await FirebaseFunctions.instanceFor(
                                            region: 'europe-west3')
                                        .httpsCallable('sendPartnerPush')
                                        .call({
                                  "type": 'album_created',
                                  "route": 'albumDetailPage',
                                  "audience": 'partner',
                                });
                                _model.cloudFunction6oy =
                                    SendPartnerPushCloudFunctionCallResponse(
                                  data: result.data,
                                  succeeded: true,
                                  resultAsString: result.data.toString(),
                                  jsonBody: result.data,
                                );
                              } on FirebaseFunctionsException catch (error) {
                                _model.cloudFunction6oy =
                                    SendPartnerPushCloudFunctionCallResponse(
                                  errorCode: error.code,
                                  succeeded: false,
                                );
                              }
                            } else {
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('No cover image'),
                                            content: Text(
                                                'Please choose a cover image'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: Text('Okay'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                            }

                            safeSetState(() {});
                          },
                          text: FFLocalizations.of(context).getText(
                            'dmzkqz8j' /* Create album */,
                          ),
                          options: FFButtonOptions(
                            height: 56.0,
                            padding: EdgeInsets.all(8.0),
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
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(28.0),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(width: 16.0)),
                  ),
                ].divide(SizedBox(height: 20.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
