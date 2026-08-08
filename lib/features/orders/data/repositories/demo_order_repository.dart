import 'package:flutter/foundation.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../../../product/data/repositories/demo_product_repository.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';

/// In-memory demo order history repository, app-wide singleton.
class DemoOrderRepository extends ChangeNotifier implements OrderRepository {
  DemoOrderRepository._internal() {
    _seedDemoOrders();
  }
  static final DemoOrderRepository instance = DemoOrderRepository._internal();

  final List<CpOrder> _orders = [];

  @override
  List<CpOrder> getOrders() =>
      List.unmodifiable(_orders.reversed.toList());

  @override
  CpOrder placeOrder({
    required List<CartItem> items,
    required int totalPrice,
    required String address,
    required String paymentMethod,
  }) {
    final order = CpOrder(
      id: 'ORD${DateTime.now().millisecondsSinceEpoch}',
      orderDate: DateTime.now(),
      items: items,
      totalPrice: totalPrice,
      address: address,
      paymentMethod: paymentMethod,
      status: OrderStatus.paid,
    );
    _orders.add(order);
    notifyListeners();
    return order;
  }

  void _seedDemoOrders() {
    final products = DemoProductRepository.products;
    if (products.isEmpty) return;
    final now = DateTime.now();
    _orders.addAll([
      CpOrder(
        id: 'ORD${now.subtract(const Duration(days: 12)).millisecondsSinceEpoch}',
        orderDate: now.subtract(const Duration(days: 12)),
        items: [CartItem(product: products[0], quantity: 1)],
        totalPrice: products[0].price,
        address: '서울특별시 송파구 로켓배송로 570',
        paymentMethod: '쿠팡페이 (카드)',
        status: OrderStatus.delivered,
      ),
      if (products.length > 2)
        CpOrder(
          id: 'ORD${now.subtract(const Duration(days: 2)).millisecondsSinceEpoch}',
          orderDate: now.subtract(const Duration(days: 2)),
          items: [
            CartItem(product: products[2], quantity: 1),
          ],
          totalPrice: products[2].price,
          address: '서울특별시 송파구 로켓배송로 570',
          paymentMethod: '무통장입금',
          status: OrderStatus.shipping,
        ),
    ]);
  }
}
