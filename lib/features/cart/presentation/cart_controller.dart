import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fastcampusmarket/features/home/data/models/product.dart';
import 'package:fastcampusmarket/features/cart/data/datasources/cart_remote_datasource.dart'; // CartApi

part 'cart_controller.g.dart';

@riverpod
class CartController extends _$CartController {
  @override
  FutureOr<void> build() {}

  // 장바구니에 상품 추가
  Future<void> addToCart(Product product) async {
    state = const AsyncLoading();
    try {
      await CartApi.addToCart(product);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
