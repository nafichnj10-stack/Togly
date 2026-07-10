import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'coupon_wallet_widget.dart' show CouponWalletWidget;
import 'package:flutter/material.dart';

class CouponWalletModel extends FlutterFlowModel<CouponWalletWidget> {
  ///  Local state fields for this page.

  String walletTab = 'received';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Cloud Function - redeemLoveCoupon] action in Button widget.
  RedeemLoveCouponCloudFunctionCallResponse? lovecoup;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
