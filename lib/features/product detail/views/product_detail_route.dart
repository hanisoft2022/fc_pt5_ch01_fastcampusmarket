import 'package:fastcampusmarket/features/product%20detail/views/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class ProductDetailRoute {
  static const name = 'productDetail';
  static const path = '/product-detail/:id';

  static GoRoute route({required GlobalKey<NavigatorState> parentNavigatorKey}) => GoRoute(
    name: name,
    path: path,
    parentNavigatorKey: parentNavigatorKey,
    builder: (context, state) {
      final String productId = state.pathParameters['id']!;
      return ProductDetailsScreen(productId: productId);
    },
  );
}
