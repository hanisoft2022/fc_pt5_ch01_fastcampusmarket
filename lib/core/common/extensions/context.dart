import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  /// Get MediaQuery Screen Size
  Size get screenSize => MediaQuery.sizeOf(this);

  double get deviceWidth => screenSize.width;
  double get deviceHeight => screenSize.height;

  ThemeData get theme => Theme.of(this);
}
