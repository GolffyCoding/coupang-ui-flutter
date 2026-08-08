import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// The demo catalog isn't partitioned by category, so this mirrors the
/// existing category page behavior of showing the full catalog.
class GetCategoryProducts {
  final ProductRepository repository;
  const GetCategoryProducts(this.repository);

  List<Product> call(String categoryName) => repository.getProductsSync();
}
