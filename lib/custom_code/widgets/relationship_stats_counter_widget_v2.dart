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

import 'dart:ui';
import 'dart:math' as math;

class RelationshipStatsCounterWidgetV2 extends StatelessWidget {
  const RelationshipStatsCounterWidgetV2({
    super.key,
    this.width,
    this.height,
    required this.togetherText,
    required this.milesText,
    this.countdownText,
    required this.appLanguage,
    this.togetherSinceConflict,
    this.loveBuddyCurrentDistanceKm,
  });

  final double? width;
  final double? height;

  final String togetherText;
  final String milesText;
  final String? countdownText;
  final String appLanguage;
  final bool? togetherSinceConflict;

  /// Add this parameter in FlutterFlow:
  /// loveBuddyCurrentDistanceKm → Double → Nullable
  final double? loveBuddyCurrentDistanceKm;

  String _normalizeLang(String raw) {
    var lang = raw.toLowerCase().trim();
    if (lang.contains('-')) lang = lang.split('-').first;
    if (lang.contains('_')) lang = lang.split('_').first;
    if (lang == 'de' || lang == 'en' || lang == 'es') return lang;
    return 'en';
  }

  String _t({
    required String en,
    required String de,
    required String es,
  }) {
    final l = _normalizeLang(appLanguage);
    if (l == 'de') return de;
    if (l == 'es') return es;
    return en;
  }

  String _formatDistanceKm(double km) {
    if (km < 1) {
      return _t(
        en: 'Very close',
        de: 'Ganz nah',
        es: 'Muy cerca',
      );
    }

    final rounded = km.round();
    final lang = _normalizeLang(appLanguage);
    final raw = rounded.toString();

    final buffer = StringBuffer();
    for (int i = 0; i < raw.length; i++) {
      final positionFromEnd = raw.length - i;
      buffer.write(raw[i]);
      if (positionFromEnd > 1 && positionFromEnd % 3 == 1) {
        buffer.write(lang == 'en' ? ',' : '.');
      }
    }

    return '${buffer.toString()} km';
  }

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
          style: TextStyle(
            fontSize: fs,
            fontWeight: weight,
            letterSpacing: -0.18,
          ),
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
    final w = width ?? double.infinity;

    final showCountdown =
        (countdownText != null && countdownText!.trim().isNotEmpty);

    final showDistance = loveBuddyCurrentDistanceKm != null;

    final bool hasConflict = (togetherSinceConflict ?? false);

    final double computedH = height ??
        (74 +
            (showDistance ? 86 : 0) +
            (hasConflict ? 64 : 0) +
            (showCountdown ? 92 : 0));

    final glassFill = Colors.white.withOpacity(0.10);
    final glassStroke = Colors.white.withOpacity(0.22);

    final togetherTitle = _t(
      en: 'Together since',
      de: 'Zusammen seit',
      es: 'Juntos desde',
    );

    final timeTitle = _t(
      en: 'Time between you',
      de: 'Zeit zwischen euch',
      es: 'Tiempo entre ustedes',
    );

    final distanceTitle = _t(
      en: 'Distance between you',
      de: 'Distanz zwischen euch',
      es: 'Distancia entre ustedes',
    );

    final countdownTitle = _t(
      en: 'Next meeting',
      de: 'Nächstes Treffen',
      es: 'Próximo encuentro',
    );

    final distanceText =
        showDistance ? _formatDistanceKm(loveBuddyCurrentDistanceKm!) : '';

