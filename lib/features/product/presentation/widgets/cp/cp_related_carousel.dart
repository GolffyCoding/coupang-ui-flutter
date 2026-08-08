import 'package:flutter/material.dart';
import '../../../../../core/theme/cp_theme.dart';

class CpRelatedCarousel extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback? onSeeAll;

  const CpRelatedCarousel({
    super.key,
    required this.title,
    required this.children,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CpColors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(title, style: CpText.h3),
                const Spacer(),
                if (onSeeAll != null)
                  GestureDetector(
                    onTap: onSeeAll,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '더보기',
                          style: CpText.caption.copyWith(
                            color: CpColors.textSub,
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          size: 16,
                          color: CpColors.textMuted,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 210,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
