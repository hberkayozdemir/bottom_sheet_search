import 'package:bottom_sheet_search/src/bottom_sheet_decoration.dart';
import 'package:bottom_sheet_search/src/bottom_sheet_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestItem {
  final String name;
  final String description;

  TestItem({required this.name, required this.description});
}

void main() {
  /// Test model class

  /// Test data
  final List<TestItem> testItems = [
    TestItem(name: 'Item 1', description: 'Description 1'),
    TestItem(name: 'Item 2', description: 'Description 2'),
    TestItem(name: 'Different 3', description: 'Description 3'),
  ];

  /// Common widget builder for tests
  Widget createWidgetUnderTest({
    List<TestItem>? items,
    BottomSheetDecoration? decoration,
    String? searchHint,
    List<Widget>? suffixIcons,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: BottomSheetSearchWidget<TestItem>(
          items: items ?? testItems,
          searchableText: (TestItem item) => item.name,
          onItemSelected: (_) {},
          itemBuilder: (_, item) => ListTile(
            key: ValueKey(item.name),
            title: Text(item.name),
            subtitle: Text(item.description),
          ),
          searchHint: searchHint ?? 'Search...',
          decoration: decoration ?? const BottomSheetDecoration(),
          suffixIcons: suffixIcons,
        ),
      ),
    );
  }

  group('BottomSheetSearchWidget', () {
    testWidgets('renders all items initially', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      for (var item in testItems) {
        expect(find.text(item.name), findsOneWidget);
        expect(find.text(item.description), findsOneWidget);
      }
    });

    testWidgets('filters items based on search text',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Item');
      await tester.pumpAndSettle();

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Different 3'), findsNothing);
    });

    testWidgets('handles empty search results', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'xyz');
      await tester.pumpAndSettle();

      for (var item in testItems) {
        expect(find.text(item.name), findsNothing);
      }
    });

    testWidgets('calls onItemSelected when item is tapped',
        (WidgetTester tester) async {
      TestItem? selectedItem;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BottomSheetSearchWidget<TestItem>(
              items: testItems,
              searchableText: (TestItem item) => item.name,
              onItemSelected: (item) => selectedItem = item,
              itemBuilder: (_, item) => ListTile(
                key: ValueKey(item.name),
                title: Text(item.name),
                subtitle: Text(item.description),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('Item 1')));
      await tester.pumpAndSettle();

      expect(selectedItem?.name, equals('Item 1'));
    });

    testWidgets('displays custom search hint', (WidgetTester tester) async {
      const customHint = 'Custom Search Hint';
      await tester.pumpWidget(createWidgetUnderTest(searchHint: customHint));
      await tester.pumpAndSettle();

      expect(find.text(customHint), findsOneWidget);
    });

    testWidgets('displays custom suffix icons', (WidgetTester tester) async {
      final suffixIcons = [
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.sort),
          onPressed: () {},
        ),
      ];

      await tester.pumpWidget(createWidgetUnderTest(suffixIcons: suffixIcons));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.filter_list), findsOneWidget);
      expect(find.byIcon(Icons.sort), findsOneWidget);
      expect(find.byIcon(Icons.mic_outlined), findsNothing);
    });

    testWidgets('handles case-insensitive search', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'iTem');
      await tester.pumpAndSettle();

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Different 3'), findsNothing);
    });

    testWidgets('displays autocomplete suggestions',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Item');
      await tester.pumpAndSettle();

      expect(
          find.byType(ListTile), findsNWidgets(2)); // Expecting 2 suggestions
    });
  });
}
