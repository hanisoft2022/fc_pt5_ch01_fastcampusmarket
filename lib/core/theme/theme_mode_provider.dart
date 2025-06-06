import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode_provider.g.dart';

@riverpod
class CustomThemeMode extends _$CustomThemeMode {
  @override
  ThemeMode build() => ThemeMode.light;

  // * UPDATE
  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
