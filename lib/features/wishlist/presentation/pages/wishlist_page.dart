import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/cp_theme.dart';
import '../../../../core/widgets/coupang_widgets.dart';
import '../../../../core/providers/repository_providers.dart';
import '../../../../core/providers/usecase_providers.dart';
import '../../../cart/presentation/widgets/cart_widgets.dart';
import '../../../product/presentation/pages/product_detail_page.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../search/presentation/pages/category_page.dart';

class CpWishlistPage extends ConsumerWidget {
  const CpWishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // The ChangeNotifier-typed provider drives reactive rebuilds (a
    // UI-reactivity concern); reads/mutations go through the usecases.
    final repo = ref.watch(wishlistChangeNotifierProvider);
    final items = repo.getItems();
    return Scaffold(
      backgroundColor: CpColors.bg,
      appBar: const CpHeader(title: '찜한 상품'),
      drawer: CpAppDrawer(
        onCartTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CpCartPage()),
        ),
        onProfileTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CpProfilePage()),
        ),
        onCategoryTap: (name) => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CpCategoryPage(categoryName: name)),
        ),
      ),
      body: items.isEmpty
          ? const CpEmptyState(
              icon: Icons.favorite_border,
              message: '찜한 상품이 없습니다',
            )
          : GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 12,
              childAspectRatio: 0.58,
              children: items
                  .map(
                    (p) => Stack(
                      children: [
                        CpProductCard(
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
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Material(
                            color: Colors.transparent,
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () => ref
                                  .read(removeFromWishlistUseCaseProvider)(
                                    p.id,
                                  ),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  shape: BoxShape.circle,
                                ),
                                child: TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0.5, end: 1.0),
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.elasticOut,
                                  builder: (context, scale, child) =>
                                      Transform.scale(
                                        scale: scale,
                                        child: child,
                                      ),
                                  child: const Icon(
                                    Icons.favorite,
                                    color: CpColors.red,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
