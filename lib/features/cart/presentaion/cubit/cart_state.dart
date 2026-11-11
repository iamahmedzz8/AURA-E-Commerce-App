import 'package:aura_maison_e_commerce/features/cart/data/models/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final CartModel cart;
  final String? updatingItemId;

  CartSuccess(this.cart, {this.updatingItemId});
}

class CartActionError extends CartSuccess {
  final String errorMessage;

  CartActionError(super.cart, {required this.errorMessage});
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
