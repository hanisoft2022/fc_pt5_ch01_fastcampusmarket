import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'core/firebase/firebase_options.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
}
