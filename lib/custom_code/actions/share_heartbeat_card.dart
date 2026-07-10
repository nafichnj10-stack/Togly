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
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';

Future shareHeartbeatCard(
  BuildContext context,
  String? titleText,
  String? partner1Name,
  String? partner2Name,
  String? partner1ImageUrl,
  String? partner2ImageUrl,
  String? dateText,
  double? scorePercent,
  String? connectionLabel,
  String? insightText,
  String? ctaText,
  String? brandText,
  String? shareText,
  String? shareSubject,
) async {
  try {
    final screenshotController = ScreenshotController();

    final safeTitleText = (titleText != null && titleText.trim().isNotEmpty)
        ? titleText.trim()
        : 'Our Heartbeat Today';

    final safePartner1Name =
        (partner1Name != null && partner1Name.trim().isNotEmpty)
            ? partner1Name.trim()
            : 'You';

    final safePartner2Name =
        (partner2Name != null && partner2Name.trim().isNotEmpty)
            ? partner2Name.trim()
            : 'Partner';

    final safePartner1ImageUrl =
        (partner1ImageUrl != null && partner1ImageUrl.trim().isNotEmpty)
            ? partner1ImageUrl.trim()
            : '';

    final safePartner2ImageUrl =
        (partner2ImageUrl != null && partner2ImageUrl.trim().isNotEmpty)
            ? partner2ImageUrl.trim()
            : '';

    final safeDateText =
        (dateText != null && dateText.trim().isNotEmpty) ? dateText.trim() : '';

    final safeScorePercent = (scorePercent ?? 0).round().clamp(0, 100);

    final safeConnectionLabel =
        (connectionLabel != null && connectionLabel.trim().isNotEmpty)
            ? connectionLabel.trim()
            : 'Connected';

    final safeInsightText =
        (insightText != null && insightText.trim().isNotEmpty)
            ? insightText.trim()
            : 'Your heartbeat is ready.';

    final safeCtaText = (ctaText != null && ctaText.trim().isNotEmpty)
        ? ctaText.trim()
        : 'Check your heartbeat together on Togly';

    final safeBrandText = (brandText != null && brandText.trim().isNotEmpty)
        ? brandText.trim()
        : 'TOGLY – Couple App';

    final safeShareText = (shareText != null && shareText.trim().isNotEmpty)
        ? shareText.trim()
        : 'Check our relationship heartbeat on Togly ❤️';

    final safeShareSubject =
        (shareSubject != null && shareSubject.trim().isNotEmpty)
            ? shareSubject.trim()
            : 'Our Heartbeat Today';

    String initialsFromName(String value) {
      final parts = value
          .trim()
          .split(RegExp(r'\s+'))
          .where((e) => e.isNotEmpty)
          .toList();

      if (parts.isEmpty) return '?';
      if (parts.length == 1) {
        return parts.first.substring(0, 1).toUpperCase();
      }
      return (parts[0].substring(0, 1) + parts[1].substring(0, 1))
          .toUpperCase();
    }

    Widget buildAvatar(String imageUrl, String fallbackName) {
      final hasImage = imageUrl.isNotEmpty;

      return Container(
        width: 112,
        height: 112,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33FF5FA2),
              blurRadius: 16,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipOval(
          child: hasImage
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Text(
                        initialsFromName(fallbackName),
                        style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF8D4BD9),
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text(
                    initialsFromName(fallbackName),
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8D4BD9),
                    ),
                  ),
                ),
        ),
      );
    }

    List<Widget> buildHearts(int percent) {
      int filledCount = 1;

      if (percent >= 90) {
        filledCount = 5;
      } else if (percent >= 75) {
        filledCount = 4;
      } else if (percent >= 60) {
        filledCount = 3;
      } else if (percent >= 40) {
        filledCount = 2;
      }

      return List.generate(5, (index) {
        final isFilled = index < filledCount;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(
            Icons.favorite,
            size: 18,
            color: isFilled ? const Color(0xFFFF5A9A) : const Color(0xFF8C78C9),
          ),
        );
      });
    }

    final shareCard = Material(
      color: Colors.transparent,
      child: Container(
        width: 1080,
        height: 1920,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE9F0FF),
              Color(0xFFDCCCF8),
              Color(0xFFF4C7E1),
              Color(0xFFF8D5E5),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 40,
              top: 210,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0x22FFFFFF),
                  border: Border.all(color: const Color(0x14FFFFFF)),
                ),
              ),
            ),
            Positioned(
              right: 70,
              top: 120,
              child: Icon(
                Icons.auto_awesome,
                color: Colors.white.withOpacity(0.5),
                size: 34,
              ),
            ),
            Positioned(
              left: 70,
              bottom: 320,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0x18FF8FC3),
                  border: Border.all(color: const Color(0x14FFFFFF)),
                ),
              ),
            ),
            Positioned(
              right: 55,
              bottom: 240,
              child: Container(
                width: 190,
                height: 190,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0x14FFFFFF),
                  border: Border.all(color: const Color(0x14FFFFFF)),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(70, 70, 70, 70),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFFF5BB1),
                                Color(0xFFB34DFF),
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 18),
                        Flexible(
                          child: Text(
                            safeBrandText,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF8A47A8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 54),
                    Text(
                      safeTitleText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 66,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF6B3387),
                        height: 1.05,
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (safeDateText.isNotEmpty)
                      Text(
                        safeDateText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFF7FAFF),
                        ),
                      ),
                    const SizedBox(height: 72),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(40, 42, 40, 34),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color(0x22FFFFFF),
                        border: Border.all(
                          color: const Color(0x33FFFFFF),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 220,
                            child: Column(
                              children: [
                                buildAvatar(
                                  safePartner1ImageUrl,
                                  safePartner1Name,
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  safePartner1Name,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF8A47A8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 94,
                            height: 94,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFFF6AB6),
                                  Color(0xFFFF4D8D),
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 46,
                            ),
                          ),
                          SizedBox(
                            width: 220,
                            child: Column(
                              children: [
                                buildAvatar(
                                  safePartner2ImageUrl,
                                  safePartner2Name,
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  safePartner2Name,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF8A47A8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 84),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(44, 56, 44, 60),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(46),
                        color: const Color(0x22FFFFFF),
                        border: Border.all(
                          color: const Color(0x33FFFFFF),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 520,
                            height: 520,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFFDE7F0),
                                  Color(0xFFF9DDEB),
                                ],
                              ),
                              border: Border.all(
                                color: const Color(0xFFF7A6C6),
                                width: 8,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x26FF5A9A),
                                  blurRadius: 34,
                                  spreadRadius: 6,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Container(
                                width: 440,
                                height: 440,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '$safeScorePercent%',
                                      style: const TextStyle(
                                        fontSize: 92,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFFFF3C93),
                                        height: 1.0,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 36,
                                      ),
                                      child: Text(
                                        safeConnectionLabel,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF8C3DA7),
                                          height: 1.25,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 22),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: buildHearts(safeScorePercent),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 56),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 42,
                              vertical: 34,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.92),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              safeInsightText,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF9A77B6),
                                height: 1.45,
                              ),
                            ),
                          ),
                          const SizedBox(height: 48),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 36,
                              vertical: 30,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(36),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF8B63FF),
                                  Color(0xFFFF3C93),
                                ],
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x2EFF4C98),
                                  blurRadius: 22,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Text(
                              safeCtaText,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'togly.app',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF8C63A8).withOpacity(0.85),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final Uint8List imageBytes = await screenshotController.captureFromWidget(
      InheritedTheme.captureAll(
        context,
        MediaQuery(
          data: MediaQuery.of(context),
          child: Directionality(
            textDirection: Directionality.of(context),
            child: shareCard,
          ),
        ),
      ),
      delay: const Duration(milliseconds: 300),
      pixelRatio: 2.0,
    );

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/heartbeat_share_card.png');
    await file.writeAsBytes(imageBytes, flush: true);

    await Share.shareXFiles(
      [XFile(file.path)],
      text: safeShareText,
      subject: safeShareSubject,
    );
  } catch (e) {
    debugPrint('shareHeartbeatCard error: $e');
  }
}
