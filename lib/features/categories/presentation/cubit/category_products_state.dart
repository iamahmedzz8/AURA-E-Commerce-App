import 'package:aura_maison_e_commerce/features/home/data/models/product_model.dart';

/// States for [CategoryProductsCubit]
abstract class CategoryProductsState {}

class CategoryProductsInitial extends CategoryProductsState {}

class CategoryProductsLoading extends CategoryProductsState {}

class CategoryProductsSuccess extends CategoryProductsState {
  final List<ProductModel> products;
  final String categoryName;

  CategoryProductsSuccess({
    required this.products,
    required this.categoryName,
  });
}

class CategoryProductsEmpty extends CategoryProductsState {
  final String categoryName;
  CategoryProductsEmpty({required this.categoryName});
}

class CategoryProductsFailure extends CategoryProductsState {
  final String errorMessage;
  CategoryProductsFailure({required this.errorMessage});
}
