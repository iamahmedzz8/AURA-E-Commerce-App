import 'dart:developer';

import 'package:aura_maison_e_commerce/core/di/injection_container.dart';
import 'package:aura_maison_e_commerce/core/error/error_handler.dart';
import 'package:aura_maison_e_commerce/core/network/api_endpoints.dart';
import 'package:aura_maison_e_commerce/core/network/dio_client.dart';
import 'package:aura_maison_e_commerce/features/home/data/models/category_model.dart';
import 'package:aura_maison_e_commerce/features/home/data/models/product_model.dart';
import 'package:dio/dio.dart';

class CategoriesRemoteDataSource {
  final DioClient _dioClient;

  CategoriesRemoteDataSource({DioClient? dioClient})
      : _dioClient = dioClient ?? sl<DioClient>();

  /// Fetch all product categories from the API
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.categories);
      final data = response.data;

      if (data is Map<String, dynamic>) {
        if (data.containsKey('categories') && data['categories'] is List) {
          return (data['categories'] as List)
              .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      } else if (data is List) {
        return data
            .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      return [];
    } on ErrorHandler catch (e) {
      throw Exception(e.failure.message);
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  /// Fetch all products from the API
  Future<List<ProductModel>> getProducts({
    int page = 1,
    int pageSize = 50,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.products,
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
        },
      );
      final data = response.data;

      if (data is Map<String, dynamic>) {
        if (data.containsKey('items') && data['items'] is List) {
          return (data['items'] as List)
              .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else if (data.containsKey('products') && data['products'] is List) {
          return (data['products'] as List)
              .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      } else if (data is List) {
        return data
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      return [];
    } on ErrorHandler catch (e) {
      throw Exception(e.failure.message);
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  void postCategory(
    String name,
    String description,
    String categoryCoverUrl,
  ) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.categories,
        data: {
          'name': name,
          'description': description,
          'categoryCoverUrl': categoryCoverUrl,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Category posted successfully');
      } else {
        throw Exception('Failed to post category');
      }
    } on DioException catch (e) {
      throw Exception(
        'Failed to post category: ${e.response?.data.toString() ?? e.toString()}',
      );
    } catch (e) {
      throw Exception('Failed to post category: $e');
    }
  }
}
