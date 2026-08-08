import '../../../cart/domain/entities/cart_item.dart';

enum OrderStatus { paid, preparing, shipping, delivered }

extension OrderStatusLabel on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.paid:
        return '결제완료';
      case OrderStatus.preparing:
        return '상품준비중';
      case OrderStatus.shipping:
        return '배송중';
      case OrderStatus.delivered:
        return '배송완료';
    }
  }
}

class CpOrder {
  final String id;
  final DateTime orderDate;
  final List<CartItem> items;
  final int totalPrice;
  final String address;
  final String paymentMethod;
  OrderStatus status;

  CpOrder({
    required this.id,
    required this.orderDate,
    required this.items,
    required this.totalPrice,
    required this.address,
    required this.paymentMethod,
    this.status = OrderStatus.paid,
  });

  static const _steps = [
    OrderStatus.paid,
    OrderStatus.preparing,
    OrderStatus.shipping,
    OrderStatus.delivered,
  ];

  int get stepIndex => _steps.indexOf(status);
  List<OrderStatus> get steps => _steps;
}
