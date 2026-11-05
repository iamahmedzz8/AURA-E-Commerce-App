import 'package:aura_maison_e_commerce/features/products/products/data/datasources/products_remote_data_source.dart';
import 'package:aura_maison_e_commerce/features/products/products/presentation/cubit/products_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsLoadingState());

  Future<void> fetchProducts() async {
    ProductsRemoteDataSource productsRemoteDataSource = ProductsRemoteDataSource();
    try {
      // Simulate fetching products from an API or database
      await productsRemoteDataSource.getProducts().then((val) {
        emit(ProductsSuccessState(products: val));
      });
    } on DioException catch (e) {
      emit(ProductsFailureState(errorMessage: e.response?.data.toString() ?? e.toString()));
    }
  }
}
