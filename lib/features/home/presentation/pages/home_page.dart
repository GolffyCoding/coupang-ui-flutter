import 'package:flutter/material.dart';
import '../../../../core/theme/cp_theme.dart';
import '../../../../core/widgets/coupang_widgets.dart';
import '../../../product/domain/entities/product.dart';
import '../../../product/presentation/pages/product_detail_page.dart';
import '../controllers/home_controller.dart';
import '../../domain/usecases/get_home_products.dart';
import '../widgets/home_widgets.dart';
import '../../../search/presentation/pages/category_page.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../../../wishlist/presentation/pages/wishlist_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';

class CpHomePage extends StatefulWidget {
  /// When embedded inside the app-level bottom-nav shell, the page
  /// should not render its own bottom nav bar.
  final bool embedded;
  final VoidCallback? onSearchTap;
  final VoidCallback? onCartTap;
  final VoidCallback? onMyPageTap;
  final VoidCallback? onWishlistTap;

  const CpHomePage({
    super.key,
    this.embedded = false,
    this.onSearchTap,
    this.onCartTap,
    this.onMyPageTap,
    this.onWishlistTap,
  });

  @override
  State<CpHomePage> createState() => _CpHomePageState();
}

class _CpHomePageState extends State<CpHomePage> {
  final HomeController _controller = HomeController(GetHomeProducts());
  List<Product> get _products => _controller.products;
  int _navIndex = 0;



  void _goToDetail(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CpProductDetailPage(product: product)),
    );
  }

  void _goToCategory(String name) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CpCategoryPage(categoryName: name)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CpColors.bg,
      appBar: CpHeader(
        onCartTap: widget.onCartTap,
        onMyPageTap: widget.onMyPageTap,
        onSearch: (_) => widget.onSearchTap?.call(),
      ),
      drawer: CpAppDrawer(
        onCartTap:
            widget.onCartTap ??
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CpCartPage()),
            ),
        onWishlistTap:
            widget.onWishlistTap ??
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CpWishlistPage()),
            ),
        onProfileTap:
            widget.onMyPageTap ??
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CpProfilePage()),
            ),
        onCategoryTap: _goToCategory,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: CpColors.white,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    CpChip(
                      label: '로켓배송',
                      icon: Icons.rocket_launch,
                      isActive: true,
                      onTap: () => _goToCategory('로켓배송'),
                    ),
                    CpChip(
                      label: '로켓프레시',
                      icon: Icons.eco,
                      onTap: () => _goToCategory('로켓프레시'),
                    ),
                    CpChip(
                      label: '쿠팡플레이',
                      icon: Icons.play_circle_outline,
                      onTap: () => _goToCategory('쿠팡플레이'),
                    ),
                    CpChip(
                      label: '골드박스',
                      icon: Icons.card_giftcard,
                      onTap: () => _goToCategory('골드박스'),
                    ),
                    CpChip(
                      label: '와우할인',
                      icon: Icons.local_offer,
                      onTap: () => _goToCategory('와우할인'),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              color: CpColors.white,
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CpCategoryCircle(
                    icon: Icons.rocket_launch,
                    label: '로켓배송',
                    bgColor: const Color(0xFFE3F2FD),
                    iconColor: CpColors.blue,
                    onTap: () => _goToCategory('로켓배송'),
                  ),
                  CpCategoryCircle(
                    icon: Icons.local_offer,
                    label: '와우특가',
                    bgColor: const Color(0xFFE8F5E9),
                    iconColor: Colors.green,
                    onTap: () => _goToCategory('와우특가'),
                  ),
                  CpCategoryCircle(
                    icon: Icons.new_releases,
                    label: '신상품',
                    bgColor: const Color(0xFFFFF3E0),
                    iconColor: CpColors.orange,
                    onTap: () => _goToCategory('신상품'),
                  ),
                  CpCategoryCircle(
                    icon: Icons.thumb_up,
                    label: '베스트',
                    bgColor: const Color(0xFFF3E5F5),
                    iconColor: Colors.purple,
                    onTap: () => _goToCategory('베스트'),
                  ),
                  CpCategoryCircle(
                    icon: Icons.event,
                    label: '이벤트',
                    bgColor: const Color(0xFFFFEBEE),
                    iconColor: CpColors.red,
                    onTap: () => _goToCategory('이벤트'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            CpHeroBanner(
              imageUrl: 'assets/images/banner_earbuds.jpg',
              title: '올해 마지막 역대급 할인\n~38% 할인',
              subtitle: 'Gillette Labs',
              sideItems: [
                SideItem(
                  imageUrl: 'assets/images/banner_side1.jpg',
                  label: '쿠폰 혜택',
                ),
                SideItem(
                  imageUrl: 'assets/images/banner_side2.jpg',
                  label: '크리스마스 주변 아이템',
                ),
                SideItem(
                  imageUrl: 'assets/images/banner_side3.jpg',
                  label: 'R.LUX',
                ),
                SideItem(
                  imageUrl: 'assets/images/banner_side4.jpg',
                  label: '올해 마지막 역대급 할인',
                ),
              ],
            ),

            const SizedBox(height: 8),

            CpCouponBanner(
              title: '웰컴팩 & 첫구매',
              amount: '~24,000원',
              subtitle: '회원가입 및 본인인증 완료 후 지급',
            ),

            Container(
              color: CpColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CpSectionHeader(
                    title: '오늘의 발견!',
                    subtitle: "Coupang's hottest products selected today!",
                    onSeeAll: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.58,
                      children: _products
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
                              onTap: () => _goToDetail(p),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Container(
              color: CpColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CpSectionHeader(title: '로켓프레시', subtitle: '신선한 식품을 다음날 아침에!'),
                  SizedBox(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: 5,
                      itemBuilder: (context, i) {
                        return Container(
                          width: 150,
                          margin: const EdgeInsets.only(right: 12),
                          child: CpHorizontalProductCard(
                            imageUrl: 'assets/images/fresh_veggies.jpg',
                            title: '신선한 야채 세트 ${i + 1}kg',
                            price: 12900 + (i * 2000),
                            originalPrice: 15900 + (i * 2000),
                            discountPercent: 15 + i,
                            isRocket: true,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: widget.embedded
          ? null
          : CpBottomNav(
              currentIndex: _navIndex,
              onTap: (i) => setState(() => _navIndex = i),
            ),
    );
  }
}
