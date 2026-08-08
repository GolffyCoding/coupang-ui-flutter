import 'package:flutter/foundation.dart';
import '../../../product/domain/entities/product.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';

/// In-memory demo cart repository. Kept as an app-wide singleton
/// (ChangeNotifier) so any page can listen for cart badge / totals
/// without a third-party state-management package.
class DemoCartRepository extends ChangeNotifier implements CartRepository {
  DemoCartRepository._internal();
  static final DemoCartRepository instance = DemoCartRepository._internal();

  final List<CartItem> _items = [];

  @override
  List<CartItem> getItems() => List.unmodifiable(_items);

  int get totalItemCount => _items.fold(0, (sum, i) => sum + i.quantity);

  @override
  void addItem(Product product, {int quantity = 1}) {
    final idx = _items.indexWhere((i) => i.product.id == product.id);
    if (idx >= 0) {
      _items[idx].quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  @override
  void removeItem(String productId) {
    _items.removeWhere((i) => i.product.id == productId);
    notifyListeners();
  }

  @override
  void updateQuantity(String productId, int quantity) {
    final idx = _items.indexWhere((i) => i.product.id == productId);
    if (idx < 0) return;
    if (quantity <= 0) {
      _items.removeAt(idx);
    } else {
      _items[idx].quantity = quantity;
    }
    notifyListeners();
  }

  @override
  void setSelected(String productId, bool selected) {
    final idx = _items.indexWhere((i) => i.product.id == productId);
    if (idx < 0) return;
    _items[idx].selected = selected;
    notifyListeners();
  }

  @override
  void setAllSelected(bool selected) {
    for (final i in _items) {
      i.selected = selected;
    }
    notifyListeners();
  }

  @override
  void clear() {
    _items.clear();
    notifyListeners();
  }

  @override
  void clearSelected() {
    _items.removeWhere((i) => i.selected);
    notifyListeners();
  }
}
