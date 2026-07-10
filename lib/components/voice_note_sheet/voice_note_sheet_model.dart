import '/flutter_flow/flutter_flow_util.dart';
import 'voice_note_sheet_widget.dart' show VoiceNoteSheetWidget;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';

class VoiceNoteSheetModel extends FlutterFlowModel<VoiceNoteSheetWidget> {
  ///  Local state fields for this component.

  bool? isRecording = false;

  String? recordedAudioPath = '\'\'';

  String? recordedAudioUrl = '\'\'';

  int? recordDurationMs = 0;

  String? voiceTitle = '\'\'';

  bool? hasRecording = false;

  int? recordStartedAtMs = 0;

  String? generatedVoiceFileName;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  AudioRecorder? audioRecorder;
  String? recordedVoiceFile;
  FFUploadedFile recordedFileBytes =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  AudioPlayer? soundPlayer;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  String? _textControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'ww7ts9or' /* Give this voice note a little ... */,
      );
    }

    return null;
  }

  // Stores action output result for [Custom Action - getDownloadUrl] action in Container widget.
  String? voiceNoteDownloadUrl;

  @override
  void initState(BuildContext context) {
    textControllerValidator = _textControllerValidator;
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
