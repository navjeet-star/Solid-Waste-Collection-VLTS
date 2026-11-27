import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/l10n/app_localizations.dart';
import 'package:vlts_swc/widgets/common_empty_view.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    Get.reset();
    appLocale.value = const Locale('en');
  });

  tearDown(() {
    Get.reset();
  });

  Widget createTestWidget({
    Widget child = const CommonEmptyView(),
    Locale locale = const Locale('en'),
  }) {
    appLocale.value = locale;
    return AppLocaleScope(
      notifier: appLocale,
      child: GetMaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: child),
      ),
    );
  }

  group('CommonEmptyView Widget Tests', () {
    testWidgets('renders default search_off icon and English "No data found"', (tester) async {
      await tester.pumpWidget(createTestWidget(child: const CommonEmptyView()));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.search_off_rounded), findsOneWidget);
      expect(find.text('No data found'), findsOneWidget);
    });

    testWidgets('renders localized Hindi "कोई डेटा नहीं मिला" when locale is Hindi', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const CommonEmptyView(),
          locale: const Locale('hi'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.search_off_rounded), findsOneWidget);
      expect(find.text('कोई डेटा नहीं मिला'), findsOneWidget);
    });

    testWidgets('renders custom title, subtitle, icon and action widget', (tester) async {
      bool actionClicked = false;

      await tester.pumpWidget(
        createTestWidget(
          child: CommonEmptyView(
            title: 'Custom Empty Title',
            subtitle: 'Please check your filters and try again',
            icon: Icons.inbox_outlined,
            iconSize: 56.0,
            action: ElevatedButton(
              onPressed: () {
                actionClicked = true;
              },
              child: const Text('Retry Action'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
      expect(find.text('Custom Empty Title'), findsOneWidget);
      expect(find.text('Please check your filters and try again'), findsOneWidget);
      expect(find.text('Retry Action'), findsOneWidget);

      await tester.tap(find.text('Retry Action'));
      expect(actionClicked, isTrue);
    });

    testWidgets('aliases CommonNoDataFound and CommonNoDataView work interchangeably', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const CommonNoDataFound(title: 'Alias Test'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Alias Test'), findsOneWidget);
      expect(find.byType(CommonEmptyView), findsOneWidget);
    });
  });
}
