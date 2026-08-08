import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/repository_providers.dart';
import '../../../../core/theme/cp_theme.dart';
import '../../../../core/widgets/coupang_widgets.dart';
import '../../../cart/presentation/widgets/cart_widgets.dart';
import '../widgets/order_widgets.dart';
import 'order_detail_page.dart';

class CpOrderListPage extends ConsumerWidget {
  const CpOrderListPage({super.key});

  String _fmt(int v) => v.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (m) => '${m[1]},',
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ChangeNotifier-typed provider drives reactive rebuilds when new
    // orders are placed elsewhere in the app.
    final repo = ref.watch(orderChangeNotifierProvider);
    return Scaffold(
      backgroundColor: CpColors.bg,
      appBar: AppBar(
        backgroundColor: CpColors.white,
        elevation: 0,
        title: const Text(
          '주문내역',
          style: TextStyle(
            color: CpColors.textMain,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: CpColors.textMain),
      ),
      body: Builder(
        builder: (context) {
          final orders = repo.getOrders();
          if (orders.isEmpty) {
            return const CpEmptyState(
              icon: Icons.receipt_long_outlined,
              message: '주문 내역이 없습니다',
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: orders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, i) {
              final order = orders[i];
              final item = order.items.first;
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CpOrderDetailPage(order: order),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: CpColors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: CpColors.border),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${order.orderDate.year}.${order.orderDate.month.toString().padLeft(2, '0')}.${order.orderDate.day.toString().padLeft(2, '0')} 주문',
                            style: const TextStyle(
                              fontSize: 12,
                              color: CpColors.textMuted,
                            ),
                          ),
                          const Spacer(),
                          CpOrderStatusChip(status: order.status),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: CpImage(
                              item.product.imageUrl,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.items.length > 1
                                      ? '${item.product.title} 외 ${order.items.length - 1}건'
                                      : item.product.title,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: CpColors.textMain,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${_fmt(order.totalPrice)}원',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: CpColors.textMain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            color: CpColors.textMuted,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
