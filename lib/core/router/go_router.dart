import 'package:fastcampusmarket/core/router/constants/allowed_paths.dart';
import 'package:fastcampusmarket/features/auth/views/login_route.dart';
import 'package:fastcampusmarket/features/cart/views/cart_route.dart';
import 'package:fastcampusmarket/features/feed/views/feed_route.dart';
import 'package:fastcampusmarket/features/product%20detail/views/product_detail_route.dart';
import 'package:fastcampusmarket/features/auth/views/sign_up_route.dart';
import 'package:fastcampusmarket/features/seller/views/seller_route.dart';
import 'package:fastcampusmarket/features/splash/views/splash_route.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:fastcampusmarket/features/home/views/home_screen.dart';

import 'package:fastcampusmarket/features/auth/providers/auth_controller.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'go_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final feedNavigatorKey = GlobalKey<NavigatorState>();
  final sellerNavigatorKey = GlobalKey<NavigatorState>();

  final auth = ref.watch(authControllerProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: SplashRoute.path,
    routes: [
      SplashRoute.route,
      LoginRoute.route,
      SignUpRoute.route,
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => HomeScreen(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(navigatorKey: feedNavigatorKey, routes: [FeedRoute.route]),
          StatefulShellBranch(
            navigatorKey: sellerNavigatorKey,
            routes: [SellerRoute.route(parentNavigatorKey: rootNavigatorKey)],
          ),
        ],
      ),
      CartRoute.route(parentNavigatorKey: rootNavigatorKey),
      ProductDetailRoute.route(parentNavigatorKey: rootNavigatorKey),
    ],
    redirect: (context, state) {
      final isLoggedIn = auth.isLogin;
      final currentPath = state.uri.path;
      final isAllowed = AllowedPaths.allowedPaths.contains(currentPath);

      if (currentPath == SplashRoute.path) {
        return isLoggedIn == null
            ? null
            : isLoggedIn && isAllowed
            ? FeedRoute.path
            : LoginRoute.path;
      }

      return null;
    },
  );
}
