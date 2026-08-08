import 'package:flutter/material.dart';
import '../../../../../core/theme/cp_theme.dart';

class CpReviewFilterBar extends StatelessWidget {
  const CpReviewFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CpColors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
        children: [
          Row(
            children: [
              _SortChip(label: '베스트순', isActive: true),
              const SizedBox(width: 12),
              _SortChip(label: '최신순', isActive: false),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: CpColors.border),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        size: 16,
                        color: CpColors.textMuted,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: '검색어를 입력하세요',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: CpColors.textPlaceholder,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                          ),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: CpColors.border),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Row(
                  children: [
                    Text(
                      '모든 별점',
                      style: TextStyle(fontSize: 14, color: CpColors.textBody),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 16,
                      color: CpColors.textSub,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  final String label;
  final bool isActive;
  const _SortChip({required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14,
        fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
        color: isActive ? CpColors.blue : CpColors.textSub,
      ),
    );
  }
}
