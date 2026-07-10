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

// ✅ ট্রিপ শুরু হলে (love_buddies_travel_active = true) কল করুন — একটা
// foreground service চালু হবে যেটা প্রতি ~১০ মিনিট পরপর GPS লোকেশন নিয়ে
// existing "updateLoveBuddyLiveLocation" Cloud Function-কে কল করবে,
// অ্যাপ ব্যাকগ্রাউন্ডে থাকলেও। ট্রিপ শেষ/বাতিল হলে অবশ্যই
// stopLoveBuddyWidgetSync() বা নিচের বন্ধ করার কল ব্যবহার করুন।
Future<void> startLoveBuddyLocationTracking() async {
  if (!isAndroid) return;
  const channel = MethodChannel('com.trinityx.togetherly/love_buddy_widget');
  try {
    await channel.invokeMethod('startLocationTracking');
  } catch (e) {
    print('startLoveBuddyLocationTracking failed: $e');
  }
}
