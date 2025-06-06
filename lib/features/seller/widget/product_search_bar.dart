import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({
    super.key,
    required this.searchBarTextEditingController,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController searchBarTextEditingController;
  final void Function(String) onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: '상품명 입력',
      controller: searchBarTextEditingController,
      onChanged: onChanged,
      leading: const Icon(Icons.search).pOnly(left: 10),
      trailing: [IconButton(onPressed: onClear, icon: const Icon(Icons.clear))],
    );
  }
}
