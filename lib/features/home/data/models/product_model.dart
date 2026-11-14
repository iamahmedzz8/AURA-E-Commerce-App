/// Model representing a Product in AURA Maison.
/// Generated from OpenAPI specification: ProductDto
class ProductModel {
  final String id;
  final String productCode;
  final String name;
  final String? arabicName;
  final String? description;
  final String? arabicDescription;
  final String coverPictureUrl;
  final List<String> productPictures;
  final double price;
  final int stock;
  final double weight;
  final String color;
  final double rating;
  final int reviewsCount;
  final int discountPercentage;
  final String? sellerId;
  final List<String> categories;

  const ProductModel({
    required this.id,
    required this.productCode,
    required this.name,
    this.arabicName,
    this.description,
    this.arabicDescription,
    required this.coverPictureUrl,
    this.productPictures = const [],
    required this.price,
    this.stock = 0,
    this.weight = 0.0,
    this.color = '',
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.discountPercentage = 0,
    this.sellerId,
    this.categories = const [],
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String? ?? '',
      productCode: json['productCode'] as String? ?? '',
      name: json['name'] as String? ?? '',
      arabicName: json['arabicName'] as String?,
      description: json['description'] as String?,
      arabicDescription: json['arabicDescription'] as String?,
      coverPictureUrl:
          json['coverPictureUrl'] as String? ??
          json['coverUrl'] as String? ??
          json['pictureUrl'] as String? ??
          '',
      productPictures:
          (json['productPictures'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          (json['pictures'] as List?)
              ?.map(
                (e) => e is Map
                    ? (e['pictureUrl']?.toString() ?? '')
                    : e.toString(),
              )
              .toList() ??
          const [],
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      color: json['color'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: (json['reviewsCount'] as num?)?.toInt() ?? 0,
      discountPercentage: (json['discountPercentage'] as num?)?.toInt() ?? 0,
      sellerId: json['sellerId'] as String?,
      categories:
          (json['categories'] as List?)
              ?.map(
                (e) => e is Map ? (e['name']?.toString() ?? '') : e.toString(),
              )
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productCode': productCode,
      'name': name,
      'arabicName': arabicName,
      'description': description,
      'arabicDescription': arabicDescription,
      'coverPictureUrl': coverPictureUrl,
      'productPictures': productPictures,
      'price': price,
      'stock': stock,
      'weight': weight,
      'color': color,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'discountPercentage': discountPercentage,
      'sellerId': sellerId,
      'categories': categories,
    };
  }
}
