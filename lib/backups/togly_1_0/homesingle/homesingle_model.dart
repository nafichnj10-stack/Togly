import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'homesingle_widget.dart' show HomesingleWidget;
import 'package:flutter/material.dart';

class HomesingleModel extends FlutterFlowModel<HomesingleWidget> {
  ///  Local state fields for this page.

  String dummyName = 'Dummy';

  String dummyImage = 'https://...';

  String dummyCity = 'Nowhere';

  DateTime? pageBirthday;

  bool moodBusy = false;

  String? partnerUserId;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in homesingle widget.
  UsersRecord? currentUserData;
  // Stores action output result for [Firestore Query - Query a collection] action in homesingle widget.
  PublicUsersRecord? currentUserData2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
