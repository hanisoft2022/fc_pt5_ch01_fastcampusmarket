import 'package:fastcampusmarket/core/colors/app_colors.dart';
import 'package:fastcampusmarket/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

extension ContextExtension on BuildContext {
  Gap get bottomPaddingGap => Gap(MediaQuery.of(this).padding.bottom);

  AppColors get appColors {
    // Theme.of(context).brightness를 활용해 라이트/다크 구분
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark ? ThemeType.dark.appColors : ThemeType.light.appColors;
  }
}
