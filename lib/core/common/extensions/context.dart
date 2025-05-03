import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

extension ContextExtension on BuildContext {
  Gap get bottomPaddingGap => Gap(MediaQuery.of(this).padding.bottom);
}
