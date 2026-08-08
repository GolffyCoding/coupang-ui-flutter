import '../../../product/domain/entities/product.dart';
import '../../../product/data/repositories/demo_product_repository.dart';

enum SortOption { recommended, priceAsc, priceDesc, rating }

class CpSearchController {
  List<Product> search(String query) {
    if (query.trim().isEmpty) return [];
    final q = query.trim().toLowerCase();
    return DemoProductRepository.products
        .where(
          (p) =>
              p.title.toLowerCase().contains(q) ||
              p.brand.toLowerCase().contains(q),
        )
        .toList();
  }

  List<Product> sort(List<Product> products, SortOption option) {
    final list = List<Product>.from(products);
    switch (option) {
      case SortOption.recommended:
        break;
      case SortOption.priceAsc:
        list.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceDesc:
        list.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.rating:
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
    return list;
  }
}
