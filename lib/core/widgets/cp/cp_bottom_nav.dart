import 'package:flutter/material.dart';
import '../../theme/cp_theme.dart';

class CpBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;
  final int cartCount;

  const CpBottomNav({
    super.key,
    this.currentIndex = 0,
    this.onTap,
    this.cartCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavData(icon: Icons.home_filled, label: '홈'),
      _NavData(icon: Icons.search, label: '검색'),
      _NavData(icon: Icons.shopping_cart_outlined, label: '장바구니'),
      _NavData(icon: Icons.favorite_border, label: '찜'),
      _NavData(icon: Icons.person_outline, label: '마이쿠팡'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: CpColors.white,
        border: Border(top: BorderSide(color: CpColors.divider)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final selected = i == currentIndex;
              final showBadge = i == 2 && cartCount > 0;
              return GestureDetector(
                onTap: () => onTap?.call(i),
                child: SizedBox(
                  width: 60,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            items[i].icon,
                            color: selected
                                ? CpColors.blue
                                : CpColors.textMuted,
                            size: 22,
                          ),
                          if (showBadge)
                            Positioned(
                              right: -6,
                              top: -4,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: CpColors.red,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Text(
                                  '$cartCount',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        items[i].label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: selected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: selected ? CpColors.blue : CpColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavData {
  final IconData icon;
  final String label;
  _NavData({required this.icon, required this.label});
}
