import 'package:aura_maison_e_commerce/features/categories/data/datasources/categories_remote_data_source.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/cubit/categories_state.dart';
import 'package:aura_maison_e_commerce/features/home/data/models/category_model.dart';
import 'package:aura_maison_e_commerce/features/home/data/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'categories_state.dart';

class CategoriesScreenCubit extends Cubit<CategoriesProductsState> {
  final CategoriesRemoteDataSource? _remoteDataSource;

  List<CategoryModel> _categories = [];
  List<ProductModel> _allProducts = [];
  String? _selectedCategoryId;

  CategoriesScreenCubit({
    CategoriesRemoteDataSource? categoriesRemoteDataSource,
    List<CategoryModel>? initialCategories,
    List<ProductModel>? initialProducts,
  })  : _remoteDataSource = categoriesRemoteDataSource,
        _categories = initialCategories ?? [],
        _allProducts = initialProducts ?? [],
        super(CategoriesProductsInitialState());

  CategoriesRemoteDataSource get _dataSource =>
      _remoteDataSource ?? CategoriesRemoteDataSource();

  List<CategoryModel> get categories => _categories;
  List<ProductModel> get allProducts => _allProducts;
  String? get selectedCategoryId => _selectedCategoryId;

  /// Loads categories and products from the API via remote data source
  Future<void> loadCategoriesAndProducts({String? initialCategoryName}) async {
    emit(CategoriesProductsLoadingState());
    try {
      final results = await Future.wait([
        _dataSource.getCategories(),
        _dataSource.getProducts(page: 1, pageSize: 50),
      ]);

      _categories = (results[0] as List).cast<CategoryModel>();
      _allProducts = (results[1] as List).cast<ProductModel>();

      _selectedCategoryId = null;
      if (initialCategoryName != null && initialCategoryName.isNotEmpty) {
        final match = _categories.where(
          (c) => c.name.toLowerCase() == initialCategoryName.toLowerCase(),
        );
        if (match.isNotEmpty) {
          _selectedCategoryId = match.first.id;
        }
      }

      _emitFilteredProducts();
    } catch (e) {
      emit(CategoriesProductsFailureState(
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  /// Calls products by category ID to display them
  void getProductsByCategoryId(String? categoryId) {
    if (_selectedCategoryId == categoryId) {
      // Toggle off / display all products if clicked again
      _selectedCategoryId = null;
    } else {
      _selectedCategoryId = categoryId;
    }

    _emitFilteredProducts();
  }

  /// Clear selection and display all products
  void clearCategorySelection() {
    _selectedCategoryId = null;
    _emitFilteredProducts();
  }

  void _emitFilteredProducts() {
    if (_selectedCategoryId == null || _selectedCategoryId!.isEmpty) {
      emit(CategoriesProductsSuccessState(
        products: _allProducts,
        categories: _categories,
        selectedCategoryId: null,
      ));
      return;
    }

    final selId = _selectedCategoryId!.trim().toLowerCase();
    CategoryModel? matchedCategory;
    for (final c in _categories) {
      if (c.id.toLowerCase() == selId) {
        matchedCategory = c;
        break;
      }
    }
    final selName = matchedCategory?.name.trim().toLowerCase();

    // Filter products belonging to this category ID
    final filtered = _allProducts.where((product) {
      return product.categories.any((c) {
        final cLower = c.trim().toLowerCase();
        return cLower == selId ||
            (selName != null &&
                (cLower == selName || cLower.contains(selName)));
      });
    }).toList();

    emit(CategoriesProductsSuccessState(
      products: filtered,
      categories: _categories,
      selectedCategoryId: _selectedCategoryId,
    ));
  }
}
