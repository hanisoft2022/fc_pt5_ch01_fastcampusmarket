import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcampusmarket/core/common/extensions/num_extensions.dart';
import 'package:fastcampusmarket/core/common/widgets/height_width_widgets.dart';
import 'package:fastcampusmarket/features/home/data/models/category.dart';
import 'package:fastcampusmarket/features/home/data/models/product.dart';
import 'package:fastcampusmarket/features/home/presentation/seller/data/firebase_auth_datasource.dart';
import 'package:fastcampusmarket/shared/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'package:velocity_x/velocity_x.dart';

class SellerScreen extends HookWidget {
  const SellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchBarTextEditingController = useTextEditingController();

    final categoryTextEditingController = useTextEditingController();
    final searchQuery = useState('');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchBar(
          hintText: '상품명 입력',
          controller: searchBarTextEditingController,
          onChanged: (value) {
            searchQuery.value = value;
          },
          leading: const Icon(Icons.search).pOnly(left: 10),
          trailing: [
            IconButton(
              onPressed: () {
                searchBarTextEditingController.clear();
                searchQuery.value = '';
              },
              icon: const Icon(Icons.clear),
            ),
          ],
        ),
        height15,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
          child: StreamBuilder<QuerySnapshot<Product>>(
            stream: ProductApi.watchProducts(searchQuery.value),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('에러 발생: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('등록된 상품이 없습니다.'));
              }
              final productList = snapshot.data!.docs.toList();
              return ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  final Product product = productList[index].data();
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
                                        MenuItemButton(child: Text('리뷰 보기'), onPressed: () {}),
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
              );
            },
          ),
        ),
      ],
    );
  }
}
