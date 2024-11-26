import 'package:flutter/material.dart';

/// A class that handles all theming properties for the BottomSheetSearchWidget
class BottomSheetDecoration {
  /// Creates a bottom sheet decoration configuration
  const BottomSheetDecoration({
    this.backgroundColor,
    this.searchBarColor,
    this.borderColor,
    this.cursorColor,
    this.searchTextStyle,
    this.hintTextStyle,
    this.itemTextStyle,
    this.borderRadius,
    this.searchBarBorderRadius,
    this.contentPadding,
    this.searchBarPadding,
    this.borderWidth = .25,
  });

  /// Background color of the bottom sheet
  final Color? backgroundColor;

  /// Color of the search bar
  final Color? searchBarColor;

  /// Color of the borders
  final Color? borderColor;

  /// Color of the cursor
  final Color? cursorColor;

  /// Text style for search input
  final TextStyle? searchTextStyle;

  /// Text style for hint text
  final TextStyle? hintTextStyle;

  /// Text style for list items
  final TextStyle? itemTextStyle;

  /// Border radius for bottom sheet
  final BorderRadius? borderRadius;

  /// Border radius for search bar
  final BorderRadius? searchBarBorderRadius;

  /// Padding for the content
  final EdgeInsets? contentPadding;

  /// Padding for search bar
  final EdgeInsets? searchBarPadding;

  /// Border width
  final double? borderWidth;

  /// Creates a copy of this decoration with the given fields replaced with new values
  BottomSheetDecoration copyWith({
    Color? backgroundColor,
    Color? searchBarColor,
    Color? borderColor,
    Color? cursorColor,
    TextStyle? searchTextStyle,
    TextStyle? hintTextStyle,
    TextStyle? itemTextStyle,
    BorderRadius? borderRadius,
    BorderRadius? searchBarBorderRadius,
    EdgeInsets? contentPadding,
    EdgeInsets? searchBarPadding,
    double? borderWidth,
  }) {
    return BottomSheetDecoration(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      searchBarColor: searchBarColor ?? this.searchBarColor,
      borderColor: borderColor ?? this.borderColor,
      cursorColor: cursorColor ?? this.cursorColor,
      searchTextStyle: searchTextStyle ?? this.searchTextStyle,
      hintTextStyle: hintTextStyle ?? this.hintTextStyle,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      borderRadius: borderRadius ?? this.borderRadius,
      searchBarBorderRadius:
          searchBarBorderRadius ?? this.searchBarBorderRadius,
      contentPadding: contentPadding ?? this.contentPadding,
      searchBarPadding: searchBarPadding ?? this.searchBarPadding,
      borderWidth: borderWidth ?? this.borderWidth,
    );
  }
}
