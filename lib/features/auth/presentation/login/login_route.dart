import 'package:fastcampusmarket/features/auth/presentation/login/login_screen.dart';
import 'package:go_router/go_router.dart';

class LoginRoute {
  static const name = 'login';
  static const path = '/login';

  static GoRoute route = GoRoute(
    name: name,
    path: path,
    builder: (context, state) => LoginScreen(),
  );
}
