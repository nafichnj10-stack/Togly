// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/services.dart';

// ✅ লগআউট হওয়ার সাথে সাথে এই action কল করুন — নাহলে নেটিভ সার্ভিস আগের
// ইউজারের ডেটা নিয়ে চলতে থাকবে (এমনিতে AuthStateListener নিজে থেকেও ধরবে,
// কিন্তু সাথে সাথে সার্ভিসটা বন্ধ করে দেওয়া ব্যাটারির জন্য ভালো)।
Future<void> stopLoveBuddyWidgetSync() async {
  if (!isAndroid) return;
  const channel = MethodChannel('com.trinityx.togetherly/love_buddy_widget');
  try {
    await channel.invokeMethod('stopWidgetSync');
    await channel.invokeMethod('stopLocationTracking');
  } catch (e) {
    print('stopLoveBuddyWidgetSync failed: $e');
  }
}
