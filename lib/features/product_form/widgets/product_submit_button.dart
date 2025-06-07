import 'package:flutter/material.dart';

class ProductSubmitButton extends StatelessWidget {
  final VoidCallback onSubmit;
  final bool isEdit;

  const ProductSubmitButton({required this.onSubmit, required this.isEdit, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSubmit,
      child: Ink(
        height: 50 + MediaQuery.of(context).padding.bottom,
        color: Colors.orange,
        child: Center(
          child: Text(
            isEdit ? '제품 수정' : '제품 추가',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
