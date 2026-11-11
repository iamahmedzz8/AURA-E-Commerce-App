import 'package:aura_maison_e_commerce/features/cart/domain/repositories/cart_repository.dart';

class DecrementCartItemUseCase {
  final CartRepository repository;

  DecrementCartItemUseCase(this.repository);

  Future<void> call({
    required String itemId,
    required int quantity,
  }) async {
    return await repository.decrementCartItem(
      itemId: itemId,
      quantity: quantity,
    );
  }
}
