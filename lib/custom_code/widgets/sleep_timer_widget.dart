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
import 'dart:ui';
import 'package:intl/intl.dart';

class SleepTimerWidget extends StatefulWidget {
  const SleepTimerWidget({
    super.key,
    this.width,
    this.height,
    required this.sleepStartedAt,
    required this.isSleeping,
    this.isMe, // optional; FF may pass null if not bound
  });

  final double? width;
  final double? height;

  final DateTime? sleepStartedAt;
  final bool isSleeping;

  /// true = left bubble tail, false = right bubble tail
  final bool? isMe;

  @override
  State<SleepTimerWidget> createState() => _SleepTimerWidgetState();
}

class _SleepTimerWidgetState extends State<SleepTimerWidget> {
  Timer? _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _setupTimer();
  }

  @override
  void didUpdateWidget(covariant SleepTimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isSleeping != widget.isSleeping ||
        oldWidget.sleepStartedAt != widget.sleepStartedAt) {
      _setupTimer();
      setState(() => _now = DateTime.now());
    }
  }

  void _setupTimer() {
    _timer?.cancel();
    _timer = null;

    if (widget.isSleeping && widget.sleepStartedAt != null) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        setState(() => _now = DateTime.now());
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _langCode(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final code = locale.languageCode.toLowerCase();
    if (code == 'de' || code == 'es' || code == 'en') return code;
    return 'en';
  }

  String _formatStartTime(DateTime dt, String lang) {
    final pattern = (lang == 'en') ? 'h:mm a' : 'HH:mm';
    return DateFormat(pattern).format(dt);
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes;
    if (m <= 0) return '0m';
    if (m < 60) return '${m}m';

    final h = d.inHours;
    final remM = m % 60;
    if (h < 24) return remM == 0 ? '${h}h' : '${h}h ${remM}m';

    final days = d.inDays;
    final remH = h % 24;
    return remH == 0 ? '${days}d' : '${days}d ${remH}h';
  }

  String _sinceLabel(String lang) {
    if (lang == 'de') return 'seit';
    if (lang == 'es') return 'desde';
    return 'since';
  }

  /// Emoji depending on duration / stage
  /// If you want ALWAYS the same emoji, just: return '🛌';
  String _sleepEmoji(Duration d) {
    final minutes = d.inMinutes;
    final hours = d.inHours;

    if (minutes < 5) return '😴';
    if (hours < 1) return '💤';
    if (hours < 4) return '🛌';
    if (hours < 8) return '🌙';
    return '😵‍💫';
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isSleeping || widget.sleepStartedAt == null) {
      return const SizedBox.shrink();
    }

    final lang = _langCode(context);
    final start = widget.sleepStartedAt!;
    final duration = _now.difference(start);

    // ✅ NEW: 2 lines
    // line1 = emoji + since + time
    // line2 = counter only
    final line1 =
        '${_sleepEmoji(duration)} ${_sinceLabel(lang)} ${_formatStartTime(start, lang)}';
    final line2 = _formatDuration(duration);

    final isMe = widget.isMe ?? true;

    return SleepBubbleCuteTail2Lines(
      line1: line1,
      line2: line2,
      width: widget.width,
      height: widget.height,
      isMe: isMe,
      useBlur: true,
    );
  }
}

/// Same cute bubble design, 2 lines.
class SleepBubbleCuteTail2Lines extends StatelessWidget {
  const SleepBubbleCuteTail2Lines({
    super.key,
    required this.line1,
    required this.line2,
    this.width,
    this.height,
    required this.isMe,
    this.useBlur = true,
  });

  final String line1;
  final String line2;

  final double? width;
  final double? height;

  final bool isMe;
  final bool useBlur;

  double _fitFontSize({
    required BuildContext context,
    required String text,
    required double maxWidth,
    required double maxFont,
    required double minFont,
    required FontWeight weight,
  }) {
    final dir = Directionality.of(context);

    for (double fs = maxFont; fs >= minFont; fs -= 0.5) {
      final tp = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(fontSize: fs, fontWeight: weight),
        ),
        maxLines: 1,
        textDirection: dir,
        ellipsis: '…',
      )..layout(maxWidth: maxWidth);

      if (!tp.didExceedMaxLines) return fs;
    }
    return minFont;
  }

  @override
  Widget build(BuildContext context) {
    final w = width ?? 240;
    final bubbleH = height ?? 78;

    final align = isMe ? Alignment.topLeft : Alignment.topRight;

    final gradA = const Color(0xFFD9C6FF).withOpacity(0.78);
    final gradB = const Color(0xFFFFC7DD).withOpacity(0.78);
    final border = Colors.white.withOpacity(0.55);

    Widget bubbleBody = LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth.isFinite ? constraints.maxWidth : w;
        final usableW = (maxW - 28).clamp(140.0, 520.0);

        // line1 is now "emoji + since + time" -> a bit smaller max helps fit
        final s1 = _fitFontSize(
          context: context,
          text: line1,
          maxWidth: usableW,
          maxFont: 12,
          minFont: 10,
          weight: FontWeight.w900,
        );

        // counter only -> can be slightly bigger for readability
        final s2 = _fitFontSize(
          context: context,
          text: line2,
          maxWidth: usableW,
          maxFont: 11,
          minFont: 10,
          weight: FontWeight.w800,
        );

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [gradA, gradB],
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: border, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                line1,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: s1,
                  fontWeight: FontWeight.w900,
                  height: 1.05,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                line2,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: s2,
                  fontWeight: FontWeight.w800,
                  height: 1.05,
                  color: Colors.black.withOpacity(0.78),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (useBlur) {
      bubbleBody = ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: bubbleBody,
        ),
      );
    }

    return SizedBox(
      width: w,
      height: bubbleH + 22,
      child: Align(
        alignment: align,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(width: w, height: bubbleH, child: bubbleBody),
            Positioned(
              top: bubbleH - 4,
              left: isMe ? 18 : null,
              right: isMe ? null : 18,
              child: _BubbleTailDots(
                left: isMe,
                dotFillA: gradA,
                dotFillB: gradB,
                border: border,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BubbleTailDots extends StatelessWidget {
  const _BubbleTailDots({
    required this.left,
    required this.dotFillA,
    required this.dotFillB,
    required this.border,
  });

  final bool left;
  final Color dotFillA;
  final Color dotFillB;
  final Color border;

  @override
  Widget build(BuildContext context) {
    final dots = SizedBox(
      width: 44,
      height: 22,
      child: Stack(
        children: [
          Positioned(left: 0, top: 2, child: _dot(9)),
          Positioned(left: 14, top: 10, child: _dot(7)),
          Positioned(left: 26, top: 16, child: _dot(6)),
        ],
      ),
    );

    return IgnorePointer(
      child: left
          ? dots
          : Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(-1.0, 1.0),
              child: dots,
            ),
    );
  }

  Widget _dot(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            dotFillA.withOpacity(0.85),
            dotFillB.withOpacity(0.85),
          ],
        ),
        border: Border.all(color: border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
    );
  }
}
