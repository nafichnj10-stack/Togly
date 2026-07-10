import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_commons/api_requests/api_manager.dart';


export 'package:ff_commons/api_requests/api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GoogleGeocodeLocationCall {
  static Future<ApiCallResponse> call({
    String? address = '',
    String? language = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GoogleGeocodeLocation',
      apiUrl: 'https://maps.googleapis.com/maps/api/geocode/json',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'address': address,
        'key': "AIzaSyC2dwTu7CBJwgzU7ziDoMQEh2259PGefBg",
        'language': language,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static double? latitude(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.results[:].geometry.location.lat''',
      ));
  static double? longitude(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.results[:].geometry.location.lng''',
      ));
  static String? countryCode(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results[:].address_components[3].short_name''',
      ));
  static String? countryName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results[:].address_components[3].long_name''',
      ));
  static String? cityName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].address_components[0].long_name''',
      ));
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
