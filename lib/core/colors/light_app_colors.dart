import 'package:fastcampusmarket/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class LightAppColors implements AppColors {
  const LightAppColors();

  @override
  Color get surfaceColor => const Color(0xFFF5F5F5);

  @override
  Color get imageBoxBackgroundColor => const Color(0xFFF0F0F0);

  @override
  Color get ratingStarColor => Colors.orange;

  @override
  Color get ratingStarEmptyColor => Colors.grey.shade400;

  @override
  Color get primaryColor => Colors.blueAccent.shade400;
}
