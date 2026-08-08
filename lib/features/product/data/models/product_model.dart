import '../../domain/entities/product.dart';

class ProductModel {
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

  const ProductModel({
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

  factory ProductModel.fromEntity(Product p) => ProductModel(
    id: p.id, imageUrl: p.imageUrl, title: p.title, brand: p.brand,
    price: p.price, originalPrice: p.originalPrice,
    discountPercent: p.discountPercent, rating: p.rating,
    reviewCount: p.reviewCount, isRocket: p.isRocket, topBadge: p.topBadge,
    galleryImages: p.galleryImages, arrivalText: p.arrivalText,
    colors: p.colors, options: p.options, description: p.description,
  );

  Product toEntity() => Product(
    id: id, imageUrl: imageUrl, title: title, brand: brand, price: price,
    originalPrice: originalPrice, discountPercent: discountPercent,
    rating: rating, reviewCount: reviewCount, isRocket: isRocket,
    topBadge: topBadge, galleryImages: galleryImages,
    arrivalText: arrivalText, colors: colors, options: options,
    description: description,
  );
}
