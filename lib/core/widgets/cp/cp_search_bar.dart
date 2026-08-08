import 'package:flutter/material.dart';
import '../../theme/cp_theme.dart';

class CpSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onSubmitted;
  final VoidCallback? onTap;

  const CpSearchBar({
    super.key,
    this.controller,
    this.onSubmitted,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: CpColors.bgGray,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                size: 18,
                color: CpColors.textMuted,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: onTap != null
                    ? Text(
                        '찾고 싶은 상품을 검색하세요',
                        style: TextStyle(
                          color: CpColors.textPlaceholder,
                          fontSize: 13,
                        ),
                      )
                    : TextField(
                        controller: controller,
                        onSubmitted: onSubmitted,
                        style: const TextStyle(
                          fontSize: 13,
                          color: CpColors.textMain,
                        ),
                        decoration: const InputDecoration(
                          hintText: '찾고 싶은 상품을 검색하세요',
                          hintStyle: TextStyle(
                            color: CpColors.textPlaceholder,
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
