import 'package:flutter/material.dart';
import '../../../../../core/theme/cp_theme.dart';
import '../../../../../core/widgets/cp/cp_image.dart';

class RelatedItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int price;
  final int? discount;

  const RelatedItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
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
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.image, color: CpColors.textMuted),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: CpText.body.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          if (discount != null)
            Text(
              '$discount%',
              style: const TextStyle(
                fontSize: 12,
                color: CpColors.red,
                fontWeight: FontWeight.w700,
              ),
            ),
          Text(
            '${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}원',
            style: CpText.price.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
