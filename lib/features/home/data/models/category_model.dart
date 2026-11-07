/// Model representing a product category in AURA Maison.
class CategoryModel {
  final String id;
  final String name;
  final String? description;
  final String coverPictureUrl;

  const CategoryModel({
    required this.id,
    required this.name,
    this.description,
    required this.coverPictureUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      coverPictureUrl: json['coverPictureUrl'] as String? ??
          json['coverUrl'] as String? ??
          json['categoryCoverUrl'] as String? ??
          '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'coverPictureUrl': coverPictureUrl,
    };
  }
}
