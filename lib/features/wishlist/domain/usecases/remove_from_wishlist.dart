import '../repositories/wishlist_repository.dart';

class RemoveFromWishlist {
  final WishlistRepository repository;
  const RemoveFromWishlist(this.repository);

  void call(String productId) => repository.remove(productId);
}
