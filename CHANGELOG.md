# Changelog

## 0.0.4 - 2024-03-XX

### Added
- New `BottomSheetDecoration` class for better theming organization
  - Encapsulates all visual customization properties
  - Provides a cleaner API for styling bottom sheets
  - Includes `copyWith` method for easy modifications

### Changed
- Refactored `BottomSheetSearchWidget` to use the new decoration class
- Improved code organization and maintainability
- Updated example app to demonstrate decoration usage

### Breaking Changes
- Individual styling properties have been moved to `BottomSheetDecoration`
- Previous style properties are now accessed through the decoration object:
  ```dart
  // Old way
  BottomSheetSearchWidget(
    backgroundColor: Colors.white,
    searchBarColor: Colors.grey[200],
    borderColor: Colors.blue
  )

  // New way
  BottomSheetSearchWidget(
    decoration: BottomSheetDecoration(
      backgroundColor: Colors.white,
      searchBarColor: Colors.grey[200],
      borderColor: Colors.blue,
    ),
  )
  ```
