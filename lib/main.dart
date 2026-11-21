import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlts_swc/app/bindings/initial_binding.dart';
import 'package:vlts_swc/app/routes/app_pages.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/core/storage/shared_prefs_service.dart';
import 'package:vlts_swc/core/theme/app_theme_mode.dart';
import 'package:vlts_swc/core/theme/dark_theme.dart';
import 'package:vlts_swc/core/theme/light_theme.dart';
import 'package:vlts_swc/l10n/app_localizations.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  await SharedPrefsService.init();

  // Get app launch and login status
  final isFirstLaunch = SharedPrefsService.isFirstLaunch;
  final isLoggedIn = SharedPrefsService.isLoggedIn;

  // Determine initial route
  String initialRoute;

  if (isFirstLaunch) {
    initialRoute = Routes.overview;
  } else if (isLoggedIn) {
    // Retrieve saved login response if required
    final loginResponse =
    await SharedPrefsService.getLoginResponse();

    if (loginResponse != null) {
      initialRoute = Routes.home;
    } else {
      initialRoute = Routes.login;
    }
  } else {
    initialRoute = Routes.login;
  }

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, this.initialRoute = Routes.login});

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
              initialRoute: initialRoute,
            );
          },
        );
      },
    );
  }
}
