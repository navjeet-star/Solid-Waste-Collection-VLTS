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
  static const Color divider = Color(0xFF233129); // Dark divider

  // 7 Additional Semantic & Feature Colors
  static const Color tertiary = Color(0xFFFBBF24); // Amber / Highlight
  static const Color error = Color(0xFFF87171); // Soft Red / Alert
  static const Color success = Color(0xFF4ADE80); // Bright Green / Operational Status
  static const Color warning = Color(0xFFFBBF24); // Warm Amber / Caution
  static const Color info = Color(0xFF60A5FA); // Sky Blue / Telemetry
  static const Color cardBackground = Color(0xFF1F2B25); // Elevated Card Surface
  static const Color accent = Color(0xFF818CF8); // Soft Indigo / Attendance & Analytics

  static const Color blue = Color(0xFF2563EB);
  static const Color green = Color(0xFF16A34A);
  static const Color red = Color(0xFFDC2626);
  static const Color yellow = Color(0xFFEAB308);

  static const Color cardBg = Color(0xFF1F2B25);
  static const Color textTitle = Color(0xFFF0FDF4);
  static const Color textDesc = Color(0xFF9EABA2);

}

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: DarkColors.background,
  colorScheme: const ColorScheme.dark(
    primary: DarkColors.primary,
    secondary: DarkColors.secondary,
    surface: DarkColors.surface,
    onSurface: DarkColors.textPrimary,
    onSurfaceVariant: DarkColors.textSecondary,
    outline: DarkColors.border,
    shadow: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: DarkColors.surface,
    foregroundColor: DarkColors.textPrimary,
    elevation: 0,
  ),
);
