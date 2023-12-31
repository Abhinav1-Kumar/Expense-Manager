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
    apiKey: 'AIzaSyDM7EYSWIkixV5RjYnGICDPpdPoszdYUSg',
    appId: '1:421758768265:web:6f6fcf7dc2511e58dee258',
    messagingSenderId: '421758768265',
    projectId: 'expense-manager-d46f4',
    authDomain: 'expense-manager-d46f4.firebaseapp.com',
    storageBucket: 'expense-manager-d46f4.appspot.com',
    measurementId: 'G-ZKXWQYY3BK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmFjc6HT9-pDVVW2iNWfuiylNWQfh32JQ',
    appId: '1:421758768265:android:e21199deff575b9adee258',
    messagingSenderId: '421758768265',
    projectId: 'expense-manager-d46f4',
    storageBucket: 'expense-manager-d46f4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAsD7feWIE5dhb1JSkvUGRaQnXwAANGkMo',
    appId: '1:421758768265:ios:bdc45fb4155f0c82dee258',
    messagingSenderId: '421758768265',
    projectId: 'expense-manager-d46f4',
    storageBucket: 'expense-manager-d46f4.appspot.com',
    iosClientId: '421758768265-ignl08mpm144tpigmrcgaptoghckaag7.apps.googleusercontent.com',
    iosBundleId: 'com.example.expenseManager',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAsD7feWIE5dhb1JSkvUGRaQnXwAANGkMo',
    appId: '1:421758768265:ios:bdc45fb4155f0c82dee258',
    messagingSenderId: '421758768265',
    projectId: 'expense-manager-d46f4',
    storageBucket: 'expense-manager-d46f4.appspot.com',
    iosClientId: '421758768265-ignl08mpm144tpigmrcgaptoghckaag7.apps.googleusercontent.com',
    iosBundleId: 'com.example.expenseManager',
  );
}
