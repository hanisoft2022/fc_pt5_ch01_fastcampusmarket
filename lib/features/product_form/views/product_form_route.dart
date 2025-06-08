import 'package:fastcampusmarket/features/home/models/product.dart';
import 'package:fastcampusmarket/features/product_form/views/product_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class ProductFormRoute {
  static const name = 'product-form';
  static const path = '/product-form';

  static GoRoute route({required GlobalKey<NavigatorState> parentNavigatorKey}) => GoRoute(
    name: name,
    path: path,
    parentNavigatorKey: parentNavigatorKey,
    builder: (context, state) {
      final Product? initialProduct = state.extra as Product?;
      return ProductFormScreen(initialProduct: initialProduct);
    },
  );
}
