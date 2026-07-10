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

import '/custom_code/widgets/index.dart';
import '/custom_code/actions/index.dart';

import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';

class HeartbeatShareSheetWidget extends StatefulWidget {
  const HeartbeatShareSheetWidget({
    super.key,
    this.width,
    this.height,
    this.titleText,
    this.partner1Name,
    this.partner2Name,
    this.partner1ImagePath,
    this.partner2ImagePath,
    this.dateText,
    this.scorePercent,
    this.connectionLabel,
    this.insightText,
    this.ctaText,
    this.brandText,
    this.shareText,
    this.shareSubject,
    this.shareButtonText,
    this.urlText,
  });

  final double? width;
  final double? height;

  final String? titleText;
  final String? partner1Name;
  final String? partner2Name;
  final String? partner1ImagePath;
  final String? partner2ImagePath;
  final String? dateText;
  final double? scorePercent;
  final String? connectionLabel;
  final String? insightText;
  final String? ctaText;
  final String? brandText;
  final String? shareText;
  final String? shareSubject;
  final String? shareButtonText;
  final String? urlText;

  @override
  State<HeartbeatShareSheetWidget> createState() =>
      _HeartbeatShareSheetWidgetState();
}

class _HeartbeatShareSheetWidgetState extends State<HeartbeatShareSheetWidget> {
  final ScreenshotController _screenshotController = ScreenshotController();
  bool _isSharing = false;

  static const double _exportWidth = 360;
  static const double _exportHeight = 640;

  String get _titleText =>
      (widget.titleText != null && widget.titleText!.trim().isNotEmpty)
          ? widget.titleText!.trim()
          : 'Our Heartbeat Today';

  String get _partner1Name =>
      (widget.partner1Name != null && widget.partner1Name!.trim().isNotEmpty)
          ? widget.partner1Name!.trim()
          : 'You';

  String get _partner2Name =>
      (widget.partner2Name != null && widget.partner2Name!.trim().isNotEmpty)
          ? widget.partner2Name!.trim()
          : 'Partner';

  String get _partner1ImagePath => (widget.partner1ImagePath != null &&
          widget.partner1ImagePath!.trim().isNotEmpty)
      ? widget.partner1ImagePath!.trim()
      : '';

  String get _partner2ImagePath => (widget.partner2ImagePath != null &&
          widget.partner2ImagePath!.trim().isNotEmpty)
      ? widget.partner2ImagePath!.trim()
      : '';

  String get _dateText =>
      (widget.dateText != null && widget.dateText!.trim().isNotEmpty)
          ? widget.dateText!.trim()
          : '';

  int get _scorePercent => (widget.scorePercent ?? 0).round().clamp(0, 100);

  String get _connectionLabel => (widget.connectionLabel != null &&
          widget.connectionLabel!.trim().isNotEmpty)
      ? widget.connectionLabel!.trim()
      : 'Connected';

  String get _insightText =>
      (widget.insightText != null && widget.insightText!.trim().isNotEmpty)
          ? widget.insightText!.trim()
          : 'Your heartbeat is ready.';

  String get _ctaText =>
      (widget.ctaText != null && widget.ctaText!.trim().isNotEmpty)
          ? widget.ctaText!.trim()
          : 'Check your heartbeat together on Togly';

  String get _brandText =>
      (widget.brandText != null && widget.brandText!.trim().isNotEmpty)
          ? widget.brandText!.trim()
          : 'TOGLY – Couple App';

  String get _shareText =>
      (widget.shareText != null && widget.shareText!.trim().isNotEmpty)
          ? widget.shareText!.trim()
          : 'Check our relationship heartbeat on Togly ❤️';

  String get _shareSubject =>
      (widget.shareSubject != null && widget.shareSubject!.trim().isNotEmpty)
          ? widget.shareSubject!.trim()
          : 'Our Heartbeat Today';

  String get _shareButtonText => (widget.shareButtonText != null &&
          widget.shareButtonText!.trim().isNotEmpty)
      ? widget.shareButtonText!.trim()
      : 'Share now';

  String get _urlText =>
      (widget.urlText != null && widget.urlText!.trim().isNotEmpty)
          ? widget.urlText!.trim()
          : 'togly.app';

  String _initialsFromName(String value) {
    final parts =
        value.trim().split(RegExp(r'\s+')).where((e) => e.isNotEmpty).toList();

    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }

