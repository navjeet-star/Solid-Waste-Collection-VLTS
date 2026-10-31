import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solid_waste_collection_vlts/common_utils/generic_grid_view.dart';
import 'package:solid_waste_collection_vlts/main.dart';
import 'package:solid_waste_collection_vlts/models/module_item.dart';
import 'package:solid_waste_collection_vlts/ui/home/home_screen.dart';
import 'package:solid_waste_collection_vlts/ui/home/module_card_item.dart';

void main() {
  testWidgets('HomeScreen renders cleanly on modern phone (390x844)', (tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(GenericGridView<ModuleItem>), findsOneWidget);
    expect(find.byType(ModuleCardItem), findsNWidgets(4));
    expect(tester.takeException(), isNull);
  });

  testWidgets('HomeScreen renders cleanly on small screen (375x667)', (tester) async {
    tester.view.physicalSize = const Size(750, 1334);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('HomeScreen renders cleanly on tablet (800x1280)', (tester) async {
    tester.view.physicalSize = const Size(1600, 2560);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('GenericGridView and ModuleCardItem dynamically generate items from data list', (tester) async {
    String? tappedModuleId;

    final testModules = [
      ModuleItem(
        title: 'Attendance Dashboard',
        icon: Icons.how_to_reg_rounded,
        color: Colors.indigo,
        onTap: () => tappedModuleId = 'test_attendance',
      ),
      ModuleItem(
        title: 'ULB-wise Progress Report',
        icon: Icons.bar_chart_rounded,
        color: Colors.green,
        onTap: () => tappedModuleId = 'test_ulb_1',
      ),
      ModuleItem(
        title: 'ULB-wise Progress Report',
        icon: Icons.pie_chart_rounded,
        color: Colors.amber,
        onTap: () => tappedModuleId = 'test_ulb_2',
      ),
      ModuleItem(
        title: 'Swachhta App Complaints',
        icon: Icons.mark_chat_unread_rounded,
        color: Colors.red,
        onTap: () => tappedModuleId = 'test_swachhta',
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: GenericGridView<ModuleItem>(
              items: testModules,
              itemBuilder: (context, module, index) => ModuleCardItem(item: module),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Attendance Dashboard'), findsOneWidget);
    expect(find.text('ULB-wise Progress Report'), findsNWidgets(2));
    expect(find.text('Swachhta App Complaints'), findsOneWidget);
    expect(find.byType(ModuleCardItem), findsNWidgets(4));

    await tester.tap(find.text('Attendance Dashboard'));
    await tester.pumpAndSettle();
    expect(tappedModuleId, equals('test_attendance'));
  });
}
