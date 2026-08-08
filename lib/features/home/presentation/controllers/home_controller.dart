import '../../../product/domain/entities/product.dart';
import '../../domain/usecases/get_home_products.dart';

class HomeController {
  final GetHomeProducts getHomeProducts;
  HomeController(this.getHomeProducts);

  List<Product> get products => getHomeProducts();
}
