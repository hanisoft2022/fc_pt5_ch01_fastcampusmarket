import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'seller_screen.dart';
import '../../product_form/views/product_form_route.dart';

abstract class SellerRoute {
  static const name = 'seller';
  static const path = '/seller';

  static GoRoute route({required GlobalKey<NavigatorState> parentNavigatorKey}) => GoRoute(
    name: name,
    path: path,
    builder: (context, state) => SellerScreen(),

    routes: [ProductFormRoute.route(parentNavigatorKey: parentNavigatorKey)],
  );
}
