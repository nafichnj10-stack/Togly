import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:firebase_storagelibrary_2sa6k9/flutter_flow/custom_functions.dart'
    as firebase_storagelibrary_2sa6k9_functions;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'brake_up_page_model.dart';
export 'brake_up_page_model.dart';

/// Design a beautiful and emotional page titled "Disconnect from Your
/// Partner" that encourages users to reflect before ending their connection
/// with their partner.
///
/// The tone should be soft, personal, and caring.
///
/// Layout and content ideas:
///
/// 1. At the top, display a **meaningful quote about love, connection, or
/// relationships** (example: “Every shared moment tells a story worth
/// remembering.”). Use a stylish font and soft typography.
///
/// 2. Add a **photo carousel or gallery-style widget** that showcases:
///    - Shared memories or placeholder images symbolizing love and
/// connection.
///    - The number of days the couple has been together (if available).
///    - Add soft drop shadows and smooth image transitions to give warmth.
///
/// 3. Below the images, include an **emotional message** encouraging
/// reflection:
///    > "Before you disconnect, take a moment to remember your shared
/// journey. The laughter, the growth, the moments you've built together. Are
/// you sure this is the end of your story?"
///
/// 4. Include a clearly visible **warning message box** with an alert icon:
///    > ⚠️ **Important**: If you disconnect from your partner, all shared
/// content will be **permanently deleted** — including messages, photos,
/// answers, and your connection history.
///    > This action **cannot be undone**.
///
/// 5. At the bottom, place a prominent **"Disconnect Now" button** (in soft
/// red or coral color) with confirmation logic (confirmation dialog or double
/// tap).
///
/// 6. Use a **warm, emotional background gradient** that reflects both love
/// and reflection:
///    - Suggested gradient: `#FDEBEB → #F5D0E0 → #EAD9F3` (light pink → blush
/// → soft lavender)
///    - Rounded cards, padding, and generous spacing to keep the layout
/// breathable and elegant.
///
/// Make sure the entire design matches the existing theme of the app: soft
/// colors, rounded elements, emotional typography. Prioritize **clarity,
/// empathy, and emotional appeal**.
class BrakeUpPageWidget extends StatefulWidget {
  const BrakeUpPageWidget({super.key});

  static String routeName = 'BrakeUpPage';
  static String routePath = '/BrakeUpPage';

  @override
  State<BrakeUpPageWidget> createState() => _BrakeUpPageWidgetState();
}

