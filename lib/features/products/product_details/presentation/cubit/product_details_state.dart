class ProductDetailsState {
  final bool isDark;
  final int quantity;
  final bool isFavorite;

  const ProductDetailsState({
    this.isDark = true,
    this.quantity = 1,
    this.isFavorite = false,
  });

  ProductDetailsState copyWith({
    bool? isDark,
    int? quantity,
    bool? isFavorite,
  }) {
    return ProductDetailsState(
      isDark: isDark ?? this.isDark,
      quantity: quantity ?? this.quantity,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}