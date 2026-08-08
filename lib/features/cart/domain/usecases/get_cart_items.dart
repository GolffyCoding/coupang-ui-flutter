import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class GetCartItems {
  final CartRepository repository;
  const GetCartItems(this.repository);

  List<CartItem> call() => repository.getItems();
}
