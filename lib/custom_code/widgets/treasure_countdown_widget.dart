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

class TreasureCountdownWidget extends StatefulWidget {
  const TreasureCountdownWidget({
    super.key,
    this.width,
    this.height,
    this.unlockAtMs,
    this.languageCode,
  });

  final double? width;
  final double? height;
  final int? unlockAtMs;
  final String? languageCode;

  @override
  State<TreasureCountdownWidget> createState() =>
      _TreasureCountdownWidgetState();
}

class _TreasureCountdownWidgetState extends State<TreasureCountdownWidget> {
  Timer? _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant TreasureCountdownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.unlockAtMs != widget.unlockAtMs ||
        oldWidget.languageCode != widget.languageCode) {
      _now = DateTime.now();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
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

  _CountdownParts _getParts() {
    final unlockAtMs = widget.unlockAtMs;

    if (unlockAtMs == null || unlockAtMs <= 0) {
      return const _CountdownParts(
        days: 0,
        hours: 0,
        minutes: 0,
        seconds: 0,
      );
    }

    final unlockAt = DateTime.fromMillisecondsSinceEpoch(unlockAtMs);
    Duration diff = unlockAt.difference(_now);

    if (diff.isNegative) {
      diff = Duration.zero;
    }

    return _CountdownParts(
      days: diff.inDays,
      hours: diff.inHours % 24,
      minutes: diff.inMinutes % 60,
      seconds: diff.inSeconds % 60,
    );
  }

  String _twoDigits(int value) => value.toString().padLeft(2, '0');

  String _getDaysLabel(int days, String? languageCode) {
    final lang = (languageCode ?? 'en').toLowerCase().trim();

    if (lang.startsWith('de')) {
      return days == 1 ? 'Tag' : 'Tage';
    }

    if (lang.startsWith('es')) {
      return days == 1 ? 'día' : 'días';
    }

    return days == 1 ? 'day' : 'days';
  }

  @override
  Widget build(BuildContext context) {
    final parts = _getParts();
    final width = widget.width ?? double.infinity;
    final height = widget.height;

    final daysLabel = _getDaysLabel(parts.days, widget.languageCode);
    final timeText =
        '${_twoDigits(parts.hours)}:${_twoDigits(parts.minutes)}:${_twoDigits(parts.seconds)}';

    final bigFontSize = width < 260 ? 30.0 : 38.0;
    final timeFontSize = width < 260 ? 24.0 : 30.0;

    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.98, end: 1.0).animate(animation),
                child: child,
              ),
            );
          },
          child: Column(
            key: ValueKey(
              '${parts.days}-${parts.hours}-${parts.minutes}-${parts.seconds}-${widget.languageCode}',
            ),
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${parts.days} $daysLabel',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: bigFontSize,
                  fontWeight: FontWeight.w800,
                  height: 1.0,
                  shadows: const [
                    Shadow(
                      color: Color(0x33000000),
                      blurRadius: 14,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0x26FFFFFF),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0x33FFFFFF),
                    width: 1.2,
                  ),
                ),
                child: Text(
                  timeText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: timeFontSize,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    height: 1.0,
                    shadows: const [
                      Shadow(
                        color: Color(0x22000000),
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
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

class _CountdownParts {
  const _CountdownParts({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  final int days;
  final int hours;
  final int minutes;
  final int seconds;
}
// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