    return SizedBox(
      width: w,
      height: computedH,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: _MiniStatCard(
                  title: togetherTitle,
                  icon: Icons.favorite,
                  value: togetherText,
                  fitValueFont: (maxWidth) => _fitFontSize(
                    context: context,
                    text: togetherText,
                    maxWidth: maxWidth,
                    maxFont: 16,
                    minFont: 12,
                    weight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MiniStatCard(
                  title: timeTitle,
                  icon: Icons.schedule,
                  value: milesText,
                  fitValueFont: (maxWidth) => _fitFontSize(
                    context: context,
                    text: milesText,
                    maxWidth: maxWidth,
                    maxFont: 16,
                    minFont: 12,
                    weight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          if (showDistance) ...[
            const SizedBox(height: 12),
            _DistanceInfoCard(
              title: distanceTitle,
              value: distanceText,
              subtitle: _t(
                en: 'Your Companions feel every kilometer',
                de: 'Eure Begleiter spüren jeden Kilometer',
                es: 'Sus compañeros sienten cada kilómetro',
              ),
              fitValueFont: (maxWidth) => _fitFontSize(
                context: context,
                text: distanceText,
                maxWidth: maxWidth,
                maxFont: 18,
                minFont: 13,
                weight: FontWeight.w900,
              ),
            ),
          ],
          if (hasConflict) ...[
            const SizedBox(height: 10),
            _InfoBanner(
              text: _t(
                en: 'Your dates do not match. Please check “Together since” in your profile settings.',
                de: 'Euer Datum stimmt nicht überein. Bitte prüft „Zusammen seit“ in den Profileinstellungen.',
                es: 'Sus fechas no coinciden. Revisen “Juntos desde” en los ajustes de perfil.',
              ),
            ),
          ],
          if (showCountdown) ...[
            const SizedBox(height: 14),
            _LoveCountdownPill(
              title: countdownTitle,
              text: countdownText!.trim(),
              height: 78,
              maxWidth:
                  (w.isFinite ? w : MediaQuery.sizeOf(context).width) * 0.92,
              glassFill: glassFill,
              glassStroke: glassStroke,
              fitFont: (maxWidth) => _fitFontSize(
                context: context,
                text: countdownText!.trim(),
                maxWidth: maxWidth,
                maxFont: 16,
                minFont: 12,
                weight: FontWeight.w900,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  const _MiniStatCard({
    required this.title,
    required this.icon,
    required this.value,
    required this.fitValueFont,
  });

  final String title;
  final IconData icon;
  final String value;
  final double Function(double maxWidth) fitValueFont;

  double _fitTitleFont(BuildContext context, String text, double maxW) {
    final dir = Directionality.of(context);
    for (double fs = 14; fs >= 10; fs -= 0.5) {
      final tp = TextPainter(
        text: TextSpan(text: text, style: TextStyle(fontSize: fs)),
        maxLines: 1,
        textDirection: dir,
        ellipsis: '…',
      )..layout(maxWidth: maxW);
      if (!tp.didExceedMaxLines) return fs;
    }
    return 10;
  }

  @override
  Widget build(BuildContext context) {
    final bg = Colors.white.withOpacity(0.10);
    final stroke = Colors.white.withOpacity(0.20);

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: stroke, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LayoutBuilder(
                builder: (context, c) {
                  final fs = _fitTitleFont(context, title, c.maxWidth - 8);
                  return Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fs,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withOpacity(0.70),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 18, color: Colors.white.withOpacity(0.92)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, c) {
                        final fs = fitValueFont(c.maxWidth - 6);
                        return Text(
                          value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: fs,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.2,
                            color: Colors.white.withOpacity(0.92),
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.28),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DistanceInfoCard extends StatelessWidget {
  const _DistanceInfoCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.fitValueFont,
  });

  final String title;
  final String value;
  final String subtitle;
  final double Function(double maxWidth) fitValueFont;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.11),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.22),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.11),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.22),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.public_rounded,
                  size: 22,
                  color: Colors.white.withOpacity(0.94),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withOpacity(0.70),
                      ),
                    ),
                    const SizedBox(height: 4),
                    LayoutBuilder(
                      builder: (context, c) {
                        final fs = fitValueFont(c.maxWidth);
                        return Text(
                          value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: fs,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.25,
                            color: Colors.white.withOpacity(0.96),
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.24),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.62),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoveCountdownPill extends StatefulWidget {
  const _LoveCountdownPill({
    required this.title,
    required this.text,
    required this.height,
    required this.maxWidth,
    required this.glassFill,
    required this.glassStroke,
    required this.fitFont,
  });

  final String title;
  final String text;
  final double height;
  final double maxWidth;
  final Color glassFill;
  final Color glassStroke;
  final double Function(double maxWidth) fitFont;

  @override
  State<_LoveCountdownPill> createState() => _LoveCountdownPillState();
}

class _LoveCountdownPillState extends State<_LoveCountdownPill>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  double _fitTitleFont(BuildContext context, String text, double maxW) {
    final dir = Directionality.of(context);
    for (double fs = 13; fs >= 10; fs -= 0.5) {
      final tp = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            fontSize: fs,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.05,
          ),
        ),
        maxLines: 1,
        textDirection: dir,
        ellipsis: '…',
      )..layout(maxWidth: maxW);

      if (!tp.didExceedMaxLines) return fs;
    }
    return 10;
  }

  @override
  Widget build(BuildContext context) {
    final t = _c.value;

    final pulse = 1.0 + math.sin(t * 2 * math.pi) * 0.008;

    final gradA = Colors.white.withOpacity(0.14);
    final gradB = const Color(0xFFFFA6C9).withOpacity(0.07);

    final glowA = const Color(0xFFB9A6FF).withOpacity(0.16 + (pulse - 1) * 6);
    final glowB = const Color(0xFFFFA6C9).withOpacity(0.12 + (pulse - 1) * 5);

    const iconSize = 40.0;
    const leftPad = 14.0;
    const gap = 12.0;
    final sideTextPadding = leftPad + iconSize + gap + 8;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: widget.maxWidth),
      child: Transform.scale(
        scale: pulse,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: [
                      BoxShadow(
                        color: glowA,
                        blurRadius: 42,
                        offset: const Offset(0, 16),
                      ),
                      BoxShadow(
                        color: glowB,
                        blurRadius: 48,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: Container(
                  height: widget.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: widget.glassStroke, width: 1),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [gradA, gradB],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: -18,
                        top: -24,
                        child: _SoftBlob(
                          size: 110,
                          color: Colors.white.withOpacity(0.09),
                        ),
                      ),
                      Positioned(
                        right: -26,
                        bottom: -30,
                        child: _SoftBlob(
                          size: 135,
                          color: Colors.white.withOpacity(0.06),
                        ),
                      ),
                      _SparkleParticleSin(
                        t: t,
                        x: 0.46,
                        y: 0.22,
                        size: 8,
                        phase: 0.0,
                      ),
                      _SparkleParticleSin(
                        t: t,
                        x: 0.54,
                        y: 0.20,
                        size: 7,
                        phase: 0.5,
                      ),
                      Positioned(
                        left: leftPad,
                        top: (widget.height - iconSize) / 2,
                        child: Container(
                          width: iconSize,
                          height: iconSize,
                          decoration: BoxDecoration(
                            color: widget.glassFill,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.22),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            Icons.location_on_rounded,
                            size: 20,
                            color: Colors.white.withOpacity(0.92),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: sideTextPadding,
                            right: sideTextPadding,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LayoutBuilder(
                                builder: (context, c) {
                                  final titleFs = _fitTitleFont(
                                    context,
                                    widget.title,
                                    c.maxWidth,
                                  );
                                  return Text(
                                    widget.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: titleFs,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white.withOpacity(0.72),
                                      letterSpacing: -0.05,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 5),
                              LayoutBuilder(
                                builder: (context, c) {
                                  final fs = widget.fitFont(c.maxWidth);
                                  return Transform.translate(
                                    offset: const Offset(2, 0),
                                    child: Text(
                                      widget.text,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      softWrap: false,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: fs,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: -0.22,
                                        color: Colors.white.withOpacity(0.97),
                                        shadows: [
                                          Shadow(
                                            color:
                                                Colors.black.withOpacity(0.18),
                                            blurRadius: 12,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SparkleParticleSin extends StatelessWidget {
  const _SparkleParticleSin({
    required this.t,
    required this.x,
    required this.y,
    required this.size,
    required this.phase,
  });

  final double t;
  final double x;
  final double y;
  final double size;
  final double phase;

  @override
  Widget build(BuildContext context) {
    final s = math.sin((t + phase) * 2 * math.pi);
    final opacity = (0.05 + 0.10 * (0.5 + 0.5 * s)).clamp(0.0, 0.15);
    final floatY = math.sin((t + phase) * 2 * math.pi) * 6.0;
    final driftX = math.sin((t + phase) * 2 * math.pi) * 2.0;

    return Positioned.fill(
      child: IgnorePointer(
        child: FractionallySizedBox(
          alignment: Alignment(x * 2 - 1, y * 2 - 1),
          child: Transform.translate(
            offset: Offset(driftX, -floatY),
            child: Opacity(
              opacity: opacity,
              child: Icon(
                Icons.auto_awesome,
                size: size,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SoftBlob extends StatelessWidget {
  const _SoftBlob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final fill = const Color(0xFFFFD66E).withOpacity(0.18);
    final stroke = const Color(0xFFFFD66E).withOpacity(0.55);

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: fill,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: stroke, width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                size: 18,
                color: const Color(0xFFFFD66E).withOpacity(0.95),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.25,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withOpacity(0.92),
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
