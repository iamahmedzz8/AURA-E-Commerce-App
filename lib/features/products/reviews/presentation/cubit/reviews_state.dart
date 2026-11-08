import 'package:aura_maison_e_commerce/features/products/reviews/data/models/reviews_model.dart';

abstract class ReviewStates {}

class ReviewInitialState extends ReviewStates {}

class GetReviewLoadingState extends ReviewStates {}

class GetReviewSuccessState extends ReviewStates {
  final List<ReviewModel> reviews;
  final double averageRating;
  final int reviewsCount;
  final ReviewsResponseModel? responseModel;

  GetReviewSuccessState({
    required this.reviews,
    this.averageRating = 0.0,
    this.reviewsCount = 0,
    this.responseModel,
  });

  int getCountForStar(int star) {
    if (responseModel != null) {
      return responseModel!.getCountForStar(star);
    }
    return reviews.where((r) => r.rating == star).length;
  }

  double getPercentageForStar(int star) {
    if (responseModel != null) {
      return responseModel!.getPercentageForStar(star);
    }
    if (reviews.isEmpty) return 0.0;
    return (getCountForStar(star) / reviews.length).clamp(0.0, 1.0);
  }

  String get formattedAverageRating =>
      averageRating > 0 ? averageRating.toStringAsFixed(1) : '0.0';
}

class GetReviewErrorState extends ReviewStates {
  final String error;

  GetReviewErrorState(this.error);
}

class AddReviewLoadingState extends ReviewStates {}

class AddReviewSuccessState extends ReviewStates {}

class AddReviewErrorState extends ReviewStates {
  final String error;

  AddReviewErrorState(this.error);
}
