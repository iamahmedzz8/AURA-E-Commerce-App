import 'package:aura_maison_e_commerce/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:aura_maison_e_commerce/features/cart/data/models/cart_model.dart';
import 'package:aura_maison_e_commerce/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addToCart({
    required String productId,
    required int quantity,
  }) async {
    await remoteDataSource.addToCart(productId: productId, quantity: quantity);
  }

  @override
  Future<CartModel> getCart() async {
    return await remoteDataSource.getCart();
  }

  @override
  Future<void> decrementCartItem({
    required String itemId,
    required int quantity,
  }) async {
    await remoteDataSource.decrementCartItem(
      itemId: itemId,
      quantity: quantity,
    );
  }

  @override
  Future<void> deleteCartItem({required String itemId}) async {
    await remoteDataSource.deleteCartItem(itemId: itemId);
  }
}
