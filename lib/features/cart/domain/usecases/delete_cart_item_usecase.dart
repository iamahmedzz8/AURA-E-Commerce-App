import 'package:aura_maison_e_commerce/features/cart/domain/repositories/cart_repository.dart';

class DeleteCartItemUseCase {
  final CartRepository repository;

  DeleteCartItemUseCase(this.repository);

  Future<void> call({required String itemId}) async {
    return await repository.deleteCartItem(itemId: itemId);
  }
}
