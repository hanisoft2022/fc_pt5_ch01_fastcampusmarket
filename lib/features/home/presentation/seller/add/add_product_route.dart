import 'package:fastcampusmarket/features/home/presentation/seller/add/add_product_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:fastcampusmarket/core/router/go_router.dart' show rootNavigatorKey;

class AddProductRoute {
  static const name = 'add_product';
  static const path = '/add_product';

  static GoRoute route = GoRoute(
    name: name,
    path: path,
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => AddProductScreen(),
  );
}
