import 'package:fastcampusmarket/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TotalWidget extends StatelessWidget {
  const TotalWidget({super.key, required this.cartTotal});

  final double cartTotal;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.orange,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: ['합계'.text.bold.make(), cartTotal.toWon().text.bold.make()],
      ).pSymmetric(h: 10),
    );
  }
}
