import '../entities/products_entity.dart';

abstract class ProductsRepository {
  Future<void> addProduct(ProductEntity product);
  Future<void> deleteProduct(String productId);
}