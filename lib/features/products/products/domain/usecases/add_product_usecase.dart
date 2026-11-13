import '../entities/products_entity.dart';
import '../repositories/products_repository.dart';

class AddProductUseCase {
  final ProductsRepository repository;

  AddProductUseCase(this.repository);

  Future<void> call(ProductEntity product) async {
    return await repository.addProduct(product);
  }
}
