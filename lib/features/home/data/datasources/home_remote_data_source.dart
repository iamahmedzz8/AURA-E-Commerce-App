import 'dart:developer';

import 'package:aura_maison_e_commerce/core/di/injection_container.dart';
import 'package:aura_maison_e_commerce/core/error/error_handler.dart';
import 'package:aura_maison_e_commerce/core/network/api_endpoints.dart';
import 'package:aura_maison_e_commerce/core/network/dio_client.dart';
import 'package:aura_maison_e_commerce/features/home/data/models/offer_model.dart';
import 'package:dio/dio.dart';

class HomeRemoteDataSource {
  final DioClient _dioClient;

  HomeRemoteDataSource({DioClient? dioClient})
      : _dioClient = dioClient ?? sl<DioClient>();

  /// Fetch all promotional offers from the API
  Future<List<OfferModel>> getOffers() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.offers);
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

  Future<List> getCategories() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.categories);
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List) return data;
        if (data is Map && data.containsKey('categories')) {
          return data['categories'] as List;
        }
        return [];
      } else {
        throw Exception('Failed to load categories');
      }
    } on ErrorHandler catch (e) {
      throw Exception(e.failure.message);
    } catch (e) {
      throw Exception('Failed to load categories: $e');
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
