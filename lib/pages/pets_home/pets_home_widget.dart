import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/components/action_btn_widget.dart';
import '/components/pet_name_sheet/pet_name_sheet_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'pets_home_model.dart';
export 'pets_home_model.dart';

/// Create a new mobile page for a couple app called “Love Buddies”.
///
/// The page should have a soft romantic purple/pink design, matching a dreamy
/// couple app style. Use rounded cards, glassmorphism effects, soft shadows,
/// pastel gradients, and a clean modern layout.
///
/// Page purpose:
/// This page is the control center for two relationship pets. The pets
/// represent the couple and later connect to an Android home screen widget.
///
/// Structure:
///
/// 1. App Bar
/// - Back button on the left
/// - Title: “Love Buddies”
/// - Small settings icon on the right
///
/// 2. Hero Section
/// Create a large rounded image card at the top.
/// Use a placeholder image container for now.
/// The placeholder should represent the two pets.
/// Add a soft purple gradient background behind it.
/// Below or inside the card show two small name chips:
/// - “Bam”
/// - “Mimi”
///
/// 3. Love Score Card
/// Create a rounded card with two columns:
/// Left:
/// - Label: “Love Score”
/// - Big number: “89”
/// - Small text: “/100”
/// - Progress bar
///
/// Right:
/// - Label: “Today’s Love Points”
/// - Heart icon
/// - Number: “89”
/// - Small text: “/100”
///
/// 4. Mood Status Card
/// Create a rounded card with an emoji/icon on the left.
/// Text:
/// Title: “Your pets are happy!”
/// Subtitle: “Keep sharing love to stay connected.”
/// Use a happy green emoji or icon.
///
/// 5. Quick Actions
/// Create a row of four rounded action buttons:
/// - Send Love
/// - Sleep Mode
/// - Swap Pets
/// - Edit Pets
///
/// Each button should have a soft icon container and label.
///
/// 6. Next Meeting Card
/// Create a rounded card showing the next meeting.
/// Left side:
/// - Calendar icon
/// - Title: “Next Meeting”
/// - Subtitle: “Weekend Trip”
/// - Date: “12 – 15 July 2025”
/// - Location: “Berlin, Germany”
///
/// Right side:
/// A small rounded countdown box:
/// - “In”
/// - “5”
/// - “days”
///
/// 7. Customize Pets Card
/// Create a simple rounded card:
/// Title: “Customize Your Pets”
/// Subtitle: “Change their names or switch who has which pet.”
/// On the right show a small placeholder pet image or icon and a chevron.
///
/// 8. Recent Activity Card
/// Create a rounded card with title “Recent Activity”.
/// Add three list items:
/// - “You sent love” / “2h ago”
/// - “Bam went to sleep” / “8h ago”
/// - “You earned 10 love points” / “1d ago”
///
/// 9. Bottom Navigation
/// Add a bottom nav bar with five items:
/// Home, Calendar, Pets, Trunk, More.
/// Pets should be selected with a purple paw icon.
///
/// Design requirements:
/// - Background: soft purple/pink gradient
/// - Cards: white or light purple with slight transparency
/// - Border radius: 20-28px
/// - Main accent color: purple
/// - Secondary accent: pink
/// - Typography: bold titles, clean readable text
/// - Overall style: cute, emotional, premium, romantic, modern
///
/// Use only static placeholder data for now.
/// Do not connect Firebase yet.
/// Make the layout responsive for a standard mobile screen.
class PetsHomeWidget extends StatefulWidget {
  const PetsHomeWidget({super.key});

  static String routeName = 'pets_home';
  static String routePath = '/pets_home';

  @override
  State<PetsHomeWidget> createState() => _PetsHomeWidgetState();
}

