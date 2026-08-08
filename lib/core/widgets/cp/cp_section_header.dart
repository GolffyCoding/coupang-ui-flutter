import 'package:flutter/material.dart';
import '../../theme/cp_theme.dart';

class CpSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onSeeAll;
  const CpSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: CpText.h2),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(subtitle!, style: CpText.caption),
              ],
            ],
          ),
          const Spacer(),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '전체보기',
                    style: CpText.caption.copyWith(color: CpColors.textSub),
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
    );
  }
}
