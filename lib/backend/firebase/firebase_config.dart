import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBzTq1MZM6NJtb37pMbfHVAU3QOBshvoE0",
            authDomain: "togetherly-39exn5.firebaseapp.com",
            projectId: "togetherly-39exn5",
            storageBucket: "togetherly-39exn5.firebasestorage.app",
            messagingSenderId: "1078257670926",
            appId: "1:1078257670926:web:7dc6e9df516b978689155f"));
  } else {
    await Firebase.initializeApp();
  }
}
