import 'package:flutter/material.dart';

class DarkColors {
  DarkColors._();

  static const Color primary = Color(0xFF4C8DF5);
  static const Color secondary = Color(0xFF29B6F6);
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color textPrimary = Color(0xFFEEEEEE);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color border = Color(0xFF2E2E2E);
  static const Color divider = Color(0xFF2C2C2C);

  // Gradient colors
  static const Color gradientStart = Color(0xFF121212);
  static const Color gradientMiddle = Color(0xFF1A2634);
  static const Color gradientEnd = Color(0xFF1E2E42);
}

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: DarkColors.background,
  colorScheme: const ColorScheme.dark(
    primary: DarkColors.primary,
    secondary: DarkColors.secondary,
    surface: DarkColors.surface,
    onPrimary: Colors.black,
    onSurface: DarkColors.textPrimary,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: DarkColors.surface,
    foregroundColor: DarkColors.textPrimary,
    elevation: 0,
  ),
);

