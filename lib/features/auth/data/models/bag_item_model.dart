class BagItemModel {
  final String title;
  final String subtitle;
  final String status;
  final String imagePath;

  const BagItemModel({
    required this.title,
    required this.subtitle,
    required this.status,
    this.imagePath = '',
  });
}
