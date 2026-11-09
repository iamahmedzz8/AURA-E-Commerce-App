import 'package:aura_maison_e_commerce/features/home/data/models/category_model.dart';
import 'package:aura_maison_e_commerce/features/home/data/models/product_model.dart';

abstract class CategoriesProductsState {}

class CategoriesProductsInitialState extends CategoriesProductsState {}

class CategoriesProductsLoadingState extends CategoriesProductsState {}

class CategoriesProductsSuccessState extends CategoriesProductsState {
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  final String? selectedCategoryId;

  CategoriesProductsSuccessState({
    required this.products,
    this.categories = const [],
    this.selectedCategoryId,
  });
}

class CategoriesProductsFailureState extends CategoriesProductsState {
  final String errorMessage;
  CategoriesProductsFailureState({required this.errorMessage});
}
