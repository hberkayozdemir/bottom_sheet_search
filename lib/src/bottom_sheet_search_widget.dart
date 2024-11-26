import 'package:bottom_sheet_search/bottom_sheet_search.dart';
import 'package:flutter/material.dart';

/// A search component that displays a bottom sheet with search functionality and autocomplete.
///
/// This widget provides a customizable search interface within a bottom sheet that includes:
/// * A search bar with customizable styling and suffix icons
/// * A scrollable list of widgets that can be filtered based on search text
/// * Customizable decorations and themes
///
/// Example usage:
/// ```dart
///BottomSheetSearchWidget<User>(           items: userProvider.users,
///            searchableText: (user) => user.name,
///            onItemSelected: (user) => _handleUserSelection(context, user),
///            itemBuilder: (context, user) {
///              return ListTile(
///                title: Text(user.name),
///                subtitle: Text(user.email),
///              );
///            },
///            decoration: BottomSheetDecoration(
///              backgroundColor = Colors.white,
///              searchBarColor = Colors.grey[200],
///              borderRadius = const BorderRadius.only(
///                topLeft: Radius.circular(24),
///                topRight: Radius.circular(24),
///              ),
///            ),
///            suffixIcons: [
///              IconButton(
///                icon = const Icon(Icons.filter_list),
///                onPressed = () {
///  //Implement filter functionality here.
///                },
///              ),
///            ],BottomSheetSearchWidget<User>(
///            items: userProvider.users,
///            searchableText: (user) => user.name,
///            onItemSelected: (user) => _handleUserSelection(context, user),
///            itemBuilder: (context, user) {
///              return ListTile(
///                title: Text(user.name),
///                subtitle: Text(user.email),
///              );
///            },
///            decoration: const BottomSheetDecoration(
///              backgroundColor: Colors.white,
///              searchBarColor: Colors.grey[200],
///              borderRadius: BorderRadius.only(
///                topLeft: Radius.circular(24),
///                topRight: Radius.circular(24),
///              ),
///            ),
///            suffixIcons: [
///              IconButton(
///                icon: const Icon(Icons.filter_list),
///                onPressed: () {
///  //Implement filter functionality here.
///                },
///         ),
///    ],
/// ```
class BottomSheetSearchWidget<T> extends StatefulWidget {
  /// Creates a bottom sheet search component
  const BottomSheetSearchWidget({
    super.key,
    required this.items,
    required this.searchableText,
    required this.onItemSelected,
    required this.itemBuilder,
    this.searchHint = 'Search...',
    this.decoration = const BottomSheetDecoration(),
    this.suffixIcons,
    this.searchController,
    this.filterOptions = const FilterOptions(),
    this.onFilterChanged,
    this.autoCompleteBuilder,
    this.isMagnifyingGlassIconEnabled = true,
  });

  /// List of items to be displayed and searched through.
  final List<T> items;

  /// Function that returns the searchable text for each item.
  /// This text will be used for filtering the items.
  final String Function(T item) searchableText;

  /// Callback function that is triggered when an item is selected from the list.
  /// Returns the selected item of type T.
  final void Function(T item) onItemSelected;

  /// Builder function that returns a widget for each item
  final Widget Function(BuildContext context, T item) itemBuilder;

  /// The placeholder text shown in the search field when it's empty.
  /// Defaults to 'Search...'.
  final String searchHint;

  /// Decoration configuration for customizing the appearance of the bottom sheet.
  /// See [BottomSheetDecoration] for available customization options.
  final BottomSheetDecoration decoration;

  /// Optional list of widgets to be displayed as suffix icons in the search bar.
  /// Commonly used for adding functionality like voice search or filters.
  final List<Widget>? suffixIcons;

  /// Optional TextEditingController for the search field.
  /// If not provided, an internal controller will be created.
  final TextEditingController? searchController;

  /// Options for controlling the filtering behavior
  final FilterOptions filterOptions;

  /// Callback when filter options change
  final void Function(FilterOptions)? onFilterChanged;

  /// Optional builder for autocomplete suggestions
  final Widget Function(BuildContext context, T suggestion)?
      autoCompleteBuilder;

  /// Whether the magnifying glass icon should be displayed in the search bar.
  final bool isMagnifyingGlassIconEnabled;

  @override
  State<BottomSheetSearchWidget<T>> createState() =>
      _BottomSheetSearchWidgetState<T>();
}

