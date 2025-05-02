import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: '상품 추가'.text.make()), body: Center(child: 'Add Product'.text.make()));
  }
}
