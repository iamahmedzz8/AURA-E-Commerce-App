import 'package:aura_maison_e_commerce/core/network/api_endpoints.dart';
import 'package:aura_maison_e_commerce/core/network/dio_client.dart';
import 'package:aura_maison_e_commerce/features/cart/data/models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<void> addToCart({required String productId, required int quantity});

  Future<CartModel> getCart();

  Future<void> decrementCartItem({
    required String itemId,
    required int quantity,
  });

  Future<void> deleteCartItem({required String itemId});
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final DioClient dioClient;

  CartRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<void> addToCart({
    required String productId,
    required int quantity,
  }) async {
    await dioClient.post(
      ApiEndpoints.cartItems,
      data: {'productId': productId, 'quantity': quantity},
    );
  }

  @override
  Future<CartModel> getCart() async {
    final response = await dioClient.get(ApiEndpoints.cart);

    return CartModel.fromJson(Map<String, dynamic>.from(response.data as Map));
  }

  @override
  Future<void> decrementCartItem({
    required String itemId,
    required int quantity,
  }) async {
    await dioClient.post(
      ApiEndpoints.cartDecrement,
      data: {'itemId': itemId, 'quantity': quantity},
    );
  }

  @override
  Future<void> deleteCartItem({required String itemId}) async {
    await dioClient.delete(
      ApiEndpoints.cartItemById(itemId),
      data: {'id': itemId},
    );
  }
}
