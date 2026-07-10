import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:firebase_storagelibrary_2sa6k9/app_state.dart'
    as firebase_storagelibrary_2sa6k9_app_state;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sharecard_heartbeat_model.dart';
export 'sharecard_heartbeat_model.dart';

/// Create a beautiful mobile social media share card component in a romantic,
/// dreamy, modern style for a couples app called Togly.
///
/// The component should be designed as a 9:16 vertical story-style card for
/// sharing on TikTok, Instagram Stories, and other social media platforms.
///
/// Design requirements:
/// - soft pink, purple, and pastel gradient background
/// - elegant, emotional, dreamy visual style
/// - clean, premium, modern mobile UI
/// - rounded corners
/// - subtle glowing heart elements or soft floating light effects in the
/// background
/// - visually balanced layout with strong focus on the heartbeat result in
/// the center
///
/// Content structure:
/// - small Togly branding at the top
/// - title: "Our Heartbeat Today"
/// - date text below the title
/// - two circular partner avatars near the top-middle with a heart icon
/// between them
/// - a large circular result area in the center showing a percentage like
/// "73%"
/// - below the percentage, a connection label like "Needs a little more
/// closeness"
/// - below that, a short emotional insight text like: "Today you may need a
/// little more closeness and intentional connection."
/// - a soft call-to-action area at the bottom saying: "Check your heartbeat
/// together on Togly"
///
/// Style notes:
/// - make it look highly shareable and visually polished
/// - suitable for social media screenshots
/// - avoid clutter
/// - use strong visual hierarchy
/// - emphasize emotion, intimacy, and elegance
/// - the result percentage should be the main visual focus
/// - keep enough empty space so it feels premium and not crowded
///
/// Use placeholder content for avatars, date, percentage, connection label,
/// and insight text.
class SharecardHeartbeatWidget extends StatefulWidget {
  const SharecardHeartbeatWidget({super.key});

  @override
  State<SharecardHeartbeatWidget> createState() =>
      _SharecardHeartbeatWidgetState();
}

