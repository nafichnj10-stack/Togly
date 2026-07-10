import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 's8_city_widget.dart' show S8CityWidget;
import 'package:flutter/material.dart';

class S8CityModel extends FlutterFlowModel<S8CityWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for PlacePicker widget.
  FFPlace placePickerValue = FFPlace();
  // Stores action output result for [Backend Call - API (GoogleGeocodeLocation)] action in Button widget.
  ApiCallResponse? geocodeResult;
  // Stores action output result for [Custom Action - parseGoogleGeocodeLocation] action in Button widget.
  dynamic parsgoogle;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
