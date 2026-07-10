// Automatic FlutterFlow imports
import '/backend/backend.dart';
import "package:firebase_storagelibrary_2sa6k9/backend/schema/structs/index.dart"
    as firebase_storagelibrary_2sa6k9_data_schema;
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import "package:firebase_storagelibrary_2sa6k9/backend/schema/structs/index.dart"
    as firebase_storagelibrary_2sa6k9_data_schema;
import "package:firebase_storagelibrary_2sa6k9/backend/schema/enums/enums.dart"
    as firebase_storagelibrary_2sa6k9_enums;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:math' as math;

class RecordingTimerWidget extends StatefulWidget {
  const RecordingTimerWidget({
    super.key,
    this.width,
    this.height,
    this.isRecording = false,
    this.recordStartedAtMs,
    this.stoppedDurationMs,
    this.languageCode,
  });

  final double? width;
  final double? height;
  final bool isRecording;
  final int? recordStartedAtMs;
  final int? stoppedDurationMs;
  final String? languageCode;

  @override
  State<RecordingTimerWidget> createState() => _RecordingTimerWidgetState();
}

class _RecordingTimerWidgetState extends State<RecordingTimerWidget> {
  Timer? _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _handleTimer();
  }

  @override
  void didUpdateWidget(covariant RecordingTimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isRecording != widget.isRecording ||
        oldWidget.recordStartedAtMs != widget.recordStartedAtMs ||
        oldWidget.stoppedDurationMs != widget.stoppedDurationMs) {
      _handleTimer();
      setState(() {
        _now = DateTime.now();
      });
    }
  }

  void _handleTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(milliseconds: 250), (_) {
      if (!mounted) return;
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  int _getElapsedMs() {
    if (widget.isRecording) {
      final startedAt = widget.recordStartedAtMs;
      if (startedAt == null || startedAt <= 0) return 0;
      final diff = _now.millisecondsSinceEpoch - startedAt;
      return diff < 0 ? 0 : diff;
    }

    return widget.stoppedDurationMs ?? 0;
  }

  String _twoDigits(int value) => value.toString().padLeft(2, '0');

  String _formatTime(int ms) {
    final totalSeconds = (ms / 1000).floor();
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${_twoDigits(minutes)}:${_twoDigits(seconds)}';
  }

  List<double> _buildBarHeights() {
    if (!widget.isRecording) {
      return [4, 4, 4, 4, 4, 4, 4];
    }

    final t = _now.millisecondsSinceEpoch / 220.0;
    return List.generate(7, (index) {
      final phase = t + (index * 0.9);
      final value = (math.sin(phase) + 1) / 2; // 0..1
      return 4 + (value * 12); // 4..16
    });
  }

  @override
  Widget build(BuildContext context) {
    final elapsedMs = _getElapsedMs();
    final timeText = _formatTime(elapsedMs);
    final barHeights = _buildBarHeights();

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: Text(
                timeText,
                key: ValueKey('${widget.isRecording}-$timeText'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF7C4C7C),
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  height: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 16,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(barHeights.length, (index) {
                  final h = barHeights[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeInOut,
                      width: 4,
                      height: h,
                      decoration: BoxDecoration(
                        gradient: widget.isRecording
                            ? const LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Color(0xFFB06AC8),
                                  Color(0xFFF2A7BE),
                                ],
                              )
                            : null,
                        color:
                            widget.isRecording ? null : const Color(0xFFCFA7D0),
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: widget.isRecording
                            ? const [
                                BoxShadow(
                                  color: Color(0x33D98FB0),
                                  blurRadius: 6,
                                  spreadRadius: 0.5,
                                ),
                              ]
                            : null,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
