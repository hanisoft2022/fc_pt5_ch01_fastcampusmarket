import 'package:fastcampusmarket/features/cart/data/models/cart_item.dart';
import 'package:fastcampusmarket/features/cart/providers/cart_controller.dart';
import 'package:fastcampusmarket/features/cart/providers/cart_items_provider.dart';
import 'package:fastcampusmarket/features/cart/widget/cart_item_tile.dart';
import 'package:fastcampusmarket/features/cart/widget/delivery_button.dart';
import 'package:fastcampusmarket/features/cart/widget/total_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User user = FirebaseAuth.instance.currentUser!;
    final AsyncValue<List<CartItem>> cartItems = ref.watch(cartItemsProvider);
    final double cartTotal = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(title: '${user.displayName}님의 장바구니'.text.make()),
      body: Column(
        children: [
          Expanded(
            child: cartItems.when(
              data:
                  (data) => ListView.separated(
                    itemCount: data.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final CartItem item = data[index];
                      return CartItemTile(
                        cartItem: item,
                        onRemove:
                            () async => await ref
                                .read(cartControllerProvider.notifier)
                                .removeFromCart(item.product!),
                        onIncrease:
                            () async => await ref
                                .read(cartControllerProvider.notifier)
                                .increaseQuantity(item.product!),
                        onDecrease:
                            () async => await ref
                                .read(cartControllerProvider.notifier)
                                .decreaseQuantity(item.product!),
                      ).p(10);
                    },
                  ),
              error: (error, stackTrace) => Center(child: error.toString().text.make()),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
          TotalWidget(cartTotal: cartTotal),
          DeliveryButton(onTap: () {}),
        ],
      ),
    );
  }
}
