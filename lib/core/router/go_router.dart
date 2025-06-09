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
  print('라우트 프로바이더 실행');
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
      print('라우트 redirect');
      final isLoggedIn = auth.isLogin;
      final currentPath = state.uri.path;
      final isAllowed = AllowedPaths.allowedPaths.contains(currentPath);

      // 1. 인증 상태가 아직 결정되지 않은 경우(로딩 중) - 스플래시 화면에 머무름
      if (isLoggedIn == null) {
        print('isLoggedIn == null');
        return currentPath == SplashRoute.path ? null : SplashRoute.path;
      }

      // 2. Splash 화면에 있을 때, 인증 상태에 따라 분기
      if (currentPath == SplashRoute.path) {
        if (isLoggedIn) {
          print('로그인됨 → 피드로 이동');
          return FeedRoute.path;
        } else {
          print('로그인 안 됨 → 로그인으로 이동');
          return LoginRoute.path;
        }
      }

      // 3. 인증이 필요 없는 경로(로그인, 회원가입, 스플래시)는 언제나 접근 허용
      if (isAllowed) {
        print('isAllowed');
        return null;
      }

      // 4. 인증이 필요한 경로에 로그인하지 않은 사용자가 접근할 경우 - 로그인 화면으로 이동
      if (isLoggedIn == false) {
        print('isLoggedIn == false');
        return LoginRoute.path;
      }

      // 5. 그 외의 경우(로그인된 사용자가 인증이 필요한 경로 접근) - 리다이렉트 없음
      print('null');
      return null;
    },
  );
}
