import 'package:flutter/material.dart';

class LightColors {
  LightColors._();

  static const Color primary = Color(0xFF1769D2);
  static const Color secondary = Color(0xFF03A9F4);
  static const Color background = Color(0xFFF5F7FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);

  // Gradient colors
  static const Color gradientStart = Color(0xFFFFFFFF);
  static const Color gradientMiddle = Color(0xFFEAF4FF);
  static const Color gradientEnd = Color(0xFFD6E8FF);
}

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: LightColors.background,
  colorScheme: const ColorScheme.light(
    primary: LightColors.primary,
    secondary: LightColors.secondary,
    surface: LightColors.surface,
    onPrimary: Colors.white,
    onSurface: LightColors.textPrimary,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: LightColors.surface,
    foregroundColor: LightColors.textPrimary,
    elevation: 0,
  ),
);

