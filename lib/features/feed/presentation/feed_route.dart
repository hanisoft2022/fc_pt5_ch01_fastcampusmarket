import 'package:fastcampusmarket/features/cart/cart_route.dart';
import 'package:fastcampusmarket/features/feed/presentation/feed_screen.dart';
import 'package:fastcampusmarket/features/product%20detail/presentation/product_detail_route.dart';
import 'package:go_router/go_router.dart';

abstract class FeedRoute {
  static const name = 'feed';
  static const path = '/feed';

  static GoRoute route = GoRoute(
    name: name,
    path: path,
    builder: (context, state) => FeedScreen(),
    routes: [ProductDetailRoute.route, CartRoute.route],
  );
}
