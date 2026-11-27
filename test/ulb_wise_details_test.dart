import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlts_swc/app/routes/app_pages.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/core/storage/shared_prefs_service.dart';
import 'package:vlts_swc/features/home/items/ulb_details_item.dart';
import 'package:vlts_swc/features/home/modules/ulb_wise_report_screen.dart';
import 'package:vlts_swc/l10n/app_localizations.dart';
import 'package:vlts_swc/models/ulb_detail_model.dart';
import 'package:vlts_swc/widgets/common_grouped_dropdown.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    Get.reset();
    SharedPreferences.setMockInitialValues({});
    await SharedPrefsService.init();
    appLocale.value = const Locale('en');
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
        home: const UlbWiseDetailsScreen(),
        getPages: AppPages.routes,
      ),
    );
  }

  group('UlbDetailItemModel Tests', () {
    test('sampleList contains 12 items (4 per category)', () {
      expect(UlbDetailItemModel.sampleList.length, 12);
      final nigamList = UlbDetailItemModel.sampleList.where((e) => e.ulbType == 'Nagar Nigam').toList();
      final palikaList = UlbDetailItemModel.sampleList.where((e) => e.ulbType == 'Nagar Palika Parishad').toList();
      final panchayatList = UlbDetailItemModel.sampleList.where((e) => e.ulbType == 'Nagar Panchayat').toList();

      expect(nigamList.length, 4);
      expect(palikaList.length, 4);
      expect(panchayatList.length, 4);
    });

    test('filterByOption filters by code and all', () {
      expect(UlbDetailItemModel.filterByOption('all').length, 12);
      expect(UlbDetailItemModel.filterByOption(null).length, 12);

      final nn1 = UlbDetailItemModel.filterByOption('nn_1');
      expect(nn1.length, 1);
      expect(nn1.first.ulbName, 'Nagar Nigam Dehradun');

      final npp2 = UlbDetailItemModel.filterByOption('npp_2');
      expect(npp2.length, 1);
      expect(npp2.first.ulbName, 'Nagar Palika Parishad Nainital');
    });
  });

  group('UlbWiseDetailsScreen Widget Tests', () {
    testWidgets('renders Dropdown and all 10 listing fields in English', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // AppBar title
      expect(find.text('ULB-wise Details'), findsOneWidget);

      // Grouped Dropdown
      expect(find.byType(CommonGroupedDropdown<String>), findsOneWidget);

      // Reusable UlbDetailsItem widgets
      expect(find.byType(UlbDetailsItem), findsWidgets);

      // First item verification: "Nagar Nigam Dehradun"
      expect(find.text('Nagar Nigam Dehradun'), findsOneWidget);

      // Check all 10 required item fields in the UI:
      // 1. ULB Name
      expect(find.text('Nagar Nigam Dehradun'), findsOneWidget);
      // 2. Wards (Registered / Target)
      expect(find.text('Wards'), findsWidgets);
      expect(find.textContaining('98 / 100'), findsOneWidget);
      // 3. Vehicles Registered (Registered / Target)
      expect(find.text('Vehicles Registered'), findsWidgets);
      expect(find.textContaining('215 / 220'), findsOneWidget);
      // 4. D2D Vehicles (Registered / Target)
      expect(find.text('D2D Vehicles'), findsWidgets);
      expect(find.textContaining('180 / 185'), findsOneWidget);
      // 5. Sanitary Inspector
      expect(find.textContaining('Sanitary Inspector:'), findsWidgets);
      // 6. Environment Inspector
      expect(find.textContaining('Environment Inspector:'), findsWidgets);
      // 7. Sanitary Worker
      expect(find.textContaining('Sanitary Worker:'), findsWidgets);
      // 8. Driver
      expect(find.textContaining('Driver:'), findsWidgets);
      // 9. Helper
      expect(find.textContaining('Helper:'), findsWidgets);
      // 10. Employee
      expect(find.textContaining('Employee:'), findsWidgets);
    });

    testWidgets('filters list immediately when an option is selected from dropdown', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Initially shows all items
      expect(find.text('Nagar Nigam Dehradun'), findsOneWidget);
      expect(find.text('Nagar Nigam Haridwar'), findsOneWidget);

      // Open the dropdown
      await tester.tap(find.byType(CommonGroupedDropdown<String>));
      await tester.pumpAndSettle();

      // Find and tap option 'nn_2' (Nagar Nigam 2 - Haridwar)
      // Category headers should be present
      expect(find.text('NAGAR NIGAM'), findsWidgets);
      expect(find.text('NAGAR PALIKA PARISHAD'), findsWidgets);
      expect(find.text('NAGAR PANCHAYAT'), findsWidgets);

      // Select '2' under Nagar Nigam
      final optionFinder = find.widgetWithText(DropdownMenuItem<String>, '2').first;
      await tester.tap(optionFinder);
      await tester.pumpAndSettle();

      // Now only Nagar Nigam Haridwar should be visible immediately
      expect(find.text('Nagar Nigam Haridwar'), findsOneWidget);
      expect(find.text('Nagar Nigam Dehradun'), findsNothing);
      expect(find.text('Nagar Palika Parishad Mussoorie'), findsNothing);
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
      expect(find.text('निकायवार विवरण'), findsOneWidget);

      // Localized metrics labels
      expect(find.text('वार्ड'), findsWidgets);
      expect(find.text('पंजीकृत वाहन'), findsWidgets);
      expect(find.text('डोर-टू-डोर वाहन'), findsWidgets);
      expect(find.textContaining('सफाई निरीक्षक:'), findsWidgets);
      expect(find.textContaining('पर्यावरण निरीक्षक:'), findsWidgets);
      expect(find.textContaining('सफाई कर्मी:'), findsWidgets);
      expect(find.textContaining('चालक:'), findsWidgets);
      expect(find.textContaining('सहायक:'), findsWidgets);
      expect(find.textContaining('कर्मचारी:'), findsWidgets);
    });
  });
}
