import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_state_photos/empty_state_photos_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:firebase_storagelibrary_2sa6k9/flutter_flow/custom_functions.dart'
    as firebase_storagelibrary_2sa6k9_functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'photo_result_model.dart';
export 'photo_result_model.dart';

/// Create a romantic mobile page design for a couples app called Togly.
///
/// The page is called Treasure Archive and should feel like a soft, emotional
/// collection of past memories.
///
/// The design must be clean, simple, and premium. Use a dreamy background
/// with soft pink, purple, or sunset tones. Add subtle glow and smooth
/// gradients, but avoid heavy or crowded design. The page should feel calm,
/// elegant, and easy to understand.
///
/// Top section:
/// - Back button on the left
/// - Centered title: “Treasure Archive”
/// - Small decorative icon (heart or sparkle) on the right
/// - Below the title, add a short subtitle like “Revisit your shared
/// memories”
///
/// Main content:
/// - A vertically scrollable list of treasure cards
/// - Keep spacing generous and layout minimal
/// - The focus should be on the cards, not too many extra elements
///
/// Treasure card design (very important):
/// Each treasure card should feel like a saved memory, not like a dashboard
/// item.
///
/// Each card should include:
/// - A soft rounded container with subtle gradient or glass effect
/// - A small treasure chest or simple icon on the left (not too big)
/// - Title of the treasure (for example: “Valentine’s Surprise ❤️”)
/// - A small date text (for example: “Opened on Feb 14”)
/// - A short secondary line that shows content summary in a simple way:
///   for example: “3 photos • 1 voice note • 2 notes”
///
/// Design style for cards:
/// - Rounded corners
/// - Soft shadow or glow
/// - Clean spacing inside the card
/// - No large colored blocks or heavy gradients inside the card
/// - Keep it minimal and elegant
///
/// Interaction:
/// - Cards should clearly feel tappable
/// - Add a small arrow or subtle indicator on the right side
///
/// Optional:
/// - You can include a very light divider or spacing between cards instead of
/// strong borders
///
/// Empty state:
/// - If no treasures exist, show a simple, soft empty state with text:
///   “No memories yet”
///   “Your treasures will appear here”
///
/// Style rules:
/// - Keep everything simple and balanced
/// - Avoid clutter, avoid too many UI elements
/// - Focus on readability and emotional tone
/// - Use soft typography and gentle contrast
/// - Make it feel like a memory list, not a control panel
///
/// Important:
/// Focus only on design and layout.
/// Do not include backend logic or complex interactions.
/// The page should feel clean, emotional, and premium, matching the Togly
/// experience.
class PhotoResultWidget extends StatefulWidget {
  const PhotoResultWidget({
    super.key,
    required this.treasureRef,
  });

  final DocumentReference? treasureRef;

  static String routeName = 'photo_result';
  static String routePath = '/photoResult';

  @override
  State<PhotoResultWidget> createState() => _PhotoResultWidgetState();
}

class _PhotoResultWidgetState extends State<PhotoResultWidget> {
  late PhotoResultModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PhotoResultModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'photo_result'});
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
        backgroundColor: Color(0xFFF9F5F7),
        appBar: AppBar(
          backgroundColor: Color(0xFFF9F5F7),
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 22.0,
              borderWidth: 0.0,
              buttonSize: 44.0,
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Color(0xFFB07090),
                size: 22.0,
              ),
              onPressed: () async {
                context.safePop();
              },
            ),
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                FFLocalizations.of(context).getText(
                  'hvmxnvc8' /* Photos */,
                ),
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).titleMediumFamily,
                      color: Color(0xFF8B4F6E),
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).titleMediumIsCustom,
                    ),
              ),
              Text(
                FFLocalizations.of(context).getText(
                  'iedhu318' /* Love Treasure */,
                ),
                style: FlutterFlowTheme.of(context).labelSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).labelSmallFamily,
                      color: Color(0xFFCB8FAD),
                      fontSize: 11.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.normal,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).labelSmallIsCustom,
                    ),
              ),
            ],
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFCE8F0), Color(0xFFFFF0F5)],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(1.0, 0.0),
                        end: AlignmentDirectional(-1.0, 0),
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Container(
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: AuthUserStreamWidget(
                    builder: (context) =>
                        StreamBuilder<List<TreasureSurprisesRecord>>(
                      stream: queryTreasureSurprisesRecord(
                        queryBuilder: (treasureSurprisesRecord) =>
                            treasureSurprisesRecord
                                .where(
                                  'treasureRef',
                                  isEqualTo: widget.treasureRef,
                                )
                                .where(
                                  'type',
                                  isEqualTo: 'photo',
                                )
                                .where(
                                  'createdByUid',
                                  isEqualTo: valueOrDefault(
                                      currentUserDocument?.partnerUID, ''),
                                )
                                .orderBy('createdAt', descending: true),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: EmptyStatePhotosWidget(),
                          );
                        }
                        List<TreasureSurprisesRecord>
                            gridViewTreasureSurprisesRecordList =
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
                          itemCount: gridViewTreasureSurprisesRecordList.length,
                          itemBuilder: (context, gridViewIndex) {
                            final gridViewTreasureSurprisesRecord =
                                gridViewTreasureSurprisesRecordList[
                                    gridViewIndex];
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
                                    borderRadius: BorderRadius.circular(16.0),
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
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          await Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.fade,
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  firebase_storagelibrary_2sa6k9_functions
                                                      .convertStringToImagePath(
                                                          gridViewTreasureSurprisesRecord
                                                              .image)!,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: true,
                                                tag: firebase_storagelibrary_2sa6k9_functions
                                                    .convertStringToImagePath(
                                                        gridViewTreasureSurprisesRecord
                                                            .image)!,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: firebase_storagelibrary_2sa6k9_functions
                                              .convertStringToImagePath(
                                                  gridViewTreasureSurprisesRecord
                                                      .image)!,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            child: Image.network(
                                              firebase_storagelibrary_2sa6k9_functions
                                                  .convertStringToImagePath(
                                                      gridViewTreasureSurprisesRecord
                                                          .image)!,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
