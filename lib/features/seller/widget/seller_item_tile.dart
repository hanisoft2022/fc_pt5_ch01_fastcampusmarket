import 'package:fastcampusmarket/common/widgets/height_width_widgets.dart';
import 'package:fastcampusmarket/core/extensions/num_extensions.dart';
import 'package:fastcampusmarket/features/home/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SellerItemTile extends StatelessWidget {
  const SellerItemTile({
    super.key,
    required this.product,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,
  });

  final Product product;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.network(
                  product.imageUrl ??
                      'https://cdn.pixabay.com/photo/2012/04/18/00/07/silhouette-of-a-man-36181_1280.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            width15,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      product.name.text.make(),
                      MenuAnchor(
                        alignmentOffset: Offset(-50, 0),
                        builder: (context, controller, child) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            },
                            child: Icon(Icons.more_vert),
                          );
                        },
                        menuChildren: [
                          MenuItemButton(onPressed: onDelete, child: Text('삭제')),
                          MenuItemButton(onPressed: onEdit, child: Text('수정')),
                        ],
                      ),
                    ],
                  ),
                  height5,
                  (product.price.toWon()).text.make(),
                  height5,
                  switch (product.isSale) {
                    true => '할인중',
                    false => '할인없음',
                  }.text.make(),
                  ('재고 수량: ${product.stock.toCount()}').text.make(),
                ],
              ).pOnly(left: 10),
            ),
          ],
        ),
      ).pSymmetric(v: 10),
    );
  }
}
