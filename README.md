# Bottom Sheet Search

![Bottom Sheet Search Demo](https://github.com/hberkayozdemir/bottom_sheet_search/raw/main/assets/bottom_sheet.gif)

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Getting Started](#getting-started)
  - [Basic Usage](#basic-usage)
  - [Advanced Customization](#advanced-customization)
- [API Reference](#api-reference)
- [Customization](#customization)
  - [Adding Suffix Icons](#adding-suffix-icons)
  - [Theming and Styling](#theming-and-styling)
- [Example](#example)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Introduction

**Bottom Sheet Search** is a robust Flutter package that offers a highly customizable bottom sheet search widget. Inspired by the elegant design of the Arc browser, this widget seamlessly integrates search functionality into your app's UI, providing users with an intuitive and efficient search experience.

## Features

- **Customizable Appearance**: Tailor colors, text styles, padding, and more to align with your app's theme.
- **Dynamic Search**: Real-time filtering of items as users type their queries.
- **Autocomplete Support**: Suggest relevant items based on user input to enhance the search experience.
- **Semantic Accessibility**: Improved accessibility with semantic labels for better user interaction.
- **Flexible Layout**: Easily integrates with your existing UI through adjustable margins and paddings.
- **Suffix Icons**: Add custom icons to the search bar for additional functionalities such as filtering or voice search.
- **Smooth Animations**: Enjoy seamless transitions and animations when interacting with the bottom sheet.

## Installation

To add `bottom_sheet_search` to your Flutter project, include it in your `pubspec.yaml` file:

```yaml
dependencies:
  bottom_sheet_search: ^1.0.0
```

Then, run the following command to fetch the package:

```bash
flutter pub get
```

## Getting Started

### Basic Usage

Here's a basic implementation of the `BottomSheetSearchWidget`:

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bottom_sheet_search/bottom_sheet_search.dart';

/// Example implementation of BottomSheetSearchWidget using Consumer.
///
/// Demonstrates integrating BottomSheetSearchWidget within a Flutter application
/// utilizing the Provider package for state management.
class UserSearchPage extends StatelessWidget {
  /// Creates a UserSearchPage widget.
  const UserSearchPage({super.key});

  /// Handles the selection of a user from the search results.
  void _handleUserSelection(BuildContext context, User selectedUser) {
    // Implement your selection logic here.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Selected user: ${selectedUser.name}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Search'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return BottomSheetSearchWidget<User>(
            items: userProvider.users,
            searchableText: (user) => user.name,
            onItemSelected: (user) => _handleUserSelection(context, user),
            itemBuilder: (context, user) {
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
              );
            },
            decoration: const BottomSheetDecoration(
              backgroundColor: Colors.white,
              searchBarColor: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            suffixIcons: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  // Implement filter functionality here.
                },
              ),
            ],
            autoCompleteBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion.name),
              );
            },
          );
        },
      ),
    );
  }
}

/// A simple User model.
class User {
  /// The name of the user.
  final String name;

  /// The email of the user.
  final String email;

  /// Creates a User instance.
  User({required this.name, required this.email});
}

/// A Provider for managing user data.
class UserProvider with ChangeNotifier {
  /// The list of users.
  final List<User> _users = [
    User(name: 'Alice', email: 'alice@example.com'),
    User(name: 'Bob', email: 'bob@example.com'),
    // Add more users as needed.
  ];

  /// Exposes the list of users.
  List<User> get users => _users;

  // Add methods to modify the user list if necessary.
}
```

### Advanced Customization

Enhance the `BottomSheetSearchWidget` by customizing its decoration and adding more functionalities:

```dart
import 'package:flutter/material.dart';
import 'package:bottom_sheet_search/bottom_sheet_search.dart';

