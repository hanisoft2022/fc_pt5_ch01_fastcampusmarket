import 'package:fastcampusmarket/core/common/widgets/height_width_widgets.dart';
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
    final categoryBatchTextEditingController = useTextEditingController();
    final categoryTextEditingController = useTextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchAnchor.bar(
          suggestionsBuilder: (context, controller) async {
            final query = controller.text.toLowerCase();
            final categories = await getCategories();
            final suggestions =
                categories.where((item) => item.toLowerCase().contains(query)).toList();
            return suggestions.map((suggestion) {
              return ListTile(
                title: Text(suggestion),
                onTap: () {
                  controller.closeView(suggestion);
                  CustomSnackBar.successSnackBar(context, '$suggestion 선택 완료!');
                },
              );
            }).toList();
          },
          isFullScreen: false,
          barHintText: '상품명 입력',
        ),
        height15,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () async {
                await showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Text('카테고리 일괄 등록'),
                        content: TextField(controller: categoryBatchTextEditingController),
                      ),
                );
              },
              child: '카테고리 일괄 등록'.text.make(),
            ),
            width20,
            ElevatedButton(
              onPressed: () async {
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
                                final result = await addCategory(
                                  context,
                                  categoryTextEditingController.text,
                                );
                                if (context.mounted) {
                                  context.pop();
                                  if (result) {
                                    CustomSnackBar.alertSnackBar(context, '이미 등록된 카테고리입니다.');
                                  } else {
                                    CustomSnackBar.successSnackBar(context, '카테고리 등록 성공!');
                                  }
                                }
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
          child: ListView.builder(
            itemCount: 10,
            itemBuilder:
                (context, index) => SizedBox(
                  height: 120,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber,
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
                                '상품명'.text.make(),
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
                                    MenuItemButton(child: Text('d'), onPressed: () {}),
                                    MenuItemButton(child: Text('f'), onPressed: () {}),
                                    MenuItemButton(child: Text('f'), onPressed: () {}),
                                  ],
                                ),
                              ],
                            ),
                            height5,
                            '상품가격'.text.make(),
                            height5,
                            '상품수량'.text.make(),
                          ],
                        ).pOnly(left: 10),
                      ),
                    ],
                  ),
                ).pSymmetric(v: 10),
          ),
        ),
      ],
    );
  }
}
