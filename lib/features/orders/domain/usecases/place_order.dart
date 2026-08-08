import '../../../cart/domain/entities/cart_item.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

class PlaceOrder {
  final OrderRepository repository;
  const PlaceOrder(this.repository);

  CpOrder call({
    required List<CartItem> items,
    required int totalPrice,
    required String address,
    required String paymentMethod,
  }) =>
      repository.placeOrder(
        items: items,
        totalPrice: totalPrice,
        address: address,
        paymentMethod: paymentMethod,
      );
}
