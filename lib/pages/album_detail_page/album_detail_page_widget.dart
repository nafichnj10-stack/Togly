import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/components/photo_actions/photo_actions_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:firebase_storagelibrary_2sa6k9/custom_code/actions/index.dart'
    as firebase_storagelibrary_2sa6k9_actions;
import 'package:firebase_storagelibrary_2sa6k9/flutter_flow/custom_functions.dart'
    as firebase_storagelibrary_2sa6k9_functions;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'album_detail_page_model.dart';
export 'album_detail_page_model.dart';

/// Create a page AlbumDetailPage (light, romantic style).
///
/// Colors: background #F7F2FF, primary #8B5CF6, surface #EFE6FF, text
/// #2D2352; rounded corners 24; soft shadows.
/// Params: album_id (String), optional album_title (String).
/// AppBar: back chevron; title = album_title; subtitle = “{photoCount}
/// photos”.
/// Body:
///
/// Section header with small cover preview (rounded 16) and date.
///
/// Staggered/Masonry grid (2 columns, spacing 12). Each card: image (radius
/// 16), subtle gradient overlay, top-right emoji chip showing reaction_emoji
/// if set. Tap → full-screen viewer; long-press → actions sheet (Share/Delete
/// – placeholders).
///
/// Empty state card: illustration + “No photos yet. Add your first memory.”
/// Data: Query gallery where relationship_id == currentUser.relationship_id
/// AND album_id == pageParam.album_id, order by created_at desc.
/// FAB: circular lilac with camera/plus; opens upload, then creates gallery
/// doc (sets image_url, album_id, relationship_id, uploaded_by, created_at).
/// Pull-to-refresh enabled.
class AlbumDetailPageWidget extends StatefulWidget {
  const AlbumDetailPageWidget({
    super.key,
    required this.albumRef,
    required this.albumId,
  });

  final DocumentReference? albumRef;
  final String? albumId;

  static String routeName = 'AlbumDetailPage';
  static String routePath = '/albumDetailPage';

  @override
  State<AlbumDetailPageWidget> createState() => _AlbumDetailPageWidgetState();
}

