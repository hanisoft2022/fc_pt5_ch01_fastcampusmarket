import 'package:fastcampusmarket/core/common/const/const.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SellerScreen extends StatelessWidget {
  const SellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry', 'Fig', 'Grapes'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchAnchor.bar(
          suggestionsBuilder: (context, controller) {
            final query = controller.text.toLowerCase();
            final suggestions = items.where((item) => item.toLowerCase().contains(query)).toList();
            return suggestions.map((suggestion) {
              return ListTile(
                title: Text(suggestion),
                onTap: () {
                  controller.closeView(suggestion);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('선택: $suggestion')));
                },
              );
            }).toList();
          },
        ),
        height15,
        OverflowBar(
          alignment: MainAxisAlignment.end,

          children: <Widget>[
            ElevatedButton(onPressed: () {}, child: '카테고리 일괄 등록'.text.make()),
            ElevatedButton(onPressed: () {}, child: '카테고리 등록'.text.make()),
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
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.amber),
                      ),
                      width15,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                '상품명'.text.make(),
                                SizedBox(
                                  width: 50,
                                  child: MenuAnchor(
                                    builder: (context, controller, child) {
                                      return IconButton(
                                        icon: Icon(Icons.more_vert),
                                        onPressed: () {
                                          if (controller.isOpen) {
                                            controller.close();
                                          } else {
                                            controller.open();
                                          }
                                        },
                                      );
                                    },
                                    menuChildren: [
                                      MenuItemButton(child: Text('fffdfdf'), onPressed: () {}),
                                      MenuItemButton(child: Text('f'), onPressed: () {}),
                                      MenuItemButton(child: Text('f'), onPressed: () {}),
                                    ],
                                  ),
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
