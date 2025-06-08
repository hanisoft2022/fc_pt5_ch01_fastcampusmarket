import 'package:fastcampusmarket/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:fastcampusmarket/features/cart/models/cart_item.dart';
import 'package:velocity_x/velocity_x.dart';

class CartItemTile extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onRemove;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItemTile({
    super.key,
    required this.cartItem,
    required this.onRemove,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              cartItem.product!.imageUrl!,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cartItem.product!.name.text.make(),
                    cartItem.product!.isSale
                        ? '할인중'.text.bold.color(Colors.red).make()
                        : '할인 안 함 ㅅㄱ'.text.bold.color(Colors.red).make(),
                    IconButton(icon: Icon(Icons.delete), onPressed: onRemove),
                  ],
                ),
                Row(
                  children: [
                    '할인 전 가격: '.text.make(),
                    cartItem.product!.price.toInt().toWon().text.make(),
                  ],
                ),
                Row(
                  children: [
                    '할인 후 가격: '.text.make(),
                    cartItem.product!.salePrice.toInt().toWon().text.make(),
                  ],
                ),
                Row(
                  children: [
                    '제품 총 가격: '.text.make(),
                    cartItem.totalPrice.toInt().toWon().text.make(),
                  ],
                ),

                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(icon: Icon(Icons.remove_circle_outline), onPressed: onDecrease),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('${cartItem.quantity}'),
                    ),
                    IconButton(icon: Icon(Icons.add_circle_outline), onPressed: onIncrease),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
