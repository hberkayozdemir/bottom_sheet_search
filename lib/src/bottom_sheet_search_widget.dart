import 'package:flutter/material.dart';

import 'list_item.dart';

/*
BottomSheetSearchWidget(
   Essential
  items: listItems,
  onItemSelected: (item) => handleSelection(item),
  
   Text Customization
  searchHint: 'Custom search hint...',
  searchTextStyle: TextStyle(color: Colors.blue, fontSize: 16),
  hintTextStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
  itemTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  
   Colors
  backgroundColor: Colors.white,
  searchBarColor: Colors.grey[200],
  borderColor: Colors.blue,
  cursorColor: Colors.blue,
  
   Layout
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  ),
  searchBarBorderRadius: BorderRadius.only(
    topLeft: Radius.circular(15),
    topRight: Radius.circular(15),
  ),
  contentPadding: EdgeInsets.all(16),
  searchBarPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  borderWidth: 0.5,
  
  suffixIcons: [
    IconButton(
      icon: Icon(Icons.mic),
      onPressed: () => handleVoiceSearch(),
    ),
    IconButton(
      icon: Icon(Icons.filter_list),
      onPressed: () => handleFilter(),
    ),
  ],
) */

/// A search component that displays a bottom sheet with search functionality
class BottomSheetSearchWidget extends StatefulWidget {
  /// Creates a bottom sheet search component
  const BottomSheetSearchWidget({
    super.key,
    required this.items,
    required this.onItemSelected,
    this.searchHint = 'Search...',
    this.backgroundColor,
    this.searchBarColor,
    this.borderColor,
    this.searchTextStyle,
    this.hintTextStyle,
    this.itemTextStyle,
    this.borderRadius,
    this.searchBarBorderRadius,
    this.contentPadding,
    this.searchBarPadding,
    this.cursorColor,
    this.borderWidth = .25,
    this.suffixIcons,
  });

  /// List of items to be displayed and searched
  final List<ListItem> items;

  /// Callback when an item is selected
  final void Function(ListItem item) onItemSelected;

  /// Hint text for the search field (defaults to 'Search...')
  final String searchHint;

  /// Background color of the bottom sheet (defaults to Color(0xff2C2B33).withOpacity(.9))
  final Color? backgroundColor;

  /// Color of the search bar (defaults to Colors.white.withOpacity(.10))
  final Color? searchBarColor;

  /// Color of the borders (defaults to Colors.white.withOpacity(.2))
  final Color? borderColor;

  /// Color of the cursor (defaults to Colors.white)
  final Color? cursorColor;

  /// Text style for search input (defaults to white color)
  final TextStyle? searchTextStyle;

  /// Text style for hint text (defaults to white color with 0.6 opacity)
  final TextStyle? hintTextStyle;

  /// Text style for list items (defaults to white color)
  final TextStyle? itemTextStyle;

  /// Border radius for bottom sheet (defaults to 32)
  final BorderRadius? borderRadius;

  /// Border radius for search bar (defaults to 32)
  final BorderRadius? searchBarBorderRadius;

  /// Padding for the content (defaults to 18)
  final EdgeInsets? contentPadding;

  /// Padding for search bar (defaults to horizontal: 16, vertical: 12)
  final EdgeInsets? searchBarPadding;

  /// Border width (defaults to 0.35)
  final double? borderWidth;

  /// Custom suffix icons for search bar
  final List<Widget>? suffixIcons;

  @override
  State<BottomSheetSearchWidget> createState() =>
      _BottomSheetSearchWidgetState();
}

class _BottomSheetSearchWidgetState extends State<BottomSheetSearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<ListItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filteredItems = widget.items
          .where(
              (item) => item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultTextColor = theme.textTheme.bodyLarge?.color;
    final defaultBorderColor = theme.dividerColor.withAlpha(600);
    const defaultBorderWidth = 1.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
          border: Border.all(
            color: widget.borderColor ?? defaultBorderColor,
            width: widget.borderWidth ?? defaultBorderWidth,
          ),
          color:
              widget.backgroundColor ?? const Color(0xff2c2b33).withOpacity(.9),
          borderRadius: widget.borderRadius ??
              const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              )),
      child: Semantics(
        container: true,
        label: 'Search bottom sheet',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: widget.contentPadding ?? const EdgeInsets.all(18),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.borderColor ?? Colors.grey.shade500,
                    width: widget.borderWidth ?? 0.25,
                  ),
                  color: widget.searchBarColor ?? Colors.white.withOpacity(.18),
                  borderRadius:
                      widget.searchBarBorderRadius ?? BorderRadius.circular(32),
                ),
                // Add semantic label for search field
                child: Semantics(
                  textField: true,
                  label: 'Search input field',
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    cursorColor: widget.cursorColor ?? defaultTextColor,
                    style: widget.searchTextStyle ??
                        TextStyle(color: defaultTextColor),
                    decoration: InputDecoration(
                      hintText: widget.searchHint,
                      hintStyle: widget.hintTextStyle ??
                          TextStyle(
                            color: defaultTextColor?.withOpacity(.6),
                            fontSize: 18,
                          ),
                      border: InputBorder.none,
                      contentPadding: widget.searchBarPadding ??
                          const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.suffixIcons ??
                            [
                              IconButton(
                                icon: Icon(
                                  Icons.mic_outlined,
                                  color: Colors.grey[400],
                                ),
                                onPressed: () {
                                  // TODO: Implement voice search
                                },
                              ),
                            ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  final item = _filteredItems[index];
                  // Add semantic labels for list items
                  return Semantics(
                    button: true,
                    label: 'Select ${item.title}',
                    child: ListTile(
                      leading: item.leading,
                      title: Text(
                        item.title,
                        style: widget.itemTextStyle ??
                            TextStyle(color: defaultTextColor),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: item.actions,
                      ),
                      onTap: () => widget.onItemSelected(item),
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
    _searchController.dispose();
    super.dispose();
  }
}
