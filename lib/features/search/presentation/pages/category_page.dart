import 'package:flutter/material.dart';
import '../../../../core/theme/cp_theme.dart';
import '../../../../core/widgets/coupang_widgets.dart';
import '../../../product/data/repositories/demo_product_repository.dart';
import '../../../product/presentation/pages/product_detail_page.dart';
import '../controllers/search_controller.dart';

class CpCategoryPage extends StatefulWidget {
  final String categoryName;
  const CpCategoryPage({super.key, required this.categoryName});

  @override
  State<CpCategoryPage> createState() => _CpCategoryPageState();
}

class _CpCategoryPageState extends State<CpCategoryPage> {
  final _searchController = CpSearchController();
  SortOption _sort = SortOption.recommended;

  @override
  Widget build(BuildContext context) {
    final products = _searchController.sort(
      DemoProductRepository.products,
      _sort,
    );
    return Scaffold(
      backgroundColor: CpColors.bg,
      appBar: AppBar(
        backgroundColor: CpColors.white,
        elevation: 0,
        title: Text(
          widget.categoryName,
          style: const TextStyle(
            color: CpColors.textMain,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: CpColors.textMain),
      ),
      body: Column(
        children: [
          Container(
            color: CpColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                _SortTab(
                  label: '추천순',
                  isActive: _sort == SortOption.recommended,
                  onTap: () => setState(() => _sort = SortOption.recommended),
                ),
                _SortTab(
                  label: '낮은가격순',
                  isActive: _sort == SortOption.priceAsc,
                  onTap: () => setState(() => _sort = SortOption.priceAsc),
                ),
                _SortTab(
                  label: '높은가격순',
                  isActive: _sort == SortOption.priceDesc,
                  onTap: () => setState(() => _sort = SortOption.priceDesc),
                ),
                _SortTab(
                  label: '평점순',
                  isActive: _sort == SortOption.rating,
                  onTap: () => setState(() => _sort = SortOption.rating),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: CpColors.divider),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 12,
              childAspectRatio: 0.58,
              children: products
                  .map(
                    (p) => CpProductCard(
                      key: ValueKey('${p.id}_${_sort.name}'),
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
                          builder: (_) => CpProductDetailPage(product: p),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SortTab extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _SortTab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              color: isActive ? CpColors.blue : CpColors.textSub,
            ),
          ),
        ),
      ),
    );
  }
}
