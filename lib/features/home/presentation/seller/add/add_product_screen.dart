import 'package:fastcampusmarket/core/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
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
                  height: context.screenWidth * 0.6,
                  width: context.screenWidth * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade300,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.add), '제품 이미지 추가'.text.make()],
                  ),
                ),
              ),
              height20,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    '제품 정보'.text.bold.size(context.textTheme.titleLarge!.fontSize).make(),
                    height25,
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: '제품명',
                        hintText: '제품명을 입력하세요',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => requiredValidator(value, '제품명'),
                      textInputAction: TextInputAction.next,
                    ),
                    height15,
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: '제품 설명',
                        hintText: '제품 설명을 입력해주세요',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => requiredValidator(value, '제품 설명'),
                      minLines: 4,
                      maxLines: null,
                      maxLength: 255,
                      keyboardType: TextInputType.multiline,
                    ),
                    height15,
                    TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                        labelText: '가격',
                        hintText: '1개 가격 입력',

                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    height15,
                    TextFormField(
                      controller: stockController,
                      decoration: InputDecoration(labelText: '재고', border: OutlineInputBorder()),
                    ),
                    height15,
                    TextFormField(
                      controller: salePercentController,
                      decoration: InputDecoration(labelText: '할인율', border: OutlineInputBorder()),
                    ),
                    height15,
                    SwitchListTile.adaptive(
                      title: '할인 여부'.text.make(),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      value: isSale.value,
                      onChanged: (value) => isSale.value = value,
                    ),
                    height15,
                    100.days.toString().text.make(),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.pop();
                          }
                        },
                        child: '제품 추가'.text.make(),
                      ),
                    ),
                    Gap(context.screenPadding.bottom),
                  ],
                ),
              ),
            ],
          ),
        ).pSymmetric(h: 20),
      ),
    );
  }
}
