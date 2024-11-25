import 'package:bottom_sheet_search/bottom_sheet_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Creates sample items for demonstration
  List<ListItem> createSampleItems() {
    return [
      const DefaultListItem(
        title: 'Instagram',
        leading: Icon(Icons.photo),
        actions: [Icon(Icons.arrow_forward_ios, size: 16)],
      ),
      const DefaultListItem(
        title: 'Twitter',
        leading: Icon(Icons.chat),
        actions: [Icon(Icons.arrow_forward_ios, size: 16)],
      ),
      const DefaultListItem(
        title: 'Facebook',
        leading: Icon(Icons.facebook),
        actions: [Icon(Icons.arrow_forward_ios, size: 16)],
      ),
    ];
  }

  /// Helper function to build widget under test
  Widget createWidgetUnderTest({
    List<ListItem>? items,
    void Function(ListItem)? onItemSelected,
    Color? backgroundColor,
    Color? searchBarColor,
    String? searchHint,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: BottomSheetSearchWidget(
          items: items ?? createSampleItems(),
          onItemSelected: onItemSelected ?? ((ListItem _) {}),
          backgroundColor: backgroundColor,
          searchBarColor: searchBarColor,
          searchHint: searchHint ?? 'Search',
        ),
      ),
    );
  }

  group('BottomSheetSearchWidget', () {
    testWidgets('renders with default properties', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(BottomSheetSearchWidget), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('shows all items initially', (WidgetTester tester) async {
      final items = createSampleItems();
      await tester.pumpWidget(createWidgetUnderTest(items: items));

      for (final item in items) {
        expect(find.text(item.title), findsOneWidget);
      }
    });

    testWidgets('filters items based on search', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.byType(TextField), 'inst');
      await tester.pump();

      expect(find.text('Instagram'), findsOneWidget);
      expect(find.text('Twitter'), findsNothing);
      expect(find.text('Facebook'), findsNothing);
    });
  });
}
