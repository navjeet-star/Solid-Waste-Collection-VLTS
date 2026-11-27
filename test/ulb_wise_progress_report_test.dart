import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlts_swc/app/routes/app_pages.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/core/storage/shared_prefs_service.dart';
import 'package:vlts_swc/features/home/items/ulb_progress_card_item.dart';
import 'package:vlts_swc/features/home/modules/ulb_wise_progress_report.dart';
import 'package:vlts_swc/features/home/viewModels/home_view_model.dart';
import 'package:vlts_swc/l10n/app_localizations.dart';
import 'package:vlts_swc/models/ulb_model.dart';

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

  Widget createTestWidget({Locale locale = const Locale('en')}) {
    appLocale.value = locale;
    return AppLocaleScope(
      notifier: appLocale,
      child: GetMaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const UlbWiseProgressReportScreen(),
      ),
    );
  }

  group('UlbWiseProgressReportScreen Tests', () {
    testWidgets('renders KPI summary card, search bar, and sample ULB cards in English', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // AppBar title
      expect(find.text('ULB-wise Progress Report'), findsOneWidget);

      // KPI card metrics
      expect(find.text('Total ULB(s)'), findsWidgets);
      expect(find.text('Score'), findsWidgets);
      expect(find.text('Total Wards'), findsOneWidget);

      // Sample ULB names from sampleList
      expect(find.text('Nagar Nigam, Kanvnagri Kotdwar'), findsOneWidget);
      expect(find.text('Nagar Nigam, Haldwani'), findsOneWidget);
    });

    testWidgets('filters ULB list when search query is entered', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Nagar Nigam, Kanvnagri Kotdwar'), findsOneWidget);
      expect(find.text('Nagar Nigam, Haldwani'), findsOneWidget);

      // Enter search query "Haldwani"
      await tester.enterText(find.byType(TextField), 'Haldwani');
      await tester.pumpAndSettle();

      // Only Haldwani is visible
      expect(find.text('Nagar Nigam, Haldwani'), findsOneWidget);
      expect(find.text('Nagar Nigam, Kanvnagri Kotdwar'), findsNothing);

      // Clear search
      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pumpAndSettle();

      // Both visible again
      expect(find.text('Nagar Nigam, Kanvnagri Kotdwar'), findsOneWidget);
      expect(find.text('Nagar Nigam, Haldwani'), findsOneWidget);
    });

    testWidgets('renders in Hindi localization when locale is Hindi', (tester) async {
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

      // Localized KPI metrics
      expect(find.text('कुल यूएलबी'), findsWidgets);
      expect(find.text('स्कोर'), findsWidgets);
      expect(find.text('कुल वार्ड'), findsOneWidget);
    });

    testWidgets('pre-populates search filter when UlbProgressData is passed in arguments', (tester) async {
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
                      Routes.ulb_wise_progress_Report,
                      arguments: targetUlb,
                    );
                  },
                  child: const Text('Go to Report'),
                );
              },
            ),
            getPages: [
              GetPage(
                name: Routes.ulb_wise_progress_Report,
                page: () => const UlbWiseProgressReportScreen(),
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap navigation button with arguments
      await tester.tap(find.text('Go to Report'));
      await tester.pumpAndSettle();

      // Verify that Haldwani was pre-filtered in the list item
      expect(find.widgetWithText(UlbProgressListItem, 'Nagar Nigam, Haldwani'), findsOneWidget);
      expect(find.widgetWithText(UlbProgressListItem, 'Nagar Nigam, Kanvnagri Kotdwar'), findsNothing);
      expect(find.text('Nagar Nigam, Haldwani'), findsWidgets);
    });
  });
}
