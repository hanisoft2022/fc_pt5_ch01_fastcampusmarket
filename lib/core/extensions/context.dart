import 'package:fastcampusmarket/core/colors/app_colors.dart';
import 'package:fastcampusmarket/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

extension ContextExtension on BuildContext {
  double get bottomPadding => MediaQuery.of(this).padding.bottom;
  Gap get bottomPaddingGap => Gap(bottomPadding);

  AppColors get appColors {
    // Theme.of(context).brightness를 활용해 라이트/다크 구분
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark ? ThemeType.dark.appColors : ThemeType.light.appColors;
  }
}
