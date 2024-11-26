import 'package:bottom_sheet_search/bottom_sheet_search.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Sheet Search Demo',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(),
    );
  }
}

/// MyHomePage widget that demonstrates the bottom sheet search functionality
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: _HomePageContent(),
    );
  }
}

/// Consumer widget for the home page content
class _HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildGradientDecoration(),
      child: Container(
        color: const Color(0xff2C2B33).withOpacity(.8),
        child: Center(
          child: _SearchButton(),
        ),
      ),
    );
  }

  /// Builds the gradient decoration for the background
  BoxDecoration _buildGradientDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.4, 0.6, 1.0],
        colors: [
          Colors.blue,
          Colors.white,
          Colors.orange,
          Colors.purple,
        ],
      ),
    );
  }
}

/// Consumer widget for the search button
class _SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showSearchBottomSheet(context),
      icon: const FlutterLogo(size: 100),
    );
  }

  /// Shows the search bottom sheet
  void _showSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _SearchBottomSheetContent(context),
    );
  }
}

/// Consumer widget for the bottom sheet content
class _SearchBottomSheetContent extends StatelessWidget {
  final BuildContext parentContext;

  const _SearchBottomSheetContent(this.parentContext);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: BottomSheetSearchWidget<String>(
        /// Items to display in the search list
        items: const ['Banana', 'Apple', 'Orange', 'Pineapple'],
        /// Function to extract the searchable text from an item
        searchableText: (item) => item,
        /// Builder for the items in the search list
        itemBuilder: (_, item) => ListTile(
          title: Text(item),
        ),
        /// Function to handle the selection of an item
        onItemSelected: (item) => _handleItemSelection(item, context),
      ),
    );
  }

  /// Handles the selection of an item from the search list
  void _handleItemSelection(String item, BuildContext context) {
    Navigator.pop(context);
    ScaffoldMessenger.of(parentContext).showSnackBar(
      SnackBar(content: Text('Selected: $item')),
    );
  }
}
