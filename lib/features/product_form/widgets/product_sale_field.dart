import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductSaleField extends StatelessWidget {
  final bool isSale;
  final ValueChanged<bool> onSaleChanged;
  final TextEditingController salePercentController;

  const ProductSaleField({
    required this.isSale,
    required this.onSaleChanged,
    required this.salePercentController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile.adaptive(
          contentPadding: EdgeInsets.zero,
          title: '할인 여부'.text.make(),
          value: isSale,
          onChanged: onSaleChanged,
        ),
        if (isSale)
          TextFormField(
            controller: salePercentController,
            decoration: InputDecoration(
              labelText: '할인율',
              hintText: '최대 할인율은 100%입니다.',
              border: OutlineInputBorder(),
              suffix: '%'.text.make(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) return '할인율을 입력하세요.';
              final num = int.tryParse(value);
              if (num == null || num < 0 || num > 100) return '0~100 사이로 입력하세요.';
              return null;
            },
          ),
      ],
    );
  }
}
