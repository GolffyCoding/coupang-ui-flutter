import 'package:flutter/material.dart';
import '../../../../../core/theme/cp_theme.dart';

class CpDeliveryInfo extends StatelessWidget {
  final bool isRocket;
  final String arrivalText;
  const CpDeliveryInfo({
    super.key,
    this.isRocket = true,
    required this.arrivalText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: CpColors.blueLight,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          if (isRocket) ...[
            const Icon(
              Icons.rocket_launch,
              color: CpColors.rocketBlue,
              size: 18,
            ),
            const SizedBox(width: 6),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isRocket)
                  Text('로켓배송', style: CpText.rocket.copyWith(fontSize: 12)),
                Text(
                  arrivalText,
                  style: const TextStyle(
                    fontSize: 13,
                    color: CpColors.textBody,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 18, color: CpColors.textMuted),
        ],
      ),
    );
  }
}
