import 'package:flutter/material.dart';
import '../../theme/cp_theme.dart';

class CpDiscountBadge extends StatelessWidget {
  final int percent;
  final bool small;
  const CpDiscountBadge({super.key, required this.percent, this.small = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 4 : 5,
        vertical: small ? 2 : 3,
      ),
      decoration: BoxDecoration(
        color: CpColors.redLight,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        '$percent%',
        style: CpText.discount.copyWith(fontSize: small ? 11 : 13),
      ),
    );
  }
}
