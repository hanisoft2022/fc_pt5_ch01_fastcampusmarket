import 'package:flutter/material.dart';

import 'core/theme/theme.dart';
import 'features/login/presentation/s_login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: const LoginScreen(),
    );
  }
}
