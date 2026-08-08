import 'package:flutter/foundation.dart';
import '../../../product/domain/entities/product.dart';
import '../../domain/repositories/wishlist_repository.dart';

/// In-memory demo wishlist repository, app-wide singleton.
class DemoWishlistRepository extends ChangeNotifier
    implements WishlistRepository {
  DemoWishlistRepository._internal();
  static final DemoWishlistRepository instance =
      DemoWishlistRepository._internal();

  final List<Product> _items = [];

  @override
  List<Product> getItems() => List.unmodifiable(_items);

  @override
  bool isWishlisted(String productId) =>
      _items.any((p) => p.id == productId);

  @override
  void toggle(Product product) {
    if (isWishlisted(product.id)) {
      _items.removeWhere((p) => p.id == product.id);
    } else {
      _items.add(product);
    }
    notifyListeners();
  }

  @override
  void remove(String productId) {
    _items.removeWhere((p) => p.id == productId);
    notifyListeners();
  }
}
