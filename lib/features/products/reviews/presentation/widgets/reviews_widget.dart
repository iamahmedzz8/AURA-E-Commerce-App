import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/features/products/reviews/data/models/reviews_model.dart';
import 'package:aura_maison_e_commerce/features/products/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:aura_maison_e_commerce/features/products/reviews/presentation/cubit/reviews_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsSummaryCard extends StatelessWidget {
  final String productId;
  final String productName;
  final VoidCallback? onViewAll;
  final VoidCallback? onWriteReview;

  const ReviewsSummaryCard({
    super.key,
    required this.productId,
    required this.productName,
    this.onViewAll,
    this.onWriteReview,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final foreground = isDark ? Colors.white : const Color(0xFF171717);
    final muted = isDark ? const Color(0xFF8A8F98) : const Color(0xFF777777);
    final orange = const Color(0xFFFF5A1F);
    final surface = isDark ? const Color(0xFF191C21) : Colors.white;

    return BlocBuilder<ReviewsCubit, ReviewStates>(
      builder: (context, state) {
        final successState = state is GetReviewSuccessState ? state : null;
        final reviews = successState?.reviews ?? const <ReviewModel>[];
        final averageRating = successState?.averageRating ?? 0.0;
        final reviewsCount = successState?.reviewsCount ?? 0;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.clientReviews,
                      style: TextStyle(
                        color: foreground,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onViewAll,
                    child: Row(
                      children: [
                        Text(
                          'VIEW ALL',
                          style: TextStyle(
                            color: orange,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: orange,
                          size: 11,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        averageRating > 0 ? averageRating.toStringAsFixed(1) : '0.0',
                        style: TextStyle(
                          color: foreground,
                          fontSize: 34,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      buildRatingStars(averageRating > 0 ? averageRating : 0, size: 13),
                      const SizedBox(height: 5),
                      Text(
                        reviewsCount == 1 ? '1 REVIEW' : '$reviewsCount REVIEWS',
                        style: TextStyle(
                          color: muted,
                          fontSize: 8,
                          letterSpacing: 0.7,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 22),
                  Expanded(
                    child: Column(
                      children: [
                        _ratingBar(
                          context,
                          stars: 5,
                          percentage: successState?.getPercentageForStar(5) ?? 0.0,
                          count: successState?.getCountForStar(5) ?? 0,
                        ),
                        _ratingBar(
                          context,
                          stars: 4,
                          percentage: successState?.getPercentageForStar(4) ?? 0.0,
                          count: successState?.getCountForStar(4) ?? 0,
                        ),
                        _ratingBar(
                          context,
                          stars: 3,
                          percentage: successState?.getPercentageForStar(3) ?? 0.0,
                          count: successState?.getCountForStar(3) ?? 0,
                        ),
                        _ratingBar(
                          context,
                          stars: 2,
                          percentage: successState?.getPercentageForStar(2) ?? 0.0,
                          count: successState?.getCountForStar(2) ?? 0,
                        ),
                        _ratingBar(
                          context,
                          stars: 1,
                          percentage: successState?.getPercentageForStar(1) ?? 0.0,
                          count: successState?.getCountForStar(1) ?? 0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Divider(color: isDark ? Colors.white12 : Colors.black12, height: 1),
              const SizedBox(height: 14),
              if (state is GetReviewLoadingState)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: CircularProgressIndicator(color: orange),
                  ),
                )
              else if (state is GetReviewErrorState)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    state.error,
                    style: TextStyle(color: Colors.red.shade400, fontSize: 11),
                  ),
                )
              else if (reviews.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'No reviews yet for this product. Be the first to share your experience!',
                    style: TextStyle(
                      color: muted,
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              else
                ...reviews.take(2).map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ReviewItemWidget(
                      initials: item.initials,
                      name: item.userName,
                      date: item.formattedDate,
                      title: '',
                      body: item.comment,
                      rating: item.rating,
                      userPicture: item.userPicture,
                    ),
                  );
                }),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onWriteReview,
                  icon: const Icon(Icons.edit_outlined, size: 16),
                  label: const Text(AppStrings.writeAReview),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: orange,
                    side: BorderSide(color: orange.withValues(alpha: 0.55)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _ratingBar(
    BuildContext context, {
    required int stars,
    required double percentage,
    required int count,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        children: [
          SizedBox(
            width: 8,
            child: Text(
              '$stars',
              style: const TextStyle(
                color: Color(0xFF777777),
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 5),
          const Icon(Icons.star_rounded, color: Color(0xFFC5A059), size: 10),
          const SizedBox(width: 7),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: percentage.clamp(0.0, 1.0),
                minHeight: 5,
                backgroundColor: isDark ? Colors.white10 : Colors.black12,
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFC5A059)),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 18,
            child: Text(
              '$count',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: isDark ? const Color(0xFF8A8F98) : const Color(0xFF9E9E9E),
                fontSize: 8,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildRatingStars(double value, {double size = 12}) {
    final clamped = value.clamp(0.0, 5.0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        if (clamped >= starIndex - 0.25) {
          return Icon(Icons.star_rounded, color: const Color(0xFFC5A059), size: size);
        } else if (clamped >= starIndex - 0.75) {
          return Icon(Icons.star_half_rounded, color: const Color(0xFFC5A059), size: size);
        } else {
          return Icon(Icons.star_outline_rounded, color: const Color(0xFFC5A059), size: size);
        }
      }),
    );
  }
}

class ReviewItemWidget extends StatelessWidget {
  final String initials;
  final String name;
  final String date;
  final String title;
  final String body;
  final int rating;
  final String? userPicture;

  const ReviewItemWidget({
    super.key,
    required this.initials,
    required this.name,
    required this.date,
    this.title = '',
    required this.body,
    required this.rating,
    this.userPicture,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final foreground = isDark ? Colors.white : const Color(0xFF171717);
    final muted = isDark ? const Color(0xFF8A8F98) : const Color(0xFF777777);
    final gold = const Color(0xFFC5A059);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: gold.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: userPicture != null && userPicture!.trim().isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        userPicture!,
                        width: 34,
                        height: 34,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Text(
                          initials,
                          style: const TextStyle(
                            color: Color(0xFFC5A059),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    )
                  : Text(
                      initials,
                      style: const TextStyle(
                        color: Color(0xFFC5A059),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: foreground,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (date.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      date,
                      style: TextStyle(
                        color: muted,
                        fontSize: 8,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < rating.clamp(0, 5) ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: gold,
                  size: 11,
                ),
              ),
            ),
          ],
        ),
        if (title.trim().isNotEmpty) ...[
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: foreground,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        if (body.trim().isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            body,
            style: TextStyle(color: muted, fontSize: 11, height: 1.55),
          ),
        ],
      ],
    );
  }
}
