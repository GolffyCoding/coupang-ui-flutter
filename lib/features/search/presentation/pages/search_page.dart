import 'package:flutter/material.dart';
import '../../../../core/theme/cp_theme.dart';
import '../../../../core/widgets/coupang_widgets.dart';
import '../../../cart/presentation/widgets/cart_widgets.dart';
import '../../../product/domain/entities/product.dart';
import '../../../product/presentation/pages/product_detail_page.dart';
import '../controllers/search_controller.dart';

class CpSearchPage extends StatefulWidget {
  const CpSearchPage({super.key});

  @override
  State<CpSearchPage> createState() => _CpSearchPageState();
}

class _CpSearchPageState extends State<CpSearchPage> {
  final _controller = TextEditingController();
  final _searchController = CpSearchController();
  final List<String> _recent = ['에어팟', '무선청소기', '스위치', '블루투스 이어폰'];
  List<Product> _results = [];
  bool _searched = false;

  void _runSearch(String query) {
    if (query.trim().isEmpty) return;
    setState(() {
      _searched = true;
      _results = _searchController.search(query);
      _controller.text = query;
      _recent.remove(query);
      _recent.insert(0, query);
      if (_recent.length > 8) _recent.removeLast();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: _searched
            ? _buildResults()
            : _buildRecent(key: const ValueKey('recent')),
      ),
    );
  }

  Widget _buildRecent({Key? key}) {
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
                onTap: () => setState(() => _recent.clear()),
                child: Text(
                  '전체삭제',
                  style: CpText.caption.copyWith(color: CpColors.textSub),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_recent.isEmpty)
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
              children: _recent
                  .map(
                    (r) => CpChip(label: r, onTap: () => _runSearch(r)),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    return Column(
      key: const ValueKey('results'),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Row(
            children: [
              Text(
                "'${_controller.text}' 검색결과 ${_results.length}개",
                style: CpText.caption.copyWith(color: CpColors.textSub),
              ),
            ],
          ),
        ),
        Expanded(
          child: _results.isEmpty
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
                  children: _results
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
