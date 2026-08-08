import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/usecase_providers.dart';
import '../../../product/domain/entities/product.dart';

/// Shared, page-level search state (query results + recent-search
/// history). Modeled as a Riverpod [Notifier] so the query/results state
/// that used to live as raw `setState` fields on [CpSearchPage] can be
/// exposed for the rest of the app the same way other shared state is.
class CpSearchState {
  final String query;
  final List<Product> results;
  final bool searched;
  final List<String> recent;

  const CpSearchState({
    this.query = '',
    this.results = const [],
    this.searched = false,
    this.recent = const ['에어팟', '무선청소기', '스위치', '블루투스 이어폰'],
  });

  CpSearchState copyWith({
    String? query,
    List<Product>? results,
    bool? searched,
    List<String>? recent,
  }) {
    return CpSearchState(
      query: query ?? this.query,
      results: results ?? this.results,
      searched: searched ?? this.searched,
      recent: recent ?? this.recent,
    );
  }
}

class CpSearchNotifier extends Notifier<CpSearchState> {
  @override
  CpSearchState build() => const CpSearchState();

  void search(String query) {
    if (query.trim().isEmpty) return;
    final searchProducts = ref.read(searchProductsUseCaseProvider);
    final recent = List<String>.from(state.recent)
      ..remove(query)
      ..insert(0, query);
    if (recent.length > 8) recent.removeLast();
    state = state.copyWith(
      searched: true,
      results: searchProducts(query),
      query: query,
      recent: recent,
    );
  }

  void clearRecent() {
    state = state.copyWith(recent: []);
  }
}

final cpSearchProvider = NotifierProvider<CpSearchNotifier, CpSearchState>(
  CpSearchNotifier.new,
);