/// State class for BottomSheetSearchWidget
class _BottomSheetSearchWidgetState<T>
    extends State<BottomSheetSearchWidget<T>> {
  late final TextEditingController _searchController;
  late List<T> _filteredItems;
  late List<T> _autoCompleteSuggestions;

  @override
  void initState() {
    super.initState();
    _searchController = widget.searchController ?? TextEditingController();
    _filteredItems = widget.items;
    _autoCompleteSuggestions = [];
    _searchController.addListener(_handleSearchChanged);
  }

  void _handleSearchChanged() {
    final query = _searchController.text;
    if (query.length < widget.filterOptions.minSearchLength) {
      setState(() {
        _filteredItems = widget.items;
        _autoCompleteSuggestions = [];
      });
      return;
    }

    setState(() {
      _filteredItems = _filterItems(query);
      _autoCompleteSuggestions = _generateAutoCompleteSuggestions(query);
    });
  }

  List<T> _filterItems(String query) {
    if (query.isEmpty) return widget.items;

    return widget.items.where((item) {
      final searchText = widget.searchableText(item);
      final searchQuery =
          widget.filterOptions.caseSensitive ? query : query.toLowerCase();
      final itemText = widget.filterOptions.caseSensitive
          ? searchText
          : searchText.toLowerCase();

      switch (widget.filterOptions.matchType) {
        case MatchType.contains:
          return itemText.contains(searchQuery);
        case MatchType.startsWith:
          return itemText.startsWith(searchQuery);
        case MatchType.exact:
          return itemText == searchQuery;
      }
    }).toList();
  }

  List<T> _generateAutoCompleteSuggestions(String query) {
    if (query.isEmpty || widget.autoCompleteBuilder == null) return [];

    return _filteredItems.take(widget.filterOptions.maxSuggestions).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultTextColor = theme.textTheme.bodyLarge?.color;
    final defaultBorderColor = theme.dividerColor.withAlpha(600);
    const defaultBorderWidth = 1.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1.5),
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.decoration.borderColor ?? defaultBorderColor,
          width: widget.decoration.borderWidth ?? defaultBorderWidth,
        ),
        color: widget.decoration.backgroundColor ??
            const Color(0xff2c2b33).withOpacity(.9),
        borderRadius: widget.decoration.borderRadius ??
            const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
      ),
      child: Semantics(
        container: true,
        label: 'Search bottom sheet',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  widget.decoration.contentPadding ?? const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        widget.decoration.borderColor ?? Colors.grey.shade500,
                    width: widget.decoration.borderWidth ?? 0.25,
                  ),
                  color: widget.decoration.searchBarColor ??
                      Colors.white.withOpacity(.079),
                  borderRadius: widget.decoration.searchBarBorderRadius ??
                      BorderRadius.circular(32),
                ),
                // Add semantic label for search field
                child: Semantics(
                  textField: true,
                  label: 'Search input field',
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => _handleSearchChanged(),
                    cursorColor:
                        widget.decoration.cursorColor ?? defaultTextColor,
                    style: widget.decoration.searchTextStyle ??
                        TextStyle(color: defaultTextColor),
                    decoration: InputDecoration(
                      hintText: widget.searchHint,
                      hintStyle: widget.decoration.hintTextStyle ??
                          TextStyle(
                            color: defaultTextColor?.withOpacity(.6),
                            fontSize: 18,
                          ),
                      border: InputBorder.none,
                      contentPadding: widget.decoration.searchBarPadding ??
                          const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                      suffixIcon:
                          ((widget.searchController ?? _searchController)
                                  .text
                                  .isNotEmpty)
                              ? IconButton(
                                  onPressed: () {
                                    (_searchController).clear();
                                  },
                                  icon: const Icon(Icons.cancel),
                                  color: Colors.white.withOpacity(.5),
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: widget.suffixIcons ??
                                      [
                                        IconButton(
                                          icon: Icon(
                                            Icons.mic_outlined,
                                            color: Colors.grey[400],
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
                                ),
                    ),
                  ),
                ),
              ),
            ),

            // Auto-complete suggestions
            if (_autoCompleteSuggestions.isNotEmpty &&
                widget.autoCompleteBuilder != null)
              Container(
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: false,
                  itemCount: _autoCompleteSuggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = _autoCompleteSuggestions[index];
                    return InkWell(
                      onTap: () {
                        _searchController.text =
                            widget.searchableText(suggestion);
                        widget.onItemSelected(suggestion);
                      },
                      child: widget.autoCompleteBuilder!(context, suggestion),
                    );
                  },
                ),
              ),

            // Filtered items list
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredItems.length,
                itemBuilder: (BuildContext context, int index) {
                  final T item = _filteredItems[index];
                  return Semantics(
                    button: true,
                    child: InkWell(
                      onTap: () => widget.onItemSelected(item),
                      child: Row(
                        children: [
                          if (widget.isMagnifyingGlassIconEnabled)
                            SizedBox(
                                width: 25,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Icon(Icons.search,
                                      color: Colors.grey[400]),
                                )),
                          Expanded(child: widget.itemBuilder(context, item)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.searchController == null) {
      _searchController.dispose();
    }
    _searchController.removeListener(_handleSearchChanged);
    super.dispose();
  }
}
