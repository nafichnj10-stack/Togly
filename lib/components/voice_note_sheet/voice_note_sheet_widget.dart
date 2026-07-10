import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import 'package:firebase_storagelibrary_2sa6k9/custom_code/actions/index.dart'
    as firebase_storagelibrary_2sa6k9_actions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'voice_note_sheet_model.dart';
export 'voice_note_sheet_model.dart';

/// Create a romantic mobile bottom sheet for a couples app feature called
/// “Voice Note” inside a feature named “Love Treasure”.
///
/// This bottom sheet should be used after the user taps “Voice Note” from an
/// “Add a Surprise” sheet. The purpose is to let the user record a voice
/// message for their partner to place inside a Love Treasure.
///
/// The visual style must feel dreamy, intimate, magical, modern, and
/// emotionally premium. It should match a romantic app with soft pink,
/// purple, blush, lilac, and subtle golden tones. The bottom sheet should
/// feel elegant, warm, and slightly glowing, with a glassmorphism /
/// frosted-glass aesthetic.
///
/// Overall layout:
/// - Mobile bottom sheet
/// - Rounded top corners with a large radius
/// - Soft blurred translucent background
/// - Gentle shadow and layered depth
/// - Medium-to-large sheet height
/// - Spacious and clean
/// - Premium romantic look
///
/// Top section:
/// - Small centered drag handle
/// - Title: “Voice Note”
/// - Subtitle: “Record something your partner can keep forever 💜”
/// - The subtitle should feel emotional, soft, and intimate
///
/// Main content:
/// Design a centered recording area that feels special and emotionally
/// important.
///
/// Include:
/// - A large circular microphone button in the center
/// - The microphone button should feel like the main focus
/// - Use a romantic pink-purple gradient for the record button
/// - Add a soft outer glow around the microphone button
/// - Include a subtle pulse effect suggestion in the UI design
/// - Under the button, show helper text:
///   “Tap to start recording”
///
/// Below that, include a timer area:
/// - Show a live-style timer placeholder like “00:00”
/// - Place it clearly under the main record button
/// - Use large elegant text styling
/// - The timer should feel softly highlighted
///
/// Below the timer, include 3 secondary action buttons in a horizontal or
/// clean stacked arrangement:
/// - Record / Start
/// - Stop
/// - Play Preview
///
/// These buttons should:
/// - Feel soft and elegant
/// - Use glassmorphism or lightly filled rounded buttons
/// - Clearly show different states
/// - Not overpower the main microphone button
///
/// Lower section:
/// - Add a text input or optional title input with label:
///   “Optional title”
/// - Placeholder:
///   “Give this voice note a little title...”
/// - Keep it soft and minimal
///
/// Bottom action area:
/// Include a primary save button:
/// - Text: “Save to Treasure”
/// - This should be the main CTA
/// - Use a strong romantic pink gradient
/// - Rounded pill shape
/// - Premium, polished, glowing
///
/// Also include a smaller secondary text button:
/// - “Cancel”
///
/// Visual style details:
/// - White or near-white primary text
/// - Pale blush / soft lavender secondary text
/// - Soft shadows
/// - High-end romantic app feel
/// - A magical but clean design
/// - Modern premium mobile UI
/// - No clutter
/// - No harsh borders
/// - No generic dark theme
///
/// Important emotional goal:
/// The sheet should feel like the user is recording something deeply personal
/// and meaningful for their partner. It should feel memorable, intimate, and
/// worthy of being saved inside a romantic Love Treasure.
class VoiceNoteSheetWidget extends StatefulWidget {
  const VoiceNoteSheetWidget({
    super.key,
    required this.treasureRef,
  });

  final DocumentReference? treasureRef;

  @override
  State<VoiceNoteSheetWidget> createState() => _VoiceNoteSheetWidgetState();
}