class _BrakeUpPageWidgetState extends State<BrakeUpPageWidget> {
  late BrakeUpPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BrakeUpPageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'BrakeUpPage'});
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthUserStreamWidget(
      builder: (context) => StreamBuilder<List<RelationshipsRecord>>(
        stream: queryRelationshipsRecord(
          queryBuilder: (relationshipsRecord) => relationshipsRecord.where(
            'relationship_id',
            isEqualTo: valueOrDefault(currentUserDocument?.relationshipId, ''),
          ),
          singleRecord: true,
        ),
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
          List<RelationshipsRecord> brakeUpPageRelationshipsRecordList =
              snapshot.data!;
          final brakeUpPageRelationshipsRecord =
              brakeUpPageRelationshipsRecordList.isNotEmpty
                  ? brakeUpPageRelationshipsRecordList.first
                  : null;

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              body: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFDEBEB),
                      Color(0xFFF5D0E0),
                      Color(0xFFEAD9F3)
                    ],
                    stops: [0.0, 0.5, 1.0],
                    begin: AlignmentDirectional(0.0, 1.0),
                    end: AlignmentDirectional(0, -1.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 30.0, 0.0, 0.0),
                          child: FlutterFlowIconButton(
                            borderRadius: 20.0,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context).secondary,
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
                        padding: EdgeInsets.all(24.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8.0,
                                color: Color(0x1A000000),
                                offset: Offset(
                                  0.0,
                                  4.0,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite_rounded,
                                  color: Color(0xFFDB7093),
                                  size: 48.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'tjqbwfpl' /* "Every shared moment tells a s... */,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleLargeFamily,
                                        color: Color(0xFF8B5A8C),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        lineHeight: 1.4,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleLargeIsCustom,
                                      ),
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    's7zvu8vp' /* — Anonymous */,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: Color(0xFFB19CD9),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontStyle: FontStyle.italic,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          width: double.infinity,
                          height: 143.44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 12.0,
                                color: Color(0x26000000),
                                offset: Offset(
                                  0.0,
                                  6.0,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  functions.daysBetween(
                                      brakeUpPageRelationshipsRecord?.startedAt,
                                      getCurrentTimestamp,
                                      true),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .displaySmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .displaySmallFamily,
                                        color: Color(0xFFEC4899),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .displaySmallIsCustom,
                                      ),
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'a34okeu6' /* Days Connected */,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                ),
                              ].divide(SizedBox(height: 8.0)),
                            ),
                          ),
                        ),
                      ),
                      StreamBuilder<List<AlbumsRecord>>(
                        stream: queryAlbumsRecord(
                          queryBuilder: (albumsRecord) => albumsRecord
                              .where(
                                'relationship_id',
                                isEqualTo: valueOrDefault(
                                    currentUserDocument?.relationshipId, ''),
                              )
                              .orderBy('created_at'),
                          limit: 3,
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
                          List<AlbumsRecord> rowAlbumsRecordList =
                              snapshot.data!;

                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: List.generate(
                                      rowAlbumsRecordList.length, (rowIndex) {
                                final rowAlbumsRecord =
                                    rowAlbumsRecordList[rowIndex];
                                return Visibility(
                                  visible:
                                      rowAlbumsRecord.reference.id != '',
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        AlbumDetailPageWidget.routeName,
                                        queryParameters: {
                                          'albumRef': serializeParam(
                                            rowAlbumsRecord.reference,
                                            ParamType.DocumentReference,
                                          ),
                                          'albumId': serializeParam(
                                            rowAlbumsRecord.reference.id,
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: Container(
                                      width: 100.0,
                                      height: 120.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4.0,
                                            color: Color(0x1A000000),
                                            offset: Offset(
                                              0.0,
                                              1.0,
                                            ),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                firebase_storagelibrary_2sa6k9_functions
                                                    .convertStringToImagePath(
                                                        rowAlbumsRecord
                                                            .coverUrl)!,
                                                width: 60.0,
                                                height: 60.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              rowAlbumsRecord.title,
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    fontSize: 10.0,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallIsCustom,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })
                                  .divide(
                                    SizedBox(width: 12.0),
                                    filterFn: (rowIndex) {
                                      final rowAlbumsRecord =
                                          rowAlbumsRecordList[rowIndex];
                                      return rowAlbumsRecord.reference.id != '';
                                    },
                                  )
                                  .addToStart(SizedBox(width: 16.0))
                                  .addToEnd(SizedBox(width: 16.0)),
                            ),
                          );
                        },
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x1A000000),
                                  offset: Offset(
                                    0.0,
                                    1.0,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEC4899),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'duhotbtx' /* First Connection */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmallFamily,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmallIsCustom,
                                              ),
                                        ),
                                        if (brakeUpPageRelationshipsRecord
                                                    ?.reference.id !=
                                                null &&
                                            brakeUpPageRelationshipsRecord
                                                    ?.reference.id !=
                                                '')
                                          Text(
                                            dateTimeFormat(
                                              "d. MMM y",
                                              brakeUpPageRelationshipsRecord!
                                                  .startedAt!,
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallIsCustom,
                                                ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                            ),
                          ),
                          StreamBuilder<List<LoveNotesRecord>>(
                            stream: queryLoveNotesRecord(
                              queryBuilder: (loveNotesRecord) => loveNotesRecord
                                  .where(
                                    'relationship_id',
                                    isEqualTo: valueOrDefault(
                                        currentUserDocument?.relationshipId,
                                        ''),
                                  )
                                  .orderBy('timestamp', descending: true),
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
                              List<LoveNotesRecord>
                                  containerLoveNotesRecordList = snapshot.data!;
                              final containerLoveNotesRecord =
                                  containerLoveNotesRecordList.isNotEmpty
                                      ? containerLoveNotesRecordList.first
                                      : null;

                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: Color(0x1A000000),
                                      offset: Offset(
                                        0.0,
                                        1.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 40.0,
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEC4899),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Icon(
                                            Icons.mail,
                                            color: Colors.white,
                                            size: 20.0,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'uwe2gkwx' /* First Love Note */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmallFamily,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmallIsCustom,
                                                  ),
                                            ),
                                            if (containerLoveNotesRecord
                                                        ?.reference.id !=
                                                    null &&
                                                containerLoveNotesRecord
                                                        ?.reference.id !=
                                                    '')
                                              Text(
                                                dateTimeFormat(
                                                  "d. MMM y",
                                                  containerLoveNotesRecord!
                                                      .timestamp!,
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
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
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallIsCustom,
                                                    ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 16.0)),
                                  ),
                                ),
                              );
                            },
                          ),
                          StreamBuilder<List<GalleryRecord>>(
                            stream: queryGalleryRecord(
                              queryBuilder: (galleryRecord) => galleryRecord
                                  .where(
                                    'relationship_id',
                                    isEqualTo: valueOrDefault(
                                        currentUserDocument?.relationshipId,
                                        ''),
                                  )
                                  .orderBy('created_at'),
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
                              List<GalleryRecord> containerGalleryRecordList =
                                  snapshot.data!;
                              final containerGalleryRecord =
                                  containerGalleryRecordList.isNotEmpty
                                      ? containerGalleryRecordList.first
                                      : null;

                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: Color(0x1A000000),
                                      offset: Offset(
                                        0.0,
                                        1.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 40.0,
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEC4899),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Icon(
                                            Icons.photo_camera,
                                            color: Colors.white,
                                            size: 20.0,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'rh40hfw5' /* First Photo Shared */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmallFamily,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmallIsCustom,
                                                  ),
                                            ),
                                            if (containerGalleryRecord
                                                        ?.reference.id !=
                                                    null &&
                                                containerGalleryRecord
                                                        ?.reference.id !=
                                                    '')
                                              Text(
                                                dateTimeFormat(
                                                  "d. MMM y",
                                                  containerGalleryRecord!
                                                      .createdAt!,
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
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
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallIsCustom,
                                                    ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 16.0)),
                                  ),
                                ),
                              );
                            },
                          ),
                        ].divide(SizedBox(height: 12.0)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8.0,
                                color: Color(0x1A000000),
                                offset: Offset(
                                  0.0,
                                  4.0,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.psychology_rounded,
                                  color: Color(0xFFDB7093),
                                  size: 40.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    '3m2q00mw' /* Take a Moment to Reflect */,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleMediumFamily,
                                        color: Color(0xFF8B5A8C),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleMediumIsCustom,
                                      ),
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'ja1arioo' /* Before you disconnect, take a ... */,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: Color(0xFF6B4C7A),
                                        letterSpacing: 0.0,
                                        lineHeight: 1.5,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
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
                            color: Color(0xFFFFF5F5),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 6.0,
                                color: Color(0x1A000000),
                                offset: Offset(
                                  0.0,
                                  3.0,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: Color(0xFFFF9999),
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.warning_rounded,
                                  color: Color(0xFFFF6B6B),
                                  size: 28.0,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          '3daiqcqg' /* Important Warning */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily,
                                              color: Color(0xFFCC4444),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .titleSmallIsCustom,
                                            ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'sn1un8dl' /* If you disconnect from your pa... */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              color: Color(0xFF994444),
                                              letterSpacing: 0.0,
                                              lineHeight: 1.4,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
                                            ),
                                      ),
                                    ].divide(SizedBox(height: 8.0)),
                                  ),
                                ),
                              ].divide(SizedBox(width: 12.0)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'czjt0xrk' /* It's okay to let go. But it's ... */,
                          ),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodySmallFamily,
                                color: FlutterFlowTheme.of(context).primary,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic,
                                lineHeight: 1.4,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodySmallIsCustom,
                              ),
                        ),
                      ),
                      StreamBuilder<List<GalleryRecord>>(
                        stream: queryGalleryRecord(
                          queryBuilder: (galleryRecord) => galleryRecord
                              .where(
                                'relationship_id',
                                isEqualTo: valueOrDefault(
                                    currentUserDocument?.relationshipId, ''),
                              )
                              .orderBy('image_url'),
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
                          List<GalleryRecord> containerGalleryRecordList =
                              snapshot.data!;
                          final containerGalleryRecord =
                              containerGalleryRecordList.isNotEmpty
                                  ? containerGalleryRecordList.first
                                  : null;

                          return Container(
                            width: 371.8,
                            height: 395.21,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x1A000000),
                                  offset: Offset(
                                    0.0,
                                    1.0,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (containerGalleryRecord?.reference.id !=
                                          null &&
                                      containerGalleryRecord?.reference.id !=
                                          '')
                                    InkWell(
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
                                                        containerGalleryRecord
                                                            ?.imageUrl)!,
                                                fit: BoxFit.contain,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Image.asset(
                                                  'assets/images/error_image.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              allowRotation: false,
                                              tag:
                                                  firebase_storagelibrary_2sa6k9_functions
                                                      .convertStringToImagePath(
                                                          containerGalleryRecord
                                                              ?.imageUrl)!,
                                              useHeroAnimation: true,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Hero(
                                        tag:
                                            firebase_storagelibrary_2sa6k9_functions
                                                .convertStringToImagePath(
                                                    containerGalleryRecord
                                                        ?.imageUrl)!,
                                        transitionOnUserGestures: true,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            firebase_storagelibrary_2sa6k9_functions
                                                .convertStringToImagePath(
                                                    containerGalleryRecord
                                                        ?.imageUrl)!,
                                            width: 349.7,
                                            height: 369.39,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Image.asset(
                                              'assets/images/error_image.png',
                                              width: 349.7,
                                              height: 369.39,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(24.0),
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
                                    blurRadius: 8.0,
                                    color: Color(0x1A000000),
                                    offset: Offset(
                                      0.0,
                                      4.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'lk5try99' /* Are you absolutely certain abo... */,
                                      ),
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: Color(0xFF8B5A8C),
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        var confirmDialogResponse =
                                            await showDialog<bool>(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getVariableText(
                                                        enText:
                                                            'Disconnect from Partner',
                                                        deText:
                                                            'Vom Partner trennen',
                                                        esText:
                                                            'Desconectarse de tu pareja',
                                                      )),
                                                      content: Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getVariableText(
                                                        enText:
                                                            'Are you sure? Your shared data will be permanently deleted after 14 days. You can restore within that period',
                                                        deText:
                                                            'Bist du sicher? Eure gemeinsamen Daten werden nach 14 Tagen dauerhaft gelöscht. Innerhalb dieses Zeitraums kannst du die Verbindung wiederherstellen',
                                                        esText:
                                                            '¿Estás seguro? Sus datos compartidos se eliminarán permanentemente después de 14 días. Puedes restaurar la conexión dentro de ese período',
                                                      )),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext,
                                                                  false),
                                                          child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getVariableText(
                                                            enText:
                                                                'No i am not sure!',
                                                            deText:
                                                                'Nein, ich bin mir nicht sicher!',
                                                            esText:
                                                                'No, no estoy seguro!',
                                                          )),
                                                        ),
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext,
                                                                  true),
                                                          child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getVariableText(
                                                            enText:
                                                                'Yes i am sure!',
                                                            deText:
                                                                'Ja, ich bin mir sicher!',
                                                            esText:
                                                                'Sí, estoy seguro!',
                                                          )),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ) ??
                                                false;
                                        if (confirmDialogResponse) {
                                          _model.partnerUserRecord =
                                              await queryUsersRecordOnce(
                                            queryBuilder: (usersRecord) =>
                                                usersRecord.where(
                                              'uid',
                                              isEqualTo: valueOrDefault(
                                                  currentUserDocument
                                                      ?.partnerUID,
                                                  ''),
                                            ),
                                            singleRecord: true,
                                          ).then((s) => s.firstOrNull);
                                          logFirebaseEvent(
                                            'relationship_disconnected',
                                            parameters: {
                                              'reason': 'user_initiated',
                                              'type': 'manual_disconnect',
                                              'restore_window_days': '14',
                                            },
                                          );
                                          try {
                                            final result =
                                                await FirebaseFunctions
                                                        .instanceFor(
                                                            region:
                                                                'europe-west3')
                                                    .httpsCallable(
                                                        'sendPartnerPush')
                                                    .call({
                                              "type": 'partner_broke_up',
                                              "route": 'restore',
                                              "audience": 'partner',
                                            });
                                            _model.brake =
                                                SendPartnerPushCloudFunctionCallResponse(
                                              data: result.data,
                                              succeeded: true,
                                              resultAsString:
                                                  result.data.toString(),
                                              jsonBody: result.data,
                                            );
                                          } on FirebaseFunctionsException catch (error) {
                                            _model.brake =
                                                SendPartnerPushCloudFunctionCallResponse(
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
                                                        'disconnectCouple')
                                                    .call({
                                              "relationshipid": valueOrDefault(
                                                  currentUserDocument
                                                      ?.relationshipId,
                                                  ''),
                                            });
                                            _model.cloudFunctionsq =
                                                DisconnectCoupleCloudFunctionCallResponse(
                                              data: CFResultStruct.fromMap(
                                                  result.data),
                                              succeeded: true,
                                              resultAsString:
                                                  result.data.toString(),
                                              jsonBody: result.data,
                                            );
                                          } on FirebaseFunctionsException catch (error) {
                                            _model.cloudFunctionsq =
                                                DisconnectCoupleCloudFunctionCallResponse(
                                              errorCode: error.code,
                                              succeeded: false,
                                            );
                                          }

                                          if (_model
                                              .cloudFunctionsq!.data!.ok) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  _model.cloudFunctionsq!.data!
                                                      .message,
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                              ),
                                            );

                                            context.goNamed(
                                              HomeWidget.routeName,
                                              extra: <String, dynamic>{
                                                '__transition_info__':
                                                    TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                      PageTransitionType.fade,
                                                ),
                                              },
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  _model.cloudFunctionsq!.data!
                                                      .message,
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                              ),
                                            );
                                          }
                                        }

                                        safeSetState(() {});
                                      },
                                      text: FFLocalizations.of(context).getText(
                                        'jfg8cd1m' /* Disconnect Now */,
                                      ),
                                      icon: Icon(
                                        Icons.heart_broken_rounded,
                                        size: 30.0,
                                      ),
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 56.0,
                                        padding: EdgeInsets.all(8.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        iconColor: Colors.white,
                                        color: Color(0xFFFF6B7D),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMediumFamily,
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .titleMediumIsCustom,
                                            ),
                                        elevation: 4.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        context
                                            .pushNamed(ConnectWidget.routeName);
                                      },
                                      text: FFLocalizations.of(context).getText(
                                        'dslnw3yw' /* Maybe Not Right Now */,
                                      ),
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 48.0,
                                        padding: EdgeInsets.all(8.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: Colors.transparent,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              color: Color(0xFF8B5A8C),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
                                            ),
                                        elevation: 0.0,
                                        borderSide: BorderSide(
                                          color: Color(0xFFDB7093),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 16.0)),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ]
                        .divide(SizedBox(height: 24.0))
                        .addToStart(SizedBox(height: 32.0))
                        .addToEnd(SizedBox(height: 32.0)),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
