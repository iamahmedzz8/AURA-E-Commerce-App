import 'package:aura_maison_e_commerce/features/home/data/datasources/home_remote_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_products_state.dart';

export 'category_products_state.dart';

/// Cubit responsible for fetching products that belong to a specific category.
///
/// Usage:
/// ```dart
/// context.read<CategoryProductsCubit>().fetchByCategory(categoryName: 'Watches');
/// ```
class CategoryProductsCubit extends Cubit<CategoryProductsState> {
  final HomeRemoteDataSource _remoteDataSource;

  CategoryProductsCubit({HomeRemoteDataSource? remoteDataSource})
    : _remoteDataSource = remoteDataSource ?? HomeRemoteDataSource(),
      super(CategoryProductsInitial());

  /// Fetches products from the API filtered by [categoryName].
  ///
  /// Internally calls [HomeRemoteDataSource.getProductsByCategory] which uses
  /// `GET /api/products?category=<categoryName>` as declared in
  /// [ApiEndpoints.productsByCategoryName].
  Future<void> fetchByCategory({
    required String categoryName,
    int page = 1,
    int pageSize = 20,
  }) async {
    emit(CategoryProductsLoading());
    try {
      final products = await _remoteDataSource.getProductsByCategory(
        categoryName: categoryName,
        page: page,
        pageSize: pageSize,
      );

      if (products.isEmpty) {
        emit(CategoryProductsEmpty(categoryName: categoryName));
      } else {
        emit(
          CategoryProductsSuccess(
            products: products,
            categoryName: categoryName,
          ),
        );
      }
    } catch (e) {
      emit(
        CategoryProductsFailure(
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}
