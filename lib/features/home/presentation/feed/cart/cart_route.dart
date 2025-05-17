import 'package:fastcampusmarket/features/home/presentation/feed/cart/cart_screen.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/router.dart';

abstract class CartRoute {
  static const name = 'cart';
  static const path = '/cart/:uid';

  static GoRoute route = GoRoute(
    name: name,
    path: path,
    builder: (context, state) => CartScreen(uid: state.pathParameters['uid'] ?? ''),
    parentNavigatorKey: GoRouterKeys.rootNavigatorKey,
  );
}
