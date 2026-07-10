import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'comes_next_page_model.dart';
export 'comes_next_page_model.dart';

/// Create an interactive "Upcoming Features" page for my FlutterFlow app
/// "2getherly", designed for couples in long-distance relationships.
///
/// The goal is to showcase planned and upcoming features while allowing users
/// to react emotionally using emojis to express what they’re most excited
/// about.
///
/// 🎨 Design Style:
/// - Emotionally warm and minimal
/// - Soft color scheme (lavender, pink, light purple, soft white)
/// - Rounded cards or containers for each feature
/// - Icons and emoji integration
/// - Clean layout with scrollable content
///
/// 📄 Page Structure:
///
/// 1. AppBar:
///    - Title: “What’s Coming Next”
///    - Back button
///
/// 2. Header Section:
///    - Title text: “We’re building this with you 💜”
///    - Subtitle: “Here’s a glimpse into the future of 2getherly – and what
/// we’re working on next.”
///    - Optional illustration (e.g. couple dreaming, rocket launch, stars)
///
/// 3. Feature List Section:
///    For each feature, display a card containing:
///    - **Feature Title** (e.g. “Shared Calendar”)
///    - **Short Description** (1–2 sentences)
///    - **Status Badge** (e.g. “Planned”, “In Progress”, “Testing”,
/// “Released” – use different colors)
///    - **Estimated Release (optional)** (e.g. “Coming Fall 2025”)
///    - **Live Emoji Voting Section** (see details below)
///
/// 4. 🔥 Emoji Voting:
///    - Under each feature card, show 3–5 reaction emojis (e.g. 😍 👍 🤩 🙏
/// 💡)
///    - Users can tap to react (1 vote per user per emoji per feature)
///    - Display vote counts next to each emoji
///    - Store votes in Firestore (`feature_votes` subcollection or field on
/// the feature document)
///    - Optional logic: prevent double-voting with user ID or session
/// tracking
///
/// 5. Suggest Feature CTA:
///    - Below the feature list, add:
///      - Text: “Have an idea of your own?”
///      - Button: “Suggest a Feature” → opens a feature request form
///
/// 6. Footer Section:
///    - Motivational quote: “Together, we’re building something beautiful.
/// 💫”
///    - Optional image or animation (e.g. floating stars, heart-shaped
/// sparkles)
///
/// 📦 Backend Setup (Firestore):
/// - Collection: `upcoming_features`
///   - Fields:
///     - title
///     - description
///     - status (enum)
///     - estimated_release
///     - emoji_votes (map or subcollection with emoji → count)
/// - Optional Subcollection: `votes_by_user` for per-user vote tracking (to
/// avoid multiple taps)
///
/// 💬 UX Notes:
/// - Add subtle animation when an emoji is tapped (e.g. bounce or glow)
/// - Show "Thank you!" toast message on vote
/// - Sort features by popularity or release date
///
/// 🧪 MVP Note:
/// If real-time emoji voting is too complex at first, store votes with a
/// simple counter for now, and expand later.
class ComesNextPageWidget extends StatefulWidget {
  const ComesNextPageWidget({super.key});

  static String routeName = 'ComesNextPage';
  static String routePath = '/comesNextPage';

  @override
  State<ComesNextPageWidget> createState() => _ComesNextPageWidgetState();
}

