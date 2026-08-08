import '../../../product/domain/entities/product.dart';
import '../repositories/wishlist_repository.dart';

class GetWishlistItems {
  final WishlistRepository repository;
  const GetWishlistItems(this.repository);

  List<Product> call() => repository.getItems();
}
