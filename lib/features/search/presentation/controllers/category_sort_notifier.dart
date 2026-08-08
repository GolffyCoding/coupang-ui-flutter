import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'search_controller.dart' show SortOption;

export 'search_controller.dart' show SortOption;

/// Page-local-but-shareable sort selection for [CpCategoryPage], modeled
/// as a Riverpod [Notifier] instead of a raw `setState` field.
class CategorySortNotifier extends Notifier<SortOption> {
  @override
  SortOption build() => SortOption.recommended;

  void select(SortOption option) => state = option;
}

final categorySortProvider =
    NotifierProvider<CategorySortNotifier, SortOption>(
  CategorySortNotifier.new,
);
