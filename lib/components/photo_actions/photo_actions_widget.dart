import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:firebase_storagelibrary_2sa6k9/flutter_flow/custom_functions.dart'
    as firebase_storagelibrary_2sa6k9_functions;
import 'package:collection/collection.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'photo_actions_model.dart';
export 'photo_actions_model.dart';

/// Create an iOS-style modal bottom sheet component PhotoActions.
///
/// Rounded top-corners (28), pill handle at top center, ultra-soft shadow.
/// Inside:
///
/// A square 72 px preview (image bound to imageUrl, 12 radius).
///
/// Title: “What do you want to do?” (title3), subtitle: file name or “Image”.
///
/// Three primary buttons (full width, 52 px height, rounded 14):
///
/// View (icon Maximize2)
///
/// Download (icon ArrowDownToLine)
///
/// Delete (icon Trash, destructive/red background with white text)
/// Spacing 12/16 px, system blur background 24 with card layer.
/// Include Haptics on tap (light for View/Download, warning for Delete).
/// Provide light/dark color tokens and accessible contrast
class PhotoActionsWidget extends StatefulWidget {
  const PhotoActionsWidget({
    super.key,
    this.imageUrl,
    this.storagePath,
    this.photoRef,
    this.albumRef,
    this.fileName,
    bool? canDelete,
  }) : this.canDelete = canDelete ?? true;

  final String? imageUrl;
  final String? storagePath;
  final DocumentReference? photoRef;
  final DocumentReference? albumRef;
  final String? fileName;
  final bool canDelete;

  @override
  State<PhotoActionsWidget> createState() => _PhotoActionsWidgetState();
}

class _PhotoActionsWidgetState extends State<PhotoActionsWidget> {
  late PhotoActionsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PhotoActionsModel());

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
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 26.0),
        child: Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryText,
            boxShadow: [
              BoxShadow(
                blurRadius: 20.0,
                color: Color(0x1A000000),
                offset: Offset(
                  0.0,
                  -2.0,
                ),
                spreadRadius: 0.0,
              )
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28.0),
              topRight: Radius.circular(28.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).alternate,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  alignment: AlignmentDirectional(0.0, 0.0),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 72.0,
                      height: 72.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: FlutterFlowExpandedImageView(
                                image: Image.network(
                                  firebase_storagelibrary_2sa6k9_functions
                                      .convertStringToImagePath(
                                          widget.imageUrl)!,
                                  fit: BoxFit.contain,
                                ),
                                allowRotation: true,
                                tag: firebase_storagelibrary_2sa6k9_functions
                                    .convertStringToImagePath(
                                        widget.imageUrl)!,
                                useHeroAnimation: true,
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: firebase_storagelibrary_2sa6k9_functions
                              .convertStringToImagePath(widget.imageUrl)!,
                          transitionOnUserGestures: true,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              firebase_storagelibrary_2sa6k9_functions
                                  .convertStringToImagePath(widget.imageUrl)!,
                              width: 72.0,
                              height: 72.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'zoingma2' /* What do you want to do? */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleMediumIsCustom,
                                ),
                          ),
                        ].divide(SizedBox(height: 4.0)),
                      ),
                    ),
                  ].divide(SizedBox(width: 12.0)),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        await downloadFile(
                          filename: valueOrDefault<String>(
                            widget.photoRef?.id,
                            'name',
                          ),
                          url: valueOrDefault<String>(
                            widget.imageUrl,
                            'img',
                          ),
                        );
                        Navigator.pop(context);
                        if (valueOrDefault(
                                currentUserDocument?.appLanguage, '') ==
                            'en') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Saved to device',
                                style: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
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
                                'Auf dem Gerät gespeichert',
                                style: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
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
                                'Guardado en el dispositivo',
                                style: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              duration: Duration(milliseconds: 4000),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).secondary,
                            ),
                          );
                        }

                        _model.partnerUserRecord = await queryUsersRecordOnce(
                          queryBuilder: (usersRecord) => usersRecord.where(
                            'uid',
                            isEqualTo: valueOrDefault(
                                currentUserDocument?.partnerUID, ''),
                          ),
                          singleRecord: true,
                        ).then((s) => s.firstOrNull);
                        if ((_model.partnerUserRecord?.muteAllNotifications ==
                                false) &&
                            (_model.partnerUserRecord?.sharedMomentsEnabled ==
                                true)) {
                          triggerPushNotification(
                            notificationTitle:
                                'Your partner downloaded a picture from the gallery 😊',
                            notificationText:
                                'Your partner has downloaded a picture from the album😊',
                            notificationSound: 'default',
                            userRefs: [_model.partnerUserRecord!.reference],
                            initialPageName: 'GaleryPage',
                            parameterData: {},
                          );
                        }

                        safeSetState(() {});
                      },
                      text: FFLocalizations.of(context).getText(
                        '7z7mihi8' /* Download */,
                      ),
                      icon: Icon(
                        Icons.download,
                        size: 15.0,
                      ),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 52.0,
                        padding: EdgeInsets.all(8.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconColor: FlutterFlowTheme.of(context).info,
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .titleSmallIsCustom,
                            ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    if (widget.canDelete)
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            var confirmDialogResponse = await showDialog<bool>(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('Delete this photo?'),
                                      content: Text(
                                          'This will remove the image from storage and from the album.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, false),
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, true),
                                          child: Text('Confirm'),
                                        ),
                                      ],
                                    );
                                  },
                                ) ??
                                false;
                            if (confirmDialogResponse) {
                              await FirebaseStorage.instance
                                  .refFromURL(widget.imageUrl!)
                                  .delete();
                              await widget.photoRef!.delete();

                              await widget.albumRef!.update({
                                ...mapToFirestore(
                                  {
                                    'photo_count': FieldValue.increment(-(1)),
                                  },
                                ),
                              });
                              Navigator.pop(context);
                              if (valueOrDefault(
                                      currentUserDocument?.appLanguage, '') ==
                                  'en') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Deleted ✅ ',
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
                                      'Gelöscht ✅',
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
                                      'Eliminado ✅',
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
                          },
                          text: FFLocalizations.of(context).getText(
                            'q0inbvx6' /* Delete */,
                          ),
                          icon: Icon(
                            Icons.delete,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 52.0,
                            padding: EdgeInsets.all(8.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconColor: FlutterFlowTheme.of(context).info,
                            color: FlutterFlowTheme.of(context).tertiary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleSmallFamily,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleSmallIsCustom,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                        ),
                      ),
                  ].divide(SizedBox(height: 12.0)),
                ),
              ].divide(SizedBox(height: 16.0)),
            ),
          ),
        ),
      ),
    );
  }
}
