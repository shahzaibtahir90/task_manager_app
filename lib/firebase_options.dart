import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions has not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions has not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions is not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA7qZ2Y5Vh74ixmNTwCGOKJifZ5Pqo995k',
    appId: '1:554820506172:web:6f6f2fd3e1a4d5b2c3d4e5f6',
    messagingSenderId: '554820506172',
    projectId: 'flutter-internship-app-9a09d',
    authDomain: 'flutter-internship-app-9a09d.firebaseapp.com',
    storageBucket: 'flutter-internship-app-9a09d.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7qZ2Y5Vh74ixmNTwCGOKJifZ5Pqo995k',
    appId: '1:554820506172:android:df29046ccac523f5556939',
    messagingSenderId: '554820506172',
    projectId: 'flutter-internship-app-9a09d',
    storageBucket: 'flutter-internship-app-9a09d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7qZ2Y5Vh74ixmNTwCGOKJifZ5Pqo995k',
    appId: '1:554820506172:ios:some-ios-app-id', // Placeholder as plist is missing, but better than before
    messagingSenderId: '554820506172',
    projectId: 'flutter-internship-app-9a09d',
    storageBucket: 'flutter-internship-app-9a09d.firebasestorage.app',
    iosBundleId: 'com.example.flutterInternshipApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA7qZ2Y5Vh74ixmNTwCGOKJifZ5Pqo995k',
    appId: '1:554820506172:ios:some-ios-app-id',
    messagingSenderId: '554820506172',
    projectId: 'flutter-internship-app-9a09d',
    storageBucket: 'flutter-internship-app-9a09d.firebasestorage.app',
    iosBundleId: 'com.example.flutterInternshipApp',
  );
}
