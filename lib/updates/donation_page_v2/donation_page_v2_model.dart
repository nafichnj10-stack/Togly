import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'donation_page_v2_widget.dart' show DonationPageV2Widget;
import 'package:flutter/material.dart';

class DonationPageV2Model extends FlutterFlowModel<DonationPageV2Widget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Stripe Payment] action in Container widget.
  String? paymentId;
  // Stores action output result for [Cloud Function - createStripeSubscriptionCheckout] action in Container widget.
  CreateStripeSubscriptionCheckoutCloudFunctionCallResponse? cloudFunctioniw2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
