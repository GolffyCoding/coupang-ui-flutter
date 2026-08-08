import 'package:flutter/material.dart';
import '../../../../../core/theme/cp_theme.dart';
import '../../../../../core/widgets/cp/cp_image.dart';

class CpReviewGallery extends StatelessWidget {
  final List<String> imageUrls;
  final int totalCount;
  const CpReviewGallery({
    super.key,
    required this.imageUrls,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    const crossAxisCount = 7;
    const spacing = 4.0;
    final size =
        (MediaQuery.of(context).size.width -
            32 -
            (crossAxisCount - 1) * spacing) /
        crossAxisCount;

    return Container(
      color: CpColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: imageUrls.asMap().entries.map((e) {
          final isLastOverlay =
              e.key == imageUrls.length - 1 && totalCount > imageUrls.length;
          return GestureDetector(
            onTap: () {},
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CpImage(
                    e.value,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: CpColors.bg),
                  ),
                  if (isLastOverlay)
                    Container(
                      color: Colors.black.withOpacity(0.7),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '+${totalCount - imageUrls.length + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Text(
                            '더보기',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
