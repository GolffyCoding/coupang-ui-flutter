import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductDetail {
  final ProductRepository repository;
  const GetProductDetail(this.repository);

  Future<Product> call(String id) => repository.getProductById(id);
}
