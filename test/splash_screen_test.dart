import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlts_swc/app/routes/app_pages.dart';
import 'package:vlts_swc/core/storage/shared_prefs_service.dart';
import 'package:vlts_swc/features/splash/views/splash_screen.dart';
import 'package:vlts_swc/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPrefsService.init();
    Get.testMode = true;
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('SplashScreen renders hero elements and titles', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      GetMaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: Routes.splash,
        getPages: AppPages.routes,
      ),
    );

    // Initial pump
    await tester.pump();

    // Verify main app title and subtitle are present
    expect(find.text('VLTS'), findsOneWidget);
    expect(find.text('Smart Waste Management System'), findsOneWidget);

    // Verify system tagline or status elements exist
    expect(find.byType(SplashScreen), findsOneWidget);

    // Advance time through total animation duration so all ticks complete
    await tester.pump(const Duration(milliseconds: 6000));
  });
}
