import 'dart:developer';

import 'package:aura_maison_e_commerce/core/network_by_khaled/api_error.dart';
import 'package:aura_maison_e_commerce/features/products/reviews/data/repositories/reviews_repository_impl.dart';
import 'package:aura_maison_e_commerce/features/products/reviews/presentation/cubit/reviews_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsCubit extends Cubit<ReviewStates> {
  ReviewsCubit({ReviewsRepo? repo})
    : _repo = repo ?? ReviewsRepo(),
      super(ReviewInitialState());

  final ReviewsRepo _repo;

  Future<void> getReviews(String productId) async {
    emit(GetReviewLoadingState());
    try {
      final response = await _repo.getReviews(productId);
      if (isClosed) return;
      emit(
        GetReviewSuccessState(
          reviews: response.reviews,
          averageRating: response.averageRating,
          reviewsCount: response.reviewsCount,
          responseModel: response,
        ),
      );
    } on ApiError catch (e) {
      log('getReviews ApiError: ${e.message}');
      if (isClosed) return;
      emit(GetReviewErrorState(e.message));
    } catch (e) {
      log('getReviews error: $e');
      if (isClosed) return;
      emit(GetReviewErrorState(e.toString()));
    }
  }

  Future<void> addReview(String productId, String comment, int rating) async {
    emit(AddReviewLoadingState());
    try {
      await _repo.addReview(
        productId: productId,
        comment: comment,
        rating: rating,
      );
      if (isClosed) return;
      emit(AddReviewSuccessState());
      await getReviews(productId);
    } on ApiError catch (e) {
      log('addReview ApiError: ${e.message}');
      if (isClosed) return;
      emit(AddReviewErrorState(e.message));
    } catch (e) {
      log('addReview error: $e');
      if (isClosed) return;
      emit(AddReviewErrorState(e.toString()));
    }
  }
}
