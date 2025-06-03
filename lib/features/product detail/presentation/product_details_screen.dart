import 'package:fastcampusmarket/common/widgets/height_width_widgets.dart';
import 'package:fastcampusmarket/core/extensions/context.dart';
import 'package:fastcampusmarket/core/extensions/num_extensions.dart';
import 'package:fastcampusmarket/features/feed/presentation/products_provider.dart';
import 'package:fastcampusmarket/features/home/data/models/product.dart';
import 'package:fastcampusmarket/features/product%20detail/presentation/review_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetailsScreen extends ConsumerWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(saleProductsProvider);
    final Product product = productsAsync.value!.firstWhere((element) => element.id == productId);

    return Scaffold(
      appBar: AppBar(title: product.name.text.make()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(product.imageUrl!), fit: BoxFit.cover),
              ),
              child:
                  product.isSale
                      ? Align(
                        alignment: Alignment(0, -0.85),
                        child: Container(
                          width: 80,
                          height: 40,
                          color: Colors.red,
                          child: Center(child: '할인중'.text.bold.color(Colors.white).make()),
                        ),
                      )
                      : null,
            ),
            height10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    product.name.text.bold.textStyle(context.textTheme.headlineMedium).make(),
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
                      menuChildren: [
                        MenuItemButton(
                          child: Text('리뷰 등록'),
                          onPressed:
                              () => showDialog(
                                context: context,
                                builder: (context) => ReviewDialog(),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
                height15,
                '제품 상세 정보'.text.bold.textStyle(context.textTheme.titleLarge).make(),
                height10,
                product.description.text.make(),
                height15,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    product.price.toWon().text.bold.make(),
                    Row(
                      children: [
                        Icon(Icons.star, color: context.appColors.ratingStarColor),
                        '4.5'.text.make(),
                      ],
                    ),
                  ],
                ),
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        splashBorderRadius: BorderRadius.circular(10),
                        tabs: [
                          Tab(
                            icon: Icon(Icons.insert_drive_file_outlined),
                            child: '상품정보'.text.make(),
                          ),
                          Tab(icon: Icon(Icons.rate_review_outlined), child: '리뷰'.text.make()),
                        ],
                      ),
                      height15,
                      Container(
                        decoration: BoxDecoration(color: Colors.red),
                        height: 400,
                        child: TabBarView(
                          children: [
                            Center(child: '상품정보'.text.make()),
                            Center(child: '리뷰'.text.make()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ).pSymmetric(h: 15),
            InkWell(
              onTap: () {},
              child: Ink(
                height: 50 + context.bottomPadding,
                color: Colors.orange,
                child: Center(
                  child: '장바구니'.text.bold.size(context.textTheme.titleLarge!.fontSize).make(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
