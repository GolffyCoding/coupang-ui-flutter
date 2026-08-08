import 'package:flutter/material.dart';

class CpColors {
  CpColors._();
  static const Color blue = Color(0xFF346AFF);
  static const Color blueLight = Color(0xFFE8F4FD);
  static const Color rocketBlue = Color(0xFF3182F6);
  static const Color rocketBg = Color(0xFFE8F4FD);
  static const Color red = Color(0xFFE02020);
  static const Color redLight = Color(0xFFFFF0F0);
  static const Color orange = Color(0xFFFF6B35);
  static const Color textMain = Color(0xFF111111);
  static const Color textBody = Color(0xFF333333);
  static const Color textSub = Color(0xFF666666);
  static const Color textMuted = Color(0xFF999999);
  static const Color textPlaceholder = Color(0xFFBBBBBB);
  static const Color white = Color(0xFFFFFFFF);
  static const Color bg = Color(0xFFF5F5F5);
  static const Color bgGray = Color(0xFFF0F0F0);
  static const Color border = Color(0xFFE5E5E5);
  static const Color divider = Color(0xFFEEEEEE);
  static const Color star = Color(0xFFFFB800);
  static const Color logoBlue = Color(0xFF4285F4);
  static const Color logoOrange = Color(0xFFFF6B35);
  static const Color logoGreen = Color(0xFF34A853);
  static const Color logoSky = Color(0xFF87CEEB);
  static const Color green = Color(0xFF34A853);
  static const Color greenLight = Color(0xFFE8F5E9);
}

class CpText {
  static const String font = 'NotoSansKR';
  static TextStyle get h1 => const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: CpColors.textMain,
    height: 1.3,
    letterSpacing: -0.5,
  );
  static TextStyle get h2 => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: CpColors.textMain,
    height: 1.35,
    letterSpacing: -0.3,
  );
  static TextStyle get h3 => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: CpColors.textMain,
    height: 1.4,
  );
  static TextStyle get body => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: CpColors.textBody,
    height: 1.5,
  );
  static TextStyle get caption => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: CpColors.textMuted,
    height: 1.4,
  );
  static TextStyle get price => const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: CpColors.textMain,
    height: 1.2,
    letterSpacing: -0.3,
  );
  static TextStyle get priceOld => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: CpColors.textMuted,
    decoration: TextDecoration.lineThrough,
    height: 1.2,
  );
  static TextStyle get discount => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: CpColors.red,
    height: 1.2,
  );
  static TextStyle get badge => const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: CpColors.white,
    height: 1.0,
  );
  static TextStyle get rocket => const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w800,
    color: CpColors.rocketBlue,
    height: 1.0,
  );
}
