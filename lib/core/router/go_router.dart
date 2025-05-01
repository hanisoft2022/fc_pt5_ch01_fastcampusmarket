import 'package:fastcampusmarket/core/router/app_router.dart';
import 'package:fastcampusmarket/core/router/auth_provider.dart';
import 'package:fastcampusmarket/features/auth/presentation/s_login.dart';
import 'package:fastcampusmarket/features/auth/presentation/s_sign_up.dart';
import 'package:fastcampusmarket/features/home/presentation/s_home.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appRouterProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    routes: [
      GoRoute(path: AppRoutePath.root, redirect: (context, state) => AppRoutePath.home),
      GoRoute(name: AppRouteName.login, path: AppRoutePath.login, builder: (context, state) => LoginScreen()),
      GoRoute(name: AppRouteName.signUp, path: AppRoutePath.signUp, builder: (context, state) => SignUpScreen()),
      GoRoute(name: AppRouteName.home, path: AppRoutePath.home, builder: (context, state) => const HomeScreen()),
    ],
    redirect: (context, state) {
      final isLoggedIn = ref.read(isLoggedInProvider);
      final currentPath = state.fullPath;
      final allowedPaths = [AppRoutePath.login, AppRoutePath.signUp];

      if (!isLoggedIn && !allowedPaths.contains(currentPath)) {
        return AppRoutePath.login;
      }
      if (isLoggedIn && allowedPaths.contains(currentPath)) {
        return AppRoutePath.home;
      }

      return null;
    },
  ),
);
