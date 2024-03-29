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
    apiKey: 'AIzaSyDhhLb2pwSR4Stqa-ShFEbx_8NoI6n8zzU',
    appId: '1:511303522786:web:a2e929a0b517c05cfe01bb',
    messagingSenderId: '511303522786',
    projectId: 'todo-list-lehoai-mobiless',
    authDomain: 'todo-list-lehoai-mobiless.firebaseapp.com',
    storageBucket: 'todo-list-lehoai-mobiless.appspot.com',
    measurementId: 'G-B0S0XQVE72',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqLnROC5Wms2lUh4nkWk8rD9QjXKz7IQs',
    appId: '1:511303522786:android:887338d1a3fd3919fe01bb',
    messagingSenderId: '511303522786',
    projectId: 'todo-list-lehoai-mobiless',
    storageBucket: 'todo-list-lehoai-mobiless.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAX5LFQC5CPDq-Ei7dIFCtRu51SBjDhAKs',
    appId: '1:511303522786:ios:eaeb96cee3919383fe01bb',
    messagingSenderId: '511303522786',
    projectId: 'todo-list-lehoai-mobiless',
    storageBucket: 'todo-list-lehoai-mobiless.appspot.com',
    iosBundleId: 'com.example.todoList',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAX5LFQC5CPDq-Ei7dIFCtRu51SBjDhAKs',
    appId: '1:511303522786:ios:92022e39ca849cd0fe01bb',
    messagingSenderId: '511303522786',
    projectId: 'todo-list-lehoai-mobiless',
    storageBucket: 'todo-list-lehoai-mobiless.appspot.com',
    iosBundleId: 'com.example.todoList.RunnerTests',
  );
}
