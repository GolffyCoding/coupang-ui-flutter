import 'package:flutter/material.dart';
import '../../theme/cp_theme.dart';
import '../../../features/cart/data/repositories/demo_cart_repository.dart';
import 'category_button.dart';
import 'coupang_logo.dart';
import 'cp_search_bar.dart';
import 'cp_fly_to_cart.dart';

class CpHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onCartTap;
  final VoidCallback? onMyPageTap;
  final TextEditingController? searchController;
  final Function(String)? onSearch;
  final bool showBack;
  final String? title;
  final GlobalKey? cartIconKey;

  const CpHeader({
    super.key,
    this.onMenuTap,
    this.onCartTap,
    this.onMyPageTap,
    this.searchController,
    this.onSearch,
    this.showBack = false,
    this.title,
    this.cartIconKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CpColors.white,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (showBack)
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.arrow_back,
                          color: CpColors.textMain,
                          size: 24,
                        ),
                      ),
                    )
                  else
                    CategoryButton(
                      onTap:
                          onMenuTap ?? () => Scaffold.of(context).openDrawer(),
                    ),
                  if (title != null) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: CpColors.textMain,
                        ),
                      ),
                    ),
                  ] else ...[
                    const SizedBox(width: 10),
                    const CoupangLogo(size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CpSearchBar(
                        controller: searchController,
                        onSubmitted: onSearch,
                        onTap: onSearch != null && searchController == null
                            ? () => onSearch!('')
                            : null,
                      ),
                    ),
                  ],
                  const SizedBox(width: 14),
                  ListenableBuilder(
                    listenable: DemoCartRepository.instance,
                    builder: (context, _) {
                      final count = DemoCartRepository.instance.totalItemCount;
                      return _HeaderIcon(
                        key: cartIconKey,
                        icon: Icons.shopping_cart_outlined,
                        onTap: onCartTap,
                        badge: count > 0 ? '$count' : null,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}

class _HeaderIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final String? badge;

  const _HeaderIcon({super.key, required this.icon, this.onTap, this.badge});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, color: CpColors.textMain, size: 24),
              if (badge != null)
                Positioned(
                  right: -6,
                  top: -4,
                  child: CpBadgePop(
                    trigger: badge,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: CpColors.blue,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: CpColors.white, width: 1.5),
                      ),
                      child: Text(
                        badge!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
