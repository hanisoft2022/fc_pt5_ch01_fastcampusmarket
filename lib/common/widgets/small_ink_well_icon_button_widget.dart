import 'package:flutter/material.dart';

InkWell smallInkWellIconButtonWidget(IconData iconData, {double borderRadius = 20}) {
  return InkWell(
    borderRadius: BorderRadius.circular(borderRadius),
    onTap: () {},
    child: Ink(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius)),
      child: Icon((iconData)),
    ),
  );
}
