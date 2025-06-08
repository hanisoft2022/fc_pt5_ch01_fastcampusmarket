import 'package:fastcampusmarket/features/auth/views/login_screen.dart';
import 'package:go_router/go_router.dart';

abstract class LoginRoute {
  static const name = 'login';
  static const path = '/login';

  static GoRoute route = GoRoute(
    name: name,
    path: path,
    builder: (context, state) => LoginScreen(),
  );
}
