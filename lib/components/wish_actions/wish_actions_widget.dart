import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:firebase_storagelibrary_2sa6k9/custom_code/actions/index.dart'
    as firebase_storagelibrary_2sa6k9_actions;
import 'package:firebase_storagelibrary_2sa6k9/flutter_flow/custom_functions.dart'
    as firebase_storagelibrary_2sa6k9_functions;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'wish_actions_model.dart';
export 'wish_actions_model.dart';

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
class WishActionsWidget extends StatefulWidget {
  const WishActionsWidget({
    super.key,
    required this.wishRef,
    this.storagePath,
    this.image,
  });

  final WishesRecord? wishRef;
  final String? storagePath;
  final String? image;

  @override
  State<WishActionsWidget> createState() => _WishActionsWidgetState();
}

class _WishActionsWidgetState extends State<WishActionsWidget> {
  late WishActionsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WishActionsModel());

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
        child: StreamBuilder<List<WishesRecord>>(
          stream: queryWishesRecord(
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
            List<WishesRecord> containerWishesRecordList = snapshot.data!;
            final containerWishesRecord = containerWishesRecordList.isNotEmpty
                ? containerWishesRecordList.first
                : null;

            return Container(
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
                          child: Visibility(
                            visible: firebase_storagelibrary_2sa6k9_functions
                                        .convertStringToImagePath(
                                            widget.image) !=
                                    null &&
                                firebase_storagelibrary_2sa6k9_functions
                                        .convertStringToImagePath(
                                            widget.image) !=
                                    '',
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
                                                widget.image)!,
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: true,
                                      tag:
                                          firebase_storagelibrary_2sa6k9_functions
                                              .convertStringToImagePath(
                                                  widget.image)!,
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: firebase_storagelibrary_2sa6k9_functions
                                    .convertStringToImagePath(widget.image)!,
                                transitionOnUserGestures: true,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    firebase_storagelibrary_2sa6k9_functions
                                        .convertStringToImagePath(
                                            widget.image)!,
                                    width: 72.0,
                                    height: 72.0,
                                    fit: BoxFit.cover,
                                  ),
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
                                  'mcasegh5' /* What do you want to do? */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleMediumFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
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
                            var confirmDialogResponse = await showDialog<bool>(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('Wish completed'),
                                      content: Text(
                                          'Do you want to mark the wish as completed?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, false),
                                          child: Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, true),
                                          child: Text('Yes'),
                                        ),
                                      ],
                                    );
                                  },
                                ) ??
                                false;
                            if (confirmDialogResponse) {
                              await widget.wishRef!.reference
                                  .update(createWishesRecordData(
                                isCompleted: true,
                                createdAt: getCurrentTimestamp,
                                completedAt: getCurrentTimestamp,
                              ));
                              if (valueOrDefault(
                                      currentUserDocument?.appLanguage, '') ==
                                  'en') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Marked as done ✅',
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
                                      'Als erledigt markiert ✅',
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
                                      'Marcado como hecho ✅',
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
                                  "type": 'wish_completed',
                                  "route": 'completedWishes',
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
                            }

                            safeSetState(() {});
                          },
                          text: FFLocalizations.of(context).getText(
                            'sq2xwj97' /* Mark wish as completed */,
                          ),
                          icon: Icon(
                            Icons.check_circle,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 52.0,
                            padding: EdgeInsets.all(8.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconColor: FlutterFlowTheme.of(context).info,
                            color: FlutterFlowTheme.of(context).primary,
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 20.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Delete wish?'),
                                            content: Text(
                                                'Do you want to delete your wish?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text('No'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: Text('Yes'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                              if (confirmDialogResponse) {
                                if (widget.image != null &&
                                    widget.image != '') {
                                  await firebase_storagelibrary_2sa6k9_actions
                                      .deleteFileFromBucket(
                                    '',
                                    widget.storagePath!,
                                  );
                                  await widget.wishRef!.reference.delete();
                                  Navigator.pop(context);
                                  if (valueOrDefault(
                                          currentUserDocument?.appLanguage,
                                          '') ==
                                      'en') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Deleted ✅',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                      ),
                                    );
                                  } else if (valueOrDefault(
                                          currentUserDocument?.appLanguage,
                                          '') ==
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
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                      ),
                                    );
                                  } else if (valueOrDefault(
                                          currentUserDocument?.appLanguage,
                                          '') ==
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
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                      ),
                                    );
                                  }
                                } else {
                                  await widget.wishRef!.reference.delete();
                                  Navigator.pop(context);
                                  if (valueOrDefault(
                                          currentUserDocument?.appLanguage,
                                          '') ==
                                      'en') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Deleted ✅',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                      ),
                                    );
                                  } else if (valueOrDefault(
                                          currentUserDocument?.appLanguage,
                                          '') ==
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
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                      ),
                                    );
                                  } else if (valueOrDefault(
                                          currentUserDocument?.appLanguage,
                                          '') ==
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
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                      ),
                                    );
                                  }
                                }
                              }
                            },
                            text: FFLocalizations.of(context).getText(
                              'dpgnu8p7' /* Delete wish */,
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
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
            );
          },
        ),
      ),
    );
  }
}
