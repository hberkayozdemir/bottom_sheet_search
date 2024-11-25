import 'package:flutter/material.dart';

/// A base class that defines the structure for search list items
abstract class ListItem {
  /// The title text to be displayed
  String get title;

  /// The leading widget (usually an icon or image)
  Widget get leading;

  /// List of action widgets to be displayed on the right side
  List<Widget> get actions;
}

/// A default implementation of ListItem for simple use cases
class DefaultListItem implements ListItem {
  /// Creates a default list item with required parameters
  const DefaultListItem({
    required this.title,
    required this.leading,
    this.actions = const [],
  });

  @override
  final String title;

  @override
  final Widget leading;

  @override
  final List<Widget> actions;
}
