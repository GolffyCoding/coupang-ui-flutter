import '../entities/product.dart';
import '../repositories/product_repository.dart';

class SearchProducts {
  final ProductRepository repository;
  const SearchProducts(this.repository);

  List<Product> call(String query) {
    if (query.trim().isEmpty) return [];
    final q = query.trim().toLowerCase();
    return repository
        .getProductsSync()
        .where(
          (p) =>
              p.title.toLowerCase().contains(q) ||
              p.brand.toLowerCase().contains(q),
        )
        .toList();
  }
}
