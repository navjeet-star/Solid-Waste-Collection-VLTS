import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlts_swc/app/routes/app_pages.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/core/storage/shared_prefs_service.dart';
import 'package:vlts_swc/core/theme/dark_theme.dart';
import 'package:vlts_swc/core/theme/light_theme.dart';
import 'package:vlts_swc/features/home/modules/ulb_progress_report_screen.dart';
import 'package:vlts_swc/features/home/viewModels/home_view_model.dart';
import 'package:vlts_swc/l10n/app_localizations.dart';
import 'package:vlts_swc/models/ulb_model.dart';
import 'package:vlts_swc/widgets/common_date_picker.dart';
import 'package:vlts_swc/widgets/common_grouped_dropdown.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late HomeViewModel homeViewModel;

  setUp(() async {
    Get.reset();
    SharedPreferences.setMockInitialValues({});
    await SharedPrefsService.init();
    appLocale.value = const Locale('en');

    homeViewModel = Get.put(HomeViewModel());
    homeViewModel.ulbList.assignAll(UlbProgressData.sampleList);
  });

  tearDown(() {
    Get.reset();
  });

  Widget createTestWidget({
    Locale locale = const Locale('en'),
    ThemeData? theme,
  }) {
    appLocale.value = locale;
    return AppLocaleScope(
      notifier: appLocale,
      child: GetMaterialApp(
        locale: locale,
        theme: theme ?? lightTheme,
        darkTheme: darkTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const UlbProgressReportScreen(),
        getPages: AppPages.routes,
      ),
    );
  }

  group('UlbProgressReportScreen Tests', () {
    testWidgets('renders Dropdown, DatePicker, 13 metrics, and footer in English', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // 1. AppBar
      expect(find.text('ULB Progress Report'), findsOneWidget);

      // 2. Filter row (Dropdown + Date Picker)
      expect(find.byType(CommonGroupedDropdown<String>), findsOneWidget);
      expect(find.byType(CommonDatePicker), findsOneWidget);

      // 3. Telemetry Detailed Card Header (Almora)
      expect(find.text('Almora'), findsOneWidget);

      // 4. Required metrics
      expect(find.textContaining('Wards'), findsWidgets);
      expect(find.text('Covered Wards'), findsOneWidget);
      expect(find.text('Not Covered'), findsOneWidget);
      expect(find.text('Total Vehicles'), findsOneWidget);
      expect(find.text('Active Vehicles'), findsOneWidget);
      expect(find.text('Inactive Vehicles'), findsOneWidget);
      expect(find.text('Never Sent Data'), findsOneWidget);
      expect(find.text('Reached Ward'), findsOneWidget);
      expect(find.text('Not Reached'), findsOneWidget);
      expect(find.text('Assigned Route (KM)'), findsOneWidget);
      expect(find.text('Matched Route (KM)'), findsOneWidget);
      expect(find.text('Uncovered Route (KM)'), findsOneWidget);
      expect(find.text('Coverage %'), findsWidgets);

      // 5. Footer banner
      expect(find.textContaining('National Informatics Centre, Uttarakhand'), findsOneWidget);
      expect(find.textContaining('Server Update:'), findsOneWidget);
    });

    testWidgets('renders properly with Hindi localization', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestWidget(locale: const Locale('hi')));
      await tester.pumpAndSettle();

      // Localized AppBar title
      expect(find.text('निकायवार प्रगति रिपोर्ट'), findsOneWidget);

      // Localized Metrics
      expect(find.textContaining('वार्ड'), findsWidgets);
      expect(find.text('कवर किए गए वार्ड'), findsOneWidget);
      expect(find.text('कवर नहीं किए गए'), findsOneWidget);
      expect(find.text('कुल वाहन'), findsOneWidget);
      expect(find.text('सक्रिय वाहन'), findsOneWidget);

      // Localized footer
      expect(find.textContaining('राष्ट्रीय सूचना विज्ञान केंद्र'), findsOneWidget);
    });

    testWidgets('navigating with arguments sets selected ULB', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final targetUlb = UlbProgressData.sampleList[1]; // Nagar Nigam, Haldwani

      await tester.pumpWidget(
        AppLocaleScope(
          notifier: appLocale,
          child: GetMaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    Get.toNamed(
                      Routes.ulb_progress_Report,
                      arguments: targetUlb,
                    );
                  },
                  child: const Text('Go to Report'),
                );
              },
            ),
            getPages: [
              GetPage(
                name: Routes.ulb_progress_Report,
                page: () => const UlbProgressReportScreen(),
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Go to Report'));
      await tester.pumpAndSettle();

      expect(find.byType(UlbProgressReportScreen), findsOneWidget);
    });
  });
}
