import 'package:fastcampusmarket/common/widgets/custom_snack_bar.dart';
import 'package:fastcampusmarket/core/theme/theme_mode_provider.dart';
import 'package:fastcampusmarket/features/auth/providers/auth_provider.dart';
import 'package:fastcampusmarket/features/auth/views/login_route.dart';
import 'package:fastcampusmarket/features/cart/presentation/cart_route.dart';
import 'package:fastcampusmarket/features/product_form/presentation/product_form_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                ref.watch(customThemeModeProvider.notifier).toggleTheme();
              },
              icon: const Icon(Icons.brightness_6),
            ),
            IconButton(
              onPressed: () async {
                await ref.watch(authNotifierProvider.notifier).logout();

                if (context.mounted) CustomSnackBar.successSnackBar(context, '로그아웃 되었습니다.');
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),

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
            onPressed: () {
              if (FirebaseAuth.instance.currentUser == null) {
                context.goNamed(LoginRoute.name);
                return;
              }
              context.pushNamed(CartRoute.name);
            },
            child: Icon(Icons.shopping_cart),
          ),
          1 => FloatingActionButton(
            onPressed: () => context.pushNamed(ProductFormRoute.name),
            child: Icon(Icons.add),
          ),
          _ => FloatingActionButton(onPressed: () {}, child: null),
        },
      ),
    );
  }
}
