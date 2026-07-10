import '/flutter_flow/flutter_flow_util.dart';
import 'donation_page_v1_widget.dart' show DonationPageV1Widget;
import 'package:flutter/material.dart';

class DonationPageV1Model extends FlutterFlowModel<DonationPageV1Widget> {
  ///  Local state fields for this page.

  bool showCustomInput = false;

  double? donationAmount = 0.0;

  bool showDonationThanks = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Stripe Payment] action in Container widget.
  String? paymentId;
  // Stores action output result for [Stripe Payment] action in Container widget.
  String? paymentIdCopy;
  // Stores action output result for [Stripe Payment] action in Container widget.
  String? paymentIdCopyCopy;
  // State field(s) for CustomAmountField widget.
  FocusNode? customAmountFieldFocusNode;
  TextEditingController? customAmountFieldTextController;
  String? Function(BuildContext, String?)?
      customAmountFieldTextControllerValidator;
  // Stores action output result for [Custom Action - parseDonationAmount] action in DonateNow widget.
  int? parsedAmountResult;
  // Stores action output result for [Stripe Payment] action in DonateNow widget.
  String? paymentId4;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    customAmountFieldFocusNode?.dispose();
    customAmountFieldTextController?.dispose();
  }
}
