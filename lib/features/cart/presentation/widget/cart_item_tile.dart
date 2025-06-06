import 'package:flutter/material.dart';
import 'package:fastcampusmarket/features/cart/data/models/cart_item.dart';
import 'package:velocity_x/velocity_x.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item.product!.imageUrl!,
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
                    item.product!.name.text.make(),
                    IconButton(icon: Icon(Icons.delete), onPressed: onRemove),
                  ],
                ),
                Row(children: ['할인 전 가격'.text.make(), '${item.product!.price}원'.text.make()]),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(icon: Icon(Icons.remove_circle_outline), onPressed: onDecrease),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('${item.quantity}'),
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
