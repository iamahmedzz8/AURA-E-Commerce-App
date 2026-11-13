import 'dart:developer';

import 'package:aura_maison_e_commerce/core/network_by_khaled/api_error.dart';
import 'package:aura_maison_e_commerce/core/network_by_khaled/api_service.dart';
import 'package:aura_maison_e_commerce/core/network_by_khaled/endpoints.dart';
import 'package:aura_maison_e_commerce/features/products/reviews/data/models/reviews_model.dart';

class ReviewsRepo {
  final ApiService apiService = ApiService();

  Future<ReviewsResponseModel> getReviews(
    String productId, {
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final dynamic response = await apiService.getData(
        '${Endpoints.reviews}/$productId',
        queryParameters: {'page': page, 'pageSize': pageSize},
      );
      log('getReviews response: $response');

      if (response is Map<String, dynamic>) {
        return ReviewsResponseModel.fromJson(response);
      } else if (response is List) {
        final parsedReviews = response
            .whereType<Map<String, dynamic>>()
            .map((e) => ReviewModel.fromJson(e))
            .toList();
        return ReviewsResponseModel(
          reviews: parsedReviews,
          reviewsCount: parsedReviews.length,
        );
      }

      return ReviewsResponseModel(
        averageRating: 0.0,
        reviewsCount: 0,
        reviews: [],
      );
    } on ApiError catch (e) {
      log('ApiError in getReviews: ${e.message}');
      rethrow;
    } catch (e) {
      log('Unexpected error in getReviews: $e');
      throw ApiError(message: e.toString());
    }
  }

  Future<void> addReview({
    required String productId,
    required String comment,
    required int rating,
  }) async {
    try {
      final dynamic response = await apiService.postData(
        '${Endpoints.reviews}/$productId',
        {'productId': productId, 'comment': comment, 'rating': rating},
      );
      log('addReview response: $response');
    } on ApiError catch (e) {
      log('ApiError in addReview: ${e.message}');
      rethrow;
    } catch (e) {
      log('Unexpected error in addReview: $e');
      throw ApiError(message: e.toString());
    }
  }
}