class _SharecardHeartbeatWidgetState extends State<SharecardHeartbeatWidget> {
  late SharecardHeartbeatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SharecardHeartbeatModel());

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
        List<PublicUsersRecord> containerPublicUsersRecordList = snapshot.data!;
        final containerPublicUsersRecord =
            containerPublicUsersRecordList.isNotEmpty
                ? containerPublicUsersRecordList.first
                : null;

        return Container(
          width: 393.0,
          height: 731.1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFF8C8D4),
                Color(0xFFE8B4F0),
                Color(0xFFC4A8F5),
                Color(0xFFA8C4F8)
              ],
              stops: [0.0, 0.4, 0.7, 1.0],
              begin: AlignmentDirectional(1.0, 1.0),
              end: AlignmentDirectional(-1.0, -1.0),
            ),
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(32.0, 48.0, 32.0, 48.0),
            child: AuthUserStreamWidget(
              builder: (context) =>
                  StreamBuilder<List<RelationshipViewsRecord>>(
                stream: queryRelationshipViewsRecord(
                  queryBuilder: (relationshipViewsRecord) =>
                      relationshipViewsRecord.where(
                    'relationship_id',
                    isEqualTo:
                        valueOrDefault(currentUserDocument?.relationshipId, ''),
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
                      columnRelationshipViewsRecordList = snapshot.data!;
                  final columnRelationshipViewsRecord =
                      columnRelationshipViewsRecordList.isNotEmpty
                          ? columnRelationshipViewsRecordList.first
                          : null;

                  return SingleChildScrollView(
                    primary: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 720.0,
                          child: custom_widgets.HeartbeatShareSheetWidget(
                            width: double.infinity,
                            height: 720.0,
                            titleText: () {
                              if (valueOrDefault(
                                      currentUserDocument?.appLanguage, '') ==
                                  'de') {
                                return 'Unser Herzschlag heute';
                              } else if (valueOrDefault(
                                      currentUserDocument?.appLanguage, '') ==
                                  'es') {
                                return 'Nuestro latido de hoy';
                              } else {
                                return 'Our heartbeat today';
                              }
                            }(),
                            partner1Name: containerPublicUsersRecord?.name,
                            partner2Name:
                                columnRelationshipViewsRecord?.partnerName,
                            scorePercent:
                                FFAppState().heartbeatScorePercent.toDouble(),
                            connectionLabel: () {
                              if (FFAppState().heartbeatConnectionLabelKey ==
                                  'deeply_connected') {
                                return () {
                                  if (valueOrDefault(
                                          currentUserDocument?.appLanguage,
                                          '') ==
                                      'de') {
                                    return 'Tief verbunden';
                                  } else if (valueOrDefault(
                                          currentUserDocument?.appLanguage,
                                          '') ==
                                      'es') {
                                    return 'Profundamente conectados';
                                  } else {
                                    return 'Deeply connected';
                                  }
                                }();
                              } else if (FFAppState()
                                      .heartbeatConnectionLabelKey ==
                                  'connected') {
                                return () {
                                  if (valueOrDefault(
                                          currentUserDocument?.appLanguage,
                                          '') ==
                                      'de') {
                                    return 'Verbunden';
                                  } else if (valueOrDefault(
                                          currentUserDocument?.appLanguage,
                                          '') ==
                                      'es') {
                                    return 'Conectados';
                                  } else {
                                    return 'Connected';
                                  }
                                }();
                              } else if (FFAppState()
                                      .heartbeatConnectionLabelKey ==
                                  'gently_needs_closeness') {
                                return () {
                                  if (valueOrDefault(
                                          currentUserDocument?.appLanguage,
                                          '') ==
                                      'de') {
                                    return 'Es braucht etwas Nähe';
                                  } else if (valueOrDefault(
                                          currentUserDocument?.appLanguage,
                                          '') ==
                                      'es') {
                                    return 'Necesita un poco más de cercanía';
                                  } else {
                                    return 'Needs a little more closeness';
                                  }
                                }();
                              } else if (FFAppState()
                                      .heartbeatConnectionLabelKey ==
                                  'needs_closeness') {
                                return () {
                                  if (valueOrDefault(
                                          currentUserDocument?.appLanguage,
                                          '') ==
                                      'de') {
                                    return 'Es braucht mehr Nähe';
                                  } else if (valueOrDefault(
                                          currentUserDocument?.appLanguage,
                                          '') ==
                                      'es') {
                                    return 'Necesita cercanía';
                                  } else {
                                    return 'Needs more closeness';
                                  }
                                }();
                              } else {
                                return '';
                              }
                            }(),
                            insightText: () {
                              if (valueOrDefault(
                                      currentUserDocument?.appLanguage, '') ==
                                  'de') {
                                return FFAppState().heartbeatInsightDe;
                              } else if (valueOrDefault(
                                      currentUserDocument?.appLanguage, '') ==
                                  'es') {
                                return FFAppState().heartbeatInsightEs;
                              } else {
                                return FFAppState().heartbeatInsightEn;
                              }
                            }(),
                            ctaText: FFLocalizations.of(context).getText(
                              'th6wnol7' /* Check your heartbeat together */,
                            ),
                            brandText: FFLocalizations.of(context).getText(
                              'qni7nzoq' /* TOGLY - Couple App */,
                            ),
                            shareText: FFLocalizations.of(context).getText(
                              'srn56162' /* Our relationship heartbeat tod... */,
                            ),
                            shareSubject: 'shareSubject',
                            shareButtonText:
                                FFLocalizations.of(context).getText(
                              'c73t2mtx' /* Share now */,
                            ),
                            urlText: FFLocalizations.of(context).getText(
                              '1e155pgf' /* on Togly */,
                            ),
                            partner1ImagePath:
                                columnRelationshipViewsRecord?.myPhotoUrl,
                            partner2ImagePath:
                                columnRelationshipViewsRecord?.partnerPhotoUrl,
                          ),
                        ),
                      ].divide(SizedBox(height: 0.0)),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
