import 'package:flutter/material.dart';
import '../../../../core/theme/cp_theme.dart';
import '../../../../core/widgets/coupang_widgets.dart';
import '../../../cart/presentation/widgets/cart_widgets.dart';
import '../../../product/presentation/pages/product_detail_page.dart';
import '../../data/repositories/demo_wishlist_repository.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../search/presentation/pages/category_page.dart';

class CpWishlistPage extends StatelessWidget {
  const CpWishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = DemoWishlistRepository.instance;
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
      body: ListenableBuilder(
        listenable: repo,
        builder: (context, _) {
          final items = repo.getItems();
          if (items.isEmpty) {
            return const CpEmptyState(
              icon: Icons.favorite_border,
              message: '찜한 상품이 없습니다',
            );
          }
          return GridView.count(
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
                        child: GestureDetector(
                          onTap: () => repo.remove(p.id),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.favorite,
                              color: CpColors.red,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
