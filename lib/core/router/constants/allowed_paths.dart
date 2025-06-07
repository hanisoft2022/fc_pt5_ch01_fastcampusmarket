import 'package:fastcampusmarket/features/auth/views/login_route.dart';
import 'package:fastcampusmarket/features/auth/views/sign_up_route.dart';

class AllowedPaths {
  static const login = LoginRoute.path;
  static const signUp = SignUpRoute.path;

  static const Set<String> allowedPaths = {login, signUp};
}
