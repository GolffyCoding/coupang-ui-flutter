import 'package:flutter/material.dart';
import '../../theme/cp_theme.dart';

class CpChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isActive;
  final VoidCallback? onTap;
  const CpChip({
    super.key,
    required this.label,
    this.icon,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Material(
        color: isActive ? CpColors.blue : CpColors.white,
        borderRadius: BorderRadius.circular(18),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isActive ? CpColors.blue : CpColors.border,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 13,
                    color: isActive ? Colors.white : CpColors.textSub,
                  ),
                  const SizedBox(width: 4),
                ],
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    color: isActive ? Colors.white : CpColors.textBody,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
