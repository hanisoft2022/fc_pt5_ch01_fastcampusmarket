import 'package:fastcampusmarket/core/theme/theme_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: '쫑알쫑알'.text.make(),
          centerTitle: false,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
            IconButton(
              onPressed: () {
                ref.watch(themeModeProvider.notifier).toggleTheme();
              },
              icon: const Icon(Icons.brightness_6_rounded),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
          ],
        ),
        body: Center(child: '임시 홈스크린'.text.make()),
      ),
    );
  }
}
