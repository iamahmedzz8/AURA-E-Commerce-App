import '../repositories/products_repository.dart';

class DeleteProductUseCase {
  final ProductsRepository repository;

  DeleteProductUseCase(this.repository);

  Future<void> call(String productId) async {
    return await repository.deleteProduct(productId);
  }
}