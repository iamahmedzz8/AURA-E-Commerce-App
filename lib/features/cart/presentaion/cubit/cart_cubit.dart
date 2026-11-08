
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aura_maison_e_commerce/core/error/error_handler.dart';

import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/get_cart_usecase.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final AddToCartUseCase addToCartUseCase;
  final GetCartUseCase getCartUseCase;

  CartCubit({
    required this.addToCartUseCase,
    required this.getCartUseCase,
  }) : super(CartInitial());

  Future<void> getCart() async {
    emit(CartLoading());

    try {
      final cart = await getCartUseCase.call();
      emit(CartSuccess(cart));
    } catch (e) {
      emit(CartError(_getErrorMessage(e)));
    }
  }

  Future<void> addToCart({
    required String productId,
    required int quantity,
  }) async {
    emit(CartLoading());

    try {
      await addToCartUseCase.call(
        productId: productId,
        quantity: quantity,
      );

      final cart = await getCartUseCase.call();

      emit(CartSuccess(cart));
    } catch (e) {
      emit(CartError(_getErrorMessage(e)));
    }
  }

  String _getErrorMessage(dynamic error) {
    if (error is ErrorHandler) {
      return error.failure.message;
    }

    return error.toString();
  }
}
