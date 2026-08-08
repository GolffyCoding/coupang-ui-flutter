import 'package:flutter/material.dart';
import '../../theme/cp_theme.dart';
import 'coupang_logo.dart';

/// Slide-out menu opened from the header's hamburger icon.
/// Provide callbacks for the destinations that make sense for the
/// hosting page; any left null simply omits that row.
class CpAppDrawer extends StatelessWidget {
  final VoidCallback? onHomeTap;
  final VoidCallback? onCartTap;
  final VoidCallback? onWishlistTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onLoginTap;
  final Function(String category)? onCategoryTap;

  const CpAppDrawer({
    super.key,
    this.onHomeTap,
    this.onCartTap,
    this.onWishlistTap,
    this.onProfileTap,
    this.onLoginTap,
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    const categories = ['로켓배송', '로켓프레시', '쿠팡플레이', '골드박스', '와우할인'];
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              color: CpColors.bg,
              child: Row(
                children: [
                  const CoupangLogo(size: 24),
                  const Spacer(),
                  if (onLoginTap != null)
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onLoginTap!();
                      },
                      child: const Text('로그인'),
                    ),
                ],
              ),
            ),
            if (onHomeTap != null)
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('홈'),
                onTap: () {
                  Navigator.pop(context);
                  onHomeTap!();
                },
              ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                '카테고리',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: CpColors.textMuted,
                ),
              ),
            ),
            for (final c in categories)
              ListTile(
                leading: const Icon(Icons.chevron_right, size: 20),
                title: Text(c),
                onTap: () {
                  Navigator.pop(context);
                  onCategoryTap?.call(c);
                },
              ),
            const Divider(height: 24),
            if (onCartTap != null)
              ListTile(
                leading: const Icon(Icons.shopping_cart_outlined),
                title: const Text('장바구니'),
                onTap: () {
                  Navigator.pop(context);
                  onCartTap!();
                },
              ),
            if (onWishlistTap != null)
              ListTile(
                leading: const Icon(Icons.favorite_border),
                title: const Text('찜한 상품'),
                onTap: () {
                  Navigator.pop(context);
                  onWishlistTap!();
                },
              ),
            if (onProfileTap != null)
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('마이쿠팡'),
                onTap: () {
                  Navigator.pop(context);
                  onProfileTap!();
                },
              ),
          ],
        ),
      ),
    );
  }
}
