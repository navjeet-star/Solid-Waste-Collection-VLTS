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

  // 7 Additional Semantic & Feature Colors
  static const Color tertiary = Color(0xFFF59E0B); // Amber / Highlight
  static const Color error = Color(0xFFEF4444); // Red / Alert
  static const Color success = Color(0xFF16A34A); // Vibrant Green / Operational Status
  static const Color warning = Color(0xFFD97706); // Dark Amber / Warning
  static const Color info = Color(0xFF2563EB); // Telemetry Blue / Info
  static const Color cardBackground = Color(0xFFFFFFFF); // Elevated Card Surface
  static const Color accent = Color(0xFF6366F1); // Indigo / Attendance & Analytics


  static const Color blue = Color(0xFF2563EB);
  static const Color green = Color(0xFF16A34A);
  static const Color red = Color(0xFFDC2626);
  static const Color yellow = Color(0xFFEAB308);

  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textTitle = Color(0xFF000000);
  static const Color textDesc = Color(0xFF6B7D74);
}

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: LightColors.background,
  colorScheme: const ColorScheme.light(
    primary: LightColors.primary,
    secondary: LightColors.secondary,
    surface: LightColors.surface,
    onSurface: LightColors.textPrimary,
    onSurfaceVariant: LightColors.textSecondary,
    outline: LightColors.border,
    shadow: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: LightColors.surface,
    foregroundColor: LightColors.textPrimary,
    elevation: 0,
  ),
);

