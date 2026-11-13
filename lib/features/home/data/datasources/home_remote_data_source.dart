import 'dart:developer';

import 'package:aura_maison_e_commerce/core/di/injection_container.dart';
import 'package:aura_maison_e_commerce/core/error/error_handler.dart';
import 'package:aura_maison_e_commerce/core/network/api_endpoints.dart';
import 'package:aura_maison_e_commerce/core/network/dio_client.dart';
import 'package:aura_maison_e_commerce/features/home/data/models/category_model.dart';
import 'package:aura_maison_e_commerce/features/home/data/models/offer_model.dart';
import 'package:aura_maison_e_commerce/features/home/data/models/product_model.dart';
import 'package:dio/dio.dart';

class HomeRemoteDataSource {
  final DioClient _dioClient;

  HomeRemoteDataSource({DioClient? dioClient})
    : _dioClient = dioClient ?? sl<DioClient>();

  /// Fetch all promotional offers from the API
  Future<List<OfferModel>> getOffers() async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.offers,
        queryParameters: {'page': 1, 'pageSize': 10},
      );
      final data = response.data;

      if (data is Map<String, dynamic>) {
        if (data.containsKey('offers') && data['offers'] is Map) {
          final items = data['offers']['items'] as List?;
          if (items != null) {
            return items
                .map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
                .toList();
          }
        } else if (data.containsKey('items') && data['items'] is List) {
          return (data['items'] as List)
              .map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      } else if (data is List) {
        return data
            .map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      return [];
    } on ErrorHandler catch (e) {
      throw Exception(e.failure.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void postOffer(String name, String description, String offerCoverUrl) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.offers,
        data: {
          'name': name,
          'description': description,
          'offerCoverUrl': offerCoverUrl,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Offer posted successfully');
      } else {
        throw Exception('Failed to post offer');
      }
    } on DioException catch (e) {
      throw Exception(
        'Failed to post offer: ${e.response?.data.toString() ?? e.toString()}',
      );
    } catch (e) {
      throw Exception('Failed to post offer: $e');
    }
  }

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
    int pageSize = 10,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.products,
        queryParameters: {'page': page, 'pageSize': pageSize},
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

  /// Fetch products filtered by [categoryName].
  ///
  /// Calls [ApiEndpoints.productsByCategoryName] which maps to
  /// `GET /api/products?category=<categoryName>`.
  Future<List<ProductModel>> getProductsByCategory({
    required String categoryName,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.productsByCategoryName(categoryName),
        queryParameters: {
          'category': categoryName,
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
      throw Exception(
        'Failed to load products for category "$categoryName": $e',
      );
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
