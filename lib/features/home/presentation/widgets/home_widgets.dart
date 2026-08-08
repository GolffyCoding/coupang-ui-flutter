import 'package:flutter/material.dart';
import '../../../../core/theme/cp_theme.dart';
import '../../../../core/widgets/coupang_widgets.dart';

class SubNavBar extends StatelessWidget {
  final List<NavItem> items;
  final int selectedIndex;
  final Function(int)? onTap;

  const SubNavBar({
    super.key,
    required this.items,
    this.selectedIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      color: CpColors.white,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 18),
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onTap?.call(index),
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (item.icon != null) ...[
                    Icon(
                      item.icon,
                      size: 13,
                      color: isSelected ? CpColors.blue : CpColors.textSub,
                    ),
                    const SizedBox(width: 3),
                  ],
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isSelected ? CpColors.blue : CpColors.textSub,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class NavItem {
  final String label;
  final IconData? icon;
  NavItem({required this.label, this.icon});
}

class CpCategoryCircle extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback? onTap;

  const CpCategoryCircle({
    super.key,
    required this.label,
    required this.icon,
    this.bgColor = CpColors.blueLight,
    this.iconColor = CpColors.blue,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 26),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: CpText.caption.copyWith(
              color: CpColors.textBody,
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class CpHeroBanner extends StatelessWidget {
  final String imageUrl;
  final String? title;
  final String? subtitle;
  final List<SideItem>? sideItems;
  final VoidCallback? onTap;
  final double height;

  const CpHeroBanner({
    super.key,
    required this.imageUrl,
    this.title,
    this.subtitle,
    this.sideItems,
    this.onTap,
    this.height = 260,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: height,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(color: CpColors.bg),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CpImage(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(color: CpColors.bg),
                    ),
                    if (title != null)
                      Positioned(
                        left: 20,
                        bottom: 32,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (subtitle != null)
                              Text(
                                subtitle!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black45,
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 4),
                            Text(
                              title!,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1.3,
                                shadows: [
                                  Shadow(color: Colors.black45, blurRadius: 6),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _Dot(isActive: true),
                          _Dot(isActive: false),
                          _Dot(isActive: false),
                          _Dot(isActive: false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (sideItems != null && sideItems!.isNotEmpty)
              Container(
                width: 130,
                color: CpColors.white,
                child: Column(
                  children: sideItems!
                      .map((item) => _SideItemWidget(item: item))
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final bool isActive;
  const _Dot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 18 : 7,
      height: 7,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: isActive ? CpColors.white : Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(3.5),
      ),
    );
  }
}

class SideItem {
  final String imageUrl;
  final String label;
  final String? badge;
  SideItem({required this.imageUrl, required this.label, this.badge});
}

class _SideItemWidget extends StatelessWidget {
  final SideItem item;
  const _SideItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: CpColors.divider)),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: CpColors.bg,
                borderRadius: BorderRadius.circular(4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CpImage(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.image,
                    size: 16,
                    color: CpColors.textMuted,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                item.label,
                style: const TextStyle(
                  fontSize: 11,
                  color: CpColors.textBody,
                  height: 1.35,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
