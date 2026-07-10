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

// ✅ লগইন সফল হওয়ার পরপরই এই action কল করুন (যেমন: login page-এর
// "on success" action flow-তে, বা app শুরু হওয়ার সময় auth state already
// valid থাকলে)। এটা নেটিভ LoveBuddyLiveService চালু করে, যেটা Firestore-এর
// relationship_views ডকুমেন্ট শুনে home-screen widget আপডেট রাখবে।
//
// ⚠️ শুধু Android-এ কাজ করে — iOS-এ home-screen widget আলাদাভাবে
// (WidgetKit/App Group দিয়ে) implement করতে হবে, তাই এখানে iOS-এ silently
// skip করা হচ্ছে।
Future<void> startLoveBuddyWidgetSync() async {
  if (!isAndroid) return;
  const channel = MethodChannel('com.trinityx.togetherly/love_buddy_widget');
  try {
    await channel.invokeMethod('startWidgetSync');
  } catch (e) {
    // চ্যানেল না থাকলে বা কোনো কারণে ব্যর্থ হলে অ্যাপ ক্র্যাশ করা ঠিক না —
    // widget sync fail করলেও মূল অ্যাপ স্বাভাবিকভাবে কাজ করবে
    print('startLoveBuddyWidgetSync failed: $e');
  }
}
