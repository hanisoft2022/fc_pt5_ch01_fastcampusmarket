import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductTitleMenuRow extends StatelessWidget {
  const ProductTitleMenuRow({super.key, required this.productName, required this.onReviewTap});

  final String productName;
  final VoidCallback onReviewTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        productName.text.bold.textStyle(context.textTheme.headlineMedium).make(),
        MenuAnchor(
          alignmentOffset: Offset(-50, 0),
          builder:
              (context, controller, child) => IconButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: Icon(Icons.more_vert, size: 30),
              ),
          menuChildren: [MenuItemButton(onPressed: onReviewTap, child: Text('리뷰 등록'))],
        ),
      ],
    );
  }
}
