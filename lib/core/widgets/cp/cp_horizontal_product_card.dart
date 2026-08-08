import 'package:flutter/material.dart';
import '../../theme/cp_theme.dart';
import 'cp_discount_badge.dart';
import 'cp_image.dart';
import 'cp_rocket_badge.dart';

class CpHorizontalProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int price;
  final int? originalPrice;
  final int? discountPercent;
  final bool isRocket;
  final VoidCallback? onTap;

  const CpHorizontalProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.originalPrice,
    this.discountPercent,
    this.isRocket = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: CpColors.bg,
                  borderRadius: BorderRadius.circular(6),
                ),
                clipBehavior: Clip.antiAlias,
                child: CpImage(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Center(
                    child: Icon(
                      Icons.image,
                      color: CpColors.textMuted,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: CpText.body.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                height: 1.35,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3),
            if (discountPercent != null)
              CpDiscountBadge(percent: discountPercent!, small: true),
            const SizedBox(height: 2),
            Text('${_fmt(price)}원', style: CpText.price.copyWith(fontSize: 14)),
            const SizedBox(height: 3),
            if (isRocket) const CpRocketBadge(small: true),
          ],
        ),
      ),
    );
  }

  String _fmt(int v) => v.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (m) => '${m[1]},',
  );
}
