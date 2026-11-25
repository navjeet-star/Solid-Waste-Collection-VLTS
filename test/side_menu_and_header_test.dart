import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlts_swc/core/storage/shared_prefs_service.dart';
import 'package:vlts_swc/features/home/hero_header_content.dart';
import 'package:vlts_swc/features/login/models/ProfileDetail.dart';
import 'package:vlts_swc/l10n/app_localizations.dart';
import 'package:vlts_swc/widgets/side_menu.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPrefsService.init();
  });

  group('HeroHeaderContent Initials Tests', () {
    testWidgets('renders dynamic initials passed via userInitials', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: HeroHeaderContent(
              onProfileTap: () {},
              onNotificationTap: () {},
              userInitials: 'RK',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('RK'), findsOneWidget);
    });

    testWidgets('derives dynamic initials from ProfileDetail user name', (tester) async {
      final user = ProfileDetail(
        name: 'Amit Verma',
        designation: 'Officer',
      );

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: HeroHeaderContent(
              onProfileTap: () {},
              onNotificationTap: () {},
              user: user,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('AV'), findsOneWidget);
    });

    testWidgets('falls back to "SW" when no user or initials provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: HeroHeaderContent(
              onProfileTap: () {},
              onNotificationTap: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('SW'), findsOneWidget);
    });
  });

  group('SideMenu Dynamic Profile Tests', () {
    testWidgets('renders dynamic officer profile in Drawer header', (tester) async {
      final officer = ProfileDetail(
        name: 'Amit Verma',
        designation: 'Executive Officer',
        emailID: 'amit.verma@gov.in',
      );

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            drawer: SideMenu(user: officer),
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  child: const Text('Open Drawer'),
                );
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Open drawer
      await tester.tap(find.text('Open Drawer'));
      await tester.pumpAndSettle();

      // Verify dynamic profile elements
      expect(find.text('AV'), findsOneWidget); // Initials
      expect(find.text('Amit Verma'), findsOneWidget); // Name
      expect(find.text('Executive Officer'), findsOneWidget); // Role/Designation
      expect(find.text('amit.verma@gov.in'), findsOneWidget); // Email
    });

    testWidgets('renders fallback Super Admin details when no user is passed', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            drawer: const SideMenu(),
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  child: const Text('Open Drawer'),
                );
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Open drawer
      await tester.tap(find.text('Open Drawer'));
      await tester.pumpAndSettle();

      expect(find.text('SA'), findsOneWidget); // Super Admin initials
      expect(find.text('Super Admin'), findsOneWidget); // Name
      expect(find.text('admin@swc.gov.in'), findsOneWidget); // Email
    });
  });
}
