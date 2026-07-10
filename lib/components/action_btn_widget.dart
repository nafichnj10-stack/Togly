import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'action_btn_model.dart';
export 'action_btn_model.dart';

class ActionBtnWidget extends StatefulWidget {
  const ActionBtnWidget({
    super.key,
    Color? color,
    this.icon,
    String? label,
  })  : this.color = color ?? const Color(0xFFEC4899),
        this.label = label ?? 'Send Love';

  final Color color;
  final Widget? icon;
  final String label;

  @override
  State<ActionBtnWidget> createState() => _ActionBtnWidgetState();
}

class _ActionBtnWidgetState extends State<ActionBtnWidget> {
  late ActionBtnModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ActionBtnModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            color: valueOrDefault<Color>(
              widget.color,
              Color(0xFFEC4899),
            ),
            borderRadius: BorderRadius.circular(18.0),
            shape: BoxShape.rectangle,
          ),
          child: widget.icon!,
        ),
        Text(
          valueOrDefault<String>(
            widget.label,
            'Send Love',
          ),
          style: FlutterFlowTheme.of(context).labelSmall.override(
                fontFamily: FlutterFlowTheme.of(context).labelSmallFamily,
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
                lineHeight: 1.27,
                useGoogleFonts:
                    !FlutterFlowTheme.of(context).labelSmallIsCustom,
              ),
        ),
      ].divide(SizedBox(height: 4.0)),
    );
  }
}
