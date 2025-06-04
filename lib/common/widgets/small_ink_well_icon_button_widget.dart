import 'package:flutter/material.dart';

class SmallInkWellIconButtonWidget extends StatelessWidget {
  const SmallInkWellIconButtonWidget(
    this.iconData, {
    super.key,
    required this.onTap,
    this.borderRadius = 20,
  });

  final IconData iconData;
  final double borderRadius;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius)),
        child: Icon((iconData)),
      ),
    );
  }
}
