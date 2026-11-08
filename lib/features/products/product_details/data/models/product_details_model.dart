class ProductDetailsModel {
  final String id;
  final String name;
  final String nameArabic;
  final String description;
  final String descriptionArabic;
  final String coverImage;
  final List<dynamic> productImage;
  final List<dynamic> categories;
  final double price;
  final int quantity;
  final double rating;
  final String color;
  final int reviewsCount;
  final int discount;

  ProductDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.rating,
    required this.color,
    required this.categories,
    required this.nameArabic,
    required this.descriptionArabic,
    required this.coverImage,
    required this.productImage,
    required this.reviewsCount,
    required this.discount,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      coverImage: json['coverPictureUrl']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: (json['stock'] as num?)?.toInt() ?? 0,
      categories: (json['categories'] as List<dynamic>?) ?? [],
      nameArabic:
          json['nameArabic']?.toString() ?? json['arabicName']?.toString() ?? '',
      descriptionArabic: json['descriptionArabic']?.toString() ??
          json['arabicDescription']?.toString() ??
          '',
      productImage: (json['productPictures'] as List<dynamic>?) ?? [],
      color: json['color']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: (json['reviewsCount'] as num?)?.toInt() ?? 0,
      discount: (json['discountPercentage'] as num?)?.toInt() ?? 0,
    );
  }
}