class _VoiceNoteSheetWidgetState extends State<VoiceNoteSheetWidget> {
  late VoiceNoteSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VoiceNoteSheetModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF8F0F8),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.0),
            topRight: Radius.circular(32.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(32.0, 8.0, 32.0, 8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      width: 48.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFD4A8C7),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          '1nh6bd27' /* Voice Note */,
                        ),
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .headlineMediumFamily,
                              color: Color(0xFF7B3F6E),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .headlineMediumIsCustom,
                            ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '298iw1t3' /* Record something your partner ... */,
                          ),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                color: Color(0xFFA06080),
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
                              ),
                        ),
                      ),
                    ].divide(SizedBox(height: 6.0)),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFE8D0E0),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(14.0, 0.0, 14.0, 0.0),
                      child: Container(
                        width: 120.0,
                        height: 120.0,
                        child: Stack(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await requestPermission(microphonePermission);
                                await startAudioRecording(
                                  context,
                                  audioRecorder: _model.audioRecorder ??=
                                      AudioRecorder(),
                                );

                                _model.isRecording = true;
                                _model.hasRecording = false;
                                _model.recordDurationMs = 0;
                                _model.recordStartedAtMs =
                                    getCurrentTimestamp.millisecondsSinceEpoch;
                                _model.recordedAudioPath = '\'\'';
                                _model.recordedAudioUrl = '\'\'';
                                safeSetState(() {});
                              },
                              child: Container(
                                width: 130.0,
                                height: 130.0,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 32.0,
                                      color: Color(0x99C06090),
                                      offset: Offset(
                                        0.0,
                                        8.0,
                                      ),
                                      spreadRadius: 0.0,
                                    )
                                  ],
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFFFB6C1),
                                      Color(0xFFC084B0),
                                      Color(0xFF9B59B6)
                                    ],
                                    stops: [0.0, 0.4, 1.0],
                                    begin: AlignmentDirectional(1.0, 1.0),
                                    end: AlignmentDirectional(-1.0, -1.0),
                                  ),
                                  borderRadius: BorderRadius.circular(65.0),
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Icon(
                                  Icons.mic_rounded,
                                  color: Colors.white,
                                  size: 52.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(14.0, 0.0, 14.0, 0.0),
                      child: Container(
                        width: 300.0,
                        height: 75.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFFDF0F8),
                          borderRadius: BorderRadius.circular(24.0),
                          border: Border.all(
                            color: Color(0xFFE8C0D8),
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                color: Color(0xFFC084B0),
                                size: 16.0,
                              ),
                              AuthUserStreamWidget(
                                builder: (context) => Container(
                                  width: 200.0,
                                  height: 50.0,
                                  child: custom_widgets.RecordingTimerWidget(
                                    width: 200.0,
                                    height: 50.0,
                                    isRecording: _model.isRecording!,
                                    recordStartedAtMs: _model.recordStartedAtMs,
                                    stoppedDurationMs: _model.recordDurationMs,
                                    languageCode: valueOrDefault(
                                        currentUserDocument?.appLanguage, ''),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_model.isRecording == true)
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await stopAudioRecording(
                                  audioRecorder: _model.audioRecorder,
                                  audioName: 'recordedFileBytes',
                                  onRecordingComplete:
                                      (audioFilePath, audioBytes) {
                                    _model.recordedVoiceFile = audioFilePath;
                                    _model.recordedFileBytes = audioBytes;
                                  },
                                );

                                _model.isRecording = false;
                                _model.hasRecording = true;
                                _model.recordDurationMs =
                                    functions.calculateRecordingDuration(
                                        _model.recordStartedAtMs!);
                                safeSetState(() {});

                                safeSetState(() {});
                              },
                              child: Container(
                                width: 90.0,
                                height: 44.0,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 12.0,
                                      color: Color(0x44C084B0),
                                      offset: Offset(
                                        0.0,
                                        4.0,
                                      ),
                                      spreadRadius: 0.0,
                                    )
                                  ],
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFF9A8D4),
                                      Color(0xFFC084B0)
                                    ],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(1.0, 1.0),
                                    end: AlignmentDirectional(-1.0, -1.0),
                                  ),
                                  borderRadius: BorderRadius.circular(22.0),
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 12.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.stop,
                                        color: Colors.white,
                                        size: 14.0,
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'weshdnpr' /* Stop */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLargeFamily,
                                              color: Colors.white,
                                              fontSize: 10.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelLargeIsCustom,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 6.0)),
                                  ),
                                ),
                              ),
                            ),
                          if ((_model.isRecording == false) &&
                              (_model.hasRecording == true))
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.soundPlayer ??= AudioPlayer();
                                if (_model.soundPlayer!.playing) {
                                  await _model.soundPlayer!.stop();
                                }
                                _model.soundPlayer!.setVolume(1.0);
                                _model.soundPlayer!
                                    .setUrl(_model.recordedVoiceFile!)
                                    .then((_) => _model.soundPlayer!.play());
                              },
                              child: Container(
                                width: 92.0,
                                height: 46.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFDF0F8),
                                  borderRadius: BorderRadius.circular(22.0),
                                  border: Border.all(
                                    color: Color(0xFFE0B0D0),
                                    width: 1.0,
                                  ),
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 12.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.play_arrow_rounded,
                                        color: Color(0xFFC084B0),
                                        size: 14.0,
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'flbcteqj' /* Preview */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLargeFamily,
                                              color: Color(0xFFC084B0),
                                              fontSize: 10.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelLargeIsCustom,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 6.0)),
                                  ),
                                ),
                              ),
                            ),
                        ].divide(SizedBox(width: 16.0)),
                      ),
                    ),
                  ].divide(SizedBox(height: 20.0)),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFE8D0E0),
                    ),
                  ),
                ),
                Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFFDF0F8),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Color(0xFFE0B0D0),
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 14.0, 16.0, 14.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.edit_note_rounded,
                              color: Color(0xFFC084B0),
                              size: 20.0,
                            ),
                            Expanded(
                              child: Container(
                                width: 200.0,
                                child: TextFormField(
                                  controller: _model.textController,
                                  focusNode: _model.textFieldFocusNode,
                                  autofocus: false,
                                  enabled: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText:
                                        FFLocalizations.of(context).getText(
                                      '5hu1alyf' /* Give this voice note a little ... */,
                                    ),
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
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
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
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  enableInteractiveSelection: true,
                                  validator: _model.textControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(width: 10.0)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(32.0, 16.0, 32.0, 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          if (_model.formKey.currentState == null ||
                              !_model.formKey.currentState!.validate()) {
                            return;
                          }
                          if (_model.recordDurationMs! >= 1000) {
                            _model.generatedVoiceFileName =
                                'vn_${currentUserUid}_${getCurrentTimestamp.millisecondsSinceEpoch.toString()}';
                            safeSetState(() {});
                            await actions.uploadVoiceNoteToBucket(
                              '',
                              'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/love_treasures/${widget.treasureRef?.id}/voice_notes/${_model.generatedVoiceFileName}.m4a',
                              _model.recordedFileBytes,
                            );
                            _model.voiceNoteDownloadUrl =
                                await firebase_storagelibrary_2sa6k9_actions
                                    .getDownloadUrl(
                              '',
                              'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/love_treasures/${widget.treasureRef?.id}/voice_notes/${_model.generatedVoiceFileName}.m4a',
                            );

                            await TreasureSurprisesRecord.collection
                                .doc()
                                .set(createTreasureSurprisesRecordData(
                                  createdBy: currentUserReference,
                                  type: 'voice_note',
                                  title: _model.textController.text,
                                  audioUrl: _model.voiceNoteDownloadUrl,
                                  durationMs: _model.recordDurationMs,
                                  createdAt: getCurrentTimestamp,
                                  revealOrder: 0,
                                  revealed: false,
                                  treasureRef: widget.treasureRef,
                                  createdByUid: currentUserUid,
                                  relationshipId: valueOrDefault(
                                      currentUserDocument?.relationshipId, ''),
                                  storagePath:
                                      'couples/${valueOrDefault(currentUserDocument?.relationshipId, '')}/love_treasures/${widget.treasureRef?.id}/voice_notes/${_model.generatedVoiceFileName}.m4a',
                                  audioPath: functions.stringToAudioPath(
                                      _model.voiceNoteDownloadUrl!),
                                ));
                            Navigator.pop(context);
                            if (valueOrDefault(
                                    currentUserDocument?.appLanguage, '') ==
                                'en') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Voice note has been added',
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
                                    'Sprachnachricht wurde hinzugefügt',
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
                                    'La nota de voz ha sido añadida',
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
                          } else {
                            if (valueOrDefault(
                                    currentUserDocument?.appLanguage, '') ==
                                'en') {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Voice note too short'),
                                    content: Text(
                                        'Please record a voice note of at least 1 second.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (valueOrDefault(
                                    currentUserDocument?.appLanguage, '') ==
                                'de') {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Sprachnachricht zu kurz'),
                                    content: Text(
                                        'Bitte nimm eine Sprachnachricht von mindestens 1 Sekunde auf'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (valueOrDefault(
                                    currentUserDocument?.appLanguage, '') ==
                                'es') {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Nota de voz demasiado corta'),
                                    content: Text(
                                        'Por favor, graba una nota de voz de al menos 1 segundo'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }

                          safeSetState(() {});
                        },
                        child: Container(
                          width: double.infinity,
                          height: 56.0,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 24.0,
                                color: Color(0x55A855F7),
                                offset: Offset(
                                  0.0,
                                  6.0,
                                ),
                                spreadRadius: 0.0,
                              )
                            ],
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFF472B6),
                                Color(0xFFA855F7),
                                Color(0xFF7C3AED)
                              ],
                              stops: [0.0, 0.5, 1.0],
                              begin: AlignmentDirectional(1.0, 1.0),
                              end: AlignmentDirectional(-1.0, -1.0),
                            ),
                            borderRadius: BorderRadius.circular(28.0),
                          ),
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 20.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'uv5jbbxz' /* Put it in the Treasure */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleSmallIsCustom,
                                      ),
                                ),
                              ].divide(SizedBox(width: 10.0)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                        child: Container(
                          width: double.infinity,
                          height: 44.0,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                Navigator.pop(context);
                              },
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  '1wqdrw6v' /* Cancel */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelLargeFamily,
                                      color: Color(0xFFA06080),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .labelLargeIsCustom,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 16.0)),
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
