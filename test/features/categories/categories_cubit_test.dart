import 'package:aura_maison_e_commerce/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/cubit/categories_state.dart';
import 'package:aura_maison_e_commerce/features/home/data/models/category_model.dart';
import 'package:aura_maison_e_commerce/features/home/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CategoriesScreenCubit & CategoriesProductsState tests', () {
    const catWatches = CategoryModel(
      id: 'cat-1',
      name: 'Watches',
      coverPictureUrl: 'https://example.com/watch.png',
    );
    const catJewelry = CategoryModel(
      id: 'cat-2',
      name: 'Jewelry',
      coverPictureUrl: 'https://example.com/jewelry.png',
    );

    const product1 = ProductModel(
      id: 'p-1',
      productCode: 'W001',
      name: 'Tourbillon Watch',
      coverPictureUrl: 'https://example.com/p1.png',
      price: 150000,
      categories: ['cat-1', 'Watches'],
    );

    const product2 = ProductModel(
      id: 'p-2',
      productCode: 'J002',
      name: 'Diamond Necklace',
      coverPictureUrl: 'https://example.com/p2.png',
      price: 90000,
      categories: ['cat-2'],
    );

    test('Initial state is CategoriesProductsInitialState', () {
      final cubit = CategoriesScreenCubit();
      expect(cubit.state, isA<CategoriesProductsInitialState>());
    });

    test('getProductsByCategoryId filters products correctly by category id', () {
      final cubit = CategoriesScreenCubit(
        initialCategories: [catWatches, catJewelry],
        initialProducts: [product1, product2],
      );

      cubit.getProductsByCategoryId('cat-1');
      expect(cubit.state, isA<CategoriesProductsSuccessState>());
      final success = cubit.state as CategoriesProductsSuccessState;
      expect(success.products.length, 1);
      expect(success.products.first.id, 'p-1');
      expect(success.selectedCategoryId, 'cat-1');
    });

    test('getProductsByCategoryId toggles off when tapping already selected category', () {
      final cubit = CategoriesScreenCubit(
        initialCategories: [catWatches, catJewelry],
        initialProducts: [product1, product2],
      );

      cubit.getProductsByCategoryId('cat-1');
      expect((cubit.state as CategoriesProductsSuccessState).selectedCategoryId, 'cat-1');

      cubit.getProductsByCategoryId('cat-1');
      expect((cubit.state as CategoriesProductsSuccessState).selectedCategoryId, isNull);
      expect((cubit.state as CategoriesProductsSuccessState).products.length, 2);
    });

    test('clearCategorySelection resets selected category and displays all products', () {
      final cubit = CategoriesScreenCubit(
        initialCategories: [catWatches, catJewelry],
        initialProducts: [product1, product2],
      );

      cubit.getProductsByCategoryId('cat-2');
      expect((cubit.state as CategoriesProductsSuccessState).selectedCategoryId, 'cat-2');

      cubit.clearCategorySelection();
      expect((cubit.state as CategoriesProductsSuccessState).selectedCategoryId, isNull);
      expect((cubit.state as CategoriesProductsSuccessState).products.length, 2);
    });
  });
}
