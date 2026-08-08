class Review {
  final String userName;
  final String? profileImage;
  final String? badge;
  final double rating;
  final String date;
  final String sellerName;
  final String productOption;
  final String? title;
  final String content;
  final List<String> images;
  final Map<String, String> subRatings;
  final int likeCount;

  Review({
    required this.userName,
    this.profileImage,
    this.badge,
    required this.rating,
    required this.date,
    this.sellerName = '',
    required this.productOption,
    this.title,
    required this.content,
    this.images = const [],
    this.subRatings = const {},
    this.likeCount = 0,
  });
}
