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

// ✅ "হোমস্ক্রিনে Widget যোগ করুন" বাটনে এই action লাগান — সিস্টেম ডায়ালগ
// দেখিয়ে widget pin করার অনুরোধ পাঠায় (সব লঞ্চার সাপোর্ট নাও করতে পারে)।
Future<bool> requestPinLoveBuddyWidget() async {
  if (!isAndroid) return false;
  const channel = MethodChannel('com.trinityx.togetherly/love_buddy_widget');
  try {
    final result = await channel.invokeMethod('requestPinWidget');
    return result == true;
  } catch (e) {
    print('requestPinLoveBuddyWidget failed: $e');
    return false;
  }
}
