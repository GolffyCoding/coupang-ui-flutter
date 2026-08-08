import '../../../product/domain/entities/product.dart';
import '../repositories/cart_repository.dart';

class AddToCart {
  final CartRepository repository;
  const AddToCart(this.repository);

  void call(Product product, {int quantity = 1}) =>
      repository.addItem(product, quantity: quantity);
}
