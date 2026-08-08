import 'package:flutter/material.dart';
import '../../theme/cp_theme.dart';

class CpRocketBadge extends StatelessWidget {
  final String text;
  final bool small;
  const CpRocketBadge({super.key, this.text = '로켓배송', this.small = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 4 : 5,
        vertical: small ? 2 : 3,
      ),
      decoration: BoxDecoration(
        color: CpColors.rocketBg,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.rocket_launch,
            size: small ? 10 : 11,
            color: CpColors.rocketBlue,
          ),
          const SizedBox(width: 2),
          Text(text, style: CpText.rocket.copyWith(fontSize: small ? 9 : 10)),
        ],
      ),
    );
  }
}
