import 'package:fastcampusmarket/core/router/constants/go_router_keys.dart';
import 'package:fastcampusmarket/features/home/models/product.dart';
import 'package:fastcampusmarket/features/product_form/views/product_form_screen.dart';
import 'package:go_router/go_router.dart';

abstract class ProductFormRoute {
  static const name = 'product-form';
  static const path = '/product-form';

  static GoRoute route = GoRoute(
    name: name,
    path: path,
    parentNavigatorKey: GoRouterKeys.rootNavigatorKey,
    builder: (context, state) {
      final Product? initialProduct = state.extra as Product?;
      return ProductFormScreen(initialProduct: initialProduct);
    },
  );
}
