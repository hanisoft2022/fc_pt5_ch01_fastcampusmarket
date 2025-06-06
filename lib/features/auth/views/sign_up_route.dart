import 'package:fastcampusmarket/features/auth/views/sign_up_screen.dart';
import 'package:go_router/go_router.dart';

class SignUpRoute {
  static const name = 'signUp';
  static const path = '/sign-up';

  static GoRoute route = GoRoute(
    name: name,
    path: path,
    builder: (context, state) => SignUpScreen(),
  );
}
