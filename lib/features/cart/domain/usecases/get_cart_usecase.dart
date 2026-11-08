
import 'package:aura_maison_e_commerce/features/cart/data/models/cart_model.dart';
import 'package:aura_maison_e_commerce/features/cart/domain/repositories/cart_repository.dart';

class GetCartUseCase {
  final CartRepository repository;

  GetCartUseCase(this.repository);

  Future<CartModel> call() async {
    return await repository.getCart();
  }
}
