import 'package:fastcampusmarket/core/common/extensions/num_extensions.dart';
import 'package:fastcampusmarket/core/common/widgets/height_width_widgets.dart';
import 'package:fastcampusmarket/core/data/datasources/category_remote_datasource.dart';
import 'package:fastcampusmarket/core/data/datasources/product_remote_datasource.dart';
import 'package:fastcampusmarket/features/home/data/models/category.dart';
import 'package:fastcampusmarket/features/home/data/models/product.dart';
import 'package:fastcampusmarket/features/product_form/presentation/product_form_route.dart';
import 'package:fastcampusmarket/common/widgets/custom_snack_bar.dart';
import 'package:fastcampusmarket/features/seller/presentation/seller_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:velocity_x/velocity_x.dart';

class SellerScreen extends HookConsumerWidget {
  const SellerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchBarTextEditingController = useTextEditingController();
    final categoryTextEditingController = useTextEditingController();

    final productListAsync = ref.watch(productListProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchBar(
          hintText: '상품명 입력',
          controller: searchBarTextEditingController,
          onChanged: (value) {
            ref.read(searchQueryProvider.notifier).set(value);
          },
          leading: const Icon(Icons.search).pOnly(left: 10),
          trailing: [
            IconButton(
              onPressed: () {
                searchBarTextEditingController.clear();
                ref.read(searchQueryProvider.notifier).clear();
              },
              icon: const Icon(Icons.clear),
            ),
          ],
        ),
        height15,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                CategoryApi.addCategories();
                CustomSnackBar.successSnackBar(context, '카테고리 일괄 등록 성공!');
              },
              child: '더미 카테고리 일괄 등록'.text.make(),
            ),
            width20,
            ElevatedButton(
              onPressed: () async {
                categoryTextEditingController.clear();
                await showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Text('카테고리 등록'),
                        content: TextField(controller: categoryTextEditingController),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              if (categoryTextEditingController.text.isNotEmpty) {
                                final result = await CategoryApi.addCategory(
                                  Category(name: categoryTextEditingController.text),
                                );
                                if (context.mounted) {
                                  if (result) {
                                    CustomSnackBar.successSnackBar(context, '카테고리 등록 성공!');
                                  } else {
                                    CustomSnackBar.alertSnackBar(context, '이미 등록된 카테고리입니다.');
                                  }
                                  context.pop();
                                }

                                return;
                              }

                              if (context.mounted) {
                                context.pop();
                                CustomSnackBar.alertSnackBar(context, '카테고리가 등록되지 않았습니다.');
                              }
                            },
                            child: Text('등록'),
                          ),
                        ],
                      ),
                );
              },
              child: '카테고리 등록'.text.make(),
            ),
          ],
        ),
        height15,
        '상품 목록'.text.bold.size(20).make(),
        height15,
        Expanded(
          child: productListAsync.when(
            data:
                (data) => ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final Product product = data[index];
                    return InkWell(
                      onTap: () => CustomSnackBar.successSnackBar(context, '상품 id: ${product.id}'),
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
                                          MenuItemButton(
                                            child: Text('삭제'),
                                            onPressed: () => ProductApi.deleteProduct(product),
                                          ),
                                          MenuItemButton(
                                            child: Text('수정'),
                                            onPressed: () {
                                              context.goNamed(
                                                ProductFormRoute.name,
                                                extra: product,
                                              );
                                            },
                                          ),
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
                  },
                ),
            error: (error, stackTrace) => Center(child: Text('에러 발생: $error')),
            loading: () => Center(child: CircularProgressIndicator()),
          ),
        ),
      ],
    );
  }
}
