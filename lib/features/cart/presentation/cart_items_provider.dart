import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fastcampusmarket/features/cart/data/models/cart_item.dart';
import 'package:fastcampusmarket/features/cart/data/datasources/cart_remote_datasource.dart';

part 'cart_items_provider.g.dart';

// 함수형 Provider로 생성 (코드 생성 사용)
@riverpod
Stream<List<CartItem>> cartItems(Ref ref) {
  return CartApi.watchCartItems();
}

@riverpod
double cartTotal(Ref ref) {
  final AsyncValue<List<CartItem>> cartItemsAsync = ref.watch(cartItemsProvider);

  return cartItemsAsync.when(
    data:
        (cartItems) =>
            cartItems.fold(0, (previousValue, cartItem) => previousValue + cartItem.totalPrice),
    loading: () => 0,
    error: (error, stackTrace) => 0,
  );
}
