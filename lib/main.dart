import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/core/app_colors.dart';
import 'package:solid_waste_collection_vlts/core/app_locale.dart';
import 'package:solid_waste_collection_vlts/l10n/app_localizations.dart';
import 'login_screen.dart';

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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: locale,
          title: 'Solid Waste Collection VLTS',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const LoginScreen(),
        );
      },
    );
  }
}
