import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vlts_swc/widgets/common_search_bar.dart';

void main() {
  group('CommonSearchBar Widget Tests', () {
    testWidgets('renders prefix icon, hintText, and TextField', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CommonSearchBar(
              hintText: 'Search records...',
            ),
          ),
        ),
      );

      expect(find.byType(CommonSearchBar), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.search_rounded), findsOneWidget);
      expect(find.text('Search records...'), findsOneWidget);
      // Clear button should not be visible when text is empty
      expect(find.byIcon(Icons.close_rounded), findsNothing);
    });

    testWidgets('updates text, invokes onChanged, and displays clear button', (tester) async {
      String typedText = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonSearchBar(
              hintText: 'Search...',
              onChanged: (val) {
                typedText = val;
              },
            ),
          ),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(TextField), 'Nainital');
      await tester.pump();

      expect(typedText, 'Nainital');
      expect(find.text('Nainital'), findsOneWidget);
      // Clear button should now be visible
      expect(find.byIcon(Icons.close_rounded), findsOneWidget);
    });

    testWidgets('tapping clear button clears text and invokes callbacks', (tester) async {
      final controller = TextEditingController(text: 'Initial Query');
      String changedText = 'Initial Query';
      bool clearTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonSearchBar(
              controller: controller,
              onChanged: (val) {
                changedText = val;
              },
              onClear: () {
                clearTapped = true;
              },
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.close_rounded), findsOneWidget);
      expect(controller.text, 'Initial Query');

      // Tap clear button
      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pump();

      expect(controller.text, '');
      expect(changedText, '');
      expect(clearTapped, isTrue);
      expect(find.byIcon(Icons.close_rounded), findsNothing);
    });

    testWidgets('supports custom styling (height, borderRadius, icons, and colors)', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonSearchBar(
              height: 50,
              prefixIcon: Icons.filter_alt_rounded,
              borderRadius: BorderRadius.circular(16),
              backgroundColor: Colors.amber.shade50,
              borderColor: Colors.amber,
              hintText: 'Filter by city',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.filter_alt_rounded), findsOneWidget);
      expect(find.text('Filter by city'), findsOneWidget);

      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(CommonSearchBar),
          matching: find.byType(SizedBox),
        ).first,
      );
      expect(sizedBox.height, 50);
    });
  });
}
