import 'package:flutter/material.dart';
import '../../../../../core/theme/cp_theme.dart';
import '../../../../../core/widgets/cp/cp_image.dart';
import '../../../domain/entities/review.dart';

class CpReviewCard extends StatelessWidget {
  final Review review;
  const CpReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CpColors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Container(
                  width: 50,
                  height: 50,
                  color: CpColors.bg,
                  child:
                      review.profileImage != null &&
                          review.profileImage!.isNotEmpty
                      ? CpImage(
                          review.profileImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.person,
                            color: CpColors.textMuted,
                          ),
                        )
                      : const Icon(Icons.person, color: CpColors.textMuted),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          review.userName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: CpColors.textMain,
                          ),
                        ),
                        if (review.badge != null &&
                            review.badge!.isNotEmpty) ...[
                          const SizedBox(width: 6),
                          CpImage(
                            review.badge!,
                            height: 16,
                            errorBuilder: (_, __, ___) =>
                                const SizedBox.shrink(),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (i) => Icon(
                              i < review.rating.floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              size: 14,
                              color: CpColors.star,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          review.date,
                          style: const TextStyle(
                            fontSize: 12,
                            color: CpColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    if (review.sellerName.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          '판매자: ${review.sellerName}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: CpColors.textMuted,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              review.productOption,
              style: const TextStyle(
                fontSize: 13,
                color: CpColors.textSub,
                height: 1.4,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (review.images.isNotEmpty)
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: review.images
                  .map(
                    (url) => Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: CpColors.bg,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: CpImage(
                        url,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.image,
                          size: 24,
                          color: CpColors.textMuted,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          if (review.title != null && review.title!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              review.title!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: CpColors.textMain,
                height: 1.4,
              ),
            ),
          ],
          const SizedBox(height: 8),
          Text(
            review.content,
            style: const TextStyle(
              fontSize: 13,
              color: CpColors.textBody,
              height: 1.7,
            ),
          ),
          if (review.subRatings.isNotEmpty) ...[
            const SizedBox(height: 12),
            ...review.subRatings.entries
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
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
                      ],
                    ),
                  ),
                )
                .toList(),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: CpColors.blue),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.thumb_up_outlined,
                      size: 12,
                      color: CpColors.blue,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      review.likeCount > 0
                          ? '${review.likeCount}명에게 도움이 됐어요'
                          : '도움이 돼요',
                      style: TextStyle(
                        fontSize: 12,
                        color: CpColors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  '신고하기',
                  style: TextStyle(fontSize: 12, color: CpColors.textSub),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
