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
    apiKey: 'AIzaSyA4neW1MuUqLrZUBZvb5uofvk9hQw2rfTc',
    appId: '1:957679994689:web:fe2449dbb262b2ef7a83c0',
    messagingSenderId: '957679994689',
    projectId: 'bake-now',
    authDomain: 'bake-now.firebaseapp.com',
    storageBucket: 'bake-now.appspot.com',
    measurementId: 'G-LRWVDFCVV5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7UwvoAZ1vvqgcwLZchYCcaWRkQMZRF8I',
    appId: '1:957679994689:android:4cbd9200b568704f7a83c0',
    messagingSenderId: '957679994689',
    projectId: 'bake-now',
    storageBucket: 'bake-now.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDzj48c_2KV848DaUkWIJEvYPrnBvW6ThQ',
    appId: '1:957679994689:ios:826caf6151ce65967a83c0',
    messagingSenderId: '957679994689',
    projectId: 'bake-now',
    storageBucket: 'bake-now.appspot.com',
    iosBundleId: 'com.example.bakeNow',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDzj48c_2KV848DaUkWIJEvYPrnBvW6ThQ',
    appId: '1:957679994689:ios:826caf6151ce65967a83c0',
    messagingSenderId: '957679994689',
    projectId: 'bake-now',
    storageBucket: 'bake-now.appspot.com',
    iosBundleId: 'com.example.bakeNow',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA4neW1MuUqLrZUBZvb5uofvk9hQw2rfTc',
    appId: '1:957679994689:web:6d01022bf34832f77a83c0',
    messagingSenderId: '957679994689',
    projectId: 'bake-now',
    authDomain: 'bake-now.firebaseapp.com',
    storageBucket: 'bake-now.appspot.com',
    measurementId: 'G-B8QX932NCJ',
  );
}
