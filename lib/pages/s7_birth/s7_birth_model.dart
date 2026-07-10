import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 's7_birth_widget.dart' show S7BirthWidget;
import 'package:flutter/material.dart';

class S7BirthModel extends FlutterFlowModel<S7BirthWidget> {
  ///  Local state fields for this page.

  DateTime? selectedBirthday;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  DateTime? datePicked;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
