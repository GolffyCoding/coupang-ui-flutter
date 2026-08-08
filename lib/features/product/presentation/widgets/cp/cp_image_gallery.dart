import 'package:flutter/material.dart';
import '../../../../../core/theme/cp_theme.dart';
import '../../../../../core/widgets/cp/cp_image.dart';

class CpImageGallery extends StatefulWidget {
  final List<String> imageUrls;
  const CpImageGallery({super.key, required this.imageUrls});

  @override
  State<CpImageGallery> createState() => _CpImageGalleryState();
}

class _CpImageGalleryState extends State<CpImageGallery> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            color: CpColors.bg,
            child: PageView.builder(
              itemCount: widget.imageUrls.length,
              onPageChanged: (i) => setState(() => _currentIndex = i),
              itemBuilder: (context, i) {
                return CpImage(
                  widget.imageUrls[i],
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Center(
                    child: Icon(
                      Icons.image,
                      color: CpColors.textMuted,
                      size: 48,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        if (widget.imageUrls.length > 1)
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: widget.imageUrls.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final isSelected = i == _currentIndex;
                return GestureDetector(
                  onTap: () => setState(() => _currentIndex = i),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: CpColors.bg,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isSelected ? CpColors.blue : CpColors.border,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CpImage(
                      widget.imageUrls[i],
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.image,
                        size: 20,
                        color: CpColors.textMuted,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
