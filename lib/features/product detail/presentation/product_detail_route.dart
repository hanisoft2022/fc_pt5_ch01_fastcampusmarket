import 'package:fastcampusmarket/core/router/go_router.dart';
import 'package:fastcampusmarket/features/product%20detail/presentation/product_details_screen.dart';
import 'package:go_router/go_router.dart';

abstract class ProductDetailRoute {
  static const name = 'productDetail';
  static const path = '/product-detail/:id';

  static GoRoute route = GoRoute(
    name: name,
    path: path,
    parentNavigatorKey: GoRouterKeys.rootNavigatorKey,
    builder: (context, state) {
      final String productId = state.pathParameters['id']!;
      return ProductDetailsScreen(productId: productId);
    },
  );
}
