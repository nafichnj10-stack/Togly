import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'edit_goal_sheet_model.dart';
export 'edit_goal_sheet_model.dart';

/// Design a bottom sheet for adding or editing a shared bucket list goal in
/// the Togetherly style.
///
/// The sheet should slide up with rounded top corners and a soft
/// lavender-to-white gradient background. At the top, place the title “New
/// Bucket List Goal ✨”. Include input fields with large rounded boxes: Goal
/// Title (text), Category (dropdown with tags), Emoji selector, Image upload
/// (with preview), Note (multiline text). Add a field for Progress/Phase:
/// either a percentage slider or a dropdown (Planning, In Progress, Saving
/// Up, Completed). Also include an optional Target Date picker. At the
/// bottom, provide a toggle for “Mark as completed”. Finish with two rounded
/// buttons: “Cancel” (light grey) and “Save Goal” (lavender gradient). Keep
/// spacing airy, playful and consistent with the romantic Togetherly
/// aesthetic
class EditGoalSheetWidget extends StatefulWidget {
  const EditGoalSheetWidget({
    super.key,
    required this.bucketGoalRecord,
  });

  final BucketListRecord? bucketGoalRecord;

  @override
  State<EditGoalSheetWidget> createState() => _EditGoalSheetWidgetState();
}

