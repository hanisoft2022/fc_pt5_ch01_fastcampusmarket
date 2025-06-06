import 'package:fastcampusmarket/features/home/models/category.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductCategoryDropdown extends StatelessWidget {
  final List<Category> categories;
  final Category? selectedCategory;
  final ValueChanged<Category?> onSelected;

  const ProductCategoryDropdown({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return categories.isNotEmpty
        ? DropdownMenu<Category>(
          hintText: '카테고리를 선택해주세요.',
          menuHeight: 300,
          expandedInsets: EdgeInsets.zero,
          initialSelection: selectedCategory,
          onSelected: onSelected,
          dropdownMenuEntries:
              categories
                  .map(
                    (Category category) =>
                        DropdownMenuEntry<Category>(value: category, label: category.name),
                  )
                  .toList(),
        )
        : '선택할 수 있는 카테고리 없음.'.text.make();
  }
}
