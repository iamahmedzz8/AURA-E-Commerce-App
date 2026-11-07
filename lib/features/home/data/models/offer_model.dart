/// Model representing a promotional offer or marketing campaign banner.
class OfferModel {
  final String id;
  final String name;
  final String? description;
  final String coverUrl;
  final DateTime? createdAt;

  const OfferModel({
    required this.id,
    required this.name,
    this.description,
    required this.coverUrl,
    this.createdAt,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      coverUrl: json['coverUrl'] as String? ??
          json['offerCoverUrl'] as String? ??
          json['offerCoverPicture'] as String? ??
          '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'coverUrl': coverUrl,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
