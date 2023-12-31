// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDh9mEWYvMpOdH-UPrbvAiDcelNS3Ml1n0',
    appId: '1:1067058371421:web:d0f042ca37b943ca0f66b4',
    messagingSenderId: '1067058371421',
    projectId: 'ozora-test-app',
    authDomain: 'ozora-test-app.firebaseapp.com',
    storageBucket: 'ozora-test-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyApTc0zxz7YnEFZFvK4IwmZ6_GHGklQZlc',
    appId: '1:1067058371421:android:1bfbc59206f261010f66b4',
    messagingSenderId: '1067058371421',
    projectId: 'ozora-test-app',
    storageBucket: 'ozora-test-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBiTUuYpxZ2XYG9Mb5qUEUQ-IDpEFkLrlQ',
    appId: '1:1067058371421:ios:25572d47fa18337a0f66b4',
    messagingSenderId: '1067058371421',
    projectId: 'ozora-test-app',
    storageBucket: 'ozora-test-app.appspot.com',
    iosBundleId: 'com.example.ozora',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBiTUuYpxZ2XYG9Mb5qUEUQ-IDpEFkLrlQ',
    appId: '1:1067058371421:ios:6814dc623135ca4e0f66b4',
    messagingSenderId: '1067058371421',
    projectId: 'ozora-test-app',
    storageBucket: 'ozora-test-app.appspot.com',
    iosBundleId: 'com.example.ozora.RunnerTests',
  );
}
