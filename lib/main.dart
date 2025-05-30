import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'core/firebase/firebase_options.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  const host = 'localhost';
  auth.useAuthEmulator(host, 9099);
  firestore.useFirestoreEmulator(host, 8080);
  storage.useStorageEmulator(host, 9199); // ✅ Storage 에뮬레이터 추가

  runApp(ProviderScope(child: MyApp()));
}
