import '../../domain/entities/products_entity.dart';
import '../../domain/repositories/products_repository.dart';
import '../datasources/products_remote_data_source.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;

  ProductsRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addProduct(ProductEntity product) async {
    await remoteDataSource.postProduct(
      sellerId: "2256a60d-feb2-4150-14f6-08df3b2ab746",
      name: product.name,
      nameArabic: product.nameArabic,
      description: product.description,
      descriptionArabic: product.descriptionArabic,
      coverPictureUrl: product.coverPictureUrl,
      price: product.price,
      stock: product.stock,
      weight: product.weight,
      color: product.color,
      discountPercentage: product.discountPercentage,
      categoryIds: product.categoryIds,
      productPictureUrls: product.productPictureUrls,
    );
  }

  @override
  Future<void> deleteProduct(String productId) async {
    await remoteDataSource.deleteProduct(productId: productId);
  }
}
