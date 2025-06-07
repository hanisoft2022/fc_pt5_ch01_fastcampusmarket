import 'package:fastcampusmarket/common/utils/validators.dart';
import 'package:fastcampusmarket/features/product_form/views/product_form_screen.dart';
import 'package:flutter/material.dart';

class ProductNameField extends StatelessWidget {
  const ProductNameField({super.key, required this.nameController});

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: decoration('제품명'),
      validator: (value) => Validators.requiredValidator(value, '제품명'),
      textInputAction: TextInputAction.next,
    );
  }
}
