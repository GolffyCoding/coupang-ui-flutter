import 'package:flutter/material.dart';
import '../../../../../core/theme/cp_theme.dart';

class CpQuantitySelector extends StatefulWidget {
  final int initial;
  final int max;
  final Function(int)? onChanged;

  const CpQuantitySelector({
    super.key,
    this.initial = 1,
    this.max = 99,
    this.onChanged,
  });

  @override
  State<CpQuantitySelector> createState() => _CpQuantitySelectorState();
}

class _CpQuantitySelectorState extends State<CpQuantitySelector> {
  late int _qty;

  @override
  void initState() {
    super.initState();
    _qty = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: CpColors.border),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QtyBtn(
            icon: Icons.remove,
            onTap: _qty > 1 ? () => _setQty(_qty - 1) : null,
          ),
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text(
              '$_qty',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          _QtyBtn(
            icon: Icons.add,
            onTap: _qty < widget.max ? () => _setQty(_qty + 1) : null,
          ),
        ],
      ),
    );
  }

  void _setQty(int v) {
    setState(() => _qty = v);
    widget.onChanged?.call(v);
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _QtyBtn({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        color: onTap == null ? CpColors.bgGray : CpColors.white,
        child: Icon(
          icon,
          size: 16,
          color: onTap == null ? CpColors.textMuted : CpColors.textBody,
        ),
      ),
    );
  }
}
