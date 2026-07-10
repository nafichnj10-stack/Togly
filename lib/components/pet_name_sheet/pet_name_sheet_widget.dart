import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'pet_name_sheet_model.dart';
export 'pet_name_sheet_model.dart';

/// Create a modern mobile bottom sheet component for a couple app called
/// Togly.
///
/// The purpose of this sheet is to let the user rename their Love Buddy pet.
///
/// Design requirements:
///
/// - Cute, emotional, and premium couple-app style
/// - Rounded top corners (24px)
/// - Soft shadows
/// - Comfortable padding and spacing
/// - Clean modern typography
/// - A small pet icon at the top
/// - Title:
///   "Edit your pet name"
///
/// - Subtitle:
///   "Choose a new name for the pet that represents you in Togly, Travel
/// Mode, and the widget."
///
/// - One text input field:
///   Label: Pet Name
///   Placeholder: Enter a new pet name...
///
/// - Two buttons at the bottom:
///   Secondary button: Cancel
///   Primary button: Save
///
/// Important:
/// Create the UI design only.
/// Do not add any actions, logic, backend connections, validations, or
/// conditions.
/// Use placeholder content only.
class PetNameSheetWidget extends StatefulWidget {
  const PetNameSheetWidget({
    super.key,
    String? title,
    String? subtitle,
    String? label,
    String? hint,
  })  : this.title = title ?? '',
        this.subtitle = subtitle ?? '',
        this.label = label ?? '',
        this.hint = hint ?? '';

  final String title;
  final String subtitle;
  final String label;
  final String hint;

  @override
  State<PetNameSheetWidget> createState() => _PetNameSheetWidgetState();
}

class _PetNameSheetWidgetState extends State<PetNameSheetWidget> {
  late PetNameSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PetNameSheetModel());

    _model.textFieldNameTextController ??= TextEditingController();
    _model.textFieldNameFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(32.0, 24.0, 32.0, 24.0),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Container(
                    width: 40.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      borderRadius: BorderRadius.circular(9999.0),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                AuthUserStreamWidget(
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
                          columnRelationshipViewsRecordList = snapshot.data!;
                      final columnRelationshipViewsRecord =
                          columnRelationshipViewsRecordList.isNotEmpty
                              ? columnRelationshipViewsRecordList.first
                              : null;

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (columnRelationshipViewsRecord?.myLoveBuddyPet ==
                              'cat')
                            Container(
                              width: 64.0,
                              height: 64.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  alignment: AlignmentDirectional(1.0, 0.0),
                                  image: Image.asset(
                                    'assets/images/cat_selfie.webp',
                                  ).image,
                                ),
                                borderRadius: BorderRadius.circular(9999.0),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                            ),
                          if (columnRelationshipViewsRecord?.myLoveBuddyPet ==
                              'dog')
                            Container(
                              width: 64.0,
                              height: 64.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  image: Image.asset(
                                    'assets/images/dog_selfie.webp',
                                  ).image,
                                ),
                                borderRadius: BorderRadius.circular(9999.0),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                            ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'y3xiunxl' /* Change Name */,
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleLargeFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      lineHeight: 1.27,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .titleLargeIsCustom,
                                    ),
                              ),
                              Text(
                                FFLocalizations.of(context).getText(
                                  'ejbmnfhg' /* Choose a new name for your Com... */,
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
                                      lineHeight: 1.47,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                              ),
                            ].divide(SizedBox(height: 4.0)),
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      );
                    },
                  ),
                ),
                AuthUserStreamWidget(
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
                          textFieldNameRelationshipViewsRecordList =
                          snapshot.data!;
                      final textFieldNameRelationshipViewsRecord =
                          textFieldNameRelationshipViewsRecordList.isNotEmpty
                              ? textFieldNameRelationshipViewsRecordList.first
                              : null;

                      return Container(
                        width: 200.0,
                        child: TextFormField(
                          controller: _model.textFieldNameTextController,
                          focusNode: _model.textFieldNameFocusNode,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.textFieldNameTextController',
                            Duration(milliseconds: 2000),
                            () async {
                              _model.newPetName =
                                  _model.textFieldNameTextController.text;
                              safeSetState(() {});
                            },
                          ),
                          autofocus: false,
                          enabled: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: FlutterFlowTheme.of(context)
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
                            hintText: textFieldNameRelationshipViewsRecord
                                ?.myLoveBuddyName,
                            hintStyle: FlutterFlowTheme.of(context)
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
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyMediumIsCustom,
                              ),
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          enableInteractiveSelection: true,
                          validator: _model.textFieldNameTextControllerValidator
                              .asValidator(context),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          text: FFLocalizations.of(context).getText(
                            '90d6wzrw' /* Cancel */,
                          ),
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).tertiary,
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
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            if (_model.newPetName != null &&
                                _model.newPetName != '') {
                              try {
                                final result =
                                    await FirebaseFunctions.instanceFor(
                                            region: 'europe-west3')
                                        .httpsCallable('updateLoveBuddyName')
                                        .call({
                                  "relationshipId": valueOrDefault(
                                      currentUserDocument?.relationshipId, ''),
                                  "newName": _model.newPetName,
                                });
                                _model.cloudFunction287 =
                                    UpdateLoveBuddyNameCloudFunctionCallResponse(
                                  data: result.data,
                                  succeeded: true,
                                  resultAsString: result.data.toString(),
                                  jsonBody: result.data,
                                );
                              } on FirebaseFunctionsException catch (error) {
                                _model.cloudFunction287 =
                                    UpdateLoveBuddyNameCloudFunctionCallResponse(
                                  errorCode: error.code,
                                  succeeded: false,
                                );
                              }

                              try {
                                final result = await FirebaseFunctions
                                        .instanceFor(region: 'europe-west3')
                                    .httpsCallable('syncLoveBuddyWidgetState')
                                    .call({
                                  "relationshipId": valueOrDefault(
                                      currentUserDocument?.relationshipId, ''),
                                });
                                _model.cloudFunctionqgo =
                                    SyncLoveBuddyWidgetStateCloudFunctionCallResponse(
                                  succeeded: true,
                                );
                              } on FirebaseFunctionsException catch (error) {
                                _model.cloudFunctionqgo =
                                    SyncLoveBuddyWidgetStateCloudFunctionCallResponse(
                                  errorCode: error.code,
                                  succeeded: false,
                                );
                              }

                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    FFLocalizations.of(context).getVariableText(
                                      enText:
                                          'Companion name updated successfully',
                                      deText:
                                          'Name des Begleiters erfolgreich aktualisiert',
                                      esText:
                                          'Nombre del compañero actualizado correctamente',
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
                            }

                            safeSetState(() {});
                          },
                          text: FFLocalizations.of(context).getText(
                            'n6r725jk' /* Save */,
                          ),
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
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
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ].divide(SizedBox(width: 16.0)),
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 24.0)),
            ),
          ),
        ),
      ),
    );
  }
}
