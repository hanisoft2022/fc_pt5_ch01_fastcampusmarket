import 'package:fastcampusmarket/common/utils/validators.dart';
import 'package:fastcampusmarket/features/product_form/presentation/product_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductPriceField extends StatelessWidget {
  const ProductPriceField({super.key, required this.priceController});

  final TextEditingController priceController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: priceController,
      decoration: decoration(
        '1개 가격',
      ).copyWith(suffix: '원'.text.make(), hintText: '최대 금액은 9,999,999원입니다.'),
      keyboardType: TextInputType.number,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => Validators.maxNumberValidator(value, maxPrice),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      textInputAction: TextInputAction.next,
    );
  }
}
