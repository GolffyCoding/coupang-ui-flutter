import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/repository_providers.dart';
import '../../../../core/providers/usecase_providers.dart';
import '../../../../core/theme/cp_theme.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../orders/presentation/pages/order_list_page.dart';
import '../../../wishlist/presentation/pages/wishlist_page.dart';

class CpProfilePage extends ConsumerWidget {
  const CpProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authChangeNotifierProvider);
    return Scaffold(
      backgroundColor: CpColors.bg,
      appBar: AppBar(
        backgroundColor: CpColors.white,
        elevation: 0,
        title: const Text(
          '마이쿠팡',
          style: TextStyle(
            color: CpColors.textMain,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Builder(
        builder: (context) {
          final user = auth.currentUser;
          return ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              Container(
                color: CpColors.white,
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: CpColors.blueLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: CpColors.blue,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user != null ? '${user.name}님' : '로그인이 필요합니다',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: CpColors.textMain,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user?.email ?? '로그인하고 다양한 혜택을 받아보세요',
                            style: const TextStyle(
                              fontSize: 12,
                              color: CpColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (user == null)
                      SizedBox(
                        height: 34,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CpColors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CpLoginPage(),
                            ),
                          ),
                          child: const Text(
                            '로그인',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: ref.read(logoutUseCaseProvider).call,
                        child: const Text(
                          '로그아웃',
                          style: TextStyle(
                            fontSize: 12,
                            color: CpColors.textSub,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              _MenuSection(
                title: '나의 쇼핑 활동',
                items: [
                  _MenuItem(
                    icon: Icons.receipt_long_outlined,
                    label: '주문내역',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CpOrderListPage(),
                      ),
                    ),
                  ),
                  _MenuItem(
                    icon: Icons.favorite_border,
                    label: '찜한 상품',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CpWishlistPage(),
                      ),
                    ),
                  ),
                  _MenuItem(
                    icon: Icons.local_offer_outlined,
                    label: '쿠폰함',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.reviews_outlined,
                    label: '상품 리뷰',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _MenuSection(
                title: '설정',
                items: [
                  _MenuItem(
                    icon: Icons.settings_outlined,
                    label: '환경설정',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.notifications_none,
                    label: '알림 설정',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.help_outline,
                    label: '고객센터',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  final String title;
  final List<_MenuItem> items;
  const _MenuSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CpColors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: CpColors.textSub,
              ),
            ),
          ),
          ...items,
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(
          children: [
            Icon(icon, size: 20, color: CpColors.textBody),
            const SizedBox(width: 14),
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: CpColors.textMain),
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              size: 18,
              color: CpColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}
