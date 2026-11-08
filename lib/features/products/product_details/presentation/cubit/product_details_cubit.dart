// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'product_details_state.dart';

// class ProductDetailsCubit extends Cubit<ProductDetailsState> {
//   ProductDetailsCubit() : super(const ProductDetailsState());

//   void toggleTheme() {
//     emit(state.copyWith(isDark: !state.isDark));
//   }

//   void toggleFavorite() {
//     emit(state.copyWith(isFavorite: !state.isFavorite));
//   }

//   void increaseQuantity() {
//     emit(state.copyWith(quantity: state.quantity + 1));
//   }

//   void decreaseQuantity() {
//     if (state.quantity > 1) {
//       emit(state.copyWith(quantity: state.quantity - 1));
//     }
//   }
// }

import 'dart:developer';

import 'package:aura_maison_e_commerce/core/network_by_khaled/api_error.dart';
import 'package:aura_maison_e_commerce/features/products/product_details/data/repositories/product_details_repo.dart';
import 'package:aura_maison_e_commerce/features/products/product_details/presentation/cubit/product_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsStates> {
  ProductDetailsCubit() : super(ProductDetailsInitialState());

  final ProductsDetailsRepo productsRepo = ProductsDetailsRepo();

  Future<void> getProductsDetails(String productId) async {
    emit(ProductDetailsLoadingState());
    try {
      final product = await productsRepo.getProductDetails(productId);
      log('Api Run Successfully: ${product.name}');

      if (isClosed) return;
      emit(ProductDetailsSuccessState(product));
    } on ApiError catch (e) {
      log('ProductDetails ApiError: ${e.message}');
      if (isClosed) return;
      emit(ProductDetailsErrorState(message: e.message));
    } catch (e) {
      log('ProductDetails Unexpected Error: $e');
      if (isClosed) return;
      emit(ProductDetailsErrorState(message: e.toString()));
    }
  }
}
