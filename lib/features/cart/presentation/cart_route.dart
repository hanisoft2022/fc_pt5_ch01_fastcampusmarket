import 'package:fastcampusmarket/features/cart/presentation/screen/cart_screen.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/router.dart';

abstract class CartRoute {
  static const name = 'carts';
  static const path = '/carts';

  static GoRoute route = GoRoute(
    name: name,
    path: path,
    parentNavigatorKey: GoRouterKeys.rootNavigatorKey,
    builder: (context, state) {
      return CartScreen();
    },
  );
}
