import 'package:flutter/material.dart';
import '../../theme/cp_theme.dart';
import 'cp_image.dart';
import 'cp_price.dart';
import 'cp_rating.dart';
import 'cp_rocket_badge.dart';

class CpProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int price;
  final int? originalPrice;
  final int? discountPercent;
  final double rating;
  final int reviewCount;
  final bool isRocket;
  final String? topBadge;
  final VoidCallback? onTap;

  const CpProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.originalPrice,
    this.discountPercent,
    this.rating = 0,
    this.reviewCount = 0,
    this.isRocket = true,
    this.topBadge,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CpImage(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Center(
                      child: Icon(
                        Icons.image,
                        color: CpColors.textMuted,
                        size: 32,
                      ),
                    ),
                  ),
                  if (topBadge != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: CpColors.red,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          topBadge!,
                          style: CpText.badge.copyWith(fontSize: 10),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: CpText.body.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          CpPrice(
            price: price,
            originalPrice: originalPrice,
            discountPercent: discountPercent,
          ),
          const SizedBox(height: 3),
          if (rating > 0) CpRating(rating: rating, count: reviewCount),
          const SizedBox(height: 4),
          if (isRocket) const CpRocketBadge(small: true),
        ],
      ),
    );
  }
}
