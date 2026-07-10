import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/add_wish_sheet/add_wish_sheet_widget.dart';
import '/components/pair_required_sheet/pair_required_sheet_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'wishes_page_copy_model.dart';
export 'wishes_page_copy_model.dart';

/// Design a beautiful and emotional "Shared Wishes" screen for the mobile app
/// Togetherly.
///
/// Use the same soft, pastel gradient color palette as the main app
/// (lavender, light beige, soft purple). The layout should feel warm,
/// romantic, and organized — perfect for long-distance couples to share both
/// emotional and material desires.
///
/// Top Section:
/// Title at the top: “Shared Wishes” in an elegant font (e.g., Poppins,
/// Inter, Nunito).
///
/// Subtitle:
/// “Things we dream of – together.”
/// (Small, centered, italic text for a romantic touch)
///
/// Main Wish List Area:
/// Display a scrollable vertical list of wish cards.
///
/// Each wish card should contain:
///
/// Title (e.g., "Hug in real life" or "Dinner at our favorite place" or "New
/// phone case")
///
/// Category tag (either: 💖 Emotional or 🎁 Gift)
///
/// Optional short description (e.g., “I saw this and thought of you…” or
/// product link placeholder)
///
/// Optional image placeholder (small rounded thumbnail, can be symbolic or a
/// product image)
///
/// A small heart icon or subtle decorative element
///
/// Add Wish Section (at the bottom or as floating button):
/// A rounded ‘Add Wish’ button (soft pink/lavender tone) with a plus icon
///
/// Optional tagline: “Add a new dream…”
///
/// Design Guidelines:
/// Pastel gradient or soft background color (light beige or off-white)
///
/// Rounded cards with soft shadows
///
/// Soft, elegant fonts (Inter, Poppins, Nunito)
///
/// Spacing between elements should feel airy and light
///
/// Clean and intuitive design, optimized for mobile screens
///
/// This screen should visually match the main Togetherly dashboard style,
/// creating a consistent experience across the app. Focus on emotional
/// warmth, gentle colors, and a loving atmosphere — while keeping the layout
/// structured and elegant.
class WishesPageCopyWidget extends StatefulWidget {
  const WishesPageCopyWidget({super.key});

  static String routeName = 'WishesPageCopy';
  static String routePath = '/wishesPageCopy';

  @override
  State<WishesPageCopyWidget> createState() => _WishesPageCopyWidgetState();
}

