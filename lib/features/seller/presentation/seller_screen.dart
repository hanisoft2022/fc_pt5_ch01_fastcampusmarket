import 'package:fastcampusmarket/common/widgets/height_width_widgets.dart';
import 'package:fastcampusmarket/core/data/datasources/category_remote_datasource.dart';
import 'package:fastcampusmarket/core/data/datasources/product_remote_datasource.dart';
import 'package:fastcampusmarket/features/feed/presentation/category_controller.dart';
import 'package:fastcampusmarket/features/home/data/models/category.dart';
import 'package:fastcampusmarket/features/home/data/models/product.dart';
import 'package:fastcampusmarket/common/widgets/custom_snack_bar.dart';
import 'package:fastcampusmarket/features/product%20detail/presentation/product_detail_route.dart';
import 'package:fastcampusmarket/features/product_form/presentation/product_form_route.dart';
import 'package:fastcampusmarket/features/seller/presentation/seller_providers.dart';
import 'package:fastcampusmarket/features/seller/widget/product_search_bar.dart';
import 'package:fastcampusmarket/features/seller/widget/seller_item_tile.dart';
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
        ProductSearchBar(
          searchBarTextEditingController: searchBarTextEditingController,
          onChanged: (value) => ref.read(searchQueryProvider.notifier).set(value),
          onClear: () {
            searchBarTextEditingController.clear();
            ref.read(searchQueryProvider.notifier).clear();
          },
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
                                final result = await ref
                                    .read(categoryControllerProvider.notifier)
                                    .addCategory(
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
                    return SellerItemTile(
                      product: product,
                      onTap:
                          () => (
                            context.pushNamed(
                              ProductDetailRoute.name,
                              pathParameters: {'id': product.id as String},
                            ),
                          ),
                      onDelete: () => ProductApi.deleteProduct(product),
                      onEdit: () => context.goNamed(ProductFormRoute.name, extra: product),
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
