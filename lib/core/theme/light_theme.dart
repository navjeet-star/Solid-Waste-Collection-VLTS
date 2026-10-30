import 'package:flutter/material.dart';

class LightColors {
  LightColors._();

  // Modern Eco-Green Palette for Waste Management & VLTS
  static const Color primary = Color(0xFF1B8E56); // Rich Emerald / Forest Green
  static const Color secondary = Color(0xFF10B981); // Mint / Jade Green
  static const Color background = Color(0xFFF7FAF8); // Clean fresh background
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1A2621);
  static const Color textSecondary = Color(0xFF6B7D74);
  static const Color border = Color(0xFFD6E2DA);
  static const Color divider = Color(0xFFE8EFEA);

  // Gradient colors (available if needed)
  static const Color gradientStart = Color(0xFFFFFFFF);
  static const Color gradientMiddle = Color(0xFFF0F7F3);
  static const Color gradientEnd = Color(0xFFE2F0E7);
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
    onSurfaceVariant: LightColors.textSecondary,
    outline: LightColors.border,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: LightColors.surface,
    foregroundColor: LightColors.textPrimary,
    elevation: 0,
  ),
);
