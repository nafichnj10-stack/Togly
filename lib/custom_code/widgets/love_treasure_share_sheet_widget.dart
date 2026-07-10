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

class LoveTreasureShareSheetWidget extends StatefulWidget {
  const LoveTreasureShareSheetWidget({
    super.key,
    this.width,
    this.height,
    this.titleText,
    this.subtitleText,
    this.partner1Name,
    this.partner2Name,
    this.partner1PhotoUrl,
    this.partner2PhotoUrl,
    this.dateText,
    this.surpriseCountText,
    this.statusText,
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
  final String? subtitleText;
  final String? partner1Name;
  final String? partner2Name;
  final String? partner1PhotoUrl;
  final String? partner2PhotoUrl;
  final String? dateText;
  final String? surpriseCountText;
  final String? statusText;
  final String? ctaText;
  final String? brandText;
  final String? shareText;
  final String? shareSubject;
  final String? shareButtonText;
  final String? urlText;

  @override
  State<LoveTreasureShareSheetWidget> createState() =>
      _LoveTreasureShareSheetWidgetState();
}

class _LoveTreasureShareSheetWidgetState
    extends State<LoveTreasureShareSheetWidget> {
  final ScreenshotController _screenshotController = ScreenshotController();
  bool _isSharing = false;

  static const double _exportWidth = 360;
  static const double _exportHeight = 640;

  static const String _treasureImageUrl =
      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/back-up1308-6rkpxv/assets/zrtxewgz2nrp/lt_open.webp';

  String get _titleText => widget.titleText?.trim().isNotEmpty == true
      ? widget.titleText!.trim()
      : 'Our Love Treasure is ready ✨';

  String get _subtitleText => widget.subtitleText?.trim().isNotEmpty == true
      ? widget.subtitleText!.trim()
      : 'A little box full of love, memories and surprises.';

  String get _partner1Name => widget.partner1Name?.trim().isNotEmpty == true
      ? widget.partner1Name!.trim()
      : 'You';

  String get _partner2Name => widget.partner2Name?.trim().isNotEmpty == true
      ? widget.partner2Name!.trim()
      : 'Partner';

  String get _partner1PhotoUrl =>
      widget.partner1PhotoUrl?.trim().isNotEmpty == true
          ? widget.partner1PhotoUrl!.trim()
          : '';

  String get _partner2PhotoUrl =>
      widget.partner2PhotoUrl?.trim().isNotEmpty == true
          ? widget.partner2PhotoUrl!.trim()
          : '';

  String get _dateText =>
      widget.dateText?.trim().isNotEmpty == true ? widget.dateText!.trim() : '';

  String get _surpriseCountText =>
      widget.surpriseCountText?.trim().isNotEmpty == true
          ? widget.surpriseCountText!.trim()
          : '5 Surprises Inside 💕';

  String get _statusText => widget.statusText?.trim().isNotEmpty == true
      ? widget.statusText!.trim()
      : 'Opened with love';

  String get _ctaText => widget.ctaText?.trim().isNotEmpty == true
      ? widget.ctaText!.trim()
      : 'Create your own Love Treasure on Togly';

  String get _brandText => widget.brandText?.trim().isNotEmpty == true
      ? widget.brandText!.trim()
      : 'TOGLY • Love Treasure';

  String get _shareText => widget.shareText?.trim().isNotEmpty == true
      ? widget.shareText!.trim()
      : 'We opened our Love Treasure on Togly 💕';

  String get _shareSubject => widget.shareSubject?.trim().isNotEmpty == true
      ? widget.shareSubject!.trim()
      : 'Our Love Treasure';

  String get _shareButtonText =>
      widget.shareButtonText?.trim().isNotEmpty == true
          ? widget.shareButtonText!.trim()
          : 'Share Treasure';

  String get _urlText => widget.urlText?.trim().isNotEmpty == true
      ? widget.urlText!.trim()
      : 'togly.app';

  String _initialsFromName(String value) {
    final parts =
        value.trim().split(RegExp(r'\s+')).where((e) => e.isNotEmpty).toList();

    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();

    return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }

  Widget _sparkle(double size, Color color, {double opacity = 1}) {
    return Opacity(
      opacity: opacity,
      child: Text(
        '✦',
        style: TextStyle(
          fontSize: size,
          color: color,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _heart(double size, Color color, {double opacity = 1}) {
    return Opacity(
      opacity: opacity,
      child: Text(
        '♥',
        style: TextStyle(
          fontSize: size,
          color: color,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _avatar(String imageUrl, String fallbackName) {
    final hasImage = imageUrl.trim().isNotEmpty;

    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7B3A91).withOpacity(0.16),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipOval(
        child: hasImage
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _avatarFallback(fallbackName);
                },
              )
            : _avatarFallback(fallbackName),
      ),
    );
  }

  Widget _avatarFallback(String fallbackName) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Text(
        _initialsFromName(fallbackName),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: Color(0xFF8B4BA3),
        ),
      ),
    );
  }

  Widget _partnerBlock(String name, String photoUrl) {
    return SizedBox(
      width: 92,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _avatar(photoUrl, name),
          const SizedBox(height: 5),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: Color(0xFF753D82),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreasureChest() {
    return SizedBox(
      width: 310,
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFD36E).withOpacity(0.65),
                  blurRadius: 90,
                  spreadRadius: 30,
                ),
                BoxShadow(
                  color: const Color(0xFFFF69B4).withOpacity(0.35),
                  blurRadius: 110,
                  spreadRadius: 35,
                ),
              ],
            ),
          ),
          Image.network(
            _treasureImageUrl,
            width: 292,
            height: 245,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _fixedStoryCard({required bool withRoundedCorners}) {
    return Container(
      width: _exportWidth,
      height: _exportHeight,
      decoration: BoxDecoration(
        borderRadius: withRoundedCorners ? BorderRadius.circular(28) : null,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFF0F7),
            Color(0xFFF5E7FF),
            Color(0xFFECEAFF),
            Color(0xFFFFE7C4),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -55,
            right: -60,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFA6D1).withOpacity(0.34),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -60,
            child: Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD8C3FF).withOpacity(0.42),
              ),
            ),
          ),
          Positioned(
            top: 96,
            left: 30,
            child: _sparkle(23, const Color(0xFFFFB84D), opacity: 0.72),
          ),
          Positioned(
            top: 160,
            right: 30,
            child: _heart(20, const Color(0xFFFF69B4), opacity: 0.68),
          ),
          Positioned(
            bottom: 162,
            right: 26,
            child: _sparkle(22, Colors.white, opacity: 0.92),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFFFF6CB9), Color(0xFF9D6BFF)],
                        ),
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        _brandText,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF85469A),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  _titleText,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF6B2E80),
                    height: 1.02,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _subtitleText,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF7C5A86).withOpacity(0.88),
                    height: 1.2,
                  ),
                ),
                if (_dateText.isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Text(
                    _dateText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF8D6A98).withOpacity(0.72),
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _partnerBlock(_partner1Name, _partner1PhotoUrl),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '💕',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    _partnerBlock(_partner2Name, _partner2PhotoUrl),
                  ],
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(10, 3, 10, 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.31),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.52),
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTreasureChest(),
                        const SizedBox(height: 0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF73B8), Color(0xFFFFB84D)],
                            ),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text(
                            _surpriseCountText,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _statusText,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF7E4E8D),
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B63FF), Color(0xFFFF4FA3)],
                    ),
                  ),
                  child: Text(
                    _ctaText,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  _urlText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF8C63A8).withOpacity(0.82),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent({required bool withRoundedCorners}) {
    return FittedBox(
      fit: BoxFit.contain,
      alignment: Alignment.center,
      child: _fixedStoryCard(withRoundedCorners: withRoundedCorners),
    );
  }

  Future<void> _shareCard() async {
    if (_isSharing) return;

    setState(() => _isSharing = true);

    try {
      final Uint8List? imageBytes = await _screenshotController.capture(
        pixelRatio: 3.0,
      );

      if (imageBytes == null) {
        throw Exception('Screenshot capture returned null.');
      }

      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/love_treasure_share_card.png');
      await file.writeAsBytes(imageBytes, flush: true);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: _shareText,
        subject: _shareSubject,
      );
    } catch (e) {
      debugPrint('LoveTreasureShareSheetWidget share error: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sharing failed. Please try again.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSharing = false);
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
                  child: _fixedStoryCard(withRoundedCorners: false),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: widget.width ?? double.infinity,
          height: widget.height ?? 760,
          decoration: BoxDecoration(
            color: const Color(0xFFF9F2FF),
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
                    color: const Color(0xFFD6C7E8),
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
                              fontWeight: FontWeight.w900,
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
