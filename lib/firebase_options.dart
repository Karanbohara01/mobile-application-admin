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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB5CKP8HHPucxTtSenCgnCeGNUqSoSw5v8',
    appId: '1:951467405762:android:5175d889a80149ccbce65b',
    messagingSenderId: '951467405762',
    projectId: 'mobile-ecommerce-53fef',
    storageBucket: 'mobile-ecommerce-53fef.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-7nxEdStZcLS9KhyIc-pq8aqnX4JxO3c',
    appId: '1:951467405762:ios:31d8842b2b763e52bce65b',
    messagingSenderId: '951467405762',
    projectId: 'mobile-ecommerce-53fef',
    storageBucket: 'mobile-ecommerce-53fef.appspot.com',
    androidClientId: '951467405762-4utf1lgk3gr5oor5nsjp4f1lq3o7242v.apps.googleusercontent.com',
    iosClientId: '951467405762-sojk5gbt396tvj582ppe824k797fbu51.apps.googleusercontent.com',
    iosBundleId: 'com.example.mobileAdmin',
  );
}