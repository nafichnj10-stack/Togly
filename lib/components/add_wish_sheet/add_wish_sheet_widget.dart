import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:firebase_storagelibrary_2sa6k9/custom_code/actions/index.dart'
    as firebase_storagelibrary_2sa6k9_actions;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'add_wish_sheet_model.dart';
export 'add_wish_sheet_model.dart';

/// Update the existing reusable Bottom Sheet component "AddWishSheet".
///
/// This is a DESIGN-ONLY update. Do NOT add any actions, controllers, state,
/// or backend bindings.
///
/// Overall
/// - Height wraps content, Safe Area bottom ON.
/// - Barrier color: #000000 @ 40% opacity.
/// - Background: vertical gradient from #FFFFFF (top) to #F7F4FF (bottom).
/// - Top corners radius: 24. Outer padding: 20. Vertical spacing: 16.
/// - Very soft shadow: #000000 @ 6% opacity, blur 16, y-offset 4.
///
/// Header
/// - Keep the rounded header card, but tighten it:
///   - Card background: #FFFFFF, radius 20, internal padding 14.
///   - Icon circle: 56x56, bg #D7CBFB, heart icon #FFFFFF at 28px.
///   - Title: “Add a wish” — size 22, weight 700, color #1A1A1A, line-height
/// 1.2.
///   - Subtitle: “Share something meaningful with your partner.” — size 15,
/// color #6B7280.
///   - Center all header content with 8px spacing between elements.
///
/// Form card
/// - Card background #FFFFFF, radius 20, internal padding 16, section spacing
/// 16.
/// - Labels color: #6B7280, size 13, weight 600, letter-spacing +0.2px.
///
/// Title field (name: tfTitle)
/// - Filled style, bg #FFFFFF, border 1px #E9E4F8, radius 14.
/// - Text color #111827, hint color #9CA3AF.
///
/// Category chips (name: chipCategory)
/// - Use these options exactly: Emotional, Gift, Experience, Travel,
/// Adventure, Food.
/// - Selected chip: background #A88BEB, text #FFFFFF.
/// - Unselected chip: background #F1ECFF, text #4B5563, no border.
/// - Chip radius 16, padding 10 vertical / 14 horizontal. Wrap layout with
/// 8px gap.
///
/// Note field (name: tfNote)
/// - Multiline 3–5 rows, same style as title field (border 1px #E9E4F8,
/// radius 14).
///
/// Image block
/// - Rounded card: bg #FFFFFF, radius 20, padding 16.
/// - Left: preview box 92x92, radius 12, placeholder bg #F3F4F6 with 1px
/// dashed border #D6CCFF and a small image icon in #A88BEB.
/// - Right: vertical buttons (NO actions):
///   1) “Pick image” — filled button, height 40, radius 14, background
/// #A88BEB, text #FFFFFF 600.
///   2) “Remove” — text button, color #A88BEB, size 14.
///
/// Footer buttons (NO logic)
/// - Primary (name: btnSave): full width, height 52, radius 16, background
/// #A88BEB, text #FFFFFF 600.
/// - Secondary (name: btnCancel): text-only, centered, color #A88BEB, top
/// margin 8.
///
/// Typography & dividers
/// - Title/body #1A1A1A / #475467, placeholders #98A2B3.
/// - Optional dividers: 1px #E9E4F8 with 12px top/bottom padding.
///
/// Create a reusable component "WishCard" for displaying a single wish item
/// in a list.
/// Design ONLY — no actions or data bindings.
///
/// Container
/// - Background #FFFFFF, radius 18, internal padding 14, external margin 10
/// vertical.
/// - Subtle gradient overlay from #FFFFFF to #F9F7FF at 12% opacity.
/// - Soft shadow: #000000 @ 5% opacity, blur 14, y-offset 4.
///
/// Layout (left-to-right)
/// - Left image preview: 56x56, radius 12. If empty, show placeholder #F3F4F6
/// with 1px dashed #D6CCFF and a small image icon #A88BEB.
/// - Right flexible column (spacing 6):
///   - Top row:
///     - Title (max 1 line, ellipsis) — size 16, weight 700, color #1A1A1A.
///     - Category pill on the far right:
///       - Background #F1ECFF, text color #53389E, radius 12, padding 6/10.
///   - Note/description (max 2 lines) — size 14, color #6B7280, line-height
/// 1.35.
///   - Bottom row aligned right:
///     - Heart icon button group (no logic):
///       - Outline heart (default) and filled heart (active) visuals
/// prepared.
///       - Active/filled color: #A88BEB; inactive outline: #D0D5DD.
///     - Optional like count text in #6B7280, size 13.
///
/// Spacing
/// - 12px gap between left image and right column, 10px vertical spacing
/// between rows.
class AddWishSheetWidget extends StatefulWidget {
  const AddWishSheetWidget({super.key});

