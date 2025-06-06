import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fastcampusmarket/features/home/models/product.dart';
import 'package:fastcampusmarket/features/cart/data/datasources/cart_remote_datasource.dart';

part 'cart_controller.g.dart';

@riverpod
class CartController extends _$CartController {
  @override
  FutureOr<void> build() async {}

  // * CREATE
  Future<bool> addToCart(Product product) async {
    state = const AsyncLoading();
    try {
      final added = await CartApi.addToCart(product);
      state = const AsyncData(null);
      return added;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  // * UPDATE
  Future<void> increaseQuantity(Product product) async {
    await CartApi.increaseQuantity(product);
  }

  // * UPDATE
  Future<void> decreaseQuantity(Product product) async {
    await CartApi.decreaseQuantity(product);
  }

  // * DELETE
  Future<void> removeFromCart(Product product) async {
    await CartApi.removeFromCart(product);
  }

  // * DELETE
}
