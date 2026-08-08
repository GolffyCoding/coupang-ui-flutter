import 'package:flutter/material.dart';
import '../../theme/cp_theme.dart';

class CoupangLogo extends StatelessWidget {
  final double size;
  const CoupangLogo({super.key, this.size = 26});

  @override
  Widget build(BuildContext context) {
    final letters = [
      ('c', CpColors.logoBlue),
      ('o', CpColors.logoOrange),
      ('u', CpColors.logoGreen),
      ('p', CpColors.logoSky),
      ('a', CpColors.logoOrange),
      ('n', CpColors.logoBlue),
      ('g', CpColors.logoGreen),
    ];
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: letters
          .map(
            (e) => Text(
              e.$1,
              style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w900,
                color: e.$2,
                height: 1,
                letterSpacing: -1.2,
              ),
            ),
          )
          .toList(),
    );
  }
}