class _PetsHomeWidgetState extends State<PetsHomeWidget> {
  late PetsHomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PetsHomeModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'pets_home'});
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SafeArea(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 16.0, 24.0, 16.0),
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  borderRadius: 8.0,
                                  buttonSize: 40.0,
                                  fillColor: Colors.transparent,
                                  icon: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 20.0,
                                  ),
                                  onPressed: () async {
                                    context.pushNamed(
                                      HomeWidget.routeName,
                                      extra: <String, dynamic>{
                                        '__transition_info__': TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                        ),
                                      },
                                    );
                                  },
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'rt5uai9y' /* Our Companions */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleLargeFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        lineHeight: 1.27,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleLargeIsCustom,
                                      ),
                                ),
                                FlutterFlowIconButton(
                                  borderRadius: 8.0,
                                  buttonSize: 40.0,
                                  fillColor: Colors.transparent,
                                  icon: Icon(
                                    Icons.settings_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 20.0,
                                  ),
                                  onPressed: () async {
                                    context.pushNamed(
                                      ProfilePageWidget.routeName,
                                      extra: <String, dynamic>{
                                        '__transition_info__': TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                        ),
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Container(
                        child: AuthUserStreamWidget(
                          builder: (context) =>
                              StreamBuilder<List<RelationshipViewsRecord>>(
                            stream: queryRelationshipViewsRecord(
                              queryBuilder: (relationshipViewsRecord) =>
                                  relationshipViewsRecord.where(
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
                              List<RelationshipViewsRecord>
                                  columnRelationshipViewsRecordList =
                                  snapshot.data!;
                              final columnRelationshipViewsRecord =
                                  columnRelationshipViewsRecordList.isNotEmpty
                                      ? columnRelationshipViewsRecordList.first
                                      : null;

                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (columnRelationshipViewsRecord
                                          ?.loveState ==
                                      'happy')
                                    StreamBuilder<
                                        List<RelationshipViewsRecord>>(
                                      stream: queryRelationshipViewsRecord(
                                        queryBuilder:
                                            (relationshipViewsRecord) =>
                                                relationshipViewsRecord.where(
                                          'relationship_id',
                                          isEqualTo: valueOrDefault(
                                              currentUserDocument
                                                  ?.relationshipId,
                                              ''),
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
                                        List<RelationshipViewsRecord>
                                            happyRelationshipViewsRecordList =
                                            snapshot.data!;
                                        // Return an empty Container when the item does not exist.
                                        if (snapshot.data!.isEmpty) {
                                          return Container();
                                        }
                                        final happyRelationshipViewsRecord =
                                            happyRelationshipViewsRecordList
                                                    .isNotEmpty
                                                ? happyRelationshipViewsRecordList
                                                    .first
                                                : null;

                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(28.0),
                                          child: Container(
                                            height: 220.0,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 20.0,
                                                  color: Color(0xFFE9D5FF),
                                                  offset: Offset(
                                                    0.0,
                                                    10.0,
                                                  ),
                                                  spreadRadius: 0.0,
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(28.0),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Stack(
                                              alignment: AlignmentDirectional(
                                                  -1.0, -1.0),
                                              children: [
                                                Image.asset(
                                                  'assets/images/happy.webp',
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  fit: BoxFit.fitWidth,
                                                  alignment:
                                                      Alignment(0.0, 0.0),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.transparent,
                                                        Color(0x33000000)
                                                      ],
                                                      stops: [0.0, 1.0],
                                                      begin:
                                                          AlignmentDirectional(
                                                              0.0, 1.0),
                                                      end: AlignmentDirectional(
                                                          0, -1.0),
                                                    ),
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 1.0),
                                                  child: Container(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: Container(
                                                        child:
                                                            SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                height: 34.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xE6FFFFFF),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12.0,
                                                                          0.0,
                                                                          12.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          happyRelationshipViewsRecord?.myLoveBuddyPet == 'dog'
                                                                              ? happyRelationshipViewsRecord?.myLoveBuddyName
                                                                              : happyRelationshipViewsRecord?.partnerLoveBuddyName,
                                                                          'name',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              lineHeight: 1.38,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).labelMediumIsCustom,
                                                                            ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            6.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 34.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xE6FFFFFF),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12.0,
                                                                          0.0,
                                                                          12.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          happyRelationshipViewsRecord?.myLoveBuddyPet == 'cat'
                                                                              ? happyRelationshipViewsRecord?.myLoveBuddyName
                                                                              : happyRelationshipViewsRecord?.partnerLoveBuddyName,
                                                                          'name',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                                                                              color: FlutterFlowTheme.of(context).secondary,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              lineHeight: 1.38,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).labelMediumIsCustom,
                                                                            ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            6.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 8.0)),
                                                          ),
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
                                  if (columnRelationshipViewsRecord
                                          ?.loveState ==
                                      'sad')
                                    StreamBuilder<
                                        List<RelationshipViewsRecord>>(
                                      stream: queryRelationshipViewsRecord(
                                        queryBuilder:
                                            (relationshipViewsRecord) =>
                                                relationshipViewsRecord.where(
                                          'relationship_id',
                                          isEqualTo: valueOrDefault(
                                              currentUserDocument
                                                  ?.relationshipId,
                                              ''),
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
                                        List<RelationshipViewsRecord>
                                            sadRelationshipViewsRecordList =
                                            snapshot.data!;
                                        // Return an empty Container when the item does not exist.
                                        if (snapshot.data!.isEmpty) {
                                          return Container();
                                        }
                                        final sadRelationshipViewsRecord =
                                            sadRelationshipViewsRecordList
                                                    .isNotEmpty
                                                ? sadRelationshipViewsRecordList
                                                    .first
                                                : null;

                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(28.0),
                                          child: Container(
                                            height: 220.0,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 20.0,
                                                  color: Color(0xFFE9D5FF),
                                                  offset: Offset(
                                                    0.0,
                                                    10.0,
                                                  ),
                                                  spreadRadius: 0.0,
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(28.0),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Stack(
                                              alignment: AlignmentDirectional(
                                                  -1.0, -1.0),
                                              children: [
                                                Image.asset(
                                                  'assets/images/sad.webp',
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  fit: BoxFit.fitWidth,
                                                  alignment:
                                                      Alignment(0.0, 0.0),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.transparent,
                                                        Color(0x33000000)
                                                      ],
                                                      stops: [0.0, 1.0],
                                                      begin:
                                                          AlignmentDirectional(
                                                              0.0, 1.0),
                                                      end: AlignmentDirectional(
                                                          0, -1.0),
                                                    ),
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 1.0),
                                                  child: Container(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: Container(
                                                        child:
                                                            SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                height: 34.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xE6FFFFFF),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12.0,
                                                                          0.0,
                                                                          12.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          sadRelationshipViewsRecord?.myLoveBuddyPet == 'dog'
                                                                              ? sadRelationshipViewsRecord?.myLoveBuddyName
                                                                              : sadRelationshipViewsRecord?.partnerLoveBuddyName,
                                                                          'name',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              lineHeight: 1.38,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).labelMediumIsCustom,
                                                                            ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            6.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 34.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xE6FFFFFF),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12.0,
                                                                          0.0,
                                                                          12.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          sadRelationshipViewsRecord?.myLoveBuddyPet == 'cat'
                                                                              ? sadRelationshipViewsRecord?.myLoveBuddyName
                                                                              : sadRelationshipViewsRecord?.partnerLoveBuddyName,
                                                                          'name',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                                                                              color: FlutterFlowTheme.of(context).secondary,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              lineHeight: 1.38,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).labelMediumIsCustom,
                                                                            ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            6.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 8.0)),
                                                          ),
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
                                  if (columnRelationshipViewsRecord
                                          ?.loveState ==
                                      'angry')
                                    StreamBuilder<
                                        List<RelationshipViewsRecord>>(
                                      stream: queryRelationshipViewsRecord(
                                        queryBuilder:
                                            (relationshipViewsRecord) =>
                                                relationshipViewsRecord.where(
                                          'relationship_id',
                                          isEqualTo: valueOrDefault(
                                              currentUserDocument
                                                  ?.relationshipId,
                                              ''),
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
                                        List<RelationshipViewsRecord>
                                            angryRelationshipViewsRecordList =
                                            snapshot.data!;
                                        // Return an empty Container when the item does not exist.
                                        if (snapshot.data!.isEmpty) {
                                          return Container();
                                        }
                                        final angryRelationshipViewsRecord =
                                            angryRelationshipViewsRecordList
                                                    .isNotEmpty
                                                ? angryRelationshipViewsRecordList
                                                    .first
                                                : null;

                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(28.0),
                                          child: Container(
                                            height: 220.0,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 20.0,
                                                  color: Color(0xFFE9D5FF),
                                                  offset: Offset(
                                                    0.0,
                                                    10.0,
                                                  ),
                                                  spreadRadius: 0.0,
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(28.0),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Stack(
                                              alignment: AlignmentDirectional(
                                                  -1.0, -1.0),
                                              children: [
                                                Image.asset(
                                                  'assets/images/angry.webp',
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  fit: BoxFit.fitWidth,
                                                  alignment:
                                                      Alignment(0.0, 0.0),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.transparent,
                                                        Color(0x33000000)
                                                      ],
                                                      stops: [0.0, 1.0],
                                                      begin:
                                                          AlignmentDirectional(
                                                              0.0, 1.0),
                                                      end: AlignmentDirectional(
                                                          0, -1.0),
                                                    ),
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 1.0),
                                                  child: Container(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: Container(
                                                        child:
                                                            SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                height: 34.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xE6FFFFFF),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12.0,
                                                                          0.0,
                                                                          12.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          angryRelationshipViewsRecord?.myLoveBuddyPet == 'dog'
                                                                              ? angryRelationshipViewsRecord?.myLoveBuddyName
                                                                              : angryRelationshipViewsRecord?.partnerLoveBuddyName,
                                                                          'name',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              lineHeight: 1.38,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).labelMediumIsCustom,
                                                                            ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            6.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 34.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xE6FFFFFF),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12.0,
                                                                          0.0,
                                                                          12.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          angryRelationshipViewsRecord?.myLoveBuddyPet == 'cat'
                                                                              ? angryRelationshipViewsRecord?.myLoveBuddyName
                                                                              : angryRelationshipViewsRecord?.partnerLoveBuddyName,
                                                                          'name',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                                                                              color: FlutterFlowTheme.of(context).secondary,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              lineHeight: 1.38,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).labelMediumIsCustom,
                                                                            ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            6.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 8.0)),
                                                          ),
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
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(28.0),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10.0,
                              sigmaY: 10.0,
                            ),
                            child: AuthUserStreamWidget(
                              builder: (context) =>
                                  StreamBuilder<List<RelationshipViewsRecord>>(
                                stream: queryRelationshipViewsRecord(
                                  queryBuilder: (relationshipViewsRecord) =>
                                      relationshipViewsRecord.where(
                                    'relationship_id',
                                    isEqualTo: valueOrDefault(
                                        currentUserDocument?.relationshipId,
                                        ''),
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
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  List<RelationshipViewsRecord>
                                      containerRelationshipViewsRecordList =
                                      snapshot.data!;
                                  final containerRelationshipViewsRecord =
                                      containerRelationshipViewsRecordList
                                              .isNotEmpty
                                          ? containerRelationshipViewsRecordList
                                              .first
                                          : null;

                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xCCFFF7FD),
                                      borderRadius: BorderRadius.circular(28.0),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(24.0),
                                      child: Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '29xv0jv7' /* Happiness */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelSmall
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmallFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          lineHeight: 1.27,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelSmallIsCustom,
                                                        ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        valueOrDefault<String>(
                                                          containerRelationshipViewsRecord
                                                              ?.loveScore
                                                              .toString(),
                                                          'score',
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              fontSize: 26.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              lineHeight: 1.47,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumIsCustom,
                                                            ),
                                                      ),
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'cuvgeyju' /* /100 */,
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumFamily,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              fontSize: 26.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              lineHeight: 1.38,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumIsCustom,
                                                            ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 2.0)),
                                                  ),
                                                  LinearPercentIndicator(
                                                    percent:
                                                        containerRelationshipViewsRecord!
                                                            .lovePercent,
                                                    lineHeight: 8.0,
                                                    animation: true,
                                                    animateFromLastPercent:
                                                        true,
                                                    progressColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    backgroundColor:
                                                        Color(0x1A9F7BFF),
                                                    barRadius:
                                                        Radius.circular(4.0),
                                                    padding: EdgeInsets.zero,
                                                  ),
                                                ].divide(SizedBox(height: 8.0)),
                                              ),
                                            ),
                                            Container(
                                              width: 1.0,
                                              height: 40.0,
                                              decoration: BoxDecoration(
                                                color: Color(0x80F8F2FF),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '4m99voe9' /* Bond Points collected today: */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelSmall
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmallFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          lineHeight: 1.27,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelSmallIsCustom,
                                                        ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      FaIcon(
                                                        FontAwesomeIcons
                                                            .solidGrinHearts,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                        size: 20.0,
                                                      ),
                                                      Text(
                                                        valueOrDefault<String>(
                                                          containerRelationshipViewsRecord
                                                              .loveTodayPoints
                                                              .toString(),
                                                          'points',
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                              fontSize: 26.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              lineHeight: 1.47,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumIsCustom,
                                                            ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 4.0)),
                                                  ),
                                                ].divide(SizedBox(height: 8.0)),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 24.0)),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(),
                      child: AuthUserStreamWidget(
                        builder: (context) =>
                            StreamBuilder<List<RelationshipViewsRecord>>(
                          stream: queryRelationshipViewsRecord(
                            queryBuilder: (relationshipViewsRecord) =>
                                relationshipViewsRecord.where(
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
                            List<RelationshipViewsRecord>
                                columnRelationshipViewsRecordList =
                                snapshot.data!;
                            final columnRelationshipViewsRecord =
                                columnRelationshipViewsRecordList.isNotEmpty
                                    ? columnRelationshipViewsRecordList.first
                                    : null;

                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                if (columnRelationshipViewsRecord?.loveState ==
                                    'happy')
                                  Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0x99DCFCE7),
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Color(0xFFBBF7D0),
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 16.0, 24.0, 16.0),
                                          child: Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '0acnxmox' /* 😊 */,
                                                  ),
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            fontSize: 32.0,
                                                            letterSpacing: 0.0,
                                                            lineHeight: 1.47,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'ci8z4e25' /* Your Companions are Happy! */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeFamily,
                                                                color: Color(
                                                                    0xFF166534),
                                                                fontSize: 17.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                lineHeight: 1.5,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLargeIsCustom,
                                                              ),
                                                        ),
                                                      ),
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          's8w2r1za' /* Your relationship is bringing ... */,
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodySmall
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallFamily,
                                                              color: Color(
                                                                  0xCC166534),
                                                              letterSpacing:
                                                                  0.0,
                                                              lineHeight: 1.38,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallIsCustom,
                                                            ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 2.0)),
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 16.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (columnRelationshipViewsRecord?.loveState ==
                                    'sad')
                                  Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .warning,
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Color(0xFFBBF7D0),
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 16.0, 24.0, 16.0),
                                          child: Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'a78ylr7d' /* 😞 */,
                                                  ),
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            fontSize: 32.0,
                                                            letterSpacing: 0.0,
                                                            lineHeight: 1.47,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'aqwrsgqg' /* Your Companions miss your conn... */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeFamily,
                                                                color: Color(
                                                                    0xFF166534),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                lineHeight: 1.5,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLargeIsCustom,
                                                              ),
                                                        ),
                                                      ),
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'r6rlguxz' /* Spend a little time together a... */,
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodySmall
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallFamily,
                                                              color: Color(
                                                                  0xCC166534),
                                                              letterSpacing:
                                                                  0.0,
                                                              lineHeight: 1.38,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallIsCustom,
                                                            ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 2.0)),
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 16.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (columnRelationshipViewsRecord?.loveState ==
                                    'angry')
                                  Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Color(0xFFBBF7D0),
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 16.0, 24.0, 16.0),
                                          child: Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'd0ti13o2' /* 😭 */,
                                                  ),
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            fontSize: 32.0,
                                                            letterSpacing: 0.0,
                                                            lineHeight: 1.47,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'hlemvqsc' /* Their world needs your love. */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeFamily,
                                                                color: Color(
                                                                    0xFF166534),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                lineHeight: 1.5,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLargeIsCustom,
                                                              ),
                                                        ),
                                                      ),
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'f7vtv19m' /* Your relationship has been qui... */,
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodySmall
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallFamily,
                                                              color: Color(
                                                                  0xCC166534),
                                                              letterSpacing:
                                                                  0.0,
                                                              lineHeight: 1.38,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallIsCustom,
                                                            ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 2.0)),
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 16.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                      child: Container(
                        child: Container(),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            var confirmDialogResponse = await showDialog<bool>(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text(FFLocalizations.of(context)
                                          .getVariableText(
                                        enText: 'Swap Companions?',
                                        deText: 'Begleiter tauschen?',
                                        esText: '¿Intercambiar compañeros?',
                                      )),
                                      content: Text(FFLocalizations.of(context)
                                          .getVariableText(
                                        enText:
                                            'This will switch which Companion represents you and your partner in Togly, Travel Mode, and the widget.',
                                        deText:
                                            'Dadurch wird entschieden, welcher Begleiter dich und deinen Partner in Togly, im Reisemodus und im Widget repräsentiert.',
                                        esText:
                                            'Esto cambiará qué compañero los representa a ti y a tu pareja en Togly, en el modo viaje y en el widget',
                                      )),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, false),
                                          child: Text(
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                            enText: 'Cancel',
                                            deText: 'Abbrechen',
                                            esText: 'Cancelar',
                                          )),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, true),
                                          child: Text(
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                            enText: 'Swap Companions!',
                                            deText: 'Begleiter tauschen!',
                                            esText: '¡Intercambiar compañeros!',
                                          )),
                                        ),
                                      ],
                                    );
                                  },
                                ) ??
                                false;
                            try {
                              final result =
                                  await FirebaseFunctions.instanceFor(
                                          region: 'europe-west3')
                                      .httpsCallable('swapLoveBuddyPets')
                                      .call({
                                "relationshipId": valueOrDefault(
                                    currentUserDocument?.relationshipId, ''),
                              });
                              _model.swap =
                                  SwapLoveBuddyPetsCloudFunctionCallResponse(
                                data: result.data,
                                succeeded: true,
                                resultAsString: result.data.toString(),
                                jsonBody: result.data,
                              );
                            } on FirebaseFunctionsException catch (error) {
                              _model.swap =
                                  SwapLoveBuddyPetsCloudFunctionCallResponse(
                                errorCode: error.code,
                                succeeded: false,
                              );
                            }

                            try {
                              final result =
                                  await FirebaseFunctions.instanceFor(
                                          region: 'europe-west3')
                                      .httpsCallable('syncLoveBuddyWidgetState')
                                      .call({
                                "relationshipId": valueOrDefault(
                                    currentUserDocument?.relationshipId, ''),
                              });
                              _model.func =
                                  SyncLoveBuddyWidgetStateCloudFunctionCallResponse(
                                succeeded: true,
                              );
                            } on FirebaseFunctionsException catch (error) {
                              _model.func =
                                  SyncLoveBuddyWidgetStateCloudFunctionCallResponse(
                                errorCode: error.code,
                                succeeded: false,
                              );
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  FFLocalizations.of(context).getVariableText(
                                    enText: 'Companions swapped successfully',
                                    deText: 'Begleiter erfolgreich getauscht',
                                    esText:
                                        'Compañeros intercambiados correctamente',
                                  ),
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

                            safeSetState(() {});
                          },
                          child: wrapWithModel(
                            model: _model.actionBtnModel1,
                            updateCallback: () => safeSetState(() {}),
                            child: ActionBtnWidget(
                              color: Color(0xFF06B6D4),
                              icon: Icon(
                                Icons.swap_horiz_rounded,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              label:
                                  FFLocalizations.of(context).getVariableText(
                                enText: 'Swap Pets',
                                deText: 'Haustiere tauschen',
                                esText: 'Intercambiar mascotas',
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
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              enableDrag: false,
                              context: context,
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  child: Padding(
                                    padding: MediaQuery.viewInsetsOf(context),
                                    child: PetNameSheetWidget(),
                                  ),
                                );
                              },
                            ).then((value) => safeSetState(() {}));
                          },
                          child: wrapWithModel(
                            model: _model.actionBtnModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: ActionBtnWidget(
                              color: Color(0xFFF59E0B),
                              icon: Icon(
                                Icons.edit_rounded,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              label:
                                  FFLocalizations.of(context).getVariableText(
                                enText: 'Edit Name',
                                deText: 'Namen ändern',
                                esText: 'Cambiar nombre',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: AuthUserStreamWidget(
                        builder: (context) =>
                            StreamBuilder<List<RelationshipsRecord>>(
                          stream: queryRelationshipsRecord(
                            queryBuilder: (relationshipsRecord) =>
                                relationshipsRecord.where(
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
                            List<RelationshipsRecord>
                                containerRelationshipsRecordList =
                                snapshot.data!;
                            // Return an empty Container when the item does not exist.
                            if (snapshot.data!.isEmpty) {
                              return Container();
                            }
                            final containerRelationshipsRecord =
                                containerRelationshipsRecordList.isNotEmpty
                                    ? containerRelationshipsRecordList.first
                                    : null;

                            return Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(24.0),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(24.0),
                                child: StreamBuilder<
                                    List<RelationshipViewsRecord>>(
                                  stream: queryRelationshipViewsRecord(
                                    queryBuilder: (relationshipViewsRecord) =>
                                        relationshipViewsRecord.where(
                                      'relationship_id',
                                      isEqualTo: valueOrDefault(
                                          currentUserDocument?.relationshipId,
                                          ''),
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
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<RelationshipViewsRecord>
                                        containerPaddingRelationshipViewsRecordList =
                                        snapshot.data!;
                                    // Return an empty Container when the item does not exist.
                                    if (snapshot.data!.isEmpty) {
                                      return Container();
                                    }
                                    final containerPaddingRelationshipViewsRecord =
                                        containerPaddingRelationshipViewsRecordList
                                                .isNotEmpty
                                            ? containerPaddingRelationshipViewsRecordList
                                                .first
                                            : null;

                                    return Container(
                                      decoration: BoxDecoration(),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Stack(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                children: [
                                                  Container(
                                                    width: 84.0,
                                                    height: 84.0,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9999.0),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            if (containerPaddingRelationshipViewsRecord
                                                                    ?.myLoveBuddyPet ==
                                                                'dog')
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              9999.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/dog_selfie.webp',
                                                                    width: 76.0,
                                                                    height:
                                                                        76.0,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    alignment:
                                                                        Alignment(
                                                                            -1.0,
                                                                            0.0),
                                                                  ),
                                                                ),
                                                              ),
                                                            if (containerPaddingRelationshipViewsRecord
                                                                    ?.myLoveBuddyPet ==
                                                                'cat')
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        1.0,
                                                                        0.0),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              9999.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/cat_selfie.webp',
                                                                    width: 76.0,
                                                                    height:
                                                                        76.0,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    alignment:
                                                                        Alignment(
                                                                            1.0,
                                                                            0.0),
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    valueOrDefault<String>(
                                                      containerPaddingRelationshipViewsRecord
                                                          ?.myLoveBuddyName,
                                                      'name',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0.0,
                                                          lineHeight: 1.35,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleMediumIsCustom,
                                                        ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .accent2,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9999.0),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  4.0,
                                                                  8.0,
                                                                  4.0,
                                                                  8.0),
                                                      child: Container(
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            containerPaddingRelationshipViewsRecord
                                                                ?.myName,
                                                            'myname',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelSmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmallFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                lineHeight:
                                                                    1.27,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmallIsCustom,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 4.0)),
                                              ),
                                            ].divide(SizedBox(height: 8.0)),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.sync_alt_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                size: 20.0,
                                              ),
                                              Container(
                                                width: 2.0,
                                                height: 40.0,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .lightVibrantColor
                                                    ],
                                                    stops: [0.0, 1.0],
                                                    begin: AlignmentDirectional(
                                                        0.0, -1.0),
                                                    end: AlignmentDirectional(
                                                        0, 1.0),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          9999.0),
                                                  shape: BoxShape.rectangle,
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 4.0)),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Stack(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                children: [
                                                  Container(
                                                    width: 84.0,
                                                    height: 84.0,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9999.0),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: Container(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            if (containerPaddingRelationshipViewsRecord
                                                                    ?.partnerLoveBuddyPet ==
                                                                'cat')
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            9999.0),
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/cat_selfie.webp',
                                                                  width: 76.0,
                                                                  height: 76.0,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  alignment:
                                                                      Alignment(
                                                                          1.0,
                                                                          0.0),
                                                                ),
                                                              ),
                                                            if (containerPaddingRelationshipViewsRecord
                                                                    ?.partnerLoveBuddyPet ==
                                                                'dog')
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            9999.0),
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/dog_selfie.webp',
                                                                  width: 76.0,
                                                                  height: 76.0,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  alignment:
                                                                      Alignment(
                                                                          -1.0,
                                                                          0.0),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    valueOrDefault<String>(
                                                      containerPaddingRelationshipViewsRecord
                                                          ?.partnerLoveBuddyName,
                                                      'name',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0.0,
                                                          lineHeight: 1.35,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleMediumIsCustom,
                                                        ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .lightMutedColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9999.0),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  4.0,
                                                                  8.0,
                                                                  4.0,
                                                                  8.0),
                                                      child: Container(
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            containerPaddingRelationshipViewsRecord
                                                                ?.partnerName,
                                                            'partnername',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelSmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmallFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                lineHeight:
                                                                    1.27,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmallIsCustom,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 4.0)),
                                              ),
                                            ].divide(SizedBox(height: 8.0)),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'qb77r4ao' /* Choose which Companion
represe... */
                          ,
                        ),
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 10.0,
                              letterSpacing: 0.0,
                              fontStyle: FontStyle.italic,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                      child: Container(),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                      child: Container(),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 32.0),
                      child: Container(
                        decoration: BoxDecoration(),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Container(
                  child: Container(
                    width: 0.0,
                    height: 0.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
