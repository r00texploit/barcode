import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBC2N9mSiG6NMI8_tURyN9Do-sWqXpB9IY',
    appId: '1:249576901616:android:440a37ffb5067fe65feb35',
    messagingSenderId: '249576901616',
    projectId: 'barcode-46ab2',
    storageBucket: 'barcode-46ab2.appspot.com',
  );
}
