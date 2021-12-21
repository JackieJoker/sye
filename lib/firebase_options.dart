// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCbNXSe8O7nkHjEI9fXvxSsuRl-4fTgBRA',
    appId: '1:807269076699:web:f670f6493cee8444ab46fe',
    messagingSenderId: '807269076699',
    projectId: 'split-your-expenses',
    authDomain: 'split-your-expenses.firebaseapp.com',
    databaseURL: 'https://split-your-expenses-default-rtdb.europe-west1.firebasedatabase.app/',
    storageBucket: 'split-your-expenses.appspot.com',
    measurementId: 'G-VS0GCG688C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDE285b4e7uOu8UppG_rQO4owKtewxnFDo',
    appId: '1:807269076699:android:19c8e25c33ae5c71ab46fe',
    messagingSenderId: '807269076699',
    projectId: 'split-your-expenses',
    databaseURL: 'https://split-your-expenses-default-rtdb.europe-west1.firebasedatabase.app/',
    storageBucket: 'split-your-expenses.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCLSpjqmVMEYwbU9AMtc44OPlDT2jgGF2w',
    appId: '1:807269076699:ios:03d88a8c3f1d7850ab46fe',
    messagingSenderId: '807269076699',
    projectId: 'split-your-expenses',
    databaseURL: 'https://split-your-expenses-default-rtdb.europe-west1.firebasedatabase.app/',
    storageBucket: 'split-your-expenses.appspot.com',
    iosClientId: '807269076699-o4u53b9evhl1eveie966fjs8lfd8oeo1.apps.googleusercontent.com',
    iosBundleId: 'it.polimi.dima.sye',
  );
}
