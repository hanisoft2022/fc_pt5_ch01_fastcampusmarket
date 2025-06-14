import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/firebase/firebase_options.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) {
    // 에뮬레이터 설정은 개발 모드에서만
    _setupFirebaseEmulators();
  }

  runApp(ProviderScope(child: MyApp()));
}

void _setupFirebaseEmulators() async {
  const host = 'localhost';
  // await FirebaseAuth.instance.signOut();
  await FirebaseAuth.instance.useAuthEmulator(host, 9099);

  FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
  FirebaseStorage.instance.useStorageEmulator(host, 9199);
}
