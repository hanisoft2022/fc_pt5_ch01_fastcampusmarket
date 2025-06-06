import 'package:fastcampusmarket/features/feed/presentation/screens/feed_screen.dart';
import 'package:go_router/go_router.dart';

abstract class FeedRoute {
  static const name = 'feed';
  static const path = '/feed';

  static GoRoute route = GoRoute(name: name, path: path, builder: (context, state) => FeedScreen());
}
