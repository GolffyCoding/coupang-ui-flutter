import '../../../cart/domain/entities/cart_item.dart';
import '../entities/order.dart';

abstract interface class OrderRepository {
  List<CpOrder> getOrders();

  CpOrder placeOrder({
    required List<CartItem> items,
    required int totalPrice,
    required String address,
    required String paymentMethod,
  });
}
