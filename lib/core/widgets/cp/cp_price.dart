import 'package:flutter/material.dart';
import '../../theme/cp_theme.dart';
import 'cp_discount_badge.dart';

class CpPrice extends StatelessWidget {
  final int price;
  final int? originalPrice;
  final int? discountPercent;
  final bool showBadge;
  const CpPrice({
    super.key,
    required this.price,
    this.originalPrice,
    this.discountPercent,
    this.showBadge = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (discountPercent != null && showBadge)
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: CpDiscountBadge(percent: discountPercent!, small: true),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            if (originalPrice != null)
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text('${_fmt(originalPrice!)}원', style: CpText.priceOld),
              ),
            Text('${_fmt(price)}원', style: CpText.price),
          ],
        ),
      ],
    );
  }

  String _fmt(int v) => v.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (m) => '${m[1]},',
  );
}
