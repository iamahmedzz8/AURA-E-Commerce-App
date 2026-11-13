part of 'products_cubit.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class AddProductLoading extends ProductsState {}

class AddProductSuccess extends ProductsState {}

class AddProductFailure extends ProductsState {
  final String error;
  AddProductFailure(this.error);
}

class DeleteProductLoading extends ProductsState {}

class DeleteProductSuccess extends ProductsState {}

class DeleteProductFailure extends ProductsState {
  final String error;
  DeleteProductFailure(this.error);
}