class _AlbumDetailPageWidgetState extends State<AlbumDetailPageWidget> {
  late AlbumDetailPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AlbumDetailPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'AlbumDetailPage'});
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AlbumsRecord>(
      stream: AlbumsRecord.getDocument(widget.albumRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFFF7F2FF),
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

        final albumDetailPageAlbumsRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFFF7F2FF),
            body: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: Image.asset(
                    'assets/images/background_album.webp',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 30.0, 0.0, 0.0),
                          child: FlutterFlowIconButton(
                            borderRadius: 20.0,
                            buttonSize: 40.0,
                            fillColor: Color(0xFFEFE6FF),
                            icon: Icon(
                              Icons.chevron_left,
                              color: Color(0xFF2D2352),
                              size: 20.0,
                            ),
                            onPressed: () async {
                              context.safePop();
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0x4BFFFFFF),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8.0,
                                color: Color(0x1A8B5CF6),
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(24.0),
                            border: Border.all(
                              color: Color(0x34FFFFFF),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 22.0,
                                sigmaY: 22.0,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Image.network(
                                        firebase_storagelibrary_2sa6k9_functions
                                            .convertStringToImagePath(
                                                albumDetailPageAlbumsRecord
                                                    .coverUrl)!,
                                        width: 80.0,
                                        height: 80.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(1.0, -1.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 5.0, 5.0, 5.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  if (albumDetailPageAlbumsRecord
                                                          .photoCount >
                                                      0) {
                                                    if (valueOrDefault(
                                                            currentUserDocument
                                                                ?.appLanguage,
                                                            '') ==
                                                        'en') {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Please delete all photos first!',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  4000),
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
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Bitte lösche zuerst alle Fotos!',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  4000),
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
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Primero, ¡borra todas las fotos!',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  4000),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondary,
                                                        ),
                                                      );
                                                    }
                                                  } else {
                                                    var confirmDialogResponse =
                                                        await showDialog<bool>(
                                                              context: context,
                                                              builder:
                                                                  (alertDialogContext) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Are you sure you want to delete this album?'),
                                                                  content: Text(
                                                                      'this step cannot be undone'),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () => Navigator.pop(
                                                                          alertDialogContext,
                                                                          false),
                                                                      child: Text(
                                                                          'Back!'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed: () => Navigator.pop(
                                                                          alertDialogContext,
                                                                          true),
                                                                      child: Text(
                                                                          'Delete!'),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            ) ??
                                                            false;
                                                    if (confirmDialogResponse) {
                                                      await firebase_storagelibrary_2sa6k9_actions
                                                          .deleteFileFromBucket(
                                                        '',
                                                        'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/albums/${albumDetailPageAlbumsRecord.reference.id}/cover.jpg',
                                                      );
                                                      await widget.albumRef!
                                                          .delete();

                                                      context.pushNamed(
                                                          GaleryPageWidget
                                                              .routeName);

                                                      if (valueOrDefault(
                                                              currentUserDocument
                                                                  ?.appLanguage,
                                                              '') ==
                                                          'en') {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Album deleted!',
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    4000),
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
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Album gelöscht',
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    4000),
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
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              '¡Álbum eliminado!',
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    4000),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                          ),
                                                        );
                                                      }
                                                    } else {
                                                      Navigator.pop(context);
                                                    }
                                                  }
                                                },
                                                child: FaIcon(
                                                  FontAwesomeIcons.trashAlt,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  size: 15.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            albumDetailPageAlbumsRecord.title,
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineSmallFamily,
                                                  color: Color(0xFF2D2352),
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .headlineSmallIsCustom,
                                                ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                albumDetailPageAlbumsRecord
                                                    .photoCount
                                                    .toString(),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodySmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallFamily,
                                                      color: Color(0xFF8B5CF6),
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallIsCustom,
                                                    ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        4.0, 0.0, 0.0, 0.0),
                                                child: FaIcon(
                                                  FontAwesomeIcons.image,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  size: 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 4.0, 0.0, 0.0),
                                            child: Text(
                                              dateTimeFormat(
                                                "d/M/y",
                                                albumDetailPageAlbumsRecord
                                                    .createdAt!,
                                                locale:
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: Color(0xFF8B5CF6),
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'x8m6rqbg' /* Long tap on an image to delete... */,
                                              ),
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    fontSize: 9.0,
                                                    letterSpacing: 0.0,
                                                    fontStyle: FontStyle.italic,
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
                                                            .bodyMediumIsCustom,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 16.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (widget.albumRef?.id != null &&
                          widget.albumRef?.id != '')
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: StreamBuilder<List<GalleryRecord>>(
                            stream: queryGalleryRecord(
                              queryBuilder: (galleryRecord) => galleryRecord
                                  .where(
                                    'album_id',
                                    isEqualTo: widget.albumId,
                                  )
                                  .where(
                                    'relationship_id',
                                    isEqualTo: albumDetailPageAlbumsRecord
                                        .relationshipId,
                                  )
                                  .orderBy('created_at', descending: true),
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
                              List<GalleryRecord> gridViewGalleryRecordList =
                                  snapshot.data!;

                              return GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12.0,
                                  mainAxisSpacing: 12.0,
                                  childAspectRatio: 0.7,
                                ),
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: gridViewGalleryRecordList.length,
                                itemBuilder: (context, gridViewIndex) {
                                  final gridViewGalleryRecord =
                                      gridViewGalleryRecordList[gridViewIndex];
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 22.0,
                                        sigmaY: 22.0,
                                      ),
                                      child: Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 12.0,
                                              color: Color(0x398B5CF6),
                                              offset: Offset(
                                                0.0,
                                                2.0,
                                              ),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                await Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child:
                                                        FlutterFlowExpandedImageView(
                                                      image: Image.network(
                                                        firebase_storagelibrary_2sa6k9_functions
                                                            .convertStringToImagePath(
                                                                gridViewGalleryRecord
                                                                    .imageUrl)!,
                                                        fit: BoxFit.contain,
                                                      ),
                                                      allowRotation: true,
                                                      tag: firebase_storagelibrary_2sa6k9_functions
                                                          .convertStringToImagePath(
                                                              gridViewGalleryRecord
                                                                  .imageUrl)!,
                                                      useHeroAnimation: true,
                                                    ),
                                                  ),
                                                );
                                              },
                                              onLongPress: () async {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  enableDrag: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        FocusManager.instance
                                                            .primaryFocus
                                                            ?.unfocus();
                                                      },
                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child:
                                                            PhotoActionsWidget(
                                                          imageUrl:
                                                              gridViewGalleryRecord
                                                                  .imageUrl,
                                                          storagePath:
                                                              gridViewGalleryRecord
                                                                  .storagePath,
                                                          photoRef:
                                                              gridViewGalleryRecord
                                                                  .reference,
                                                          albumRef:
                                                              widget.albumRef,
                                                          canDelete:
                                                              gridViewGalleryRecord
                                                                      .uploadedBy ==
                                                                  currentUserUid,
                                                          fileName:
                                                              gridViewGalleryRecord
                                                                  .reference.id,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));
                                              },
                                              child: Hero(
                                                tag: firebase_storagelibrary_2sa6k9_functions
                                                    .convertStringToImagePath(
                                                        gridViewGalleryRecord
                                                            .imageUrl)!,
                                                transitionOnUserGestures: true,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                  child: Image.network(
                                                    firebase_storagelibrary_2sa6k9_functions
                                                        .convertStringToImagePath(
                                                            gridViewGalleryRecord
                                                                .imageUrl)!,
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                    ]
                        .divide(SizedBox(height: 16.0))
                        .addToStart(SizedBox(height: 16.0)),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(1.05, 0.99),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 40.0),
                    child: FlutterFlowIconButton(
                      borderRadius: 32.0,
                      buttonSize: 64.0,
                      fillColor: Color(0xFF8B5CF6),
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Color(0xFFF7F2FF),
                        size: 28.0,
                      ),
                      onPressed: () async {
                        if (_model.isUploading == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please wait....',
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
                        } else {
                          _model.isUploading = true;
                          safeSetState(() {});
                          safeSetState(() {
                            _model.isDataUploading_pickAlbumPhoto = false;
                            _model.uploadedLocalFile_pickAlbumPhoto =
                                FFUploadedFile(
                                    bytes: Uint8List.fromList([]),
                                    originalFilename: '');
                          });

                          final selectedMedia = await selectMedia(
                            imageQuality: 85,
                            includeDimensions: true,
                            mediaSource: MediaSource.photoGallery,
                            multiImage: false,
                          );
                          if (selectedMedia != null &&
                              selectedMedia.every((m) =>
                                  validateFileFormat(m.storagePath, context))) {
                            safeSetState(() =>
                                _model.isDataUploading_pickAlbumPhoto = true);
                            var selectedUploadedFiles = <FFUploadedFile>[];

                            try {
                              showUploadMessage(
                                context,
                                'Uploading file...',
                                showLoading: true,
                              );
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
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              _model.isDataUploading_pickAlbumPhoto = false;
                            }
                            if (selectedUploadedFiles.length ==
                                selectedMedia.length) {
                              safeSetState(() {
                                _model.uploadedLocalFile_pickAlbumPhoto =
                                    selectedUploadedFiles.first;
                              });
                              showUploadMessage(context, 'Success!');
                            } else {
                              safeSetState(() {});
                              showUploadMessage(
                                  context, 'Failed to upload data');
                              return;
                            }
                          }

                          _model.fileName = random_data.randomString(
                            20,
                            20,
                            true,
                            false,
                            true,
                          );
                          safeSetState(() {});
                          if ((_model.uploadedLocalFile_pickAlbumPhoto.bytes
                                      ?.isNotEmpty ??
                                  false)) {
                            await firebase_storagelibrary_2sa6k9_actions
                                .uploadFileToBucket(
                              '',
                              'couples/${albumDetailPageAlbumsRecord.relationshipId}/albums/${widget.albumId}/${_model.fileName}.jpg',
                              _model.uploadedLocalFile_pickAlbumPhoto,
                              '',
                            );
                            _model.downloadimg =
                                await firebase_storagelibrary_2sa6k9_actions
                                    .getDownloadUrl(
                              '',
                              'couples/${albumDetailPageAlbumsRecord.relationshipId}/albums/${widget.albumId}/${_model.fileName}.jpg',
                            );

                            await GalleryRecord.collection
                                .doc()
                                .set(createGalleryRecordData(
                                  relationshipId: albumDetailPageAlbumsRecord
                                      .relationshipId,
                                  albumId: widget.albumId,
                                  createdAt: getCurrentTimestamp,
                                  uploadedBy: currentUserUid,
                                  storagePath: _model.fileName,
                                  imageUrl: _model.downloadimg,
                                ));
                            try {
                              final result =
                                  await FirebaseFunctions.instanceFor(
                                          region: 'europe-west3')
                                      .httpsCallable('awardAlbumWeeklyPair')
                                      .call({});
                              _model.albums =
                                  AwardAlbumWeeklyPairCloudFunctionCallResponse(
                                succeeded: true,
                              );
                            } on FirebaseFunctionsException catch (error) {
                              _model.albums =
                                  AwardAlbumWeeklyPairCloudFunctionCallResponse(
                                errorCode: error.code,
                                succeeded: false,
                              );
                            }

                            await widget.albumRef!.update({
                              ...mapToFirestore(
                                {
                                  'photo_count': FieldValue.increment(1),
                                },
                              ),
                            });
                            _model.partnerUserRecord =
                                await queryUsersRecordOnce(
                              queryBuilder: (usersRecord) => usersRecord.where(
                                'uid',
                                isEqualTo: valueOrDefault(
                                    currentUserDocument?.partnerUID, ''),
                              ),
                              singleRecord: true,
                            ).then((s) => s.firstOrNull);
                            await Future.delayed(
                              Duration(
                                milliseconds: 1000,
                              ),
                            );
                            try {
                              final result =
                                  await FirebaseFunctions.instanceFor(
                                          region: 'europe-west3')
                                      .httpsCallable('sendPartnerPush')
                                      .call({
                                "type": 'album_photo_added',
                                "route": 'galeryPage',
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
                            safeSetState(() {
                              _model.isDataUploading_pickAlbumPhoto = false;
                              _model.uploadedLocalFile_pickAlbumPhoto =
                                  FFUploadedFile(
                                      bytes: Uint8List.fromList([]),
                                      originalFilename: '');
                            });
                          }
                        }

                        safeSetState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
