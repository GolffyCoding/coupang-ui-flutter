import 'package:flutter/material.dart';
import '../../../../../core/theme/cp_theme.dart';

class CpOptionSelector extends StatelessWidget {
  final String label;
  final List<String> options;
  final String? selected;
  final Function(String)? onSelect;

  const CpOptionSelector({
    super.key,
    required this.label,
    required this.options,
    this.selected,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: CpText.body.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((opt) {
            final isSelected = opt == selected;
            return GestureDetector(
              onTap: () => onSelect?.call(opt),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? CpColors.blue : CpColors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: isSelected ? CpColors.blue : CpColors.border,
                  ),
                ),
                child: Text(
                  opt,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? Colors.white : CpColors.textBody,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
