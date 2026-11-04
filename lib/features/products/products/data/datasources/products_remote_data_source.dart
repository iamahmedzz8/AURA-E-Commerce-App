import 'dart:developer';

import 'package:dio/dio.dart';

class ProductsRemoteDataSource {
  final Dio dio = Dio();
  Future<List> getProducts() async {
    try {
      final response = await dio.get(
        'https://accessories-eshop.runasp.net/api/products',
      );
      if (response.statusCode == 200) {
        return response.data as List;
      } else {
        throw Exception('Failed to load products');
      }
    } on DioException catch (e) {
      throw Exception(
        'Failed to load products: ${e.response?.data.toString() ?? e.toString()}',
      );
    }
  }

  void postProduct({
    required String name,
    required String nameArabic,
    required String description,
    required String descriptionArabic,
    required String coverPictureUrl,
    required double price,
    required int stock,
    required double weight,
    required String color,
    required double discountPercentage,
    required List<String> categoryIds,
    required List<String> productPictureUrls,
  }) async {
    try {
      final response = await dio.post(
        'https://accessories-eshop.runasp.net/api/products',
        data: {
          "name": name,
          "description": description,
          "nameArabic": nameArabic,
          "descriptionArabic": descriptionArabic,
          "coverPictureUrl": coverPictureUrl,
          "price": price,
          "stock": stock,
          "weight": weight,
          "color": color,
          "discountPercentage": discountPercentage,
          "categoryIds": categoryIds,
          "productPictureUrls": productPictureUrls,
        },
      );
      if (response.statusCode == 201) {
        log('Product posted successfully');
      } else {
        throw Exception('Failed to post product');
      }
    } on DioException catch (e) {
      throw Exception(
        'Failed to post product: ${e.response?.data.toString() ?? e.toString()}',
      );
    }
  }
}
