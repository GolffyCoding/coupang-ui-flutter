import 'package:flutter/material.dart';
import '../../theme/cp_theme.dart';

class CategoryButton extends StatelessWidget {
  final VoidCallback? onTap;
  const CategoryButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      icon: const Icon(Icons.menu, color: CpColors.textMain, size: 24),
    );
  }
}
