import 'package:fastcampusmarket/core/router/constants/go_router_keys.dart';
import 'package:fastcampusmarket/core/router/constants/allowed_paths.dart';
import 'package:fastcampusmarket/features/cart/presentation/cart_route.dart';
import 'package:fastcampusmarket/features/product%20detail/presentation/product_detail_route.dart';
import 'package:fastcampusmarket/features/auth/views/sign_up_route.dart';

import 'package:go_router/go_router.dart';

import 'package:fastcampusmarket/features/home/views/home_screen.dart';

import 'package:fastcampusmarket/core/router/router.dart';

import 'package:fastcampusmarket/features/auth/providers/auth_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'go_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final bool isLoggedIn = ref.watch(authNotifierProvider).isLogin;

  return GoRouter(
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
      CartRoute.route,
      ProductDetailRoute.route,
    ],
    redirect: (context, state) {
      final currentPath = state.uri.path;
      final isAllowed = AllowedPaths.allowedPaths.contains(currentPath);

      // * 비로그인 상태에서 인증 경로(로그인/회원가입)가 아니면 로그인 페이지로
      if (!isLoggedIn && !isAllowed) {
        return LoginRoute.path;
      }

      // * 로그인 상태에서 로그인/회원가입 페이지 접근 시 피드로
      if (isLoggedIn && isAllowed) {
        return FeedRoute.path;
      }
      return null;
    },
  );
}
