import 'package:fastcampusmarket/core/theme/theme_mode_provider.dart';
import 'package:fastcampusmarket/features/home/presentation/feed/cart/cart_route.dart';
import 'package:fastcampusmarket/features/home/presentation/seller/product%20add/product_add_route.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const HomeScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = navigationShell.currentIndex;

    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: '쫑알쫑알'.text.make(),
          centerTitle: false,
          actions: [
            if (currentIndex == 0) IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(
              onPressed: () {
                ref.watch(themeModeProvider.notifier).toggleTheme();
              },
              icon: const Icon(Icons.brightness_6),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
          ],
        ),

        // for commit, practicing firestore
        body: navigationShell.p(10),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (value) => navigationShell.goBranch(value),
          selectedIndex: currentIndex,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: '쫑알쫑알'),
            NavigationDestination(icon: Icon(Icons.sell), label: '판매자'),
          ],
        ),
        floatingActionButton: switch (currentIndex) {
          0 => FloatingActionButton(
            onPressed: () => context.goNamed(CartRoute.name),
            child: Icon(Icons.shopping_cart),
          ),
          1 => FloatingActionButton(
            onPressed: () => context.goNamed(ProductAddRoute.name),
            child: Icon(Icons.add),
          ),
          _ => FloatingActionButton(onPressed: () {}, child: null),
        },
      ),
    );
  }
}
