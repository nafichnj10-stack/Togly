import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:firebase_storagelibrary_2sa6k9/app_state.dart'
    as firebase_storagelibrary_2sa6k9_app_state;
import 'package:firebase_storagelibrary_2sa6k9/custom_code/actions/index.dart'
    as firebase_storagelibrary_2sa6k9_actions;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'goal_sheet_model.dart';
export 'goal_sheet_model.dart';

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
class GoalSheetWidget extends StatefulWidget {
  const GoalSheetWidget({super.key});

  @override
  State<GoalSheetWidget> createState() => _GoalSheetWidgetState();
}

class _GoalSheetWidgetState extends State<GoalSheetWidget> {
  late GoalSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GoalSheetModel());

    _model.textFieldtitleTextController ??= TextEditingController();
    _model.textFieldtitleFocusNode ??= FocusNode();

    _model.textFieldnoteTextController ??= TextEditingController();
    _model.textFieldnoteFocusNode ??= FocusNode();

    _model.currentTextController ??= TextEditingController();
    _model.currentFocusNode ??= FocusNode();

    _model.targetTextController ??= TextEditingController();
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
    context.watch<FFAppState>();
    context.watch<firebase_storagelibrary_2sa6k9_app_state.FFAppState>();

    return Container(
      decoration: BoxDecoration(),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryText,
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
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(),
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
                            'c56upugs' /* New Bucket List Goal ✨ */,
                          ),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineMediumFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'qmyxceu8' /* Goal Title */,
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
                            Form(
                              key: _model.formKey2,
                              autovalidateMode: AutovalidateMode.always,
                              child: TextFormField(
                                controller: _model.textFieldtitleTextController,
                                focusNode: _model.textFieldtitleFocusNode,
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: FFLocalizations.of(context).getText(
                                    'z0krompm' /* Enter your dream goal... */,
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
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
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
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'stxbdbdv' /* Category */,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FlutterFlowDropDown<String>(
                                      controller:
                                          _model.categoryValueController ??=
                                              FormFieldController<String>(null),
                                      options: [
                                        FFLocalizations.of(context).getText(
                                          'du1cr1kw' /* Travel */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          't427qcw2' /* Home */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          '0p5w3gbh' /* Learning */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          '1csb8o5m' /* Health */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'jzm7zpuz' /* Finance */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'k0fzzo3n' /* Career */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'x0mv6400' /* Relationship */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          '2yuwugz4' /* Creativity */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          '3qxw2j77' /* Social impact */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          '75try05k' /* Personal Growth */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          '181eu1rr' /* Fitness */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'sr9uyqga' /* Other */,
                                        )
                                      ],
                                      onChanged: (val) async {
                                        safeSetState(
                                            () => _model.categoryValue = val);
                                        _model.categoryLabel =
                                            _model.categoryValue;
                                        _model.categoryKey = () {
                                          if ((_model.categoryValue == 'Travel') ||
                                              (_model.categoryValue ==
                                                  'Reisen') ||
                                              (_model.categoryValue ==
                                                  'Viajes')) {
                                            return 'travel';
                                          } else if ((_model.categoryValue == 'Home') ||
                                              (_model.categoryValue ==
                                                  'Heim') ||
                                              (_model.categoryValue ==
                                                  'Hogar')) {
                                            return 'home';
                                          } else if ((_model.categoryValue == 'Learning') ||
                                              (_model.categoryValue ==
                                                  'Lernen') ||
                                              (_model.categoryValue ==
                                                  'Aprendizaje')) {
                                            return 'learning';
                                          } else if ((_model.categoryValue == 'Health') ||
                                              (_model.categoryValue ==
                                                  'Gesundheit') ||
                                              (_model.categoryValue ==
                                                  'Salud')) {
                                            return 'health';
                                          } else if ((_model.categoryValue == 'Finance') ||
                                              (_model.categoryValue ==
                                                  'Finanzen') ||
                                              (_model.categoryValue ==
                                                  'Finanzas')) {
                                            return 'finance';
                                          } else if ((_model.categoryValue == 'Career') ||
                                              (_model.categoryValue ==
                                                  'Karriere') ||
                                              (_model.categoryValue ==
                                                  'Carrera profesional')) {
                                            return 'career';
                                          } else if ((_model.categoryValue == 'Relationship') ||
                                              (_model.categoryValue ==
                                                  'Beziehung') ||
                                              (_model.categoryValue ==
                                                  'Relación')) {
                                            return 'relationship';
                                          } else if ((_model.categoryValue == 'Creativity') ||
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
                                          } else if ((_model.categoryValue == 'Fitness') ||
                                              (_model.categoryValue ==
                                                  'Fitness') ||
                                              (_model.categoryValue ==
                                                  'Fitness')) {
                                            return 'fitness';
                                          } else if ((_model.categoryValue == 'Other') ||
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
                                      hintText:
                                          FFLocalizations.of(context).getText(
                                        '5q4j5pve' /* Select category */,
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
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'dt9oztso' /* Emoji */,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FlutterFlowDropDown<String>(
                                      controller:
                                          _model.emojiValueController ??=
                                              FormFieldController<String>(null),
                                      options: [
                                        FFLocalizations.of(context).getText(
                                          'bi1tblrx' /* 😍 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'cjjdnhf4' /* 😋 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'gdq8jnvg' /* 😮 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'dhwblylk' /* 😎 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'syobbe4i' /* 💪 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'kvyia55y' /* 🫦 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'fmige1pv' /* 🧠 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'spcoc5n8' /* 🫂 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'pp7597mf' /* 💍 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          '632grkyg' /* 🍳 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'e6lufh8w' /* 🐕 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'doqxcpqn' /* ✈️ */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'wxpd121r' /* 🏠 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'xgkep9hg' /* 🍩 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'adtszq9f' /* 🍷 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          '33t9grny' /* 🐶 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'pjxyggq4' /* 💜 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          '152njb3a' /* 📚 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'jrm9brp1' /* 🎉 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          '4grlehr4' /* 🌍 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'slq2c0uf' /* 🎨 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'o86nfy8h' /* 💼 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'llgvsohr' /* 🌱 */,
                                        )
                                      ],
                                      onChanged: (val) => safeSetState(
                                          () => _model.emojiValue = val),
                                      width: 276.4,
                                      height: 40.0,
                                      textStyle: FlutterFlowTheme.of(context)
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
                                      hintText:
                                          FFLocalizations.of(context).getText(
                                        '4z8ryphk' /* Choose an emoji 😊 */,
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
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                '4m6s0hrs' /* Image */,
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
                            Container(
                              width: 300.0,
                              height: 200.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.memory(
                                    _model.uploadedLocalFile_buckIMG2.bytes ??
                                        Uint8List.fromList([]),
                                  ).image,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4.0,
                                    color: Color(0x33000000),
                                    offset: Offset(
                                      0.0,
                                      2.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                  color: Color(0xFFF3E8FF),
                                  width: 2.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 16.0, 16.0, 16.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    final selectedMedia = await selectMedia(
                                      imageQuality: 85,
                                      includeDimensions: true,
                                      mediaSource: MediaSource.photoGallery,
                                      multiImage: false,
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      safeSetState(() => _model
                                          .isDataUploading_buckIMG2 = true);
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
                                        _model.isDataUploading_buckIMG2 = false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                          selectedMedia.length) {
                                        safeSetState(() {
                                          _model.uploadedLocalFile_buckIMG2 =
                                              selectedUploadedFiles.first;
                                        });
                                      } else {
                                        safeSetState(() {});
                                        return;
                                      }
                                    }

                                    _model.coverFile =
                                        _model.uploadedLocalFile_buckIMG2;
                                    safeSetState(() {});
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if ((_model.uploadedLocalFile_buckIMG2
                                                  .bytes?.isEmpty ??
                                              true))
                                        Icon(
                                          Icons.add_photo_alternate_outlined,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 32.0,
                                        ),
                                      if ((_model.uploadedLocalFile_buckIMG2
                                                  .bytes?.isEmpty ??
                                              true))
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'h4gvtr6c' /* Tap to add image */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmallIsCustom,
                                              ),
                                        ),
                                    ].divide(SizedBox(height: 8.0)),
                                  ),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'r1t64tvg' /* Note */,
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
                            Form(
                              key: _model.formKey1,
                              autovalidateMode: AutovalidateMode.always,
                              child: TextFormField(
                                controller: _model.textFieldnoteTextController,
                                focusNode: _model.textFieldnoteFocusNode,
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: FFLocalizations.of(context).getText(
                                    'dqwhavq1' /* Add details about your goal... */,
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
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
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
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'tqf3iki6' /* Progress */,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FlutterFlowDropDown<String>(
                                      controller:
                                          _model.phasedropValueController ??=
                                              FormFieldController<String>(
                                        _model.phasedropValue ??= '',
                                      ),
                                      options: List<String>.from([
                                        'planning',
                                        'in_progress',
                                        'saving_up',
                                        'someday'
                                      ]),
                                      optionLabels: [
                                        FFLocalizations.of(context).getText(
                                          'flc7ovnq' /* Planing */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          '0pglw842' /* In progress */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'rhwchhop' /* Saving up */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'rglftu74' /* Someday */,
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
                                      hintText:
                                          FFLocalizations.of(context).getText(
                                        '7o38yfrk' /* Choose a status... */,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'cn2v86f7' /* Percentage progress */,
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
                                  activeColor:
                                      FlutterFlowTheme.of(context).primary,
                                  inactiveColor:
                                      FlutterFlowTheme.of(context).tertiary,
                                  min: 0.0,
                                  max: 100.0,
                                  value: _model.finalProgressValue ??= 0.0,
                                  label: _model.finalProgressValue
                                      ?.toStringAsFixed(2),
                                  onChanged: (newValue) {
                                    newValue = double.parse(
                                        newValue.toStringAsFixed(2));
                                    safeSetState(() =>
                                        _model.finalProgressValue = newValue);
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
                                      'kp1bt3qb' /* Saved, goal and currency */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
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
                                        controller:
                                            _model.currentTextController,
                                        focusNode: _model.currentFocusNode,
                                        autofocus: false,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .labelMediumIsCustom,
                                              ),
                                          hintText: FFLocalizations.of(context)
                                              .getText(
                                            'ym2nhaby' /* Current amount... */,
                                          ),
                                          hintStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
                                            ),
                                        keyboardType: TextInputType.number,
                                        cursorColor:
                                            FlutterFlowTheme.of(context)
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
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .labelMediumIsCustom,
                                              ),
                                          hintText: FFLocalizations.of(context)
                                              .getText(
                                            'g8sg8lgn' /* Amount target... */,
                                          ),
                                          hintStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
                                            ),
                                        keyboardType: TextInputType.number,
                                        cursorColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                        enableInteractiveSelection: true,
                                        validator: _model
                                            .targetTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  FlutterFlowDropDown<String>(
                                    controller:
                                        _model.currencyValueController ??=
                                            FormFieldController<String>(
                                      _model.currencyValue ??= '',
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
                                        'nmlt2z1e' /* EUR – € */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        '6hgetzk8' /* USD – $ */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        'cj9qmu7u' /* GBP – £ */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        'ea5dwcle' /* JPY – ¥ */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        'ku92ilv3' /* CNY – ¥ / 元 */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        'f83oexar' /* INR – ₹ */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        '1km69tde' /* AUD – A$ */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        'rwyah6dr' /* CAD – C$ */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        'ke9ni4bw' /* CHF – Fr */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        '953h6dnx' /* HKD – HK$ */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        'l567mnjg' /* SGD – S$ */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        'vi8olqf5' /* KRW – ₩ */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        'psg2y8qu' /* MXN – Mex$ */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        'hqd7i396' /* BRL – R$ */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        'kj5fsrmg' /* ZAR – R */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        'h6rmhncd' /* TRY – ₺ */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        '7cxj48ni' /* RUB – ₽ */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        'syrtr0s1' /* AED – د.إ */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        'g9t2e7ki' /* SEK – kr */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        'apqh99ye' /* NOK – kr */,
                                      )
                                    ],
                                    onChanged: (val) => safeSetState(
                                        () => _model.currencyValue = val),
                                    width: 290.7,
                                    height: 40.0,
                                    textStyle: FlutterFlowTheme.of(context)
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
                                    hintText:
                                        FFLocalizations.of(context).getText(
                                      'g2pu09an' /* Currency */,
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
                                  'kb0b74gt' /* Deadline for this goal (option... */,
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
                                    final _datePickedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: getCurrentTimestamp,
                                      firstDate: getCurrentTimestamp,
                                      lastDate: DateTime(2050),
                                      builder: (context, child) {
                                        return wrapInMaterialDatePickerTheme(
                                          context,
                                          child!,
                                          headerBackgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
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
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .headlineLargeIsCustom,
                                              ),
                                          pickerBackgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          pickerForegroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          selectedDateTimeBackgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
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
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 50.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            text: FFLocalizations.of(context).getText(
                              '1zxkag27' /* Cancel */,
                            ),
                            options: FFButtonOptions(
                              width: 120.0,
                              height: 48.0,
                              padding: EdgeInsets.all(8.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleSmallFamily,
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
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
                              var bucketListRecordReference =
                                  BucketListRecord.collection.doc();
                              await bucketListRecordReference.set({
                                ...createBucketListRecordData(
                                  relationshipId: valueOrDefault(
                                      currentUserDocument?.relationshipId, ''),
                                  title:
                                      _model.textFieldtitleTextController.text,
                                  note: _model.textFieldnoteTextController.text,
                                  emoji: _model.emojiValue,
                                  progressPercent: _model.finalProgressValue,
                                  amountCurrent: double.tryParse(
                                      _model.currentTextController.text),
                                  amountTarget: double.tryParse(
                                      _model.targetTextController.text),
                                  currency: _model.currencyValue,
                                  isCompleted: false,
                                  createdBy: currentUserUid,
                                  updatedBy: currentUserUid,
                                  targetDate: _model.selectedDate,
                                  categoryLabel: _model.categoryValue,
                                  categoryKey: _model.categoryKey,
                                  phaseKey: _model.phasedropValue,
                                ),
                                ...mapToFirestore(
                                  {
                                    'created_at': FieldValue.serverTimestamp(),
                                    'updated_at': FieldValue.serverTimestamp(),
                                  },
                                ),
                              });
                              _model.newBucketRef =
                                  BucketListRecord.getDocumentFromData({
                                ...createBucketListRecordData(
                                  relationshipId: valueOrDefault(
                                      currentUserDocument?.relationshipId, ''),
                                  title:
                                      _model.textFieldtitleTextController.text,
                                  note: _model.textFieldnoteTextController.text,
                                  emoji: _model.emojiValue,
                                  progressPercent: _model.finalProgressValue,
                                  amountCurrent: double.tryParse(
                                      _model.currentTextController.text),
                                  amountTarget: double.tryParse(
                                      _model.targetTextController.text),
                                  currency: _model.currencyValue,
                                  isCompleted: false,
                                  createdBy: currentUserUid,
                                  updatedBy: currentUserUid,
                                  targetDate: _model.selectedDate,
                                  categoryLabel: _model.categoryValue,
                                  categoryKey: _model.categoryKey,
                                  phaseKey: _model.phasedropValue,
                                ),
                                ...mapToFirestore(
                                  {
                                    'created_at': DateTime.now(),
                                    'updated_at': DateTime.now(),
                                  },
                                ),
                              }, bucketListRecordReference);
                              logFirebaseEvent(
                                'goal_created',
                                parameters: {
                                  'category': _model.categoryValue,
                                  'role': 'initiator',
                                },
                              );
                              if (FFAppState().selectedDate != null) {
                                await _model.newBucketRef!.reference
                                    .update(createBucketListRecordData(
                                  targetDate: _model.selectedDate,
                                ));
                              } else {
                                await Future.delayed(
                                  Duration(
                                    milliseconds: 10,
                                  ),
                                );
                              }

                              if ((_model.uploadedLocalFile_buckIMG2.bytes
                                          ?.isNotEmpty ??
                                      false)) {
                                _model.fileName = random_data.randomString(
                                  16,
                                  24,
                                  true,
                                  false,
                                  true,
                                );
                                safeSetState(() {});
                                _model.uploadedObj =
                                    await firebase_storagelibrary_2sa6k9_actions
                                        .uploadFileToBucket(
                                  '',
                                  'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/bucket/${_model.newBucketRef?.reference.id}${_model.fileName}.jpg',
                                  _model.uploadedLocalFile_buckIMG2,
                                  '',
                                );
                                _model.coverURL =
                                    await firebase_storagelibrary_2sa6k9_actions
                                        .getDownloadUrl(
                                  '',
                                  'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/bucket/${_model.newBucketRef?.reference.id}${_model.fileName}.jpg',
                                );

                                await _model.newBucketRef!.reference
                                    .update(createBucketListRecordData(
                                  imagePath:
                                      'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/bucket/${_model.newBucketRef?.reference.id}${_model.fileName}.jpg',
                                  imageUrl: _model.coverURL,
                                ));
                                Navigator.pop(context);
                                if (valueOrDefault(
                                        currentUserDocument?.appLanguage, '') ==
                                    'en') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Goal saved ✨',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondary,
                                    ),
                                  );
                                } else if (valueOrDefault(
                                        currentUserDocument?.appLanguage, '') ==
                                    'de') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Ziel erstellt ✨',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondary,
                                    ),
                                  );
                                } else if (valueOrDefault(
                                        currentUserDocument?.appLanguage, '') ==
                                    'es') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Objetivo guardado ✨',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
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
                                    "type": 'goal_created',
                                    "route": 'goalList',
                                    "audience": 'partner',
                                  });
                                  _model.cloudFunctionzwp =
                                      SendPartnerPushCloudFunctionCallResponse(
                                    data: result.data,
                                    succeeded: true,
                                    resultAsString: result.data.toString(),
                                    jsonBody: result.data,
                                  );
                                } on FirebaseFunctionsException catch (error) {
                                  _model.cloudFunctionzwp =
                                      SendPartnerPushCloudFunctionCallResponse(
                                    errorCode: error.code,
                                    succeeded: false,
                                  );
                                }
                              } else {
                                Navigator.pop(context);
                                if (valueOrDefault(
                                        currentUserDocument?.appLanguage, '') ==
                                    'en') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Goal saved ✨',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondary,
                                    ),
                                  );
                                } else if (valueOrDefault(
                                        currentUserDocument?.appLanguage, '') ==
                                    'de') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Ziel erstellt ✨',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondary,
                                    ),
                                  );
                                } else if (valueOrDefault(
                                        currentUserDocument?.appLanguage, '') ==
                                    'es') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Objetivo guardado ✨',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
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
                                    "type": 'goal_created',
                                    "route": 'goalList',
                                    "audience": 'partner',
                                  });
                                  _model.cloudFunctionzwp2 =
                                      SendPartnerPushCloudFunctionCallResponse(
                                    data: result.data,
                                    succeeded: true,
                                    resultAsString: result.data.toString(),
                                    jsonBody: result.data,
                                  );
                                } on FirebaseFunctionsException catch (error) {
                                  _model.cloudFunctionzwp2 =
                                      SendPartnerPushCloudFunctionCallResponse(
                                    errorCode: error.code,
                                    succeeded: false,
                                  );
                                }
                              }

                              safeSetState(() {});
                            },
                            text: FFLocalizations.of(context).getText(
                              'wxe9qsru' /* Save Goal */,
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
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
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
        ),
      ),
    );
  }
}