class _EditGoalSheetWidgetState extends State<EditGoalSheetWidget> {
  late EditGoalSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditGoalSheetModel());

    _model.textFieldtitleTextController ??=
        TextEditingController(text: widget.bucketGoalRecord?.title);
    _model.textFieldtitleFocusNode ??= FocusNode();

    _model.textFieldnoteTextController ??=
        TextEditingController(text: widget.bucketGoalRecord?.note);
    _model.textFieldnoteFocusNode ??= FocusNode();

    _model.currentTextController ??= TextEditingController(
        text: widget.bucketGoalRecord?.amountCurrent.toString());
    _model.currentFocusNode ??= FocusNode();

    _model.targetTextController ??= TextEditingController(
        text: widget.bucketGoalRecord?.amountTarget.toString());
    _model.targetFocusNode ??= FocusNode();

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
        padding: EdgeInsets.all(14.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF3E8FF),
            boxShadow: [
              BoxShadow(
                blurRadius: 8.0,
                color: Color(0x33000000),
                offset: Offset(
                  0.0,
                  -2.0,
                ),
                spreadRadius: 0.0,
              )
            ],
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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        'gsu5f2ks' /* Edit Goal ✨ */,
                      ),
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context)
                          .headlineMedium
                          .override(
                            fontFamily: FlutterFlowTheme.of(context)
                                .headlineMediumFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .headlineMediumIsCustom,
                          ),
                    ),
                    Container(
                      width: 40.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryText,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                  ].divide(SizedBox(height: 8.0)),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'epzxuzru' /* Goal Title */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                          ),
                        ),
                        Form(
                          key: _model.formKey1,
                          autovalidateMode: AutovalidateMode.always,
                          child: TextFormField(
                            controller: _model.textFieldtitleTextController,
                            focusNode: _model.textFieldtitleFocusNode,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: FFLocalizations.of(context).getText(
                                '900ko653' /* Enter your dream goal... */,
                              ),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyLargeFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyLargeIsCustom,
                                  ),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 16.0, 16.0, 16.0),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                            validator: _model
                                .textFieldtitleTextControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'p42p9elb' /* Category */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 56.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: Color(0xFFF3E8FF),
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FlutterFlowDropDown<String>(
                                  controller: _model.categoryValueController ??=
                                      FormFieldController<String>(
                                    _model.categoryValue ??=
                                        widget.bucketGoalRecord?.categoryKey,
                                  ),
                                  options: [
                                    FFLocalizations.of(context).getText(
                                      'p2euvq9d' /* Travel */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      '37zi87ef' /* Home */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      '05vn97js' /* Learning */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'qzzy75db' /* Health */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'rjmhgmmn' /* Finance */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      '9m7r5kp4' /* Career */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      '8peo59wg' /* Relationship */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'rcp9adn8' /* Creativity */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'v6qzq5wr' /* Social impact */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'n0fnpz2e' /* Personal Growth */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      '8kv6rcts' /* Fitness */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'sm8eujox' /* Other */,
                                    )
                                  ],
                                  onChanged: (val) async {
                                    safeSetState(
                                        () => _model.categoryValue = val);
                                    _model.categoryLabel = _model.categoryValue;
                                    _model.categoryKey = () {
                                      if ((_model.categoryValue == 'Travel') ||
                                          (_model.categoryValue == 'Reisen') ||
                                          (_model.categoryValue == 'Viajes')) {
                                        return 'travel';
                                      } else if ((_model.categoryValue == 'Home') ||
                                          (_model.categoryValue == 'Heim') ||
                                          (_model.categoryValue == 'Hogar')) {
                                        return 'home';
                                      } else if ((_model.categoryValue ==
                                              'Learning') ||
                                          (_model.categoryValue == 'Lernen') ||
                                          (_model.categoryValue ==
                                              'Aprendizaje')) {
                                        return 'learning';
                                      } else if ((_model.categoryValue == 'Health') ||
                                          (_model.categoryValue ==
                                              'Gesundheit') ||
                                          (_model.categoryValue == 'Salud')) {
                                        return 'health';
                                      } else if ((_model.categoryValue ==
                                              'Finance') ||
                                          (_model.categoryValue ==
                                              'Finanzen') ||
                                          (_model.categoryValue ==
                                              'Finanzas')) {
                                        return 'finance';
                                      } else if ((_model.categoryValue ==
                                              'Career') ||
                                          (_model.categoryValue ==
                                              'Karriere') ||
                                          (_model.categoryValue ==
                                              'Carrera profesional')) {
                                        return 'career';
                                      } else if ((_model.categoryValue ==
                                              'Relationship') ||
                                          (_model.categoryValue ==
                                              'Beziehung') ||
                                          (_model.categoryValue ==
                                              'Relación')) {
                                        return 'relationship';
                                      } else if ((_model.categoryValue ==
                                              'Creativity') ||
                                          (_model.categoryValue ==
                                              'Kreativität') ||
                                          (_model.categoryValue ==
                                              'Creatividad')) {
                                        return 'creativity';
                                      } else if ((_model.categoryValue ==
                                              'Social impact') ||
                                          (_model.categoryValue ==
                                              'Soziales') ||
                                          (_model.categoryValue ==
                                              'Impacto social')) {
                                        return 'social_impact';
                                      } else if ((_model.categoryValue ==
                                              'Personal Growth') ||
                                          (_model.categoryValue ==
                                              'Persönliches Wachstum') ||
                                          (_model.categoryValue ==
                                              'Crecimiento personal')) {
                                        return 'personal_growth';
                                      } else if ((_model.categoryValue ==
                                              'Fitness') ||
                                          (_model.categoryValue == 'Fitness') ||
                                          (_model.categoryValue == 'Fitness')) {
                                        return 'fitness';
                                      } else if ((_model.categoryValue ==
                                              'Other') ||
                                          (_model.categoryValue == 'Anderes') ||
                                          (_model.categoryValue == 'Otros')) {
                                        return 'other';
                                      } else {
                                        return '';
                                      }
                                    }();
                                    safeSetState(() {});
                                  },
                                  width: 276.5,
                                  height: 40.0,
                                  textStyle: FlutterFlowTheme.of(context)
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
                                  hintText: _model.categoryKey,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  elevation: 2.0,
                                  borderColor: Colors.transparent,
                                  borderWidth: 0.0,
                                  borderRadius: 8.0,
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 12.0, 0.0),
                                  hidesUnderline: true,
                                  isOverButton: false,
                                  isSearchable: false,
                                  isMultiSelect: false,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'kr2cd6wk' /* Emoji */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 56.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: Color(0xFFF3E8FF),
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FlutterFlowDropDown<String>(
                                  controller: _model.emojiValueController ??=
                                      FormFieldController<String>(
                                    _model.emojiValue ??=
                                        widget.bucketGoalRecord?.emoji,
                                  ),
                                  options: [
                                    FFLocalizations.of(context).getText(
                                      '68cuibo9' /* 😍 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      '73ovi3fq' /* 😋 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'i7uzo1vc' /* 😮 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      '595slmhj' /* 😎 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      '5ex67b4u' /* 💪 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'm93md55w' /* 🫦 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'iq4izh14' /* 🧠 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'neo7oi2e' /* 🫂 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'tcu8lzj9' /* 💍 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      '5r8bwo4z' /* 🍳 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      '2ye0c3td' /* 🐕 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'zxbvnmbs' /* ✈️ */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'aod0d33b' /* 🏠 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'zjqyje32' /* 🍩 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      '6j9nbc47' /* 🍷 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'k0u033zb' /* 🐶 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'xu5rc02l' /* 💜 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'htjnp5mh' /* 📚 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      '40j8aji9' /* 🎉 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'fl6ch3k4' /* 🌍 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'mgthwk29' /* 🎨 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      '49m8eorn' /* 💼 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      '8lh5o93c' /* 🌱 */,
                                    )
                                  ],
                                  onChanged: (val) => safeSetState(
                                      () => _model.emojiValue = val),
                                  width: 276.4,
                                  height: 40.0,
                                  textStyle: FlutterFlowTheme.of(context)
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
                                  hintText: widget.bucketGoalRecord?.emoji,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  elevation: 2.0,
                                  borderColor: Colors.transparent,
                                  borderWidth: 0.0,
                                  borderRadius: 8.0,
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 12.0, 0.0),
                                  hidesUnderline: true,
                                  isOverButton: false,
                                  isSearchable: false,
                                  isMultiSelect: false,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'm9dow2p9' /* Note */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                          ),
                        ),
                        Form(
                          key: _model.formKey2,
                          autovalidateMode: AutovalidateMode.always,
                          child: TextFormField(
                            controller: _model.textFieldnoteTextController,
                            focusNode: _model.textFieldnoteFocusNode,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: FFLocalizations.of(context).getText(
                                'ho2lkxrx' /* Add details about your goal... */,
                              ),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyLargeFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyLargeIsCustom,
                                  ),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 16.0, 16.0, 16.0),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                            maxLines: 5,
                            minLines: 3,
                            validator: _model
                                .textFieldnoteTextControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '1fxnpix7' /* Progress */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 56.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: Color(0xFFF3E8FF),
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FlutterFlowDropDown<String>(
                                  controller:
                                      _model.phasedropValueController ??=
                                          FormFieldController<String>(
                                    _model.phasedropValue ??= _model.phaseKey,
                                  ),
                                  options: List<String>.from([
                                    'planning',
                                    'in_progress',
                                    'saving_up',
                                    'someday'
                                  ]),
                                  optionLabels: [
                                    FFLocalizations.of(context).getText(
                                      '4zn1osq8' /* Planning */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'ffwuqtat' /* In progress */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'v84bhtwe' /* Saving up */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      'z3rk4bhr' /* Someday */,
                                    )
                                  ],
                                  onChanged: (val) async {
                                    safeSetState(
                                        () => _model.phasedropValue = val);
                                    _model.phaseKey = _model.phasedropValue;
                                    safeSetState(() {});
                                  },
                                  width: 273.39,
                                  height: 40.0,
                                  textStyle: FlutterFlowTheme.of(context)
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
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  elevation: 2.0,
                                  borderColor: Colors.transparent,
                                  borderWidth: 0.0,
                                  borderRadius: 8.0,
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 12.0, 0.0),
                                  hidesUnderline: true,
                                  isOverButton: false,
                                  isSearchable: false,
                                  isMultiSelect: false,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                    if (_model.phaseKey == 'in_progress')
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'cml4i8m5' /* Percentage progress */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                            ),
                          ),
                          SliderTheme(
                            data: SliderThemeData(
                              showValueIndicator: ShowValueIndicator.onDrag,
                            ),
                            child: Slider(
                              activeColor: FlutterFlowTheme.of(context).primary,
                              inactiveColor:
                                  FlutterFlowTheme.of(context).tertiary,
                              min: 0.0,
                              max: 100.0,
                              value: _model.finalProgressValue ??=
                                  valueOrDefault<double>(
                                widget.bucketGoalRecord?.progressPercent,
                                1.0,
                              ),
                              label:
                                  _model.finalProgressValue?.toStringAsFixed(2),
                              onChanged: (newValue) {
                                newValue =
                                    double.parse(newValue.toStringAsFixed(2));
                                safeSetState(
                                    () => _model.finalProgressValue = newValue);
                              },
                            ),
                          ),
                        ],
                      ),
                    if (_model.phaseKey == 'saving_up')
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 6.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'ux4234r3' /* Saved, goal and currency */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelMediumFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .labelMediumIsCustom,
                                    ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 6.0),
                                child: Container(
                                  width: 200.0,
                                  child: TextFormField(
                                    controller: _model.currentTextController,
                                    focusNode: _model.currentFocusNode,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelMediumIsCustom,
                                          ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelMediumIsCustom,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                    keyboardType: TextInputType.number,
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    enableInteractiveSelection: true,
                                    validator: _model
                                        .currentTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 6.0),
                                child: Container(
                                  width: 200.0,
                                  child: TextFormField(
                                    controller: _model.targetTextController,
                                    focusNode: _model.targetFocusNode,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelMediumIsCustom,
                                          ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelMediumIsCustom,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                    keyboardType: TextInputType.number,
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    enableInteractiveSelection: true,
                                    validator: _model
                                        .targetTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                              FlutterFlowDropDown<String>(
                                controller: _model.currencyValueController ??=
                                    FormFieldController<String>(
                                  _model.currencyValue ??=
                                      widget.bucketGoalRecord?.currency,
                                ),
                                options: List<String>.from([
                                  'EUR',
                                  'USD',
                                  'GBP',
                                  'JPY',
                                  'CNY',
                                  'INR',
                                  'AUD',
                                  'CAD',
                                  'CHF',
                                  'HKD',
                                  'SGD',
                                  'KRW',
                                  'MXN',
                                  'BRL',
                                  'ZAR',
                                  'TRY',
                                  'RUB',
                                  'AED',
                                  'SEK',
                                  'NOK'
                                ]),
                                optionLabels: [
                                  FFLocalizations.of(context).getText(
                                    's63w32r8' /* EUR – € */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'q52vsvsf' /* USD – $ */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'xuvzongq' /* GBP – £ */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'qylip5jo' /* JPY – ¥ */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    '8xslm7p1' /* CNY – ¥ / 元 */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    '7kscxxk8' /* INR – ₹ */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'bc9n0yap' /* AUD – A$ */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'kvbiie89' /* CAD – C$ */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    '61ywvnrb' /* CHF – Fr */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'vop9vtvv' /* HKD – HK$ */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'khk98ksj' /* SGD – S$ */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'zc7skcgf' /* KRW – ₩ */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    '54u9svzk' /* MXN – Mex$ */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'n2jnyr7u' /* BRL – R$ */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    't82mzc7u' /* ZAR – R */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    '4se9bema' /* TRY – ₺ */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    '9jyn3xr5' /* RUB – ₽ */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'ysfwh4o4' /* AED – د.إ */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'fl7o50vd' /* SEK – kr */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    '30d75cdk' /* NOK – kr */,
                                  )
                                ],
                                onChanged: (val) => safeSetState(
                                    () => _model.currencyValue = val),
                                width: 290.7,
                                height: 40.0,
                                textStyle: FlutterFlowTheme.of(context)
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
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                ),
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                elevation: 2.0,
                                borderColor: Colors.transparent,
                                borderWidth: 0.0,
                                borderRadius: 8.0,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 12.0, 0.0),
                                hidesUnderline: true,
                                isOverButton: false,
                                isSearchable: false,
                                isMultiSelect: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '4x1ey4h7' /* Deadline for this goal (option... */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 56.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: Color(0xFFF3E8FF),
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 12.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                final _datePickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: getCurrentTimestamp,
                                  firstDate: getCurrentTimestamp,
                                  lastDate: DateTime(2050),
                                  builder: (context, child) {
                                    return wrapInMaterialDatePickerTheme(
                                      context,
                                      child!,
                                      headerBackgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                      headerForegroundColor:
                                          FlutterFlowTheme.of(context).info,
                                      headerTextStyle: FlutterFlowTheme.of(
                                              context)
                                          .headlineLarge
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .headlineLargeFamily,
                                            fontSize: 32.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .headlineLargeIsCustom,
                                          ),
                                      pickerBackgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      pickerForegroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      selectedDateTimeBackgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                      selectedDateTimeForegroundColor:
                                          FlutterFlowTheme.of(context).info,
                                      actionButtonForegroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      iconSize: 24.0,
                                    );
                                  },
                                );

                                if (_datePickedDate != null) {
                                  safeSetState(() {
                                    _model.datePicked = DateTime(
                                      _datePickedDate.year,
                                      _datePickedDate.month,
                                      _datePickedDate.day,
                                    );
                                  });
                                } else if (_model.datePicked != null) {
                                  safeSetState(() {
                                    _model.datePicked = getCurrentTimestamp;
                                  });
                                }
                                _model.selectedDate = _model.datePicked;
                                safeSetState(() {});
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    valueOrDefault<String>(
                                      dateTimeFormat(
                                        "yMd",
                                        _model.datePicked,
                                        locale: FFLocalizations.of(context)
                                            .languageCode,
                                      ),
                                      'Deadline....',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                  ),
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                  ].divide(SizedBox(height: 16.0)),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 50.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        text: FFLocalizations.of(context).getText(
                          '7jyanekb' /* Cancel */,
                        ),
                        options: FFButtonOptions(
                          width: 120.0,
                          height: 48.0,
                          padding: EdgeInsets.all(8.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).tertiary,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleSmallIsCustom,
                              ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          _model.categoryKey =
                              widget.bucketGoalRecord?.categoryKey;
                          _model.categoryLabel =
                              widget.bucketGoalRecord?.categoryLabel;
                          _model.phaseKey = widget.bucketGoalRecord?.phaseKey;
                          safeSetState(() {});

                          await widget.bucketGoalRecord!.reference
                              .update(createBucketListRecordData(
                            title: _model.textFieldtitleTextController.text,
                            note: _model.textFieldnoteTextController.text,
                            emoji: _model.emojiValue,
                            progressPercent: _model.finalProgressValue,
                            amountCurrent: double.tryParse(
                                _model.currentTextController.text),
                            amountTarget: double.tryParse(
                                _model.targetTextController.text),
                            currency: _model.currencyValue,
                            updatedAt: getCurrentTimestamp,
                            updatedBy: currentUserUid,
                            targetDate: _model.selectedDate,
                            relationshipId: valueOrDefault(
                                currentUserDocument?.relationshipId, ''),
                            phaseKey: _model.phasedropValue,
                            categoryKey: _model.categoryKey,
                            categoryLabel: _model.categoryValue,
                          ));
                          Navigator.pop(context);
                          if (valueOrDefault(
                                  currentUserDocument?.appLanguage, '') ==
                              'en') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Goal updated!',
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
                                  'Ziel aktualisiert!',
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
                                  'Objetivo actualizado!',
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

                          try {
                            final result = await FirebaseFunctions.instanceFor(
                                    region: 'europe-west3')
                                .httpsCallable('sendPartnerPush')
                                .call({
                              "type": 'goal_updated',
                              "route": 'goalList',
                              "audience": 'partner',
                            });
                            _model.cloudFunction88i =
                                SendPartnerPushCloudFunctionCallResponse(
                              data: result.data,
                              succeeded: true,
                              resultAsString: result.data.toString(),
                              jsonBody: result.data,
                            );
                          } on FirebaseFunctionsException catch (error) {
                            _model.cloudFunction88i =
                                SendPartnerPushCloudFunctionCallResponse(
                              errorCode: error.code,
                              succeeded: false,
                            );
                          }

                          safeSetState(() {});
                        },
                        text: FFLocalizations.of(context).getText(
                          'jac4fnc5' /* Edit Goal */,
                        ),
                        options: FFButtonOptions(
                          width: 180.0,
                          height: 48.0,
                          padding: EdgeInsets.all(8.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Color(0xFF4B39EF),
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: Colors.white,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleSmallIsCustom,
                              ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                    ].divide(SizedBox(width: 12.0)),
                  ),
                ),
              ].divide(SizedBox(height: 20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
