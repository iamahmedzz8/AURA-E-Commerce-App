import 'package:aura_maison_e_commerce/features/products/reviews/data/models/reviews_model.dart';
import 'package:aura_maison_e_commerce/features/products/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:aura_maison_e_commerce/features/products/reviews/presentation/cubit/reviews_state.dart';
import 'package:aura_maison_e_commerce/features/products/reviews/presentation/screens/write_review_screen.dart';
import 'package:aura_maison_e_commerce/features/products/reviews/presentation/widgets/reviews_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsScreen extends StatelessWidget {
  final String productId;
  final String productName;
  final String productImage;

  const ReviewsScreen({
    super.key,
    required this.productId,
    required this.productName,
    this.productImage = '',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReviewsCubit()..getReviews(productId),
      child: _ReviewsScreenBody(
        productId: productId,
        productName: productName,
        productImage: productImage,
      ),
    );
  }
}

class _ReviewsScreenBody extends StatelessWidget {
  final String productId;
  final String productName;
  final String productImage;

  const _ReviewsScreenBody({
    required this.productId,
    required this.productName,
    required this.productImage,
  });

  void _openWriteReview(BuildContext context) {
    final reviewsCubit = context.read<ReviewsCubit>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: reviewsCubit,
          child: WriteReviewScreen(
            productId: productId,
            productName: productName,
            productImage: productImage,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final foreground = isDark ? Colors.white : const Color(0xFF171717);
    final muted = isDark ? const Color(0xFF8A8F98) : const Color(0xFF777777);
    final background = isDark ? const Color(0xFF080B10) : const Color(0xFFFBF9F5);
    final surface = isDark ? const Color(0xFF191C21) : Colors.white;
    const orange = Color(0xFFFF5A1F);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: foreground,
        elevation: 0,
        title: Text(
          'All Reviews',
          style: TextStyle(
            color: foreground,
            fontFamily: 'EB Garamond',
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Write a Review',
            icon: const Icon(Icons.rate_review_outlined, color: orange),
            onPressed: () => _openWriteReview(context),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<ReviewsCubit, ReviewStates>(
          builder: (context, state) {
            final successState = state is GetReviewSuccessState ? state : null;
            final reviews = successState?.reviews ?? const <ReviewModel>[];
            final averageRating = successState?.averageRating ?? 0.0;
            final reviewsCount = successState?.reviewsCount ?? 0;

            return RefreshIndicator(
              color: orange,
              onRefresh: () => context.read<ReviewsCubit>().getReviews(productId),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productName,
                                  style: TextStyle(
                                    color: foreground,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '$reviewsCount ${reviewsCount == 1 ? "review" : "reviews"}',
                                  style: TextStyle(
                                    color: muted,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                averageRating > 0 ? averageRating.toStringAsFixed(1) : '0.0',
                                style: TextStyle(
                                  color: foreground,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              ReviewsSummaryCard.buildRatingStars(
                                averageRating > 0 ? averageRating : 0,
                                size: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    if (state is GetReviewLoadingState)
                      const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(color: orange),
                        ),
                      )
                    else if (state is GetReviewErrorState)
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                state.error,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.red.shade400, fontSize: 13),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () =>
                                    context.read<ReviewsCubit>().getReviews(productId),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: orange,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      )
                    else if (reviews.isEmpty)
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star_outline_rounded, size: 48, color: muted.withValues(alpha: 0.5)),
                              const SizedBox(height: 12),
                              Text(
                                'No reviews yet for this product.',
                                style: TextStyle(color: muted, fontSize: 13),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Be the first to share your thoughts!',
                                style: TextStyle(color: muted, fontSize: 11),
                              ),
                              const SizedBox(height: 16),
                              OutlinedButton.icon(
                                onPressed: () => _openWriteReview(context),
                                icon: const Icon(Icons.edit_outlined, size: 16),
                                label: const Text('Write a Review'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: orange,
                                  side: const BorderSide(color: orange),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: reviews.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 14),
                          itemBuilder: (context, index) {
                            final item = reviews[index];
                            return ReviewItemWidget(
                              initials: item.initials,
                              name: item.userName,
                              date: item.formattedDate,
                              title: '',
                              body: item.comment,
                              rating: item.rating,
                              userPicture: item.userPicture,
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
