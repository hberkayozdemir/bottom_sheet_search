import 'package:bottom_sheet_search/src/match_type.dart';

/// Configuration options for filtering behavior
class FilterOptions {
  const FilterOptions({
    this.caseSensitive = false,
    this.matchType = MatchType.contains,
    this.minSearchLength = 1,
    this.maxSuggestions = 5,
  });

  final bool caseSensitive;
  final MatchType matchType;
  final int minSearchLength;
  final int maxSuggestions;
}

