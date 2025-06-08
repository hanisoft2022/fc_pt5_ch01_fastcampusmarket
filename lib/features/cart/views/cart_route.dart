import 'package:fastcampusmarket/features/cart/views/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class CartRoute {
  static const name = 'carts';
  static const path = '/carts';

  static GoRoute route({required GlobalKey<NavigatorState> parentNavigatorKey}) => GoRoute(
    name: name,
    path: path,
    parentNavigatorKey: parentNavigatorKey,
    builder: (context, state) => CartScreen(),
  );
}
