import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/usecase_providers.dart';
import '../../../../core/theme/cp_theme.dart';
import '../../../../core/widgets/coupang_widgets.dart';
import '../../../product/presentation/pages/product_detail_page.dart';
import '../controllers/category_sort_notifier.dart';
import '../controllers/search_controller.dart' show CpSearchController;

class CpCategoryPage extends ConsumerWidget {
  final String categoryName;
  const CpCategoryPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(categorySortProvider);
    final catalog = ref.watch(getCategoryProductsUseCaseProvider)(
      categoryName,
    );
    final products = CpSearchController().sort(catalog, sort);
    return Scaffold(
      backgroundColor: CpColors.bg,
      appBar: AppBar(
        backgroundColor: CpColors.white,
        elevation: 0,
        title: Text(
          categoryName,
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
                  isActive: sort == SortOption.recommended,
                  onTap: () => ref
                      .read(categorySortProvider.notifier)
                      .select(SortOption.recommended),
                ),
                _SortTab(
                  label: '낮은가격순',
                  isActive: sort == SortOption.priceAsc,
                  onTap: () => ref
                      .read(categorySortProvider.notifier)
                      .select(SortOption.priceAsc),
                ),
                _SortTab(
                  label: '높은가격순',
                  isActive: sort == SortOption.priceDesc,
                  onTap: () => ref
                      .read(categorySortProvider.notifier)
                      .select(SortOption.priceDesc),
                ),
                _SortTab(
                  label: '평점순',
                  isActive: sort == SortOption.rating,
                  onTap: () => ref
                      .read(categorySortProvider.notifier)
                      .select(SortOption.rating),
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
                      key: ValueKey('${p.id}_${sort.name}'),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 150),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                    color: isActive ? CpColors.blue : CpColors.textSub,
                  ),
                  child: Text(label),
                ),
                const SizedBox(height: 4),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  height: 2,
                  width: isActive ? 20 : 0,
                  decoration: BoxDecoration(
                    color: CpColors.blue,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
