import '../../../product/domain/entities/product.dart';
import '../../../product/domain/repositories/product_repository.dart';

class GetHomeProducts {
  final ProductRepository repository;
  const GetHomeProducts(this.repository);

  List<Product> call() => repository.getProductsSync();
}
