class ProductEntity {
  final String id;
  final String name;
  final String nameArabic;
  final String description;
  final String descriptionArabic;
  final String coverPictureUrl;
  final double price;
  final int stock;
  final double weight;
  final String color;
  final double discountPercentage;
  final List<String> categoryIds;
  final List<String> productPictureUrls;

  ProductEntity({
    required this.id,
    required this.name,
    required this.nameArabic,
    required this.description,
    required this.descriptionArabic,
    required this.coverPictureUrl,
    required this.price,
    required this.stock,
    required this.weight,
    required this.color,
    required this.discountPercentage,
    required this.categoryIds,
    required this.productPictureUrls,
  });
}