import 'package:fastcampusmarket/core/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DeliveryButton extends StatelessWidget {
  const DeliveryButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        height: 50 + context.bottomPadding,
        color: Colors.red,
        child: Center(child: '배달 주문'.text.bold.size(context.textTheme.titleLarge!.fontSize).make()),
      ),
    );
  }
}
