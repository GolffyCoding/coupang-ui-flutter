import 'package:flutter/material.dart';
import '../../../../core/theme/cp_theme.dart';
import '../../domain/entities/cart_item.dart';
import '../../data/repositories/demo_cart_repository.dart';
import '../../../orders/data/repositories/demo_order_repository.dart';
import '../../../orders/presentation/pages/order_detail_page.dart';

class CpCheckoutPage extends StatefulWidget {
  final List<CartItem> items;
  const CpCheckoutPage({super.key, required this.items});

  @override
  State<CpCheckoutPage> createState() => _CpCheckoutPageState();
}

class _CpCheckoutPageState extends State<CpCheckoutPage> {
  final _paymentMethods = const ['쿠팡페이 (카드)', '무통장입금', '휴대폰 결제', '네이버페이'];
  int _selectedPayment = 0;
  bool _placing = false;

  String _fmt(int v) => v.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (m) => '${m[1]},',
  );

  int get _total => widget.items.fold(0, (sum, i) => sum + i.subtotal);

  Future<void> _placeOrder() async {
    setState(() => _placing = true);
    await Future.delayed(const Duration(milliseconds: 600));
    final order = DemoOrderRepository.instance.placeOrder(
      items: widget.items,
      totalPrice: _total,
      address: '서울특별시 송파구 로켓배송로 570 (본인)',
      paymentMethod: _paymentMethods[_selectedPayment],
    );
    for (final item in widget.items) {
      DemoCartRepository.instance.removeItem(item.product.id);
    }
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            CpOrderDetailPage(order: order, justPlaced: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CpColors.bg,
      appBar: AppBar(
        backgroundColor: CpColors.white,
        elevation: 0,
        title: const Text(
          '주문/결제',
          style: TextStyle(
            color: CpColors.textMain,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: CpColors.textMain),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 16),
        children: [
          _SectionCard(
            title: '배송지',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '본인  010-1234-5678',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: CpColors.textMain,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '서울특별시 송파구 로켓배송로 570',
                  style: TextStyle(fontSize: 13, color: CpColors.textBody),
                ),
                SizedBox(height: 2),
                Text(
                  '공동현관 비밀번호 없음 · 문 앞에 놓아주세요',
                  style: TextStyle(fontSize: 12, color: CpColors.textMuted),
                ),
              ],
            ),
          ),
          _SectionCard(
            title: '주문상품 (${widget.items.length})',
            child: Column(
              children: widget.items
                  .map(
                    (i) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${i.product.title} x${i.quantity}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: CpColors.textBody,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '${_fmt(i.subtotal)}원',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: CpColors.textMain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          _SectionCard(
            title: '결제수단',
            child: Column(
              children: List.generate(_paymentMethods.length, (i) {
                final selected = i == _selectedPayment;
                return GestureDetector(
                  onTap: () => setState(() => _selectedPayment = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: selected ? CpColors.blueLight : CpColors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: selected ? CpColors.blue : CpColors.border,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          selected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          size: 18,
                          color: selected
                              ? CpColors.blue
                              : CpColors.textMuted,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _paymentMethods[i],
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w400,
                            color: selected
                                ? CpColors.textMain
                                : CpColors.textBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          _SectionCard(
            title: '결제금액',
            child: Column(
              children: [
                _PriceRow(label: '상품금액', value: '${_fmt(_total)}원'),
                const _PriceRow(label: '배송비', value: '무료'),
                const Divider(height: 20),
                _PriceRow(
                  label: '총 결제금액',
                  value: '${_fmt(_total)}원',
                  isTotal: true,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          color: CpColors.white,
          border: const Border(top: BorderSide(color: CpColors.divider)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CpColors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: _placing ? null : _placeOrder,
              child: _placing
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.4,
                      ),
                    )
                  : Text(
                      '${_fmt(_total)}원 결제하기',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      color: CpColors.white,
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: CpText.h3),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  const _PriceRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 14 : 13,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
              color: isTotal ? CpColors.textMain : CpColors.textBody,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 13,
              fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
              color: isTotal ? CpColors.red : CpColors.textMain,
            ),
          ),
        ],
      ),
    );
  }
}
