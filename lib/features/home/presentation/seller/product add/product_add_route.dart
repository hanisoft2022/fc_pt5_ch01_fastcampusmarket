import 'package:fastcampusmarket/core/router/router.dart';
import 'package:fastcampusmarket/features/home/presentation/seller/product%20add/product_add_screen.dart';
import 'package:go_router/go_router.dart';

abstract class ProductAddRoute {
  static const name = 'add_product';
  static const path = '/add_product';

  static GoRoute route = GoRoute(
    name: name,
    path: path,
    parentNavigatorKey: GoRouterKeys.rootNavigatorKey,
    builder: (context, state) => AddProductScreen(),
  );
}
