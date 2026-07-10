import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'comes_next_page_widget.dart' show ComesNextPageWidget;
import 'package:flutter/material.dart';

class ComesNextPageModel extends FlutterFlowModel<ComesNextPageWidget> {
  ///  Local state fields for this page.

  bool isVoting = false;

  String? myReaction;

  String? clickedKey;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Text widget.
  List<ReactionsRecord>? myReactionQ;
  // Stores action output result for [Firestore Query - Query a collection] action in Text widget.
  List<ReactionsRecord>? myReactionQ2;
  // Stores action output result for [Firestore Query - Query a collection] action in Text widget.
  List<ReactionsRecord>? myReactionQ3;
  // Stores action output result for [Firestore Query - Query a collection] action in Text widget.
  List<ReactionsRecord>? myReactionQ4;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
