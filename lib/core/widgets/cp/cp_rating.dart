import 'package:flutter/material.dart';
import '../../theme/cp_theme.dart';

class CpRating extends StatelessWidget {
  final double rating;
  final int count;
  final bool showCount;
  const CpRating({
    super.key,
    required this.rating,
    required this.count,
    this.showCount = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: CpColors.star, size: 14),
        const SizedBox(width: 2),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: CpColors.textSub,
          ),
        ),
        if (showCount) ...[
          const SizedBox(width: 3),
          Text(
            '(${_fmtCount(count)})',
            style: const TextStyle(fontSize: 11, color: CpColors.textMuted),
          ),
        ],
      ],
    );
  }

  String _fmtCount(int c) {
    if (c >= 10000) return '${(c / 10000).toStringAsFixed(1)}만';
    if (c >= 1000) return '${(c / 1000).toStringAsFixed(1)}천';
    return c.toString();
  }
}
