import 'package:fastcampusmarket/common/widgets/height_width_widgets.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDescriptionSection extends StatelessWidget {
  final String title;
  final String description;

  const ProductDescriptionSection({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.text.bold.textStyle(context.textTheme.titleLarge).make(),
        height10,
        description.text.make(),
      ],
    );
  }
}
