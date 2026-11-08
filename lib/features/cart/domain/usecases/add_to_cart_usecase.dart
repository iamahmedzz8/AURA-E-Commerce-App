
import 'package:aura_maison_e_commerce/features/cart/domain/repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  Future<void> call({
    required String productId,
    required int quantity,
  }) async {
    return await repository.addToCart(
      productId: productId,
      quantity: quantity,
    );
  }
}
