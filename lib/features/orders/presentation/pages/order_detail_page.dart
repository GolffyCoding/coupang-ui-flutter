import 'package:flutter/material.dart';
import '../../../../core/theme/cp_theme.dart';
import '../../../../core/widgets/coupang_widgets.dart';
import '../../domain/entities/order.dart';
import '../widgets/order_widgets.dart';

class CpOrderDetailPage extends StatelessWidget {
  final CpOrder order;
  final bool justPlaced;
  const CpOrderDetailPage({
    super.key,
    required this.order,
    this.justPlaced = false,
  });

  String _fmt(int v) => v.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (m) => '${m[1]},',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CpColors.bg,
      appBar: AppBar(
        backgroundColor: CpColors.white,
        elevation: 0,
        automaticallyImplyLeading: !justPlaced,
        title: Text(
          justPlaced ? '주문 완료' : '주문 상세',
          style: const TextStyle(
            color: CpColors.textMain,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: CpColors.textMain),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          if (justPlaced)
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              color: CpColors.white,
              padding: const EdgeInsets.symmetric(vertical: 28),
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: CpColors.greenLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: CpColors.green,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '주문이 완료되었어요!',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: CpColors.textMain,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '주문번호 ${order.id}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: CpColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            color: CpColors.white,
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('배송 현황', style: CpText.h3),
                    const Spacer(),
                    CpOrderStatusChip(status: order.status),
                  ],
                ),
                const SizedBox(height: 16),
                CpDeliveryStepper(
                  steps: order.steps,
                  currentIndex: order.stepIndex,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            color: CpColors.white,
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('주문 상품', style: CpText.h3),
                const SizedBox(height: 10),
                ...order.items.map(
                  (i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: CpImage(
                            i.product.imageUrl,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 56,
                              height: 56,
                              color: CpColors.bg,
                              child: const Icon(
                                Icons.image,
                                color: CpColors.textMuted,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '${i.product.title} x${i.quantity}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: CpColors.textBody,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '${_fmt(i.subtotal)}원',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: CpColors.textMain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            color: CpColors.white,
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('배송지 / 결제', style: CpText.h3),
                const SizedBox(height: 8),
                Text(
                  order.address,
                  style: const TextStyle(
                    fontSize: 13,
                    color: CpColors.textBody,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  order.paymentMethod,
                  style: const TextStyle(
                    fontSize: 13,
                    color: CpColors.textBody,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      '총 결제금액',
                      style: TextStyle(fontSize: 13, color: CpColors.textSub),
                    ),
                    const Spacer(),
                    Text(
                      '${_fmt(order.totalPrice)}원',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: CpColors.textMain,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: justPlaced
          ? Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              decoration: const BoxDecoration(
                color: CpColors.white,
                border: Border(top: BorderSide(color: CpColors.divider)),
              ),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CpColors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () =>
                        Navigator.popUntil(context, (r) => r.isFirst),
                    child: const Text(
                      '쇼핑 계속하기',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