class _ComesNextPageWidgetState extends State<ComesNextPageWidget> {
  late ComesNextPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ComesNextPageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ComesNextPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent(
        'comes_next_page_opened',
        parameters: {
          'source': 'navigation ',
        },
      );
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
    return StreamBuilder<List<RoadmapItemsRecord>>(
      stream: queryRoadmapItemsRecord(
        queryBuilder: (roadmapItemsRecord) => roadmapItemsRecord
            .where(
              'is_published',
              isEqualTo: true,
            )
            .where(
              'publish_at',
              isLessThanOrEqualTo: getCurrentTimestamp,
            )
            .orderBy('publish_at', descending: true)
            .orderBy('sort_order'),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFFF8F5FF),
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
        List<RoadmapItemsRecord> comesNextPageRoadmapItemsRecordList =
            snapshot.data!;
        final comesNextPageRoadmapItemsRecord =
            comesNextPageRoadmapItemsRecordList.isNotEmpty
                ? comesNextPageRoadmapItemsRecordList.first
                : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFFF8F5FF),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 30.0, 0.0, 0.0),
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
                    padding: EdgeInsets.all(24.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFE8D6FF), Color(0xFFF0E6FF)],
                          stops: [0.0, 1.0],
                          begin: AlignmentDirectional(1.0, 1.0),
                          end: AlignmentDirectional(-1.0, -1.0),
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '342b7vrd' /* We are building this with you ... */,
                            ),
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineMediumFamily,
                                  color: Color(0xFF6B46C1),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineMediumIsCustom,
                                ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'j1olxra8' /* Here's a glimpse into the futu... */,
                            ),
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyLargeFamily,
                                  color: Color(0xFF8B5CF6),
                                  letterSpacing: 0.0,
                                  lineHeight: 1.4,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyLargeIsCustom,
                                ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 10.0),
                            child: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFC084FC),
                                    Color(0xFFA855F7)
                                  ],
                                  stops: [0.0, 1.0],
                                  begin: AlignmentDirectional(1.0, -1.0),
                                  end: AlignmentDirectional(-1.0, 1.0),
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onLongPress: () async {
                                    if (valueOrDefault<bool>(
                                            currentUserDocument?.isAdmin,
                                            false) ==
                                        true) {
                                      context.pushNamed(
                                        RoadmapAdminWidget.routeName,
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
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'c20wns2c' /* 🚀 */,
                                    ),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .displayMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .displayMediumFamily,
                                          fontSize: 48.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .displayMediumIsCustom,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
                    ),
                  ),
                  StreamBuilder<List<RoadmapItemsRecord>>(
                    stream: queryRoadmapItemsRecord(
                      queryBuilder: (roadmapItemsRecord) => roadmapItemsRecord
                          .where(
                            'is_published',
                            isEqualTo: true,
                          )
                          .orderBy('publish_at'),
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
                      List<RoadmapItemsRecord> listViewRoadmapItemsRecordList =
                          snapshot.data!;

                      return ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewRoadmapItemsRecordList.length,
                        separatorBuilder: (_, __) => SizedBox(height: 16.0),
                        itemBuilder: (context, listViewIndex) {
                          final listViewRoadmapItemsRecord =
                              listViewRoadmapItemsRecordList[listViewIndex];
                          return Visibility(
                            visible: (listViewRoadmapItemsRecord.publishAt ==
                                    null) ||
                                (listViewRoadmapItemsRecord.publishAt! <=
                                    getCurrentTimestamp),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child:
                                          StreamBuilder<List<ReactionsRecord>>(
                                        stream: queryReactionsRecord(
                                          parent: listViewRoadmapItemsRecord
                                              .reference,
                                          queryBuilder: (reactionsRecord) =>
                                              reactionsRecord.where(
                                            'user_id',
                                            isEqualTo: currentUserUid,
                                          ),
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
                                          List<ReactionsRecord>
                                              containerReactionsRecordList =
                                              snapshot.data!;

                                          return Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
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
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 0.0, 20.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  20.0,
                                                                  0.0,
                                                                  20.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              if (valueOrDefault<
                                                                          bool>(
                                                                      currentUserDocument
                                                                          ?.isAdmin,
                                                                      false) ==
                                                                  true) {
                                                                context
                                                                    .pushNamed(
                                                                  RoadmapAdminWidget
                                                                      .routeName,
                                                                  queryParameters:
                                                                      {
                                                                    'roadmapItemRef':
                                                                        serializeParam(
                                                                      listViewRoadmapItemsRecord
                                                                          .reference,
                                                                      ParamType
                                                                          .DocumentReference,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              }
                                                            },
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Expanded(
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                20.0,
                                                                                0.0,
                                                                                4.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              dateTimeFormat(
                                                                                "yMMMd",
                                                                                listViewRoadmapItemsRecord.publishAt!,
                                                                                locale: FFLocalizations.of(context).languageCode,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                                    color: Color(0xFFA855F7),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    useGoogleFonts: !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            10.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Expanded(
                                                                              child: Align(
                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                                                                                  child: Text(
                                                                                    listViewRoadmapItemsRecord.title,
                                                                                    maxLines: 2,
                                                                                    style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                          fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                                                                                          color: Color(0xFF6B46C1),
                                                                                          fontSize: 18.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          useGoogleFonts: !FlutterFlowTheme.of(context).titleLargeIsCustom,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(12.0, 6.0, 20.0, 6.0),
                                                                              child: Container(
                                                                                height: 28.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: () {
                                                                                    if (comesNextPageRoadmapItemsRecord?.status == 'Planned') {
                                                                                      return FlutterFlowTheme.of(context).info;
                                                                                    } else if (listViewRoadmapItemsRecord.status == 'In Progress') {
                                                                                      return FlutterFlowTheme.of(context).warning;
                                                                                    } else if (listViewRoadmapItemsRecord.status == 'Testing') {
                                                                                      return FlutterFlowTheme.of(context).primary;
                                                                                    } else if (listViewRoadmapItemsRecord.status == 'Released') {
                                                                                      return FlutterFlowTheme.of(context).success;
                                                                                    } else if (comesNextPageRoadmapItemsRecord?.status == 'Cancelled') {
                                                                                      return FlutterFlowTheme.of(context).error;
                                                                                    } else if (listViewRoadmapItemsRecord.status == 'Bug/Error') {
                                                                                      return FlutterFlowTheme.of(context).tertiary;
                                                                                    } else if (listViewRoadmapItemsRecord.status == 'Fixed') {
                                                                                      return Color(0xFF18CE32);
                                                                                    } else {
                                                                                      return FlutterFlowTheme.of(context).error;
                                                                                    }
                                                                                  }(),
                                                                                  borderRadius: BorderRadius.circular(14.0),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.all(8.0),
                                                                                  child: Text(
                                                                                    listViewRoadmapItemsRecord.status,
                                                                                    style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                          fontFamily: FlutterFlowTheme.of(context).labelSmallFamily,
                                                                                          color: Colors.white,
                                                                                          fontSize: 11.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          useGoogleFonts: !FlutterFlowTheme.of(context).labelSmallIsCustom,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              20.0,
                                                                              0.0,
                                                                              20.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            listViewRoadmapItemsRecord.description,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                  color: Color(0xFF64748B),
                                                                                  letterSpacing: 0.0,
                                                                                  lineHeight: 1.4,
                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            20.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  listViewRoadmapItemsRecord
                                                                      .releaseTextOverride,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).bodySmallFamily,
                                                                        color:
                                                                            () {
                                                                          if (comesNextPageRoadmapItemsRecord?.status ==
                                                                              'Planned') {
                                                                            return FlutterFlowTheme.of(context).info;
                                                                          } else if (listViewRoadmapItemsRecord.status ==
                                                                              'In Progress') {
                                                                            return FlutterFlowTheme.of(context).warning;
                                                                          } else if (listViewRoadmapItemsRecord.status ==
                                                                              'Testing') {
                                                                            return FlutterFlowTheme.of(context).primary;
                                                                          } else if (listViewRoadmapItemsRecord.status ==
                                                                              'Released') {
                                                                            return FlutterFlowTheme.of(context).success;
                                                                          } else if (comesNextPageRoadmapItemsRecord?.status ==
                                                                              'Cancelled') {
                                                                            return FlutterFlowTheme.of(context).error;
                                                                          } else if (listViewRoadmapItemsRecord.status ==
                                                                              'Bug/Error') {
                                                                            return FlutterFlowTheme.of(context).tertiary;
                                                                          } else if (listViewRoadmapItemsRecord.status ==
                                                                              'Fixed') {
                                                                            return Color(0xFF18CE32);
                                                                          } else {
                                                                            return FlutterFlowTheme.of(context).error;
                                                                          }
                                                                        }(),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        useGoogleFonts:
                                                                            !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(
                                                            thickness: 1.0,
                                                            color: Color(
                                                                0xFFF1F5F9),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        5.0,
                                                                        0.0,
                                                                        5.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        Container(
                                                                          width:
                                                                              45.0,
                                                                          height:
                                                                              45.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.transparent,
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            border:
                                                                                Border.all(
                                                                              color: Colors.transparent,
                                                                              width: 2.0,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                _model.myReactionQ = await queryReactionsRecordOnce(
                                                                                  parent: listViewRoadmapItemsRecord.reference,
                                                                                  queryBuilder: (reactionsRecord) => reactionsRecord.where(
                                                                                    'user_id',
                                                                                    isEqualTo: currentUserUid,
                                                                                  ),
                                                                                  limit: 1,
                                                                                );
                                                                                if ((_model.myReactionQ != null && (_model.myReactionQ)!.isNotEmpty) && (_model.myReactionQ?.elementAtOrNull(0)?.emoji == '😍')) {
                                                                                  await containerReactionsRecordList.elementAtOrNull(0)!.reference.delete();
                                                                                } else {
                                                                                  if (_model.myReactionQ != null && (_model.myReactionQ)!.isNotEmpty) {
                                                                                    await _model.myReactionQ!.elementAtOrNull(0)!.reference.update(createReactionsRecordData(
                                                                                          emoji: '😍',
                                                                                        ));
                                                                                  } else {
                                                                                    await ReactionsRecord.createDoc(listViewRoadmapItemsRecord.reference).set(createReactionsRecordData(
                                                                                      userId: currentUserUid,
                                                                                      emoji: '😍',
                                                                                      createdAt: getCurrentTimestamp,
                                                                                    ));
                                                                                  }
                                                                                }

                                                                                safeSetState(() {});
                                                                              },
                                                                              child: Text(
                                                                                FFLocalizations.of(context).getText(
                                                                                  'fc9o1f0f' /* 😍 */,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                                                                                      color: FlutterFlowTheme.of(context).primaryBtnText,
                                                                                      fontSize: 24.0,
                                                                                      letterSpacing: 0.0,
                                                                                      useGoogleFonts: !FlutterFlowTheme.of(context).bodyLargeIsCustom,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        StreamBuilder<
                                                                            List<ReactionsRecord>>(
                                                                          stream:
                                                                              queryReactionsRecord(
                                                                            parent:
                                                                                listViewRoadmapItemsRecord.reference,
                                                                            queryBuilder: (reactionsRecord) =>
                                                                                reactionsRecord.where(
                                                                              'emoji',
                                                                              isEqualTo: '😍',
                                                                            ),
                                                                          ),
                                                                          builder:
                                                                              (context, snapshot) {
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
                                                                            List<ReactionsRecord>
                                                                                count1ReactionsRecordList =
                                                                                snapshot.data!;

                                                                            return Text(
                                                                              valueOrDefault<String>(
                                                                                count1ReactionsRecordList.length.toString(),
                                                                                '0',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                                    color: Color(0xFF64748B),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    useGoogleFonts: !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                                  ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              width: 4.0)),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        Container(
                                                                          width:
                                                                              45.0,
                                                                          height:
                                                                              45.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.transparent,
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            border:
                                                                                Border.all(
                                                                              color: Colors.transparent,
                                                                              width: 2.0,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                _model.myReactionQ2 = await queryReactionsRecordOnce(
                                                                                  parent: listViewRoadmapItemsRecord.reference,
                                                                                  queryBuilder: (reactionsRecord) => reactionsRecord.where(
                                                                                    'user_id',
                                                                                    isEqualTo: currentUserUid,
                                                                                  ),
                                                                                  limit: 1,
                                                                                );
                                                                                if ((_model.myReactionQ2 != null && (_model.myReactionQ2)!.isNotEmpty) && (_model.myReactionQ2?.elementAtOrNull(0)?.emoji == '🎉')) {
                                                                                  await containerReactionsRecordList.elementAtOrNull(0)!.reference.delete();
                                                                                } else {
                                                                                  if (_model.myReactionQ2 != null && (_model.myReactionQ2)!.isNotEmpty) {
                                                                                    await _model.myReactionQ2!.elementAtOrNull(0)!.reference.update(createReactionsRecordData(
                                                                                          emoji: '🎉',
                                                                                        ));
                                                                                  } else {
                                                                                    await ReactionsRecord.createDoc(listViewRoadmapItemsRecord.reference).set(createReactionsRecordData(
                                                                                      userId: currentUserUid,
                                                                                      emoji: '🎉',
                                                                                      createdAt: getCurrentTimestamp,
                                                                                    ));
                                                                                  }
                                                                                }

                                                                                safeSetState(() {});
                                                                              },
                                                                              child: Text(
                                                                                FFLocalizations.of(context).getText(
                                                                                  'k5uh1y5r' /* 🎉 */,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                                                                                      fontSize: 24.0,
                                                                                      letterSpacing: 0.0,
                                                                                      useGoogleFonts: !FlutterFlowTheme.of(context).bodyLargeIsCustom,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        StreamBuilder<
                                                                            List<ReactionsRecord>>(
                                                                          stream:
                                                                              queryReactionsRecord(
                                                                            parent:
                                                                                listViewRoadmapItemsRecord.reference,
                                                                            queryBuilder: (reactionsRecord) =>
                                                                                reactionsRecord.where(
                                                                              'emoji',
                                                                              isEqualTo: '🎉',
                                                                            ),
                                                                          ),
                                                                          builder:
                                                                              (context, snapshot) {
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
                                                                            List<ReactionsRecord>
                                                                                count2ReactionsRecordList =
                                                                                snapshot.data!;

                                                                            return Text(
                                                                              valueOrDefault<String>(
                                                                                count2ReactionsRecordList.length.toString(),
                                                                                '0',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                                    color: Color(0xFF64748B),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    useGoogleFonts: !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                                  ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              width: 4.0)),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        Container(
                                                                          width:
                                                                              45.0,
                                                                          height:
                                                                              45.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.transparent,
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            border:
                                                                                Border.all(
                                                                              color: Colors.transparent,
                                                                              width: 2.0,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                _model.myReactionQ3 = await queryReactionsRecordOnce(
                                                                                  parent: listViewRoadmapItemsRecord.reference,
                                                                                  queryBuilder: (reactionsRecord) => reactionsRecord.where(
                                                                                    'user_id',
                                                                                    isEqualTo: currentUserUid,
                                                                                  ),
                                                                                  limit: 1,
                                                                                );
                                                                                if ((_model.myReactionQ3 != null && (_model.myReactionQ3)!.isNotEmpty) && (_model.myReactionQ3?.elementAtOrNull(0)?.emoji == '💜')) {
                                                                                  await containerReactionsRecordList.elementAtOrNull(0)!.reference.delete();
                                                                                } else {
                                                                                  if (_model.myReactionQ3 != null && (_model.myReactionQ3)!.isNotEmpty) {
                                                                                    await _model.myReactionQ3!.elementAtOrNull(0)!.reference.update(createReactionsRecordData(
                                                                                          emoji: '💜',
                                                                                        ));
                                                                                  } else {
                                                                                    await ReactionsRecord.createDoc(listViewRoadmapItemsRecord.reference).set(createReactionsRecordData(
                                                                                      userId: currentUserUid,
                                                                                      emoji: '💜',
                                                                                      createdAt: getCurrentTimestamp,
                                                                                    ));
                                                                                  }
                                                                                }

                                                                                safeSetState(() {});
                                                                              },
                                                                              child: Text(
                                                                                FFLocalizations.of(context).getText(
                                                                                  '60pake22' /* 💜 */,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                                                                                      fontSize: 24.0,
                                                                                      letterSpacing: 0.0,
                                                                                      useGoogleFonts: !FlutterFlowTheme.of(context).bodyLargeIsCustom,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        StreamBuilder<
                                                                            List<ReactionsRecord>>(
                                                                          stream:
                                                                              queryReactionsRecord(
                                                                            parent:
                                                                                listViewRoadmapItemsRecord.reference,
                                                                            queryBuilder: (reactionsRecord) =>
                                                                                reactionsRecord.where(
                                                                              'emoji',
                                                                              isEqualTo: '💜',
                                                                            ),
                                                                          ),
                                                                          builder:
                                                                              (context, snapshot) {
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
                                                                            List<ReactionsRecord>
                                                                                count3ReactionsRecordList =
                                                                                snapshot.data!;

                                                                            return Text(
                                                                              valueOrDefault<String>(
                                                                                count3ReactionsRecordList.length.toString(),
                                                                                '0',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                                    color: Color(0xFF64748B),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    useGoogleFonts: !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                                  ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              width: 4.0)),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        Container(
                                                                          width:
                                                                              45.0,
                                                                          height:
                                                                              45.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.transparent,
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            border:
                                                                                Border.all(
                                                                              color: Colors.transparent,
                                                                              width: 2.0,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                _model.myReactionQ4 = await queryReactionsRecordOnce(
                                                                                  parent: listViewRoadmapItemsRecord.reference,
                                                                                  queryBuilder: (reactionsRecord) => reactionsRecord.where(
                                                                                    'user_id',
                                                                                    isEqualTo: currentUserUid,
                                                                                  ),
                                                                                  limit: 1,
                                                                                );
                                                                                if ((_model.myReactionQ4 != null && (_model.myReactionQ4)!.isNotEmpty) && (_model.myReactionQ4?.elementAtOrNull(0)?.emoji == '🙏')) {
                                                                                  await containerReactionsRecordList.elementAtOrNull(0)!.reference.delete();
                                                                                } else {
                                                                                  if (_model.myReactionQ4 != null && (_model.myReactionQ4)!.isNotEmpty) {
                                                                                    await _model.myReactionQ4!.elementAtOrNull(0)!.reference.update(createReactionsRecordData(
                                                                                          emoji: '🙏',
                                                                                        ));
                                                                                  } else {
                                                                                    await ReactionsRecord.createDoc(listViewRoadmapItemsRecord.reference).set(createReactionsRecordData(
                                                                                      userId: currentUserUid,
                                                                                      emoji: '🙏',
                                                                                      createdAt: getCurrentTimestamp,
                                                                                    ));
                                                                                  }
                                                                                }

                                                                                safeSetState(() {});
                                                                              },
                                                                              child: Text(
                                                                                FFLocalizations.of(context).getText(
                                                                                  '0g09b04k' /* 🙏 */,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                                                                                      fontSize: 24.0,
                                                                                      letterSpacing: 0.0,
                                                                                      useGoogleFonts: !FlutterFlowTheme.of(context).bodyLargeIsCustom,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        StreamBuilder<
                                                                            List<ReactionsRecord>>(
                                                                          stream:
                                                                              queryReactionsRecord(
                                                                            parent:
                                                                                listViewRoadmapItemsRecord.reference,
                                                                            queryBuilder: (reactionsRecord) =>
                                                                                reactionsRecord.where(
                                                                              'emoji',
                                                                              isEqualTo: '🙏',
                                                                            ),
                                                                          ),
                                                                          builder:
                                                                              (context, snapshot) {
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
                                                                            List<ReactionsRecord>
                                                                                count4ReactionsRecordList =
                                                                                snapshot.data!;

                                                                            return Text(
                                                                              valueOrDefault<String>(
                                                                                count4ReactionsRecordList.length.toString(),
                                                                                '0',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                                    color: Color(0xFF64748B),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    useGoogleFonts: !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                                  ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              width: 4.0)),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          12.0)),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 8.0)),
                                                            ),
                                                          ),
                                                          if (listViewRoadmapItemsRecord
                                                                      .ctaUrl !=
                                                                  '')
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    FFButtonWidget(
                                                                  onPressed:
                                                                      () {
                                                                    print(
                                                                        'Button pressed ...');
                                                                  },
                                                                  text: listViewRoadmapItemsRecord
                                                                      .ctaLabel,
                                                                  options:
                                                                      FFButtonOptions(
                                                                    width:
                                                                        140.0,
                                                                    height:
                                                                        40.0,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            20.0,
                                                                            0.0,
                                                                            20.0,
                                                                            0.0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    color: Color(
                                                                        0xFFA855F7),
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                        ),
                                                                    elevation:
                                                                        2.0,
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width:
                                                                          0.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            24.0),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                        ].divide(SizedBox(
                                                            height: 12.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 16.0)),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFF3E8FF), Color(0xFFFDF2F8)],
                          stops: [0.0, 1.0],
                          begin: AlignmentDirectional(1.0, -1.0),
                          end: AlignmentDirectional(-1.0, 1.0),
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'k8gjdorm' /* Have an idea of your own? */,
                            ),
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleMediumFamily,
                                  color: Color(0xFF6B46C1),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleMediumIsCustom,
                                ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              context.pushNamed(
                                SupportPageWidget.routeName,
                                extra: <String, dynamic>{
                                  '__transition_info__': TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.fade,
                                  ),
                                },
                              );
                            },
                            text: FFLocalizations.of(context).getText(
                              'mqyf20mp' /* Suggest a Feature */,
                            ),
                            options: FFButtonOptions(
                              height: 48.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  32.0, 0.0, 32.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Color(0xFF8B5CF6),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleSmallFamily,
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .titleSmallIsCustom,
                                  ),
                              elevation: 2.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
                    ),
                  ),
                ]
                    .divide(SizedBox(height: 24.0))
                    .addToStart(SizedBox(height: 16.0))
                    .addToEnd(SizedBox(height: 32.0)),
              ),
            ),
          ),
        );
      },
    );
  }
}
