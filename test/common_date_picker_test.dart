import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vlts_swc/widgets/common_date_picker.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CommonDatePicker Widget Tests', () {
    test('defaultFormat formats dates as YYYY-MM-DD', () {
      final date = DateTime(2026, 11, 18);
      expect(CommonDatePicker.defaultFormat(date), '2026-11-18');

      final dateSingleDigits = DateTime(2026, 3, 5);
      expect(CommonDatePicker.defaultFormat(dateSingleDigits), '2026-03-05');
    });

    testWidgets('renders formatted date string and calendar icon', (tester) async {
      final testDate = DateTime(2026, 11, 18);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonDatePicker(
              selectedDate: testDate,
              onDateSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('2026-11-18'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_month_rounded), findsOneWidget);
    });

    testWidgets('renders hint text when selectedDate is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonDatePicker(
              selectedDate: null,
              hintText: 'Pick a Date',
              onDateSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Pick a Date'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_month_rounded), findsOneWidget);
    });

    testWidgets('renders prefixIcon when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonDatePicker(
              selectedDate: DateTime(2026, 5, 20),
              prefixIcon: Icons.event_rounded,
              onDateSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.event_rounded), findsOneWidget);
      expect(find.text('2026-05-20'), findsOneWidget);
    });

    testWidgets('supports custom dateFormatter', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonDatePicker(
              selectedDate: DateTime(2026, 11, 18),
              dateFormatter: (d) => '${d.day}/${d.month}/${d.year}',
              onDateSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('18/11/2026'), findsOneWidget);
    });

    testWidgets('tapping CommonDatePicker opens Flutter date picker dialog', (tester) async {
      DateTime? chosenDate;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonDatePicker(
              selectedDate: DateTime(2026, 11, 18),
              onDateSelected: (val) {
                chosenDate = val;
              },
            ),
          ),
        ),
      );

      // Tap the date picker container
      await tester.tap(find.byType(CommonDatePicker));
      await tester.pumpAndSettle();

      // Verify date picker dialog is shown
      expect(find.byType(DatePickerDialog), findsOneWidget);

      // Select 'OK' button to confirm
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      // Dialog is dismissed
      expect(find.byType(DatePickerDialog), findsNothing);
      expect(chosenDate, isNotNull);
    });
  });
}
