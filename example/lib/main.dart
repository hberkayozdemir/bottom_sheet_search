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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  /// Creates sample items for demonstration
  List<ListItem> _createSampleItems() {
    return [
      DefaultListItem(
        title: 'Instagram',
        leading:
            Image.asset('assets/instagram_icon.png', width: 24, height: 24),
        actions: const [Icon(Icons.arrow_forward_ios, size: 16)],
      ),
      DefaultListItem(
        title: 'Twitter / X',
        leading: Image.asset('assets/twitter_icon.png', width: 24, height: 24),
        actions: const [Icon(Icons.arrow_forward_ios, size: 16)],
      ),
      // Add more items as needed
      DefaultListItem(
        title: 'Twitter / X',
        leading: Image.asset('assets/twitter_icon.png', width: 24, height: 24),
        actions: const [Icon(Icons.arrow_forward_ios, size: 16)],
      ),
      DefaultListItem(
        title: 'Twitter / X',
        leading: Image.asset('assets/twitter_icon.png', width: 24, height: 24),
        actions: const [Icon(Icons.arrow_forward_ios, size: 16)],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
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
        ),
        child: Container(
          color: const Color(0xff2C2B33).withOpacity(.8),
          child: Center(
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: BottomSheetSearchWidget(
                      items: _createSampleItems(),
                      onItemSelected: (item) {
                        // Handle item selection
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Selected: ${item.title}')),
                        );
                      },
                    ),
                  ),
                );
              },
              icon: const FlutterLogo(size: 100),
            ),
          ),
        ),
      ),
    );
  }
}
