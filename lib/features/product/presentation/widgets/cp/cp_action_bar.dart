import 'package:flutter/material.dart';
import '../../../../../core/theme/cp_theme.dart';

class CpActionBar extends StatelessWidget {
  final VoidCallback? onAddToCart;
  final VoidCallback? onBuyNow;
  final VoidCallback? onWishlistTap;
  final bool isWishlisted;
  final GlobalKey? addToCartKey;

  const CpActionBar({
    super.key,
    this.onAddToCart,
    this.onBuyNow,
    this.onWishlistTap,
    this.isWishlisted = false,
    this.addToCartKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      decoration: BoxDecoration(
        color: CpColors.white,
        border: Border(top: BorderSide(color: CpColors.divider)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onWishlistTap,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isWishlisted ? CpColors.redLight : CpColors.white,
                    border: Border.all(
                      color: isWishlisted ? CpColors.red : CpColors.border,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TweenAnimationBuilder<double>(
                    key: ValueKey(isWishlisted),
                    tween: Tween(begin: 0.4, end: 1.0),
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.elasticOut,
                    builder: (context, scale, child) =>
                        Transform.scale(scale: scale, child: child),
                    child: Icon(
                      isWishlisted ? Icons.favorite : Icons.favorite_border,
                      color: isWishlisted ? CpColors.red : CpColors.textSub,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Material(
                key: addToCartKey,
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: onAddToCart,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(color: CpColors.blue),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '장바구니 담기',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: CpColors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Material(
                color: CpColors.blue,
                borderRadius: BorderRadius.circular(6),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: onBuyNow,
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    child: const Text(
                      '바로구매',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
