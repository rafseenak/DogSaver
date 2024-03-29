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
    apiKey: 'AIzaSyDYu9w7El-_o-HCPZD2w7y17LkXoLMEH9A',
    appId: '1:78165056938:web:ae504823c69a9013185fd3',
    messagingSenderId: '78165056938',
    projectId: 'dog-catcher-c6ed4',
    authDomain: 'dog-catcher-c6ed4.firebaseapp.com',
    databaseURL: 'https://dog-catcher-c6ed4-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'dog-catcher-c6ed4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBE94guAiIrAfU1rWemSFRda_Rt4j3QcMk',
    appId: '1:78165056938:android:326e0c8500c569e3185fd3',
    messagingSenderId: '78165056938',
    projectId: 'dog-catcher-c6ed4',
    databaseURL: 'https://dog-catcher-c6ed4-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'dog-catcher-c6ed4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAX-ey5nn6cEOrS1Zst2VHaZ9uq1mdkUA8',
    appId: '1:78165056938:ios:33826a9ceede741d185fd3',
    messagingSenderId: '78165056938',
    projectId: 'dog-catcher-c6ed4',
    databaseURL: 'https://dog-catcher-c6ed4-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'dog-catcher-c6ed4.appspot.com',
    iosBundleId: 'com.example.dogCatcher',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAX-ey5nn6cEOrS1Zst2VHaZ9uq1mdkUA8',
    appId: '1:78165056938:ios:fc7f55c836569526185fd3',
    messagingSenderId: '78165056938',
    projectId: 'dog-catcher-c6ed4',
    databaseURL: 'https://dog-catcher-c6ed4-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'dog-catcher-c6ed4.appspot.com',
    iosBundleId: 'com.example.dogCatcher.RunnerTests',
  );
}
