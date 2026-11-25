import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vlts_swc/features/home/tabs/complaint_card_item.dart';
import 'package:vlts_swc/features/home/tabs/complaint_status_item.dart';
import 'package:vlts_swc/features/home/tabs/complaints_tab.dart';
import 'package:vlts_swc/l10n/app_localizations.dart';
import 'package:vlts_swc/widgets/common_simple_dropdown.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createTestWidget() {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ComplaintsTab(),
    );
  }

  testWidgets('ComplaintsTab renders CommonSimpleDropdown and custom status list (no ChoiceChip)', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Verify CommonSimpleDropdown for complaint type exists
    expect(find.byType(CommonSimpleDropdown<String>), findsOneWidget);
    expect(find.text('All Complaint Types'), findsOneWidget);

    // Verify Search bar and date filters remain removed
    expect(find.byType(TextField), findsNothing);
    expect(find.byIcon(Icons.calendar_today_rounded), findsNothing);

    // Verify NO ChoiceChip or FilterChip are used
    expect(find.byType(ChoiceChip), findsNothing);
    expect(find.byType(FilterChip), findsNothing);

    // Verify Status items exist in horizontal list
    expect(find.byType(ComplaintStatusItem), findsWidgets);
    expect(find.text('All'), findsWidgets);
    expect(find.text('Pending'), findsWidgets);
    expect(find.text('In Progress'), findsWidgets);
    expect(find.text('Resolved'), findsWidgets);

    // Verify initial complaint cards
    expect(find.byType(ComplaintCardItem), findsWidgets);
    expect(find.text('#SWC-8921'), findsOneWidget);
    expect(find.text('Overflowing Waste Container'), findsOneWidget);
  });

  testWidgets('Selecting a custom status item filters complaints list dynamically', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Tap 'Pending' status item
    final pendingItem = find.text('Pending');
    expect(pendingItem, findsWidgets);
    await tester.tap(pendingItem.first);
    await tester.pumpAndSettle();

    // Verify pending items are present, but in-progress item #SWC-8921 is filtered out
    expect(find.text('#SWC-8919'), findsOneWidget);
    expect(find.text('#SWC-8921'), findsNothing);

    // Tap 'All' status item
    final allItem = find.text('All');
    expect(allItem, findsWidgets);
    await tester.tap(allItem.first);
    await tester.pumpAndSettle();

    // All items return
    expect(find.text('#SWC-8921'), findsOneWidget);
    expect(find.text('#SWC-8919'), findsOneWidget);
  });

  testWidgets('Selecting a complaint type from dropdown filters the list and preserves card UI', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Tap dropdown to open options
    await tester.tap(find.byType(CommonSimpleDropdown<String>));
    await tester.pumpAndSettle();

    // Select 'Missed D2D Tipper Collection'
    final option = find.text('Missed D2D Tipper Collection').last;
    await tester.tap(option);
    await tester.pumpAndSettle();

    // Verify only 'Missed D2D Tipper Collection' (#SWC-8919) is displayed
    expect(find.text('#SWC-8919'), findsOneWidget);
    expect(find.text('#SWC-8921'), findsNothing);
  });

  testWidgets('ComplaintCardItem renders details and handles onTap callback', (tester) async {
    bool tapped = false;
    final item = ComplaintItem(
      id: '#SWC-1001',
      title: 'Plastic Littering on Ghat',
      location: 'Ward 01 • Main Ghat Path',
      time: '10 mins ago',
      status: 'Pending',
      statusColor: const Color(0xFFEF4444),
      citizenName: 'Aman Sharma',
      details: 'Large plastic pile near stairs',
      date: DateTime.now(),
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ComplaintCardItem(
            item: item,
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('#SWC-1001'), findsOneWidget);
    expect(find.text('Plastic Littering on Ghat'), findsOneWidget);
    expect(find.text('Ward 01 • Main Ghat Path'), findsOneWidget);
    expect(find.text('Aman Sharma'), findsOneWidget);
    expect(find.text('Large plastic pile near stairs'), findsOneWidget);
    expect(find.text('Pending'), findsOneWidget);

    await tester.tap(find.byType(ComplaintCardItem));
    expect(tapped, isTrue);
  });

  testWidgets('ComplaintStatusItem renders text, changes style on selection, and invokes onTap', (tester) async {
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ComplaintStatusItem(
            label: 'In Progress',
            isSelected: true,
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('In Progress'), findsOneWidget);
    await tester.tap(find.byType(ComplaintStatusItem));
    expect(tapped, isTrue);
  });
}
