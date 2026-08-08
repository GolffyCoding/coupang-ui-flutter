import '../../../product/domain/entities/product.dart';
import '../repositories/wishlist_repository.dart';

/// Toggles a product's wishlist membership (the demo repository exposes a
/// single toggle operation rather than separate add/contains checks).
class AddToWishlist {
  final WishlistRepository repository;
  const AddToWishlist(this.repository);

  void call(Product product) => repository.toggle(product);
}
