import 'package:fastcampusmarket/common/utils/validators.dart';
import 'package:fastcampusmarket/features/product_form/views/product_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductStockField extends StatelessWidget {
  const ProductStockField({super.key, required this.stockController});

  final TextEditingController stockController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: stockController,
      decoration: decoration(
        '수량',
      ).copyWith(suffix: '개'.text.make(), hintText: '최대 수량은 $maxCount개입니다.'),
      keyboardType: TextInputType.number,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => Validators.maxNumberValidator(value, maxCount),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      textInputAction: TextInputAction.next,
    );
  }
}
