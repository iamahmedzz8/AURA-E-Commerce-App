abstract class ProductsState {}
class ProductsLoadingState extends ProductsState {}
class ProductsSuccessState extends ProductsState {
  final List products;
  ProductsSuccessState({required this.products});
}
class ProductsFailureState extends ProductsState {
  final String errorMessage;
  ProductsFailureState({required this.errorMessage});
}