class _WishesPageCopyWidgetState extends State<WishesPageCopyWidget> {
  late WishesPageCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WishesPageCopyModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'WishesPageCopy'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if ((valueOrDefault(currentUserDocument?.relationshipId, '') == '') ||
          (valueOrDefault(currentUserDocument?.relationshipId, '') == '')) {
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          isDismissible: false,
          enableDrag: false,
          useSafeArea: true,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: PairRequiredSheetWidget(),
              ),
            );
          },
        ).then((value) => safeSetState(() {}));

        context.goNamed(ConnectWidget.routeName);
      }
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
    return AuthUserStreamWidget(
      builder: (context) => StreamBuilder<List<WishesRecord>>(
        stream: queryWishesRecord(
          queryBuilder: (wishesRecord) => wishesRecord
              .where(
                'relationship_id',
                isEqualTo:
                    valueOrDefault(currentUserDocument?.relationshipId, ''),
              )
              .where(
                'is_completed',
                isEqualTo: false,
              ),
        ),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: Color(0xFFF8F6F9),
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
          List<WishesRecord> wishesPageCopyWishesRecordList = snapshot.data!;

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: Color(0xFFF8F6F9),
              appBar: AppBar(
                backgroundColor: Color(0xFFF8F6F9),
                automaticallyImplyLeading: false,
                actions: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    child: Container(
                      width: 56.0,
                      height: 56.0,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6.0,
                            color: Color(0x1ADE8BA6),
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                          )
                        ],
                        gradient: LinearGradient(
                          colors: [Color(0xFFB8A9DA), Color(0xFFDE8BA6)],
                          stops: [0.8, 1.0],
                          begin: AlignmentDirectional(1.0, -1.0),
                          end: AlignmentDirectional(-1.0, 1.0),
                        ),
                        borderRadius: BorderRadius.circular(28.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                                useSafeArea: true,
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
                                      child: AddWishSheetWidget(),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            },
                            child: Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                              size: 24.0,
                            ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              '5b9v58nm' /* Add */,
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodySmall.override(
                                      fontFamily: 'Nunito',
                                      color: Colors.white,
                                      fontSize: 10.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                centerTitle: false,
                elevation: 0.0,
              ),
              body: SafeArea(
                top: true,
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'yg55w1ac' /* Shared Wishes */,
                                    ),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          font: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineMedium
                                                    .fontStyle,
                                          ),
                                          color: Color(0xFF6B5B95),
                                          fontSize: 28.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .headlineMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'ks6w3c4s' /* Lets share 2getherly! */,
                                    ),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle: FontStyle.italic,
                                          ),
                                          color: Color(0xFF9B8DB5),
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle: FontStyle.italic,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 8.0)),
                              ),
                            ),
                            SafeArea(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          final wish =
                                              wishesPageCopyWishesRecordList
                                                  .toList();

                                          return ListView.builder(
                                            padding: EdgeInsets.zero,
                                            reverse: true,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: wish.length,
                                            itemBuilder: (context, wishIndex) {
                                              final wishItem = wish[wishIndex];
                                              return Container(
                                                width: 144.4,
                                                height: 212.0,
                                                decoration: BoxDecoration(),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            16.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius: 8.0,
                                                                color: Color(
                                                                    0x1A6B5B95),
                                                                offset: Offset(
                                                                  0.0,
                                                                  2.0,
                                                                ),
                                                              )
                                                            ],
                                                            gradient:
                                                                LinearGradient(
                                                              colors: [
                                                                Color(
                                                                    0xFFF0F5F0),
                                                                Colors.white
                                                              ],
                                                              stops: [0.8, 1.0],
                                                              begin:
                                                                  AlignmentDirectional(
                                                                      1.0, 1.0),
                                                              end:
                                                                  AlignmentDirectional(
                                                                      -1.0,
                                                                      -1.0),
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          20.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      await Navigator
                                                                          .push(
                                                                        context,
                                                                        PageTransition(
                                                                          type:
                                                                              PageTransitionType.fade,
                                                                          child:
                                                                              FlutterFlowExpandedImageView(
                                                                            image:
                                                                                Image.network(
                                                                              wishItem.wishimage,
                                                                              fit: BoxFit.contain,
                                                                              alignment: Alignment(0.0, 0.0),
                                                                              errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                'assets/images/error_image.png',
                                                                                fit: BoxFit.contain,
                                                                                alignment: Alignment(0.0, 0.0),
                                                                              ),
                                                                            ),
                                                                            allowRotation:
                                                                                false,
                                                                            tag:
                                                                                wishItem.wishimage,
                                                                            useHeroAnimation:
                                                                                true,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: Hero(
                                                                      tag: wishItem
                                                                          .wishimage,
                                                                      transitionOnUserGestures:
                                                                          true,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                        child: Image
                                                                            .network(
                                                                          wishItem
                                                                              .wishimage,
                                                                          width:
                                                                              59.9,
                                                                          height:
                                                                              58.8,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          alignment: Alignment(
                                                                              0.0,
                                                                              0.0),
                                                                          errorBuilder: (context, error, stackTrace) =>
                                                                              Image.asset(
                                                                            'assets/images/error_image.png',
                                                                            width:
                                                                                59.9,
                                                                            height:
                                                                                58.8,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            alignment:
                                                                                Alignment(0.0, 0.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
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
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              wishItem.title,
                                                                              'Title',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                  ),
                                                                                  color: Color(0xFF4A4A6A),
                                                                                  fontSize: 14.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            if (wishItem.createdBy !=
                                                                                currentUserUid) {
                                                                              await wishesPageCopyWishesRecordList.firstOrNull!.reference.update(createWishesRecordData(
                                                                                reactionEmoji: '❤️',
                                                                                reactionBy: currentUserUid,
                                                                                reactionAt: getCurrentTimestamp,
                                                                              ));
                                                                            }
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              wishItem.reactionEmoji != '' ? wishItem.reactionEmoji : '🙂',
                                                                              'Emoji',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  fontSize: 20.0,
                                                                                  letterSpacing: 0.0,
                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        wishItem
                                                                            .note,
                                                                        'Note',
                                                                      ),
                                                                      maxLines:
                                                                          6,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                Color(0xFF7A7A9A),
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            lineHeight:
                                                                                1.4,
                                                                          ),
                                                                    ),
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        if (wishItem.linkUrl !=
                                                                                '')
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                                                              child: FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  await launchURL(wishItem.linkUrl != ''
                                                                                      ? ((String url) {
                                                                                          return ((url ?? '').trim().isEmpty) ? '' : (((url ?? '').trim().toLowerCase().startsWith('http')) ? (url ?? '').trim() : 'https://' + (url ?? '').trim());
                                                                                        }(wishItem.linkUrl))
                                                                                      : '');
                                                                                },
                                                                                text: FFLocalizations.of(context).getText(
                                                                                  '5itmi1lv' /* Link to the wish */,
                                                                                ),
                                                                                options: FFButtonOptions(
                                                                                  width: 150.0,
                                                                                  height: 30.0,
                                                                                  padding: EdgeInsets.all(8.0),
                                                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                  color: FlutterFlowTheme.of(context).secondary,
                                                                                  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                        color: Colors.white,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FontStyle.italic,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
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
                                                                          ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              if (wishItem.createdBy == currentUserUid)
                                                                                Align(
                                                                                  alignment: AlignmentDirectional(1.0, 1.0),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 0.0),
                                                                                    child: InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        var confirmDialogResponse = await showDialog<bool>(
                                                                                              context: context,
                                                                                              builder: (alertDialogContext) {
                                                                                                return AlertDialog(
                                                                                                  title: Text('Wish completed'),
                                                                                                  content: Text('Do you want to mark the wish as completed?'),
                                                                                                  actions: [
                                                                                                    TextButton(
                                                                                                      onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                                      child: Text('No'),
                                                                                                    ),
                                                                                                    TextButton(
                                                                                                      onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                                      child: Text('Yes'),
                                                                                                    ),
                                                                                                  ],
                                                                                                );
                                                                                              },
                                                                                            ) ??
                                                                                            false;
                                                                                        if (confirmDialogResponse) {
                                                                                          await wishItem.reference.update(createWishesRecordData(
                                                                                            isCompleted: true,
                                                                                            createdAt: getCurrentTimestamp,
                                                                                            completedAt: getCurrentTimestamp,
                                                                                          ));
                                                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                                                            SnackBar(
                                                                                              content: Text(
                                                                                                'Marked as done ✅',
                                                                                                style: TextStyle(
                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                ),
                                                                                              ),
                                                                                              duration: Duration(milliseconds: 4000),
                                                                                              backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                            ),
                                                                                          );
                                                                                        }
                                                                                      },
                                                                                      child: Icon(
                                                                                        Icons.check_circle,
                                                                                        color: FlutterFlowTheme.of(context).success,
                                                                                        size: 18.0,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              if (wishItem.category != '')
                                                                                Align(
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(0xFFE6F7FF),
                                                                                        borderRadius: BorderRadius.circular(12.0),
                                                                                      ),
                                                                                      alignment: AlignmentDirectional(1.0, 0.0),
                                                                                      child: Align(
                                                                                        alignment: AlignmentDirectional(1.0, 0.0),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsets.all(8.0),
                                                                                          child: Text(
                                                                                            wishItem.category,
                                                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                  fontFamily: 'Nunito',
                                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                  fontSize: 12.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              if (wishItem.createdBy == currentUserUid)
                                                                                Align(
                                                                                  alignment: AlignmentDirectional(1.0, 1.0),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 5.0, 5.0),
                                                                                    child: InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        var confirmDialogResponse = await showDialog<bool>(
                                                                                              context: context,
                                                                                              builder: (alertDialogContext) {
                                                                                                return AlertDialog(
                                                                                                  title: Text('Delete wish?'),
                                                                                                  content: Text('Do you want to delete your wish?'),
                                                                                                  actions: [
                                                                                                    TextButton(
                                                                                                      onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                                      child: Text('No'),
                                                                                                    ),
                                                                                                    TextButton(
                                                                                                      onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                                      child: Text('Yes'),
                                                                                                    ),
                                                                                                  ],
                                                                                                );
                                                                                              },
                                                                                            ) ??
                                                                                            false;
                                                                                        if (confirmDialogResponse) {
                                                                                          await wishesPageCopyWishesRecordList.firstOrNull!.reference.delete();
                                                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                                                            SnackBar(
                                                                                              content: Text(
                                                                                                'Deleted ✅',
                                                                                                style: TextStyle(
                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                ),
                                                                                              ),
                                                                                              duration: Duration(milliseconds: 4000),
                                                                                              backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                            ),
                                                                                          );
                                                                                        }
                                                                                      },
                                                                                      child: FaIcon(
                                                                                        FontAwesomeIcons.solidTrashAlt,
                                                                                        color: FlutterFlowTheme.of(context).tertiary,
                                                                                        size: 15.0,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          8.0)),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 12.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]
                              .divide(SizedBox(height: 24.0))
                              .addToStart(SizedBox(height: 16.0))
                              .addToEnd(SizedBox(height: 100.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
