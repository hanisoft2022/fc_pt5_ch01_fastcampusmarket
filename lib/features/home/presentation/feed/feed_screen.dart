import 'package:fastcampusmarket/features/home/presentation/feed/product%20detail/route/product_detail_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class FeedScreen extends HookWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = usePageController(initialPage: 0);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.grey.shade400,
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
          SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: JumpingDotEffect(dotWidth: 10, dotHeight: 10),
          ).pSymmetric(v: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              '카테고리'.text.bold.size(18).make(),
              TextButton(onPressed: () {}, child: '더보기'.text.make()),
            ],
          ),
          Container(height: 150, color: Colors.red),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              '오늘의 특가'.text.bold.size(18).make(),
              TextButton(onPressed: () {}, child: '더보기'.text.make()),
            ],
          ),
          Container(
            height: 150,
            color: Colors.green,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,

              itemBuilder:
                  (context, index) => GestureDetector(
                    onTap: () => context.goNamed(ProductDetailRoute.name),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(color: Colors.orange),
                    ).pSymmetric(h: 10),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
