import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:fastcampusmarket/features/home/presentation/home_screen.dart';

import 'package:fastcampusmarket/core/router/router.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fastcampusmarket/core/router/auth_provider.dart';

abstract class GoRouterKeys {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final feedNavigatorKey = GlobalKey<NavigatorState>();
  static final sellerNavigatorKey = GlobalKey<NavigatorState>();
}

final appRouterProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    navigatorKey: GoRouterKeys.rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', redirect: (context, state) => FeedRoute.path),
      LoginRoute.route,
      SignUpRoute.route,
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => HomeScreen(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: GoRouterKeys.feedNavigatorKey,
            routes: [FeedRoute.route],
          ),
          StatefulShellBranch(
            navigatorKey: GoRouterKeys.sellerNavigatorKey,
            routes: [SellerRoute.route],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = ref.read(isLoggedInProvider);
      final currentPath = state.fullPath;
      final allowedPaths = [LoginRoute.path, SignUpRoute.path];

      if (!isLoggedIn && !allowedPaths.contains(currentPath)) {
        return LoginRoute.path;
      }
      if (isLoggedIn && allowedPaths.contains(currentPath)) {
        return FeedRoute.path;
      }
      return null;
    },
  ),
);
