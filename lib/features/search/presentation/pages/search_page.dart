import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/cp_theme.dart';
import '../../../../core/widgets/coupang_widgets.dart';
import '../../../cart/presentation/widgets/cart_widgets.dart';
import '../../../product/presentation/pages/product_detail_page.dart';
import '../controllers/search_notifier.dart';

class CpSearchPage extends ConsumerStatefulWidget {
  const CpSearchPage({super.key});

  @override
  ConsumerState<CpSearchPage> createState() => _CpSearchPageState();
}

class _CpSearchPageState extends ConsumerState<CpSearchPage> {
  final _controller = TextEditingController();

  void _runSearch(String query) {
    if (query.trim().isEmpty) return;
    ref.read(cpSearchProvider.notifier).search(query);
    _controller.text = query;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cpSearchProvider);
    return Scaffold(
      backgroundColor: CpColors.bg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          color: CpColors.white,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: CpColors.textMain,
                    ),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  Expanded(
                    child: CpSearchBar(
                      controller: _controller,
                      onSubmitted: _runSearch,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: state.searched
            ? _buildResults(state)
            : _buildRecent(state, key: const ValueKey('recent')),
      ),
    );
  }

  Widget _buildRecent(CpSearchState state, {Key? key}) {
    return Padding(
      key: key,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('최근 검색어', style: CpText.h3),
              const Spacer(),
              GestureDetector(
                onTap: () => ref.read(cpSearchProvider.notifier).clearRecent(),
                child: Text(
                  '전체삭제',
                  style: CpText.caption.copyWith(color: CpColors.textSub),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (state.recent.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Text(
                '최근 검색 내역이 없습니다',
                style: TextStyle(color: CpColors.textMuted, fontSize: 13),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: state.recent
                  .map(
                    (r) => CpChip(label: r, onTap: () => _runSearch(r)),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildResults(CpSearchState state) {
    return Column(
      key: const ValueKey('results'),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Row(
            children: [
              Text(
                "'${state.query}' 검색결과 ${state.results.length}개",
                style: CpText.caption.copyWith(color: CpColors.textSub),
              ),
            ],
          ),
        ),
        Expanded(
          child: state.results.isEmpty
              ? const CpEmptyState(
                  icon: Icons.search_off,
                  message: '검색 결과가 없습니다',
                )
              : GridView.count(
                  padding: const EdgeInsets.all(16),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.58,
                  children: state.results
                      .map(
                        (p) => CpProductCard(
                          imageUrl: p.imageUrl,
                          title: p.title,
                          price: p.price,
                          originalPrice: p.originalPrice,
                          discountPercent: p.discountPercent,
                          rating: p.rating,
                          reviewCount: p.reviewCount,
                          topBadge: p.topBadge,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CpProductDetailPage(product: p),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
      ],
    );
  }
}
