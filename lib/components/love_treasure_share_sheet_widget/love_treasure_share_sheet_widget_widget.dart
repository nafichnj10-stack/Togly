import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'love_treasure_share_sheet_widget_model.dart';
export 'love_treasure_share_sheet_widget_model.dart';

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
class LoveTreasureShareSheetWidgetWidget extends StatefulWidget {
  const LoveTreasureShareSheetWidgetWidget({super.key});

  @override
  State<LoveTreasureShareSheetWidgetWidget> createState() =>
      _LoveTreasureShareSheetWidgetWidgetState();
}

class _LoveTreasureShareSheetWidgetWidgetState
    extends State<LoveTreasureShareSheetWidgetWidget> {
  late LoveTreasureShareSheetWidgetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoveTreasureShareSheetWidgetModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

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
                        StreamBuilder<List<LoveTreasuresRecord>>(
                          stream: queryLoveTreasuresRecord(
                            queryBuilder: (loveTreasuresRecord) =>
                                loveTreasuresRecord.where(
                              'relationship_id',
                              isEqualTo: valueOrDefault(
                                  currentUserDocument?.relationshipId, ''),
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
                            List<LoveTreasuresRecord>
                                loveTreasureShareSheetWidgetLoveTreasuresRecordList =
                                snapshot.data!;
                            // Return an empty Container when the item does not exist.
                            if (snapshot.data!.isEmpty) {
                              return Container();
                            }
                            final loveTreasureShareSheetWidgetLoveTreasuresRecord =
                                loveTreasureShareSheetWidgetLoveTreasuresRecordList
                                        .isNotEmpty
                                    ? loveTreasureShareSheetWidgetLoveTreasuresRecordList
                                        .first
                                    : null;

                            return Container(
                              width: double.infinity,
                              height: 600.0,
                              child:
                                  custom_widgets.LoveTreasureShareSheetWidget(
                                width: double.infinity,
                                height: 600.0,
                                titleText:
                                    FFLocalizations.of(context).getVariableText(
                                  enText: 'Our Love Treasure is ready ✨',
                                  deText: 'Unsere Liebestruhe ist bereit ✨',
                                  esText:
                                      'Nuestro tesoro del amor está listo ✨',
                                ),
                                subtitleText:
                                    FFLocalizations.of(context).getVariableText(
                                  enText:
                                      'A little box full of love, memories and surprises.',
                                  deText:
                                      'Eine kleine Truhe voller Liebe, Erinnerungen und Überraschungen.',
                                  esText:
                                      'Un pequeño tesoro lleno de amor, recuerdos y sorpresas.',
                                ),
                                partner1Name:
                                    columnRelationshipViewsRecord?.myName,
                                partner2Name:
                                    columnRelationshipViewsRecord?.partnerName,
                                dateText: dateTimeFormat(
                                  "yMd",
                                  getCurrentTimestamp,
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                ),
                                surpriseCountText: functions
                                    .getTreasureSurpriseCount(
                                        loveTreasureShareSheetWidgetLoveTreasuresRecord
                                            ?.surprisesCountUserA,
                                        loveTreasureShareSheetWidgetLoveTreasuresRecord
                                            ?.surprisesCountUserB)
                                    .toString(),
                                statusText:
                                    FFLocalizations.of(context).getVariableText(
                                  enText: 'surprises in the Treasure',
                                  deText: 'überraschungen in der Truhe',
                                  esText: 'sorpresas en el tesoro',
                                ),
                                ctaText:
                                    FFLocalizations.of(context).getVariableText(
                                  enText:
                                      'Create your own Love Treasure on Togly',
                                  deText:
                                      'Erstelle deine eigene Liebestruhe auf Togly',
                                  esText:
                                      'Crea tu propio tesoro del amor en Togly',
                                ),
                                brandText:
                                    FFLocalizations.of(context).getVariableText(
                                  enText: 'TOGLY • Love Treasure',
                                  deText: 'TOGLY • Liebestruhe',
                                  esText: 'TOGLY • Tesoro del amor',
                                ),
                                shareText:
                                    FFLocalizations.of(context).getVariableText(
                                  enText:
                                      'We opened our Love Treasure on Togly 💕',
                                  deText:
                                      'Wir haben unsere Liebestruhe auf Togly geöffnet 💕',
                                  esText:
                                      'Abrimos nuestro tesoro del amor en Togly 💕',
                                ),
                                shareSubject:
                                    FFLocalizations.of(context).getVariableText(
                                  enText: 'Our Love Treasure',
                                  deText: 'Unsere Liebestruhe',
                                  esText: 'Nuestro tesoro del amor',
                                ),
                                shareButtonText:
                                    FFLocalizations.of(context).getVariableText(
                                  enText: 'Share Treasure',
                                  deText: 'Truhe teilen',
                                  esText: 'Compartir tesoro',
                                ),
                                urlText:
                                    FFLocalizations.of(context).getVariableText(
                                  enText: 'togly.app',
                                  deText: 'togly.app',
                                  esText: 'togly.app',
                                ),
                                partner1PhotoUrl:
                                    columnRelationshipViewsRecord?.myPhotoUrl,
                                partner2PhotoUrl: columnRelationshipViewsRecord
                                    ?.partnerPhotoUrl,
                              ),
                            );
                          },
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
