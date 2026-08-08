import 'package:flutter/material.dart';
import '../../../../../core/theme/cp_theme.dart';

class CpReviewSummary extends StatelessWidget {
  final double averageRating;
  final int totalCount;
  final Map<String, int> distribution;
  final Map<String, String> aspectRatings;
  final Map<String, int> aspectPercents;

  const CpReviewSummary({
    super.key,
    required this.averageRating,
    required this.totalCount,
    required this.distribution,
    required this.aspectRatings,
    required this.aspectPercents,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CpColors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: List.generate(5, (i) {
                  if (i < averageRating.floor()) {
                    return const Icon(
                      Icons.star,
                      size: 24,
                      color: Color(0xFFFF9D5C),
                    );
                  } else if (i == averageRating.floor() &&
                      averageRating % 1 >= 0.5) {
                    return const Icon(
                      Icons.star_half,
                      size: 24,
                      color: Color(0xFFFF9D5C),
                    );
                  }
                  return const Icon(
                    Icons.star_border,
                    size: 24,
                    color: Color(0xFFFF9D5C),
                  );
                }),
              ),
              const SizedBox(width: 8),
              Text(
                averageRating.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: CpColors.textMain,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '($totalCount)',
                style: const TextStyle(fontSize: 14, color: CpColors.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.sentiment_satisfied_outlined,
                  size: 18,
                  color: CpColors.textSub,
                ),
                const SizedBox(width: 6),
                Text(
                  '6,000명 이상 만족했어요',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: CpColors.textMain,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...distribution.entries.map((e) {
            final percent = e.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      e.key,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: CpColors.textBody,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: percent / 100,
                        backgroundColor: const Color(0xFFE5E5E5),
                        valueColor: AlwaysStoppedAnimation(
                          percent > 50
                              ? const Color(0xFFFF9D5C)
                              : CpColors.textMuted,
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 38,
                    child: Text(
                      '$percent%',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: CpColors.textMain,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          const Divider(height: 24),
          ...aspectRatings.entries.map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(
                      e.key,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: CpColors.textMain,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      e.value,
                      style: const TextStyle(
                        fontSize: 13,
                        color: CpColors.textBody,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 38,
                    child: Text(
                      '${aspectPercents[e.key]}%',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: CpColors.textMain,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '자세히 보기',
                    style: CpText.caption.copyWith(color: CpColors.blue),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 14,
                    color: CpColors.blue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
