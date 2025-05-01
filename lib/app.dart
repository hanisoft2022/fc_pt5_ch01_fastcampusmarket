import 'package:fastcampusmarket/core/router/go_router.dart';
import 'package:fastcampusmarket/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/theme_mode_provider.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode themeMode = ref.watch(themeModeProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeType.light.themeData,
      darkTheme: ThemeType.dark.themeData,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