  @override
  State<AddWishSheetWidget> createState() => _AddWishSheetWidgetState();
}

class _AddWishSheetWidgetState extends State<AddWishSheetWidget> {
  late AddWishSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddWishSheetModel());

    _model.tfTitletextTextController ??= TextEditingController();
    _model.tfTitletextFocusNode ??= FocusNode();

    _model.tfNoteTextController ??= TextEditingController();
    _model.tfNoteFocusNode ??= FocusNode();

    _model.tfLinkTextController ??= TextEditingController();
    _model.tfLinkFocusNode ??= FocusNode();

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
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 16.0,
                color: Color(0x0F000000),
                offset: Offset(
                  0.0,
                  4.0,
                ),
                spreadRadius: 0.0,
              )
            ],
            gradient: LinearGradient(
              colors: [Colors.white, Color(0xFFF7F4FF)],
              stops: [0.0, 1.0],
              begin: AlignmentDirectional(0.0, -1.0),
              end: AlignmentDirectional(0, 1.0),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 56.0,
                            height: 56.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFD7CBFB),
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                            child: Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 28.0,
                            ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'xxv7098i' /* Add a wish */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleMediumFamily,
                                  color: Color(0xFF1A1A1A),
                                  fontSize: 22.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleMediumIsCustom,
                                ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'yjnh6spa' /* Share your wishes 
with your p... */
                              ,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: Color(0xFF6B7280),
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                          ),
                        ].divide(SizedBox(height: 8.0)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 4.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'ilgigjx2' /* Title */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelSmallFamily,
                                        color: Color(0xFF6B7280),
                                        fontSize: 13.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelSmallIsCustom,
                                      ),
                                ),
                              ),
                              TextFormField(
                                controller: _model.tfTitletextTextController,
                                focusNode: _model.tfTitletextFocusNode,
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: FFLocalizations.of(context).getText(
                                    'grl8vaax' /* Enter your wish title... */,
                                  ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: Color(0xFF6B7280),
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFE9E4F8),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          12.0, 16.0, 12.0, 16.0),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                                maxLines: null,
                                maxLength: 60,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                validator: _model
                                    .tfTitletextTextControllerValidator
                                    .asValidator(context),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 4.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'fwozmae4' /* Category */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelSmallFamily,
                                        color: Color(0xFF6B7280),
                                        fontSize: 13.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelSmallIsCustom,
                                      ),
                                ),
                              ),
                              FlutterFlowChoiceChips(
                                options: [
                                  ChipData(FFLocalizations.of(context).getText(
                                    '43bxpzmn' /* 💞 Relationship */,
                                  )),
                                  ChipData(FFLocalizations.of(context).getText(
                                    'r6wh2thy' /* 🎁 Gift */,
                                  )),
                                  ChipData(FFLocalizations.of(context).getText(
                                    'lkig1m22' /* ✨ Experience */,
                                  )),
                                  ChipData(FFLocalizations.of(context).getText(
                                    '1yl4raub' /* 🌍 Travel */,
                                  )),
                                  ChipData(FFLocalizations.of(context).getText(
                                    'tby65khm' /* 🧭 Adventure */,
                                  )),
                                  ChipData(FFLocalizations.of(context).getText(
                                    'fd7opl9a' /* 🍽️ Food */,
                                  )),
                                  ChipData(FFLocalizations.of(context).getText(
                                    'bys1ema8' /* 🐾 Pet */,
                                  )),
                                  ChipData(FFLocalizations.of(context).getText(
                                    '97ts9e1y' /* 🏷️ Clothing */,
                                  )),
                                  ChipData(FFLocalizations.of(context).getText(
                                    'o7h7zgoz' /* 💍 Jewelry */,
                                  )),
                                  ChipData(FFLocalizations.of(context).getText(
                                    '2siyhtvq' /* 💫 Other */,
                                  ))
                                ],
                                onChanged: (val) async {
                                  safeSetState(() => _model.choiceChipsValue =
                                      val?.firstOrNull);
                                  _model.categoryLabel =
                                      _model.choiceChipsValue;
                                  _model.categoryKey = () {
                                    if ((_model.choiceChipsValue ==
                                            '💞 Relationship') ||
                                        (_model.choiceChipsValue ==
                                            '💞 Beziehung') ||
                                        (_model.choiceChipsValue ==
                                            '💞 Relación')) {
                                      return 'relationship';
                                    } else if ((_model.choiceChipsValue ==
                                            '🎁 Gift') ||
                                        (_model.choiceChipsValue ==
                                            '🎁 Geschenk') ||
                                        (_model.choiceChipsValue ==
                                            '🎁 Regalo')) {
                                      return 'gift';
                                    } else if ((_model.choiceChipsValue ==
                                            '✨ Experience') ||
                                        (_model.choiceChipsValue ==
                                            '✨ Erleben') ||
                                        (_model.choiceChipsValue ==
                                            '✨ Experiencia')) {
                                      return 'experience';
                                    } else if ((_model.choiceChipsValue ==
                                            '🌍 Travel') ||
                                        (_model.choiceChipsValue ==
                                            '🌍 Reisen') ||
                                        (_model.choiceChipsValue ==
                                            '🌍 Viajes')) {
                                      return 'travel';
                                    } else if ((_model.choiceChipsValue ==
                                            '🧭 Adventure') ||
                                        (_model.choiceChipsValue ==
                                            '🧭 Abenteuer') ||
                                        (_model.choiceChipsValue ==
                                            '🧭 Aventura')) {
                                      return 'adventure';
                                    } else if ((_model.choiceChipsValue ==
                                            '🍽️ Food') ||
                                        (_model.choiceChipsValue ==
                                            '🍽️ Essen') ||
                                        (_model.choiceChipsValue ==
                                            '🍽️ Comida')) {
                                      return 'food';
                                    } else if ((_model.choiceChipsValue == '🐾 Pet') ||
                                        (_model.choiceChipsValue ==
                                            '🐾 Haustier') ||
                                        (_model.choiceChipsValue ==
                                            '🐾 Mascota')) {
                                      return 'pet';
                                    } else if ((_model.choiceChipsValue ==
                                            '🏷️ Clothing') ||
                                        (_model.choiceChipsValue ==
                                            '🏷️ Kleidung') ||
                                        (_model.choiceChipsValue ==
                                            '🏷️ Ropa')) {
                                      return 'clothing';
                                    } else if ((_model.choiceChipsValue ==
                                            '💍 Jewelry') ||
                                        (_model.choiceChipsValue ==
                                            '💍 Schmuck') ||
                                        (_model.choiceChipsValue ==
                                            '💍 Joyería')) {
                                      return 'jewelry';
                                    } else if ((_model.choiceChipsValue == '✨ Other') ||
                                        (_model.choiceChipsValue == '✨ Sonstiges') ||
                                        (_model.choiceChipsValue == '✨ Otro')) {
                                      return 'other';
                                    } else {
                                      return 'other';
                                    }
                                  }();
                                  safeSetState(() {});
                                },
                                selectedChipStyle: ChipStyle(
                                  backgroundColor: Color(0xFFA88BEB),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                  iconColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  iconSize: 18.0,
                                  elevation: 4.0,
                                  borderWidth: 0.0,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                unselectedChipStyle: ChipStyle(
                                  backgroundColor: Color(0xFFF1ECFF),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodySmallFamily,
                                        color: Color(0xFF4B5563),
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodySmallIsCustom,
                                      ),
                                  iconColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  iconSize: 18.0,
                                  elevation: 4.0,
                                  borderWidth: 0.0,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                chipSpacing: 8.0,
                                rowSpacing: 8.0,
                                multiselect: false,
                                alignment: WrapAlignment.start,
                                controller:
                                    _model.choiceChipsValueController ??=
                                        FormFieldController<List<String>>(
                                  [],
                                ),
                                wrapped: true,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 4.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'xnkxevgc' /* Note */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelSmallFamily,
                                        color: Color(0xFF6B7280),
                                        fontSize: 13.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelSmallIsCustom,
                                      ),
                                ),
                              ),
                              TextFormField(
                                controller: _model.tfNoteTextController,
                                focusNode: _model.tfNoteFocusNode,
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: FFLocalizations.of(context).getText(
                                    'wn4tl04o' /* Add details about your wish... */,
                                  ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: Color(0xFF6B7280),
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFE9E4F8),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          12.0, 16.0, 12.0, 16.0),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                                maxLines: 6,
                                minLines: 3,
                                maxLength: 400,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                validator: _model.tfNoteTextControllerValidator
                                    .asValidator(context),
                              ),
                            ],
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'xkw73dqo' /* Link */,
                    ),
                    style: FlutterFlowTheme.of(context).labelSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelSmallFamily,
                          color: Color(0xFF6B7280),
                          fontSize: 13.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelSmallIsCustom,
                        ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    child: TextFormField(
                      controller: _model.tfLinkTextController,
                      focusNode: _model.tfLinkFocusNode,
                      autofocus: false,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: FFLocalizations.of(context).getText(
                          'tfawrbur' /* Direct link to your wish (opti... */,
                        ),
                        hintStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              color: Color(0xFF6B7280),
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE9E4F8),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            12.0, 16.0, 12.0, 16.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                      maxLines: null,
                      maxLength: 300,
                      maxLengthEnforcement: MaxLengthEnforcement.none,
                      validator: _model.tfLinkTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 92.0,
                            height: 92.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFF3F4F6),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.memory(
                                  _model.uploadedLocalFile_wishFile.bytes ??
                                      Uint8List.fromList([]),
                                ).image,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: Color(0xFFD6CCFF),
                                width: 1.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    final selectedMedia = await selectMedia(
                                      imageQuality: 75,
                                      mediaSource: MediaSource.photoGallery,
                                      multiImage: false,
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      safeSetState(() => _model
                                          .isDataUploading_wishFile = true);
                                      var selectedUploadedFiles =
                                          <FFUploadedFile>[];

                                      try {
                                        selectedUploadedFiles = selectedMedia
                                            .map((m) => FFUploadedFile(
                                                  name: m.storagePath
                                                      .split('/')
                                                      .last,
                                                  bytes: m.bytes,
                                                  height: m.dimensions?.height,
                                                  width: m.dimensions?.width,
                                                  blurHash: m.blurHash,
                                                  originalFilename:
                                                      m.originalFilename,
                                                ))
                                            .toList();
                                      } finally {
                                        _model.isDataUploading_wishFile = false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                          selectedMedia.length) {
                                        safeSetState(() {
                                          _model.uploadedLocalFile_wishFile =
                                              selectedUploadedFiles.first;
                                        });
                                      } else {
                                        safeSetState(() {});
                                        return;
                                      }
                                    }

                                    _model.pickedImageUrl = _model.wishFile;
                                    safeSetState(() {});
                                  },
                                  text: FFLocalizations.of(context).getText(
                                    'bkyuv04n' /* Pick image */,
                                  ),
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 40.0,
                                    padding: EdgeInsets.all(8.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: Color(0xFFA88BEB),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(14.0),
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
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FFButtonWidget(
                        onPressed: (/* NOT RECOMMENDED */ _model
                                    .tfTitletextTextController.text ==
                                'true')
                            ? null
                            : () async {
                                if (_model.choiceChipsValue != null &&
                                    _model.choiceChipsValue != '') {
                                  var wishesRecordReference =
                                      WishesRecord.collection.doc();
                                  await wishesRecordReference
                                      .set(createWishesRecordData(
                                    relationshipId: valueOrDefault(
                                        currentUserDocument?.relationshipId,
                                        ''),
                                    title:
                                        _model.tfTitletextTextController.text,
                                    emoji: () {
                                      if (_model.choiceChipsValue ==
                                          'Relationship') {
                                        return '💞';
                                      } else if (_model.choiceChipsValue ==
                                          'Gift') {
                                        return '🎁';
                                      } else if (_model.choiceChipsValue ==
                                          'Experience') {
                                        return '✨';
                                      } else if (_model.choiceChipsValue ==
                                          'Travel') {
                                        return '🌍';
                                      } else if (_model.choiceChipsValue ==
                                          'Adventure') {
                                        return '🧭';
                                      } else if (_model.choiceChipsValue ==
                                          'Food') {
                                        return '🍽️';
                                      } else if (_model.choiceChipsValue ==
                                          'Pet') {
                                        return '🐾';
                                      } else if (_model.choiceChipsValue ==
                                          'Clothing') {
                                        return '🏷️';
                                      } else if (_model.choiceChipsValue ==
                                          'Jewelry') {
                                        return '💍';
                                      } else if (_model.choiceChipsValue ==
                                          'Other') {
                                        return '💫';
                                      } else {
                                        return '💫';
                                      }
                                    }(),
                                    createdBy: currentUserUid,
                                    createdAt: getCurrentTimestamp,
                                    updatedAt: getCurrentTimestamp,
                                    note: _model.tfNoteTextController.text,
                                    linkUrl: functions.normalizeUrl(
                                        _model.tfLinkTextController.text),
                                    isCompleted: false,
                                    categoryLabel: _model.categoryLabel,
                                    categoryKey: _model.categoryKey,
                                  ));
                                  _model.newWishRef =
                                      WishesRecord.getDocumentFromData(
                                          createWishesRecordData(
                                            relationshipId: valueOrDefault(
                                                currentUserDocument
                                                    ?.relationshipId,
                                                ''),
                                            title: _model
                                                .tfTitletextTextController.text,
                                            emoji: () {
                                              if (_model.choiceChipsValue ==
                                                  'Relationship') {
                                                return '💞';
                                              } else if (_model
                                                      .choiceChipsValue ==
                                                  'Gift') {
                                                return '🎁';
                                              } else if (_model
                                                      .choiceChipsValue ==
                                                  'Experience') {
                                                return '✨';
                                              } else if (_model
                                                      .choiceChipsValue ==
                                                  'Travel') {
                                                return '🌍';
                                              } else if (_model
                                                      .choiceChipsValue ==
                                                  'Adventure') {
                                                return '🧭';
                                              } else if (_model
                                                      .choiceChipsValue ==
                                                  'Food') {
                                                return '🍽️';
                                              } else if (_model
                                                      .choiceChipsValue ==
                                                  'Pet') {
                                                return '🐾';
                                              } else if (_model
                                                      .choiceChipsValue ==
                                                  'Clothing') {
                                                return '🏷️';
                                              } else if (_model
                                                      .choiceChipsValue ==
                                                  'Jewelry') {
                                                return '💍';
                                              } else if (_model
                                                      .choiceChipsValue ==
                                                  'Other') {
                                                return '💫';
                                              } else {
                                                return '💫';
                                              }
                                            }(),
                                            createdBy: currentUserUid,
                                            createdAt: getCurrentTimestamp,
                                            updatedAt: getCurrentTimestamp,
                                            note: _model
                                                .tfNoteTextController.text,
                                            linkUrl: functions.normalizeUrl(
                                                _model
                                                    .tfLinkTextController.text),
                                            isCompleted: false,
                                            categoryLabel: _model.categoryLabel,
                                            categoryKey: _model.categoryKey,
                                          ),
                                          wishesRecordReference);
                                  logFirebaseEvent(
                                    'wish_event_created',
                                    parameters: {
                                      'category': _model.choiceChipsValue,
                                      'note': _model.tfNoteTextController.text,
                                    },
                                  );
                                  _model.fileName = random_data.randomString(
                                    10,
                                    20,
                                    true,
                                    false,
                                    true,
                                  );
                                  safeSetState(() {});
                                  if ((_model.uploadedLocalFile_wishFile.bytes
                                              ?.isNotEmpty ??
                                          false)) {
                                    _model.uploadedObj =
                                        await firebase_storagelibrary_2sa6k9_actions
                                            .uploadFileToBucket(
                                      '',
                                      'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/wish/${_model.newWishRef?.reference.id}${_model.fileName}.jpg',
                                      _model.uploadedLocalFile_wishFile,
                                      '',
                                    );
                                    _model.coverURL =
                                        await firebase_storagelibrary_2sa6k9_actions
                                            .getDownloadUrl(
                                      '',
                                      'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/wish/${_model.newWishRef?.reference.id}${_model.fileName}.jpg',
                                    );

                                    await _model.newWishRef!.reference
                                        .update(createWishesRecordData(
                                      wishimage: _model.coverURL,
                                      storagePath:
                                          'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/wish/${_model.newWishRef?.reference.id}${_model.fileName}.jpg',
                                    ));
                                    safeSetState(() {
                                      _model.isDataUploading_wishFile = false;
                                      _model.uploadedLocalFile_wishFile =
                                          FFUploadedFile(
                                              bytes: Uint8List.fromList([]),
                                              originalFilename: '');
                                    });

                                    Navigator.pop(context);
                                    if (valueOrDefault(
                                            currentUserDocument?.appLanguage,
                                            '') ==
                                        'en') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Wish saved ✨',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                    } else if (valueOrDefault(
                                            currentUserDocument?.appLanguage,
                                            '') ==
                                        'de') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Wunsch gespeichert ✨',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                    } else if (valueOrDefault(
                                            currentUserDocument?.appLanguage,
                                            '') ==
                                        'es') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Deseo guardado ✨',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                    }

                                    try {
                                      final result =
                                          await FirebaseFunctions.instanceFor(
                                                  region: 'europe-west3')
                                              .httpsCallable('sendPartnerPush')
                                              .call({
                                        "type": 'wish_created',
                                        "route": 'wishesPage',
                                        "audience": 'partner',
                                      });
                                      _model.cloudFunction7k8a =
                                          SendPartnerPushCloudFunctionCallResponse(
                                        data: result.data,
                                        succeeded: true,
                                        resultAsString: result.data.toString(),
                                        jsonBody: result.data,
                                      );
                                    } on FirebaseFunctionsException catch (error) {
                                      _model.cloudFunction7k8a =
                                          SendPartnerPushCloudFunctionCallResponse(
                                        errorCode: error.code,
                                        succeeded: false,
                                      );
                                    }
                                  } else {
                                    safeSetState(() {
                                      _model.isDataUploading_wishFile = false;
                                      _model.uploadedLocalFile_wishFile =
                                          FFUploadedFile(
                                              bytes: Uint8List.fromList([]),
                                              originalFilename: '');
                                    });

                                    Navigator.pop(context);
                                    if (valueOrDefault(
                                            currentUserDocument?.appLanguage,
                                            '') ==
                                        'en') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Wish saved ✨',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                    } else if (valueOrDefault(
                                            currentUserDocument?.appLanguage,
                                            '') ==
                                        'de') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Wunsch gespeichert ✨',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                    } else if (valueOrDefault(
                                            currentUserDocument?.appLanguage,
                                            '') ==
                                        'es') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Deseo guardado ✨',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                    }

                                    try {
                                      final result =
                                          await FirebaseFunctions.instanceFor(
                                                  region: 'europe-west3')
                                              .httpsCallable('sendPartnerPush')
                                              .call({
                                        "type": 'wish_created',
                                        "route": 'wishesPage',
                                        "audience": 'partner',
                                      });
                                      _model.cloudFunction7k8 =
                                          SendPartnerPushCloudFunctionCallResponse(
                                        data: result.data,
                                        succeeded: true,
                                        resultAsString: result.data.toString(),
                                        jsonBody: result.data,
                                      );
                                    } on FirebaseFunctionsException catch (error) {
                                      _model.cloudFunction7k8 =
                                          SendPartnerPushCloudFunctionCallResponse(
                                        errorCode: error.code,
                                        succeeded: false,
                                      );
                                    }
                                  }
                                } else {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: Text('Category'),
                                        content:
                                            Text('Please select a category'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }

                                safeSetState(() {});
                              },
                        text: FFLocalizations.of(context).getText(
                          'qul44k26' /* Share wish */,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 52.0,
                          padding: EdgeInsets.all(8.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Color(0xFFA88BEB),
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleSmallIsCustom,
                              ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          text: FFLocalizations.of(context).getText(
                            '6yg3416b' /* Cancel */,
                          ),
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 32.0,
                            padding: EdgeInsets.all(8.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Colors.transparent,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: Color(0xFFA88BEB),
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 8.0)),
                  ),
                ),
              ].divide(SizedBox(height: 16.0)),
            ),
          ),
        ),
      ),
    );
  }
}
