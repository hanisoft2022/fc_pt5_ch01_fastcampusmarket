import 'package:go_router/go_router.dart';
import 'seller_screen.dart';
import 'add/add_product_route.dart';

class SellerRoute {
  static const name = 'seller';
  static const path = '/seller';

  static GoRoute route = GoRoute(
    name: name,
    path: path,
    builder: (context, state) => SellerScreen(),
    routes: [AddProductRoute.route],
  );
}
