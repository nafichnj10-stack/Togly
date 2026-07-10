import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'empty_treasure_archive_model.dart';
export 'empty_treasure_archive_model.dart';

class EmptyTreasureArchiveWidget extends StatefulWidget {
  const EmptyTreasureArchiveWidget({super.key});

  @override
  State<EmptyTreasureArchiveWidget> createState() =>
      _EmptyTreasureArchiveWidgetState();
}

class _EmptyTreasureArchiveWidgetState
    extends State<EmptyTreasureArchiveWidget> {
  late EmptyTreasureArchiveModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyTreasureArchiveModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14.0),
      child: Container(
        width: 350.1,
        height: 275.5,
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
          gradient: LinearGradient(
            colors: [Color(0xFFF9E4EE), Color(0xFFFCE8F3), Color(0xFFF8F0F5)],
            stops: [0.0, 0.5, 1.0],
            begin: AlignmentDirectional(0.0, -1.0),
            end: AlignmentDirectional(0, 1.0),
          ),
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Container(
            decoration: BoxDecoration(),
            child: Container(
              height: 192.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 64.0,
                    height: 64.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).accent3,
                      borderRadius: BorderRadius.circular(9999.0),
                      shape: BoxShape.rectangle,
                    ),
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Icon(
                      Icons.diamond_rounded,
                      color: FlutterFlowTheme.of(context).tertiary,
                      size: 32.0,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'tzoeu6d8' /* No Love Treasure yet */,
                        ),
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleLargeFamily,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              lineHeight: 1.27,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .titleLargeIsCustom,
                            ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 260.0,
                        ),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '7rgeh6lf' /* Love Treasures you create toge... */,
                          ),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color: FlutterFlowTheme.of(context).secondary,
                                letterSpacing: 0.0,
                                lineHeight: 1.47,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyMediumIsCustom,
                              ),
                        ),
                      ),
                    ].divide(SizedBox(height: 4.0)),
                  ),
                ].divide(SizedBox(height: 16.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
