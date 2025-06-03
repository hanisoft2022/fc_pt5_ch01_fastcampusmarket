import 'package:fastcampusmarket/common/utils/validators.dart';
import 'package:fastcampusmarket/features/product_form/presentation/product_form_screen.dart';
import 'package:flutter/material.dart';

class ProductDescriptionField extends StatelessWidget {
  const ProductDescriptionField({super.key, required this.descriptionController});

  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: descriptionController,
      decoration: decoration('제품 설명').copyWith(alignLabelWithHint: true),
      validator: (value) => Validators.requiredValidator(value, '제품 설명'),
      minLines: 4,
      maxLines: null,
      maxLength: 255,
      keyboardType: TextInputType.multiline,
    );
  }
}
