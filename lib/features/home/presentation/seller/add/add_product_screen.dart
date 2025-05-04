// ignore_for_file: avoid_print

import 'package:fastcampusmarket/core/common/common.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:velocity_x/velocity_x.dart';

final _formKey = GlobalKey<FormState>();

const int maxPrice = 9999999;
const int maxCount = 999;

InputDecoration decoration(String name) =>
    InputDecoration(labelText: name, hintText: '$name을(를) 입력하세요.', border: OutlineInputBorder());

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
                    // 제품명
                    TextFormField(
                      controller: titleController,
                      decoration: decoration('제품명'),
                      validator: (value) => Validators.requiredValidator(value, '제품명'),
                      textInputAction: TextInputAction.next,
                    ),
                    height15,
                    // 제품 설명
                    TextFormField(
                      controller: descriptionController,
                      decoration: decoration('제품 설명').copyWith(alignLabelWithHint: true),
                      validator: (value) => Validators.requiredValidator(value, '제품 설명'),
                      minLines: 4,
                      maxLines: null,
                      maxLength: 255,
                      keyboardType: TextInputType.multiline,
                    ),
                    height15,
                    // 가격
                    TextFormField(
                      controller: priceController,
                      decoration: decoration(
                        '1개 가격',
                      ).copyWith(suffix: '원'.text.make(), hintText: '최대 금액은 9,999,999원입니다.'),
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => Validators.maxNumberValidator(value, maxPrice),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textInputAction: TextInputAction.next,
                    ),
                    height15,
                    // 수량
                    TextFormField(
                      controller: stockController,
                      decoration: decoration(
                        '수량',
                      ).copyWith(suffix: '개'.text.make(), hintText: '최대 수량은 $maxCount개입니다.'),
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => Validators.maxNumberValidator(value, maxCount),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textInputAction: TextInputAction.next,
                    ),
                    height15,

                    // 할인여부
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: '할인 여부'.text.make(),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      value: isSale.value,
                      onChanged: (value) => isSale.value = value,
                    ),
                    height15,
                    if (isSale.value)
                      // 할인율
                      TextFormField(
                        controller: salePercentController,
                        decoration: decoration(
                          '할인율',
                        ).copyWith(hintText: '최대 할인율은 100%입니다.', suffix: '%'.text.make()),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => Validators.maxNumberValidator(value, 100),
                      ),
                    height15,
                    // 제품 추가
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
                    // Bottom Padding
                    context.bottomPaddingGap,
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
