import 'package:fastcampusmarket/core/theme/theme_mode_provider.dart';
import 'package:fastcampusmarket/features/home/presentation/screens/feed_screen.dart';
import 'package:fastcampusmarket/features/home/presentation/screens/seller_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);

    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: '쫑알쫑알'.text.make(),
          centerTitle: false,
          actions: [
            if (currentIndex.value == 0) IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(
              onPressed: () {
                ref.watch(themeModeProvider.notifier).toggleTheme();
              },
              icon: const Icon(Icons.brightness_6),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
          ],
        ),
        body: IndexedStack(
          index: currentIndex.value,
          children: [FeedScreen(), SellerScreen(), Container(color: Colors.yellow), Container(color: Colors.green)],
        ).p(15),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (value) => currentIndex.value = value,
          selectedIndex: currentIndex.value,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: '쫑알쫑알'),
            NavigationDestination(icon: Icon(Icons.chat), label: '계산기'),
            NavigationDestination(icon: Icon(Icons.add), label: '매칭'),
            NavigationDestination(icon: Icon(Icons.person), label: '프로필'),
          ],
        ),
        floatingActionButton: switch (currentIndex.value) {
          0 => FloatingActionButton(onPressed: () {}, child: Icon(Icons.home)),
          1 => FloatingActionButton(onPressed: () {}, child: Icon(Icons.message)),
          2 => FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
          3 => FloatingActionButton(onPressed: () {}, child: Icon(Icons.person)),
          _ => FloatingActionButton(onPressed: () {}, child: Icon(Icons.help)),
        },
      ),
    );
  }
}
