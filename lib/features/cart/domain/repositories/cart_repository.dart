import 'package:aura_maison_e_commerce/features/cart/data/models/cart_model.dart';

abstract class CartRepository {
  Future<void> addToCart({required String productId, required int quantity});

  Future<CartModel> getCart();

  Future<void> decrementCartItem({
    required String itemId,
    required int quantity,
  });

  Future<void> deleteCartItem({required String itemId});
}
