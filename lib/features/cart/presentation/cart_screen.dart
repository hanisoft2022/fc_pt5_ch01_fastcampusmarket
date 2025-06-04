import 'package:fastcampusmarket/common/widgets/height_width_widgets.dart';
import 'package:fastcampusmarket/common/widgets/small_ink_well_icon_button_widget.dart';
import 'package:fastcampusmarket/core/extensions/context.dart';
import 'package:fastcampusmarket/core/extensions/num_extensions.dart';
import 'package:fastcampusmarket/features/cart/data/models/cart_item.dart';
import 'package:fastcampusmarket/features/cart/presentation/cart_controller.dart';
import 'package:fastcampusmarket/features/cart/presentation/cart_items_provider.dart';
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
                      return SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                            Container(width: 100, height: 100, color: Colors.redAccent),
                            width20,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      item.product!.name.text.make(),
                                      SmallInkWellIconButtonWidget(
                                        Icons.delete,
                                        onTap: () async {
                                          await ref
                                              .read(cartControllerProvider.notifier)
                                              .removeFromCart(item.product!);
                                        },
                                      ),
                                    ],
                                  ),
                                  item.product!.price.toWon().text.make(),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SmallInkWellIconButtonWidget(
                                        Icons.remove_circle_outline,
                                        onTap: () async {
                                          await ref
                                              .read(cartControllerProvider.notifier)
                                              .decreaseQuantity(item.product!);
                                        },
                                      ),
                                      item.quantity!.text.make().pSymmetric(h: 10),
                                      SmallInkWellIconButtonWidget(
                                        Icons.add_circle_outline,
                                        onTap: () async {
                                          await ref
                                              .read(cartControllerProvider.notifier)
                                              .increaseQuantity(item.product!);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ).p(10);
                    },
                  ),
              error: (error, stackTrace) => Center(child: error.toString().text.make()),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
          Container(
            height: 60,
            color: Colors.orange,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['합계'.text.bold.make(), '100,000원'.text.bold.make()],
            ).pSymmetric(h: 10),
          ),
          InkWell(
            onTap: () {},
            child: Ink(
              height: 50 + context.bottomPadding,
              color: Colors.red,
              child: Center(
                child: '배달 주문'.text.bold.size(context.textTheme.titleLarge!.fontSize).make(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
