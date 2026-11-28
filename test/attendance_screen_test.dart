import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlts_swc/app/routes/app_pages.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/core/network/base_api_response.dart';
import 'package:vlts_swc/core/storage/shared_prefs_service.dart';
import 'package:vlts_swc/core/theme/dark_theme.dart';
import 'package:vlts_swc/core/theme/light_theme.dart';
import 'package:vlts_swc/features/home/items/attendance_card_item.dart';
import 'package:vlts_swc/features/home/modules/attendance_screen.dart';
import 'package:vlts_swc/features/home/viewModels/home_view_model.dart';
import 'package:vlts_swc/l10n/app_localizations.dart';
import 'package:vlts_swc/models/attendance_model.dart';
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
    homeViewModel.attendanceStatusList.assignAll(
      AttendanceStatusList.sampleList,
    );
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
        home: const AttendanceScreen(),
        getPages: AppPages.routes,
      ),
    );
  }

  group('UlbAttendanceItem Model Tests', () {
    test('creates attendance item directly from UlbProgressData', () {
      final sample = UlbProgressData.sampleList.first;
      final record = UlbAttendanceItem.fromUlbProgress(sample);

      expect(record.ulbName, sample.ulbName);
      expect(record.present, greaterThan(0));
      expect(record.absent, greaterThanOrEqualTo(0));
      expect(record.leave, greaterThanOrEqualTo(0));
      expect(record.notMarked, greaterThanOrEqualTo(0));
      expect(record.totalStaff,
          record.present + record.absent + record.leave + record.notMarked);
    });

    test('supports sampleList fallback', () {
      expect(UlbAttendanceItem.sampleList.isNotEmpty, isTrue);
      expect(UlbAttendanceItem.sampleList.first.present, greaterThan(0));
    });
  });

  group('ApiResponse<List<AttendanceStatusList>> & AttendanceStatusList Tests', () {
    test('parses ApiResponse and AttendanceStatusList from JSON', () {
      final jsonMap = {
        "Code": "S",
        "Message": "Record fetched successfully.",
        "AttendanceStatusList": [
          {
            "ULBID": "248449",
            "ULBName": "Almora",
            "TotalEmployee": "130",
            "PresentCount": "98",
            "AbsentCount": "12",
            "LeaveCount": "5",
            "NotMarkedCount": "15",
            "PresentPercentage": "75.38",
            "AbsentPercentage": "9.23",
            "LeavePercentage": "3.85",
            "NotMarkedPercentage": "11.54",
            "ULBTypeName": "Nagar Nigam"
          }
        ]
      };

      final response = ApiResponse<List<AttendanceStatusList>>.fromJson(
        jsonMap,
        (data) => (data as List<dynamic>)
            .map((e) => AttendanceStatusList.fromJson(e))
            .toList(),
      );
      expect(response.code, 'S');
      expect(response.message, 'Record fetched successfully.');
      expect(response.isSuccess, isTrue);
      expect(response.data?.length, 1);

      final item = response.data!.first;
      expect(item.ulbid, '248449');
      expect(item.uLBName, 'Almora');
      expect(item.ulbName, 'Almora');
      expect(item.totalStaff, 130);
      expect(item.present, 98);
      expect(item.absent, 12);
      expect(item.leave, 5);
      expect(item.notMarked, 15);
      expect(item.uLBTypeName, 'Nagar Nigam');

      // Verify typed properties on item
      final attendanceItem = item;
      expect(attendanceItem.ulbName, 'Almora');
      expect(attendanceItem.present, 98);
      expect(attendanceItem.absent, 12);
      expect(attendanceItem.leave, 5);
      expect(attendanceItem.notMarked, 15);
      expect(attendanceItem.totalStaff, 130);
    });

    test('supports sampleList fallback', () {
      final sample = AttendanceStatusList.sampleList;
      expect(sample.isNotEmpty, isTrue);
      expect(sample.first.ulbName.isNotEmpty, isTrue);
    });
  });

  group('AttendanceScreen Widget Tests', () {
    testWidgets('renders Dropdown, DatePicker, Search, KPI banner, and Attendance Cards in English',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // 1. AppBar
      expect(find.text('Attendance Dashboard'), findsOneWidget);

      // 2. Filter controls
      expect(find.byType(CommonGroupedDropdown<String>), findsOneWidget);
      expect(find.byType(CommonDatePicker), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      // 3. Status indicators on cards
      expect(find.byType(AttendanceCardItem), findsWidgets);
      expect(find.text('Present'), findsWidgets);
      expect(find.text('Absent'), findsWidgets);
      expect(find.text('Leave'), findsWidgets);
      expect(find.text('Not Marked'), findsWidgets);

      // 4. Sample ULB Names displayed at the top of records
      expect(find.text('Nagar Nigam, Kanvnagri Kotdwar'), findsOneWidget);
      expect(find.text('Nagar Nigam, Haldwani'), findsOneWidget);
    });

    testWidgets('filters list by search query', (tester) async {
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

      // Search "Haldwani"
      await tester.enterText(find.byType(TextField), 'Haldwani');
      await tester.pumpAndSettle();

      expect(find.text('Nagar Nigam, Haldwani'), findsOneWidget);
      expect(find.text('Nagar Nigam, Kanvnagri Kotdwar'), findsNothing);

      // Clear search
      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pumpAndSettle();

      expect(find.text('Nagar Nigam, Kanvnagri Kotdwar'), findsOneWidget);
      expect(find.text('Nagar Nigam, Haldwani'), findsOneWidget);
    });

    testWidgets('renders cleanly with Hindi localization', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestWidget(locale: const Locale('hi')));
      await tester.pumpAndSettle();

      // Localized AppBar
      expect(find.text('उपस्थिति डैशबोर्ड'), findsOneWidget);

      // Localized status labels
      expect(find.text('उपस्थित'), findsWidgets);
      expect(find.text('अनुपस्थित'), findsWidgets);
      expect(find.text('अवकाश'), findsWidgets);
      expect(find.text('चिह्नित नहीं'), findsWidgets);
    });

    testWidgets('adapts responsively on compact width without overflow', (tester) async {
      // Extremely compact screen width (300px)
      tester.view.physicalSize = const Size(300, 700);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Verify no exceptions or overflow occurred and cards are rendered
      expect(find.byType(AttendanceCardItem), findsWidgets);
      expect(find.text('Present'), findsWidgets);
    });

    testWidgets('renders cleanly in dark theme', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestWidget(theme: darkTheme));
      await tester.pumpAndSettle();

      expect(find.byType(AttendanceCardItem), findsWidgets);
      expect(find.text('Present'), findsWidgets);
      expect(find.text('Absent'), findsWidgets);
    });

    testWidgets('tapping attendance card navigates with selected date and ulb id', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final firstCard = find.byType(AttendanceCardItem).first;
      await tester.tap(firstCard);
      await tester.pumpAndSettle();

      expect(Get.arguments, isNotNull);
      if (Get.arguments is Map) {
        final args = Get.arguments as Map;
        expect(args['ulbId'], isNotNull);
        expect(args['date'], isA<DateTime>());
      }
    });

    test('HomeViewModel.fetchAttendanceStatus accepts date and ulbId', () async {
      expect(
        () => homeViewModel.fetchAttendanceStatus(
          date: DateTime(2026, 11, 28),
          ulbId: '248449',
        ),
        returnsNormally,
      );
    });
  });
}
