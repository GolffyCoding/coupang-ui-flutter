import '../entities/product.dart';

abstract interface class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProductById(String id);

  /// Synchronous accessor for the full product catalog. The demo/in-memory
  /// data source never actually performs I/O, so callers that need the
  /// list synchronously (e.g. home feed, search/sort) can use this instead
  /// of awaiting [getProducts].
  List<Product> getProductsSync();
}
