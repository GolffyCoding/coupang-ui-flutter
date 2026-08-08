class Product {
  final String id;
  final String imageUrl;
  final String title;
  final String brand;
  final int price;
  final int? originalPrice;
  final int? discountPercent;
  final double rating;
  final int reviewCount;
  final bool isRocket;
  final String? topBadge;
  final List<String> galleryImages;
  final String? arrivalText;
  final List<String> colors;
  final List<String> options;
  final String? description;

  Product({
    required this.id,
    required this.imageUrl,
    required this.title,
    this.brand = '',
    required this.price,
    this.originalPrice,
    this.discountPercent,
    this.rating = 0,
    this.reviewCount = 0,
    this.isRocket = true,
    this.topBadge,
    this.galleryImages = const [],
    this.arrivalText,
    this.colors = const [],
    this.options = const [],
    this.description,
  });
}
