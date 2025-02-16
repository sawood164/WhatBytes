import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // Copy the configuration from Firebase console here
    // You can find this in your Firebase project settings
    return const FirebaseOptions(
      apiKey: 'AIzaSyC3FhAnw6WYUl8BGpoSiDJPPg1lerN5H3w',
      appId: '1:615620117105:android:6b35bef0620e6aedefd1d0',
      messagingSenderId: '615620117105',
      projectId: 'whatbytes-11aae',
      storageBucket: 'whatbytes-11aae.firebasestorage.app',
      // ... other platform-specific options
    );
  }
}