  Widget _buildAvatar(String imagePath, String fallbackName) {
    final hasImage = imagePath.isNotEmpty;

    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: ClipOval(
        child: hasImage
            ? Image.network(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      _initialsFromName(fallbackName),
                      style: const TextStyle(
                        fontSize: 20,
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
                  _initialsFromName(fallbackName),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8D4BD9),
                  ),
                ),
              ),
      ),
    );
  }

  List<Widget> _buildHearts(int percent) {
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
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Icon(
          Icons.favorite,
          size: 13,
          color: isFilled ? const Color(0xFFFF5A9A) : const Color(0xFF8C78C9),
        ),
      );
    });
  }

  Widget _buildCardContent({required bool withRoundedCorners}) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE9F0FF),
            Color(0xFFDCCCF8),
            Color(0xFFF4C7E1),
            Color(0xFFF8D5E5),
          ],
        ),
        borderRadius: withRoundedCorners ? BorderRadius.circular(26) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 28,
                  height: 28,
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
                    size: 15,
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    _brandText,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8A47A8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              _titleText,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF6B3387),
                height: 1.08,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              '❤️',
              style: TextStyle(fontSize: 24),
            ),
            if (_dateText.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                _dateText,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFF7FAFF),
                ),
              ),
            ],
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: const Color(0x22FFFFFF),
                border: Border.all(
                  color: const Color(0x33FFFFFF),
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 68,
                    child: Column(
                      children: [
                        _buildAvatar(_partner1ImagePath, _partner1Name),
                        const SizedBox(height: 5),
                        Text(
                          _partner1Name,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF8A47A8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 42,
                    height: 42,
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
                      size: 22,
                    ),
                  ),
                  SizedBox(
                    width: 68,
                    child: Column(
                      children: [
                        _buildAvatar(_partner2ImagePath, _partner2Name),
                        const SizedBox(height: 5),
                        Text(
                          _partner2Name,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
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
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0x22FFFFFF),
                  border: Border.all(
                    color: const Color(0x33FFFFFF),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 178,
                      height: 178,
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
                          width: 4,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 144,
                          height: 144,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$_scorePercent%',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFFFF3C93),
                                  height: 1.0,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  _connectionLabel,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF8C3DA7),
                                    height: 1.2,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: _buildHearts(_scorePercent),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.92),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        _insightText,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF9A77B6),
                          height: 1.3,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF8B63FF),
                            Color(0xFFFF3C93),
                          ],
                        ),
                      ),
                      child: Text(
                        _ctaText,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _urlText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF8C63A8).withOpacity(0.85),
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
  }

  Future<void> _shareCard() async {
    if (_isSharing) return;

    setState(() {
      _isSharing = true;
    });

    try {
      final Uint8List? imageBytes = await _screenshotController.capture(
        pixelRatio: 3.0,
      );

      if (imageBytes == null) {
        throw Exception('Screenshot capture returned null.');
      }

      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/heartbeat_share_card.png');
      await file.writeAsBytes(imageBytes, flush: true);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: _shareText,
        subject: _shareSubject,
      );
    } catch (e) {
      debugPrint('HeartbeatShareSheetWidget share error: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sharing failed. Please try again.'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSharing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final previewMedia = MediaQuery.of(context).copyWith(
      textScaler: const TextScaler.linear(1.0),
    );

    return Stack(
      children: [
        Positioned(
          left: -5000,
          top: 0,
          child: SizedBox(
            width: _exportWidth,
            height: _exportHeight,
            child: MediaQuery(
              data: previewMedia.copyWith(
                size: const Size(_exportWidth, _exportHeight),
              ),
              child: Screenshot(
                controller: _screenshotController,
                child: SizedBox(
                  width: _exportWidth,
                  height: _exportHeight,
                  child: _buildCardContent(withRoundedCorners: false),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: widget.width ?? double.infinity,
          height: widget.height ?? 760,
          decoration: BoxDecoration(
            color: const Color(0xFFF7F3FF),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
            child: Column(
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD3C7E9),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: MediaQuery(
                      data: previewMedia,
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: _buildCardContent(withRoundedCorners: true),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _isSharing ? null : _shareCard,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B63FF),
                      disabledBackgroundColor: const Color(0xFFC7B9E8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 0,
                    ),
                    child: _isSharing
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            _shareButtonText,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
