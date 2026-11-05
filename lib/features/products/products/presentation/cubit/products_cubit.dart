import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/products_entity.dart';
import '../../domain/usecases/add_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final AddProductUseCase addProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  ProductsCubit({
    required this.addProductUseCase,
    required this.deleteProductUseCase,
  }) : super(ProductsInitial());

  // دالة إضافة منتج
  Future<void> addProduct(ProductEntity product) async {
    emit(AddProductLoading());
    try {
      await addProductUseCase(product);
      emit(AddProductSuccess());
    } catch (e) {
      emit(AddProductFailure(e.toString()));
    }
  }

  // دالة حذف منتج
  Future<void> deleteProduct(String productId) async {
    emit(DeleteProductLoading());
    try {
      await deleteProductUseCase(productId);
      emit(DeleteProductSuccess());
    } catch (e) {
      emit(DeleteProductFailure(e.toString()));
    }
  }
}