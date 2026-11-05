import 'package:flutter/material.dart';
import 'package:vlts_swc/core/theme/dark_theme.dart';
import 'package:vlts_swc/core/theme/light_theme.dart';

extension CustomColorScheme on ColorScheme {
  Color get blue => brightness == Brightness.dark
      ? DarkColors.blue
      : LightColors.blue;

  Color get green => brightness == Brightness.dark
      ? DarkColors.green
      : LightColors.green;

  Color get red => brightness == Brightness.dark
      ? DarkColors.red
      : LightColors.red;

  Color get yellow => brightness == Brightness.dark
      ? DarkColors.yellow
      : LightColors.yellow;

  Color get cardBg => brightness == Brightness.dark
      ? DarkColors.cardBg
      : LightColors.cardBg;

  Color get textTitle => brightness == Brightness.dark
      ? DarkColors.textTitle
      : LightColors.textTitle;

  Color get textDesc => brightness == Brightness.dark
      ? DarkColors.textDesc
      : LightColors.textDesc;

}