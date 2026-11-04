import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlts_swc/app/bindings/initial_binding.dart';
import 'package:vlts_swc/app/routes/app_pages.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/core/theme/app_theme_mode.dart';
import 'package:vlts_swc/core/theme/dark_theme.dart';
import 'package:vlts_swc/core/theme/light_theme.dart';
import 'package:vlts_swc/features/overview/view/overview_screen.dart';
import 'package:vlts_swc/l10n/app_localizations.dart';

Future<void> main() async {


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
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              locale: locale,
              onGenerateTitle: (context) => context.l10n.appTitle,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              initialBinding: InitialBinding(),
              getPages: AppPages.routes,
              initialRoute: AppPages.initial,
            );
          },
        );
      },
    );
  }
}
