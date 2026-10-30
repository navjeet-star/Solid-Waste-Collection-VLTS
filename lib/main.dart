import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/core/app_locale.dart';
import 'package:solid_waste_collection_vlts/core/theme/app_theme_mode.dart';
import 'package:solid_waste_collection_vlts/core/theme/dark_theme.dart';
import 'package:solid_waste_collection_vlts/core/theme/light_theme.dart';
import 'package:solid_waste_collection_vlts/l10n/app_localizations.dart';
import 'package:solid_waste_collection_vlts/overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocale,
      builder: (context, locale, child) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: appThemeMode,
          builder: (context, themeMode, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: locale,
              onGenerateTitle: (context) => context.l10n.appTitle,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: const OverviewScreen(),
            );
          },
        );
      },
    );
  }
}
