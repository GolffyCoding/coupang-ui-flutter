import '../../../product/domain/entities/product.dart';

abstract interface class WishlistRepository {
  List<Product> getItems();
  bool isWishlisted(String productId);
  void toggle(Product product);
  void remove(String productId);
}
