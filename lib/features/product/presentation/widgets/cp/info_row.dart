import 'package:flutter/material.dart';
import '../../../../../core/theme/cp_theme.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: CpColors.textMuted),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: CpColors.textBody,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
