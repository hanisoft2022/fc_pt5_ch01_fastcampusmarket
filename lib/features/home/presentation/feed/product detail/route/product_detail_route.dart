import 'package:fastcampusmarket/core/router/go_router.dart';
import 'package:fastcampusmarket/features/home/presentation/feed/product%20detail/screens/product_details_screen.dart';
import 'package:go_router/go_router.dart';

abstract class ProductDetailRoute {
  static const name = 'product_detail';
  static const path = '/product_detail';

  static GoRoute route = GoRoute(
    name: name,
    path: path,
    parentNavigatorKey: GoRouterKeys.rootNavigatorKey,
    builder: (context, state) => ProductDetailsScreen(),
  );
}