/// Custom decoration for BottomSheetSearchWidget.
const BottomSheetDecoration customDecoration = BottomSheetDecoration(
  backgroundColor: Colors.blueAccent,
  searchBarColor: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(16),
    topRight: Radius.circular(16),
  ),
  borderColor: Colors.blue,
  borderWidth: 2.0,
  contentPadding: EdgeInsets.all(20),
  searchBarPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  cursorColor: Colors.blueAccent,
  searchTextStyle: TextStyle(color: Colors.black, fontSize: 18),
  hintTextStyle: TextStyle(color: Colors.grey, fontSize: 16),
);
```

## API Reference

### `BottomSheetSearchWidget<T>`

A generic widget that displays a bottom sheet with integrated search functionality.

#### Parameters

- **items** (`List<T>`): The list of items to display and search through.
- **searchableText** (`String Function(T)`): A function that returns the text to search within each item.
- **onItemSelected** (`void Function(T)`): A callback triggered when an item is selected.
- **itemBuilder** (`Widget Function(BuildContext, T)`): Builder function for each item in the list.
- **decoration** (`BottomSheetDecoration`): Customizes the appearance of the bottom sheet and search bar.
- **suffixIcons** (`List<Widget>`): List of widgets to display as suffix icons in the search bar.
- **autoCompleteBuilder** (`Widget Function(BuildContext, T)`): Builder function for autocomplete suggestions.

### `BottomSheetDecoration`

Defines the visual styling of the `BottomSheetSearchWidget`.

#### Properties

- **backgroundColor** (`Color`): Background color of the bottom sheet.
- **searchBarColor** (`Color`): Background color of the search bar.
- **borderRadius** (`BorderRadius`): Defines the border radius of the bottom sheet.
- **borderColor** (`Color`): Color of the border around the bottom sheet.
- **borderWidth** (`double`): Width of the border around the bottom sheet.
- **contentPadding** (`EdgeInsets`): Padding inside the bottom sheet content area.
- **searchBarPadding** (`EdgeInsets`): Padding inside the search bar.
- **cursorColor** (`Color`): Color of the cursor in the search bar.
- **searchTextStyle** (`TextStyle`): Text style of the search input.
- **hintTextStyle** (`TextStyle`): Text style of the hint text in the search bar.

## Customization

### Adding Suffix Icons

Enhance the search bar by adding custom suffix icons for additional functionalities.

```dart
import 'package:flutter/material.dart';
import 'package:bottom_sheet_search/bottom_sheet_search.dart';

/// Example of adding suffix icons to the search bar.
List<Widget> suffixIcons = [
  IconButton(
    icon: const Icon(Icons.filter_list),
    onPressed: () {
      // Implement filter functionality here.
    },
  ),
  IconButton(
    icon: const Icon(Icons.mic),
    onPressed: () {
      // Implement voice search functionality here.
    },
  ),
];
```

### Theming and Styling

Customize the appearance of the bottom sheet and search bar to match your app's theme.

```dart
import 'package:flutter/material.dart';
import 'package:bottom_sheet_search/bottom_sheet_search.dart';

/// Custom theming for BottomSheetSearchWidget.
const BottomSheetDecoration themedDecoration = BottomSheetDecoration(
  backgroundColor: Colors.deepPurple,
  searchBarColor: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  ),
  borderColor: Colors.deepPurpleAccent,
  borderWidth: 1.5,
  contentPadding: EdgeInsets.all(16),
  searchBarPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  cursorColor: Colors.deepPurple,
  searchTextStyle: TextStyle(color: Colors.black87, fontSize: 16),
  hintTextStyle: TextStyle(color: Colors.black54, fontSize: 14),
);
```

## Example

To see the `BottomSheetSearchWidget` in action, run the example provided in the `example` directory:

```bash
flutter run example/lib/main.dart
```

Ensure you have fetched the necessary dependencies by navigating to the `example` directory and running:

```bash
flutter pub get
```

## Contributing

Contributions are welcome! To contribute to **Bottom Sheet Search**, please follow these steps:

1. **Fork the Repository**: Click the "Fork" button at the top right of the repository page.
2. **Clone Your Fork**:

   ```bash
   git clone https://github.com/your-username/bottom_sheet_search.git
   ```

3. **Create a New Branch** for your feature or bugfix:

   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Make Your Changes**: Implement your feature or fix the bug.
5. **Commit Your Changes** with clear and descriptive messages:

   ```bash
   git commit -m "Add feature X"
   ```

6. **Push to Your Fork**:

   ```bash
   git push origin feature/your-feature-name
   ```

7. **Submit a Pull Request**: Navigate to the original repository and open a pull request detailing your changes.

Please ensure your contributions adhere to the project's coding standards and include necessary tests and documentation updates.

## License

This project is licensed under the [MIT License](LICENSE).

## Contact

For any inquiries or support, please open an issue on the [GitHub repository](https://github.com/hberkayozdemir/bottom_sheet_search).