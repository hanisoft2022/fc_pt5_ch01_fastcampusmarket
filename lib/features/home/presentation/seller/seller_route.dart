import 'package:go_router/go_router.dart';
import 'seller_screen.dart';
import 'product add/product_add_route.dart';

abstract class SellerRoute {
  static const name = 'seller';
  static const path = '/seller';

  static GoRoute route = GoRoute(
    name: name,
    path: path,
    builder: (context, state) => SellerScreen(),
    routes: [ProductAddRoute.route],
  );
}
