import 'package:fastcampusmarket/core/router/app_router.dart';
import 'package:fastcampusmarket/features/auth/presentation/s_login.dart';
import 'package:fastcampusmarket/features/home/presentation/s_home.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', redirect: (context, state) => AppRoutePath.home),
    GoRoute(
      name: AppRouteName.home,
      path: AppRoutePath.home,
      builder: (context, state) => const HomeScreen(),
      routes: [
        // GoRoute(
        //   name: AppRouteName.profile,
        //   path: 'profile/:userId',
        //   builder: (context, state) {
        //     final userId = state.pathParameters['userId']!;
        //     return ProfileScreen(userId: userId);
        //   },
        // ),
      ],
    ),
    GoRoute(name: AppRouteName.login, path: AppRoutePath.login, builder: (context, state) => LoginScreen()),
  ],
  redirect: (context, state) {
    final bool isLoggedIn = false;
    if (!isLoggedIn && state.path != AppRoutePath.login) {
      return AppRoutePath.login;
    }

    return null;
  },
);
