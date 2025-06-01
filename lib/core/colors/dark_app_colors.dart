import 'package:fastcampusmarket/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class DarkAppColors implements AppColors {
  const DarkAppColors();

  @override
  Color get surfaceColor => Color(0xFF121212);

  @override
  Color get imageBoxBackgroundColor => const Color(0xFF232323);

  @override
  Color get ratingStarColor => Colors.orangeAccent;

  @override
  Color get ratingStarEmptyColor => Colors.grey.shade500;

  @override
  Color get primaryColor => Colors.blueAccent;
}
