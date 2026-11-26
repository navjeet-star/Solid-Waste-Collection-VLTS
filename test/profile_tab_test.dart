import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/core/storage/shared_prefs_service.dart';
import 'package:vlts_swc/features/home/tabs/profile_info_tile.dart';
import 'package:vlts_swc/features/home/tabs/profile_tab.dart';
import 'package:vlts_swc/features/login/models/ProfileDetail.dart';
import 'package:vlts_swc/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPrefsService.init();
    appLocale.value = const Locale('en');
  });

  Widget createTestWidget({
    ProfileDetail? user,
    Locale locale = const Locale('en'),
  }) {
    appLocale.value = locale;
    return AppLocaleScope(
      notifier: appLocale,
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ProfileTab(user: user),
      ),
    );
  }

  group('ProfileTab Tests', () {
    testWidgets('renders all 6 required fields and avatar with default dummy data in English', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Header elements
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Rajesh Kumar Sharma'), findsWidgets);
      expect(find.text('Senior Sanitation Officer'), findsWidgets);
      expect(find.text('RS'), findsOneWidget); // Initials

      // Section titles
      expect(find.text('Profile Information'), findsOneWidget);
      expect(find.text('Official Information'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);

      // Settings options
      expect(find.text('Change Theme'), findsOneWidget);
      expect(find.text('Change Language'), findsOneWidget);
      expect(find.text('English'), findsWidgets);

      // Field labels (all 6 fields)
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Mobile Number'), findsOneWidget);
      expect(find.text('Email ID'), findsOneWidget);
      expect(find.text('Designation'), findsOneWidget);
      expect(find.text('Role'), findsOneWidget);
      expect(find.text('User Level'), findsOneWidget);

      // Field values
      expect(find.text('+91 98765 43210'), findsOneWidget);
      expect(find.text('rajesh.sharma@swc.gov.in'), findsOneWidget);
      expect(find.text('Operations Administrator'), findsOneWidget);
      expect(find.text('State Level (Level 1)'), findsOneWidget);

      // Icons
      expect(find.byIcon(Icons.person_outline_rounded), findsOneWidget);
      expect(find.byIcon(Icons.phone_outlined), findsOneWidget);
      expect(find.byIcon(Icons.email_outlined), findsOneWidget);
      expect(find.byIcon(Icons.work_outline_rounded), findsOneWidget);
      expect(find.byIcon(Icons.admin_panel_settings_outlined), findsOneWidget);
      expect(find.byIcon(Icons.layers_outlined), findsOneWidget);

      // Logout button
      expect(find.text('Logout'), findsOneWidget);
      expect(find.byIcon(Icons.logout_rounded), findsOneWidget);
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
      expect(find.text('प्रोफ़ाइल'), findsOneWidget);

      // Localized section titles
      expect(find.text('प्रोफ़ाइल जानकारी'), findsOneWidget);
      expect(find.text('आधिकारिक विवरण'), findsOneWidget);
      expect(find.text('सेटिंग्स'), findsOneWidget);

      // Localized settings options
      expect(find.text('थीम बदलें'), findsOneWidget);
      expect(find.text('भाषा बदलें'), findsOneWidget);

      // Localized field labels
      expect(find.text('नाम'), findsOneWidget);
      expect(find.text('मोबाइल नंबर'), findsOneWidget);
      expect(find.text('ईमेल आईडी'), findsOneWidget);
      expect(find.text('पद'), findsOneWidget);
      expect(find.text('भूमिका'), findsOneWidget);
      expect(find.text('उपयोगकर्ता स्तर'), findsOneWidget);

      // Localized logout
      expect(find.text('लॉग आउट'), findsOneWidget);
    });

    testWidgets('renders custom injected ProfileDetail (API ready)', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final customOfficer = ProfileDetail(
        name: 'Amit Verma',
        mobileNo: '+91 99887 76655',
        designation: 'Executive Officer',
        roleName: 'Municipal Commissioner',
        emailID: 'amit.verma@gov.in',
        userLevel: 'ULB Level',
      );

      await tester.pumpWidget(createTestWidget(user: customOfficer));
      await tester.pumpAndSettle();

      expect(find.text('Amit Verma'), findsWidgets);
      expect(find.text('Executive Officer'), findsWidgets);
      expect(find.text('+91 99887 76655'), findsOneWidget);
      expect(find.text('Municipal Commissioner'), findsOneWidget);
      expect(find.text('amit.verma@gov.in'), findsOneWidget);
      expect(find.text('ULB Level'), findsOneWidget);
      expect(find.text('AV'), findsOneWidget); // Initials
    });

    testWidgets('ProfileInfoTile standalone handles tap and renders custom trailing widget', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProfileInfoTile(
              icon: Icons.badge_outlined,
              label: 'Employee ID',
              value: 'EMP-1029',
              trailing: const Icon(Icons.copy_rounded, size: 16),
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Employee ID'), findsOneWidget);
      expect(find.text('EMP-1029'), findsOneWidget);
      expect(find.byIcon(Icons.copy_rounded), findsOneWidget);

      await tester.tap(find.byType(ProfileInfoTile));
      expect(tapped, isTrue);
    });
  });
}
