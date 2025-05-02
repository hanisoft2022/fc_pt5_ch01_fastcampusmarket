import 'package:fastcampusmarket/features/home/presentation/seller/add/add_product_screen.dart';
import 'package:go_router/go_router.dart';

class AddProductRoute {
  static const path = 'add_product';
  static const name = 'add_product';

  static GoRoute route = GoRoute(name: name, path: path, builder: (context, state) => AddProductScreen());
}
