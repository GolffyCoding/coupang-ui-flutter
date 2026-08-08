import '../../../product/domain/entities/product.dart';
import '../entities/cart_item.dart';

abstract interface class CartRepository {
  List<CartItem> getItems();
  void addItem(Product product, {int quantity = 1});
  void removeItem(String productId);
  void updateQuantity(String productId, int quantity);
  void setSelected(String productId, bool selected);
  void setAllSelected(bool selected);
  void clear();
  void clearSelected();
}
