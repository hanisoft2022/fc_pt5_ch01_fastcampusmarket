import 'package:fastcampusmarket/core/common/common.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatelessWidget {
  final String uid;

  const CartScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: '장바구니'.text.make()),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
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
                                '상품 이름'.text.make(),
                                smallInkWellIconButtonWidget(Icons.delete),
                              ],
                            ),
                            '100000'.text.make(),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                smallInkWellIconButtonWidget(Icons.remove_circle_outline),
                                '1'.text.make().pSymmetric(h: 10),
                                smallInkWellIconButtonWidget(Icons.add_circle_outline),
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
