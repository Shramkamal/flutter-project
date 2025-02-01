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
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for Windows. '
          'Reconfigure using the FlutterFire CLI or manually update firebase_options.dart.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAAJlwSZqhlb-8Mvfhmqlvm3yWebqEDY_w',
    appId: '1:233516973768:web:470451a7a01f327cc46ffd',
    messagingSenderId: '233516973768',
    projectId: 'todolist-af3a2',
    authDomain: 'todolist-af3a2.firebaseapp.com',
    storageBucket: 'todolist-af3a2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB8a912CIsTUV-C7XP18b-mPOleNFfda-M',
    appId: '1:233516973768:android:21be94741d99a77bc46ffd',
    messagingSenderId: '233516973768',
    projectId: 'todolist-af3a2',
    storageBucket: 'todolist-af3a2.appspot.com',
  );
}
