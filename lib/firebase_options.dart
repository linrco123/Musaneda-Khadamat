// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyD2gDo_mY0BF4IjpbS_OA9ZfJ23rsydXsc',
    appId: '1:213649598855:web:1667e3b903cee97778cb22',
    messagingSenderId: '213649598855',
    projectId: 'musaneda-khdamat',
    authDomain: 'musaneda-khdamat.firebaseapp.com',
    storageBucket: 'musaneda-khdamat.appspot.com',
    measurementId: 'G-KRW8Q1F7ZL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCyBaZjk0NhgdUj8vA20UQSyzlL9KUQ3HM',
    appId: '1:213649598855:android:698b698974a5a0c078cb22',
    messagingSenderId: '213649598855',
    projectId: 'musaneda-khdamat',
    storageBucket: 'musaneda-khdamat.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC0P-IcQnviTU6ZDKjqKLGiIZvJXNEaPvg',
    appId: '1:213649598855:ios:1cbe4d972e89a2e178cb22',
    messagingSenderId: '213649598855',
    projectId: 'musaneda-khdamat',
    storageBucket: 'musaneda-khdamat.appspot.com',
    iosBundleId: 'com.fnrco.musaneda',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC0P-IcQnviTU6ZDKjqKLGiIZvJXNEaPvg',
    appId: '1:213649598855:ios:1cbe4d972e89a2e178cb22',
    messagingSenderId: '213649598855',
    projectId: 'musaneda-khdamat',
    storageBucket: 'musaneda-khdamat.appspot.com',
    iosBundleId: 'com.fnrco.musaneda',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD2gDo_mY0BF4IjpbS_OA9ZfJ23rsydXsc',
    appId: '1:213649598855:web:e32bc614dc3d880f78cb22',
    messagingSenderId: '213649598855',
    projectId: 'musaneda-khdamat',
    authDomain: 'musaneda-khdamat.firebaseapp.com',
    storageBucket: 'musaneda-khdamat.appspot.com',
    measurementId: 'G-72Y54BVQW6',
  );

}