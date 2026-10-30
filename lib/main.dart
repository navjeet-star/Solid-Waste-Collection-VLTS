import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/core/app_locale.dart';
import 'package:solid_waste_collection_vlts/core/theme/app_theme_mode.dart';
import 'package:solid_waste_collection_vlts/core/theme/dark_theme.dart';
import 'package:solid_waste_collection_vlts/core/theme/light_theme.dart';
import 'package:solid_waste_collection_vlts/l10n/app_localizations.dart';
import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([appLocale, appThemeMode]),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: appLocale.value,
          themeMode: appThemeMode.value,
          theme: lightTheme,
          darkTheme: darkTheme,
          title: 'Solid Waste Collection VLTS',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const LoginScreen(),
        );
      },
    );
  }
}
