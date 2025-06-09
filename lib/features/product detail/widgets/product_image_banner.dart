import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductImageBanner extends StatelessWidget {
  const ProductImageBanner({super.key, required this.imageUrl, required this.isSale});

  final String imageUrl;
  final bool isSale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
      ),
      child:
          isSale
              ? Align(
                alignment: Alignment(0, -0.85),
                child: Container(
                  width: 80,
                  height: 40,
                  color: Colors.red,
                  child: Center(child: '할인중'.text.bold.color(Colors.white).make()),
                ),
              )
              : null,
    );
  }
}
