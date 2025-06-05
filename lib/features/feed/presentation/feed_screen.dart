import 'package:fastcampusmarket/common/widgets/height_width_widgets.dart';
import 'package:fastcampusmarket/core/extensions/context.dart';
import 'package:fastcampusmarket/core/extensions/num_extensions.dart';
import 'package:fastcampusmarket/features/feed/presentation/categories_provider.dart';
import 'package:fastcampusmarket/features/feed/presentation/products_provider.dart';
import 'package:fastcampusmarket/features/product%20detail/presentation/product_detail_route.dart';

import 'package:fastcampusmarket/common/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class FeedScreen extends HookConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = usePageController(initialPage: 0);
    final categoryAsync = ref.watch(categoriesProvider);
    final productsAsync = ref.watch(saleProductsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        final _ = await ref.refresh(categoriesProvider.future);
        final _ = await ref.refresh(saleProductsProvider.future);
      },
      child: ListView(
        children: [
          SizedBox(
            height: 140,
            child: PageView(
              controller: controller,
              children: [
                Image.asset('assets/images/logo/indischool/indischool.png'),
                Image.asset('assets/images/logo/indischool/indischool.png'),
                Image.asset('assets/images/logo/indischool/indischool.png'),
              ],
            ),
          ),
          Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: JumpingDotEffect(dotWidth: 10, dotHeight: 10),
            ).pSymmetric(v: 10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              '카테고리'.text.bold.size(18).make(),
              TextButton(onPressed: () {}, child: '더보기'.text.make()),
            ],
          ),
          SizedBox(
            height: 200,
            child: categoryAsync.when(
              data:
                  (categories) => GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return GestureDetector(
                        onTap: () {
                          CustomSnackBar.successSnackBar(context, category.name);
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: context.appColors.primaryColor,
                            ),
                            height5,
                            category.name.text.make(),
                          ],
                        ),
                      );
                    },
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text(error.toString())),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              '오늘의 특가'.text.bold.size(18).make(),
              Spacer(),
              TextButton(
                onPressed: () async {
                  final _ = await ref.refresh(saleProductsProvider.future);
                },
                child: '새로고침'.text.make(),
              ),
              TextButton(onPressed: () {}, child: '더보기'.text.make()),
            ],
          ),
          SizedBox(
            height: 300,
            child: productsAsync.when(
              data:
                  (products) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final item = products[index];
                      return GestureDetector(
                        onTap:
                            () => context.pushNamed(
                              ProductDetailRoute.name,
                              pathParameters: {'id': item.id.toString()},
                            ),
                        child: SizedBox(
                          width: 140,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  item.imageUrl!,
                                  fit: BoxFit.cover,
                                  width: 140,
                                  height: 140,
                                ),
                              ),
                              height5,
                              '상품명: ${item.name}'.text.bold.ellipsis.make(),
                              '할인율: ${item.discountRate!}%'.text.ellipsis.make(),
                              '할인 전 가격: ${item.price.toWon()}'.text.lineThrough.ellipsis.make(),
                              '할인가: ${(item.price * (1 - item.discountRate! / 100)).toInt().toWon()}'
                                  .text
                                  .ellipsis
                                  .make(),
                            ],
                          ).pOnly(right: 10),
                        ),
                      );
                    },
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text(error.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
