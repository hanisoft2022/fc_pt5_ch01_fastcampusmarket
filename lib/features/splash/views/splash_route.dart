import 'package:fastcampusmarket/features/splash/views/splash_screen.dart';
import 'package:go_router/go_router.dart';

abstract class SplashRoute {
  static const path = '/splash';
  static const name = 'splash';

  static GoRoute route = GoRoute(
    name: name,
    path: path,
    builder: (context, state) => const SplashScreen(),
  );
}
