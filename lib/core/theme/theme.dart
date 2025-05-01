import 'package:fastcampusmarket/core/colors/app_colors.dart';
import 'package:fastcampusmarket/core/colors/dark_app_colors.dart';
import 'package:fastcampusmarket/core/colors/light_app_colors.dart';
import 'package:flutter/material.dart';

enum ThemeType {
  light(LightAppColors()),
  dark(DarkAppColors());

  const ThemeType(this.appColors);

  final AppColors appColors;

  ThemeData get themeData => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.seedColor,
      brightness: this == ThemeType.light ? Brightness.light : Brightness.dark,
      surface: appColors.surfaceColor,
    ),
  );
}
