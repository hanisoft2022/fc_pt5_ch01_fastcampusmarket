import 'package:fastcampusmarket/core/common/common.dart';
import 'package:fastcampusmarket/core/common/extensions/context.dart';
import 'package:fastcampusmarket/features/home/data/models/product.dart';
import 'package:fastcampusmarket/features/product%20detail/presentation/product_detail_route.dart';
import 'package:fastcampusmarket/features/seller/data/firebase_auth_datasource.dart';
import 'package:fastcampusmarket/common/widgets/custom_snack_bar.dart';
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
    final productsFuture = useState(Future.value(<Product>[]));

    useEffect(() {
      productsFuture.value = ProductApi.fetchProducts();
      return null;
    }, []);

    return RefreshIndicator(
      onRefresh: () async {
        productsFuture.value = ProductApi.fetchProducts();
        await productsFuture.value;
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
            child: FutureBuilder(
              future: CategoryApi.fetchCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final category = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        CustomSnackBar.successSnackBar(context, category.name);
                      },
                      child: Column(
                        children: [
                          CircleAvatar(radius: 30, backgroundColor: context.appColors.primaryColor),
                          height5,
                          category.name.text.make(),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              '오늘의 특가'.text.bold.size(18).make(),
              Spacer(),
              TextButton(
                onPressed: () => productsFuture.value = ProductApi.fetchProducts(),
                child: '새로고침'.text.make(),
              ),
              TextButton(onPressed: () {}, child: '더보기'.text.make()),
            ],
          ),
          SizedBox(
            height: 300,
            child: FutureBuilder(
              future: productsFuture.value,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return GestureDetector(
                      onTap: () => context.goNamed(ProductDetailRoute.name),
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
                            '할인율: ${item.saleRate!.toInt()}%'.text.ellipsis.make(),
                            '할인 전 가격: ${item.price.toWon()}'.text.lineThrough.ellipsis.make(),
                            '할인가: ${(item.price * (100 - item.saleRate!) / 100).toInt().toWon()}'
                                .text
                                .ellipsis
                                .make(),
                          ],
                        ).pOnly(right: 10),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
