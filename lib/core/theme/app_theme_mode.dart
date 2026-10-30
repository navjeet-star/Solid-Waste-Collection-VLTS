import 'package:flutter/material.dart';

/// Single source of truth for the app's theme mode
final ValueNotifier<ThemeMode> appThemeMode = ValueNotifier(ThemeMode.system);

/// Toggle theme mode between light and dark
void toggleTheme([BuildContext? context]) {
  if (appThemeMode.value == ThemeMode.dark) {
    appThemeMode.value = ThemeMode.light;
  } else if (appThemeMode.value == ThemeMode.light) {
    appThemeMode.value = ThemeMode.dark;
  } else {
    // If currently ThemeMode.system, toggle based on current device brightness
    if (context != null) {
      final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;
      appThemeMode.value = isDark ? ThemeMode.light : ThemeMode.dark;
    } else {
      appThemeMode.value = ThemeMode.dark;
    }
  }
}

