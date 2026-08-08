import 'package:flutter/material.dart';
import '../../../../core/theme/cp_theme.dart';
import '../../../../core/widgets/coupang_widgets.dart';
import '../../../product/presentation/widgets/product_widgets.dart';
import '../../domain/entities/cart_item.dart';

class CpCartItemTile extends StatelessWidget {
  final CartItem item;
  final ValueChanged<bool?> onSelectChanged;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemove;

  const CpCartItemTile({
    super.key,
    required this.item,
    required this.onSelectChanged,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  String _fmt(int v) => v.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (m) => '${m[1]},',
  );

  @override
  Widget build(BuildContext context) {
    final p = item.product;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: CpColors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: item.selected,
                onChanged: onSelectChanged,
                activeColor: CpColors.blue,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CpImage(
                  p.imageUrl,
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 72,
                    height: 72,
                    color: CpColors.bg,
                    child: const Icon(Icons.image, color: CpColors.textMuted),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (p.isRocket) const CpRocketBadge(small: true),
                    const SizedBox(height: 4),
                    Text(
                      p.title,
                      style: CpText.body.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${_fmt(p.price)}원',
                      style: CpText.price.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onRemove,
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: CpColors.textMuted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CpQuantitySelector(
                initial: item.quantity,
                onChanged: onQuantityChanged,
              ),
              const SizedBox(width: 12),
              Text(
                '${_fmt(item.subtotal)}원',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: CpColors.textMain,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CpEmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const CpEmptyState({
    super.key,
    required this.icon,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: CpColors.textPlaceholder),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(fontSize: 14, color: CpColors.textMuted),
          ),
          if (actionLabel != null) ...[
            const SizedBox(height: 20),
            GestureDetector(
              onTap: onAction,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: CpColors.blue,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  actionLabel!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
