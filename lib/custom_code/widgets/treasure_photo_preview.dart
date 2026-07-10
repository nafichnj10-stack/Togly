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

class TreasurePhotoPreview extends StatefulWidget {
  const TreasurePhotoPreview({
    super.key,
    this.width,
    this.height,
    this.uploadedFile,
    this.borderRadius,
  });

  final double? width;
  final double? height;
  final FFUploadedFile? uploadedFile;
  final double? borderRadius;

  @override
  State<TreasurePhotoPreview> createState() => _TreasurePhotoPreviewState();
}

class _TreasurePhotoPreviewState extends State<TreasurePhotoPreview> {
  @override
  Widget build(BuildContext context) {
    final bytes = widget.uploadedFile?.bytes;
    final radius = widget.borderRadius ?? 24.0;

    if (bytes == null || bytes.isEmpty) {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: const Color(0xFFF4ECFA),
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: const Color(0xFFE5D3F7),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: const BoxDecoration(
                color: Color(0xFFEADDF7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.image_search_rounded,
                size: 42,
                color: Color(0xFF9B6DFF),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'No photo selected yet',
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily:
                        FlutterFlowTheme.of(context).headlineSmallFamily,
                    color: const Color(0xFF8B4DFF),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                  ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Choose or take a photo to preview it here',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      color: const Color(0xFFB78FEA),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
            ),
          ],
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.memory(
        bytes,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.cover,
      ),
    );
  }
}
// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
