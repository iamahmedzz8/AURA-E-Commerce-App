import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aura_maison_e_commerce/core/error/error_handler.dart';

import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/decrement_cart_item_usecase.dart';
import '../../domain/usecases/delete_cart_item_usecase.dart';
import '../../domain/usecases/get_cart_usecase.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final AddToCartUseCase addToCartUseCase;
  final GetCartUseCase getCartUseCase;
  final DecrementCartItemUseCase decrementCartItemUseCase;
  final DeleteCartItemUseCase deleteCartItemUseCase;

  CartCubit({
    required this.addToCartUseCase,
    required this.getCartUseCase,
    required this.decrementCartItemUseCase,
    required this.deleteCartItemUseCase,
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
    String? itemId,
  }) async {
    final currentCart = state is CartSuccess
        ? (state as CartSuccess).cart
        : null;
    if (currentCart != null && itemId != null) {
      emit(CartSuccess(currentCart, updatingItemId: itemId));
    } else {
      emit(CartLoading());
    }

    try {
      await addToCartUseCase.call(productId: productId, quantity: quantity);

      final cart = await getCartUseCase.call();
      emit(CartSuccess(cart));
    } catch (e) {
      if (currentCart != null) {
        emit(CartActionError(currentCart, errorMessage: _getErrorMessage(e)));
      } else {
        emit(CartError(_getErrorMessage(e)));
      }
    }
  }

  Future<void> decrementCartItem({
    required String itemId,
    int quantity = 1,
  }) async {
    final currentCart = state is CartSuccess
        ? (state as CartSuccess).cart
        : null;
    if (currentCart != null) {
      emit(CartSuccess(currentCart, updatingItemId: itemId));
    } else {
      emit(CartLoading());
    }

    try {
      await decrementCartItemUseCase.call(itemId: itemId, quantity: quantity);

      final cart = await getCartUseCase.call();
      emit(CartSuccess(cart));
    } catch (e) {
      if (currentCart != null) {
        emit(CartActionError(currentCart, errorMessage: _getErrorMessage(e)));
      } else {
        emit(CartError(_getErrorMessage(e)));
      }
    }
  }

  Future<void> deleteCartItem({required String itemId}) async {
    final currentCart = state is CartSuccess
        ? (state as CartSuccess).cart
        : null;
    if (currentCart != null) {
      emit(CartSuccess(currentCart, updatingItemId: itemId));
    } else {
      emit(CartLoading());
    }

    try {
      await deleteCartItemUseCase.call(itemId: itemId);

      final cart = await getCartUseCase.call();
      emit(CartSuccess(cart));
    } catch (e) {
      if (currentCart != null) {
        emit(CartActionError(currentCart, errorMessage: _getErrorMessage(e)));
      } else {
        emit(CartError(_getErrorMessage(e)));
      }
    }
  }

  String _getErrorMessage(dynamic error) {
    if (error is ErrorHandler) {
      return error.failure.message;
    }

    return error.toString();
  }
}
