import 'package:fastcampusmarket/common/widgets/height_width_widgets.dart';
import 'package:fastcampusmarket/core/extensions/num_extensions.dart';
import 'package:fastcampusmarket/features/home/models/product.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class FeedSaleItemTile extends StatelessWidget {
  const FeedSaleItemTile({super.key, required this.onTap, required this.item});

  final VoidCallback onTap;
  final Product item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(item.imageUrl!, fit: BoxFit.cover, width: 140, height: 140),
            ),
            height5,
            '상품명: ${item.name}'.text.bold.ellipsis.make(),
            '할인율: ${item.discountRate}%'.text.ellipsis.make(),
            '할인 전 가격: ${item.price.toWon()}'.text.lineThrough.ellipsis.make(),
            '할인가: ${(item.salePrice).toInt().toWon()}'.text.ellipsis.make(),
          ],
        ).pOnly(right: 10),
      ),
    );
  }
}
