import 'package:fastcampusmarket/common/widgets/height_width_widgets.dart';
import 'package:fastcampusmarket/core/extensions/context.dart';
import 'package:fastcampusmarket/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PriceAndRatingsRow extends StatelessWidget {
  const PriceAndRatingsRow({
    super.key,
    required this.price,
    required this.rating,
    required this.reviewCount,
  });

  final double price;
  final int? reviewCount;
  final double? rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        price.toWon().text.bold.make(),
        Row(
          children: [
            '리뷰 수: '.text.bold.make(),
            reviewCount == null ? '리뷰 없음'.text.make() : reviewCount!.text.make(),
            '  |  '.text.bold.make(),
            '평점: '.text.bold.make(),
            Icon(Icons.star, color: context.appColors.ratingStarColor),
            rating == null ? '평점 없음'.text.make() : rating!.toStringAsFixed(1).text.make(),
          ],
        ),
      ],
    );
  }
}
