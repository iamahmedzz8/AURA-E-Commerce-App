class CartItemModel {
  final String itemId;
  final String productId;
  final String productName;
  final String productCoverUrl;
  final int productStock;
  final double weightInGrams;
  final int quantity;
  final double discountPercentage;
  final double basePricePerUnit;
  final double finalPricePerUnit;
  final double totalPrice;

  const CartItemModel({
    required this.itemId,
    required this.productId,
    required this.productName,
    required this.productCoverUrl,
    required this.productStock,
    required this.weightInGrams,
    required this.quantity,
    required this.discountPercentage,
    required this.basePricePerUnit,
    required this.finalPricePerUnit,
    required this.totalPrice,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      itemId: json['itemId']?.toString() ?? '',
      productId: json['productId']?.toString() ?? '',
      productName: json['productName']?.toString() ?? '',
      productCoverUrl: json['productCoverUrl']?.toString() ?? '',
      productStock: (json['productStock'] as num?)?.toInt() ?? 0,
      weightInGrams: (json['weightInGrams'] as num?)?.toDouble() ?? 0.0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      basePricePerUnit: (json['basePricePerUnit'] as num?)?.toDouble() ?? 0.0,
      finalPricePerUnit: (json['finalPricePerUnit'] as num?)?.toDouble() ?? 0.0,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
