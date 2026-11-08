import 'dart:developer';

import 'package:aura_maison_e_commerce/core/network_by_khaled/api_error.dart';
import 'package:aura_maison_e_commerce/core/network_by_khaled/api_service.dart';
import 'package:aura_maison_e_commerce/core/network_by_khaled/endpoints.dart';
import 'package:aura_maison_e_commerce/features/products/product_details/data/models/product_details_model.dart';

class ProductsDetailsRepo {
  final ApiService apiService = ApiService();

  Future<ProductDetailsModel> getProductDetails(String id) async {
    try {
      final response = await apiService.getData(
        '${Endpoints.productDetails}/$id',
      );

      log('ProductDetails API response: $response');

      return ProductDetailsModel.fromJson(response);
    } on ApiError catch (e) {
      log('ApiError in ProductsDetailsRepo: ${e.message}');
      rethrow;
    } catch (e) {
      log('Unexpected error in ProductsDetailsRepo: $e');
      throw ApiError(message: e.toString());
    }
  }
}
