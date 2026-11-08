
import 'cart_item_model.dart';

class CartModel {
  final String cartId;
  final List<CartItemModel> cartItems;

  const CartModel({
    required this.cartId,
    required this.cartItems,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartId: json['cartId']?.toString() ?? '',
      cartItems: (json['cartItems'] as List<dynamic>? ?? [])
          .map(
            (item) => CartItemModel.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList(),
    );
  }
}
