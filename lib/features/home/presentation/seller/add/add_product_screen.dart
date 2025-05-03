import 'package:fastcampusmarket/core/common/common.dart';
import 'package:fastcampusmarket/core/common/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:velocity_x/velocity_x.dart';

final _formKey = GlobalKey<FormState>();

class AddProductScreen extends HookWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isSale = useState<bool>(false);

    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final priceController = useTextEditingController();
    final stockController = useTextEditingController();
    final salePercentController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: '상품 추가'.text.make(),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.batch_prediction)),
          IconButton(onPressed: () {}, icon: Icon(Icons.add)),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: Ink(
                  height: context.deviceWidth * 0.6,
                  width: context.deviceWidth * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade300,
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.add), '제품(상품) 이미지 추가'.text.make()],
                  ),
                ),
              ),
              height20,
              '........'.text.make(),
            ],
          ),
        ),
      ),
    );
  }
}
