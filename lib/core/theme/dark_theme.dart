import 'package:flutter/material.dart';

class DarkColors {
  DarkColors._();

  // Modern Eco-Green Palette for Dark Theme
  static const Color primary = Color(0xFF34D399); // Vibrant accessible emerald green
  static const Color secondary = Color(0xFF6EE7B7); // Mint accent
  static const Color background = Color(0xFF101713); // Deep dark forest slate
  static const Color surface = Color(0xFF19231D); // Elevated surface
  static const Color textPrimary = Color(0xFFF0FDF4); // High contrast light text
  static const Color textSecondary = Color(0xFF9EABA2); // Muted sage text
  static const Color border = Color(0xFF28382F); // Subtle dark outline
  static const Color divider = Color(0xFF233129);

  // Gradient colors (available if needed)
  static const Color gradientStart = Color(0xFF101713);
  static const Color gradientMiddle = Color(0xFF14201A);
  static const Color gradientEnd = Color(0xFF1A2A22);
}

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: DarkColors.background,
  colorScheme: const ColorScheme.dark(
    primary: DarkColors.primary,
    secondary: DarkColors.secondary,
    surface: DarkColors.surface,
    onPrimary: Color(0xFF06331C), // High-contrast dark text on bright green primary
    onSurface: DarkColors.textPrimary,
    onSurfaceVariant: DarkColors.textSecondary,
    outline: DarkColors.border,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: DarkColors.surface,
    foregroundColor: DarkColors.textPrimary,
    elevation: 0,
  ),
);
