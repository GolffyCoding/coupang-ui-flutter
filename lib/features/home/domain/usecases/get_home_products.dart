import '../../../product/domain/entities/product.dart';
import '../../../product/data/repositories/demo_product_repository.dart';

class GetHomeProducts {
  List<Product> call() => DemoProductRepository.products;
}
