import '/flutter_flow/flutter_flow_util.dart';
import 'dart:math' as math;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'sticky_note_comp_model.dart';
export 'sticky_note_comp_model.dart';

/// Design a romantic mobile bottom sheet that contains only one large sticky
/// note.
///
/// The sticky note should be the entire focus of the design.
///
/// Style:
/// - Soft pastel colors
/// - Premium paper texture
/// - Rounded corners
/// - Gentle shadows
/// - Slight floating effect
/// - Cozy romantic atmosphere
/// - Elegant and minimal
/// - Dreamy lighting
/// - Warm subtle glow
///
/// The sticky note should appear as if it was selected from a love wall and
/// gently expanded into a larger version.
///
/// No buttons.
/// No forms.
/// No UI controls.
/// No cards.
/// No menus.
///
/// The sticky note should dominate the entire design and feel personal,
/// emotional and intimate.
class StickyNoteCompWidget extends StatefulWidget {
  const StickyNoteCompWidget({
    super.key,
    String? noteText,
    required this.noteIcon,
    required this.noteStyle,
    required this.reasonRef,
  }) : this.noteText = noteText ?? '';

  final String noteText;
  final String? noteIcon;
  final int? noteStyle;
  final DocumentReference? reasonRef;

  @override
  State<StickyNoteCompWidget> createState() => _StickyNoteCompWidgetState();
}

class _StickyNoteCompWidgetState extends State<StickyNoteCompWidget> {
  late StickyNoteCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StickyNoteCompModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Container(
          child: Stack(
            alignment: AlignmentDirectional(-1.0, -1.0),
            children: [
              Container(
                decoration: BoxDecoration(),
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Transform.rotate(
                  angle: 0.0 * (math.pi / 180),
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: ClipRRect(
                    child: Container(
                      width: double.infinity,
                      height: 400.0,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x33000000),
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                          )
                        ],
                        shape: BoxShape.rectangle,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: () {
                            if (widget.noteStyle == 1) {
                              return Color(0xFFF8E8EE);
                            } else if (widget.noteStyle == 2) {
                              return Color(0xFFF6F1DC);
                            } else if (widget.noteStyle == 3) {
                              return Color(0xFFDCE6F5);
                            } else if (widget.noteStyle == 4) {
                              return Color(0xFFE2F1E8);
                            } else if (widget.noteStyle == 5) {
                              return Color(0xFFEADFF2);
                            } else {
                              return Color(0xFFA5571B);
                            }
                          }(),
                          borderRadius: BorderRadius.circular(4.0),
                          shape: BoxShape.rectangle,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 20.0, 0.0, 0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    widget.noteIcon,
                                    'icon',
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
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Text(
                                widget.noteText,
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
