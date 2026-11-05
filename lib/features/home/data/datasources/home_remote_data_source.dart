import 'dart:developer';

import 'package:dio/dio.dart';

class HomeRemoteDataSource {
  final Dio dio = Dio();
  Future<List> getOffers () async {
    try {
      final response = await dio.get('https://accessories-eshop.runasp.net/api/offers');
      if (response.statusCode == 200) {
        return response.data as List;
      } else {
        throw Exception('Failed to load offers');
      }
    }  on DioException catch (e) {
      throw Exception('Failed to load offers: ${e.response?.data.toString() ?? e.toString()}');
    }
  }
  void postOffer(String name,String description,String offerCoverUrl) async {
    
    try {
      final response = await dio.post('https://accessories-eshop.runasp.net/api/offers', data: {
        'name': name,
        'description': description,
        'offerCoverUrl': offerCoverUrl,
      });
      if (response.statusCode == 201) {
        log('Offer posted successfully');
      } else {
        throw Exception('Failed to post offer');
      }
    } on DioException catch (e) {
      throw Exception('Failed to : ${e.response?.data.toString() ?? e.toString()}');
    }
  }
Future<List> getCategories () async {
    try {
      final response = await dio.get('https://accessories-eshop.runasp.net/api/categories');
      if (response.statusCode == 200) {
        return response.data as List;
      } else {
        throw Exception('Failed to load categories');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load categories: ${e.response?.data.toString() ?? e.toString()}');
    }
  }
  void postCategory(String name,String description,String categoryCoverUrl) async {
    
    try {
      final response = await dio.post('https://accessories-eshop.runasp.net/api/categories', data: {
        'name': name,
        'description': description,
        'categoryCoverUrl': categoryCoverUrl,
      });
      if (response.statusCode == 201) {
        log('Category posted successfully');
      } else {
        throw Exception('Failed to post category');
      }
    } on DioException catch (e) {
      throw Exception('Failed to post category: ${e.response?.data.toString() ?? e.toString()}');
    }
  }
}
