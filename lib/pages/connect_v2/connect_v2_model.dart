import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'connect_v2_widget.dart' show ConnectV2Widget;
import 'package:flutter/material.dart';

class ConnectV2Model extends FlutterFlowModel<ConnectV2Widget> {
  ///  Local state fields for this page.

  bool hasPendingRequest = false;

  String? partnerUid;

  String? pairKeyVar;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Firestore Query - Query a collection] action in ConnectV2 widget.
  RelationshipRequestsRecord? pendingRequest;
  // Stores action output result for [Firestore Query - Query a collection] action in ConnectV2 widget.
  PublicUsersRecord? initiatorUserData;
  // Stores action output result for [Cloud Function - acceptRelationshipRequest] action in Button widget.
  AcceptRelationshipRequestCloudFunctionCallResponse? cloudFunctionq9k;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  RelationshipRequestsRecord? incomingRequest;
  // State field(s) for partnerCodeInput widget.
  FocusNode? partnerCodeInputFocusNode;
  TextEditingController? partnerCodeInputTextController;
  String? Function(BuildContext, String?)?
      partnerCodeInputTextControllerValidator;
  String? _partnerCodeInputTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'zaflg3oi' /* Enter code here... is required */,
      );
    }

    return null;
  }

  // Stores action output result for [Cloud Function - sendRelationshipRequest] action in Button widget.
  SendRelationshipRequestCloudFunctionCallResponse? cloudFunctionz3i;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  RelationshipRequestsRecord? pendingRequestToCancel;
  // Stores action output result for [Cloud Function - cancelRelationshipRequest] action in Button widget.
  CancelRelationshipRequestCloudFunctionCallResponse? cloudFunctionzlw;

  @override
  void initState(BuildContext context) {
    partnerCodeInputTextControllerValidator =
        _partnerCodeInputTextControllerValidator;
  }

  @override
  void dispose() {
    partnerCodeInputFocusNode?.dispose();
    partnerCodeInputTextController?.dispose();
  }
}
