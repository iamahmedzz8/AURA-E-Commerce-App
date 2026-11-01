import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(const ProductDetailsState());

  void toggleTheme() {
    emit(state.copyWith(isDark: !state.isDark));
  }

  void toggleFavorite() {
    emit(state.copyWith(isFavorite: !state.isFavorite));
  }

  void increaseQuantity() {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void decreaseQuantity() {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }
}