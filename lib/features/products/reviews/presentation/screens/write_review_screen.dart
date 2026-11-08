import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/features/products/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:aura_maison_e_commerce/features/products/reviews/presentation/cubit/reviews_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteReviewScreen extends StatefulWidget {
  final String productName;
  final String productId;
  final String productImage;

  const WriteReviewScreen({
    super.key,
    required this.productName,
    required this.productId,
    this.productImage = '',
  });

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  static const Color gold = Color(0xFFC5A059);
  static const Color orange = Color(0xFFFF5A1F);

  int _rating = 5;
  final TextEditingController _reviewController = TextEditingController();

  bool get isDark => Theme.of(context).brightness == Brightness.dark;
  Color get background =>
      isDark ? const Color(0xFF080B10) : const Color(0xFFFBF9F5);
  Color get surface => isDark ? const Color(0xFF191C21) : Colors.white;
  Color get foreground => isDark ? Colors.white : const Color(0xFF171717);
  Color get muted => isDark ? const Color(0xFF8A8F98) : const Color(0xFF777777);

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSubmitting = context.select<ReviewsCubit, bool>(
      (cubit) => cubit.state is AddReviewLoadingState,
    );

    return BlocListener<ReviewsCubit, ReviewStates>(
      listener: (context, state) {
        if (state is AddReviewSuccessState) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Review submitted successfully')),
            );
          Navigator.pop(context, true);
        }
        if (state is AddReviewErrorState) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.error)),
            );
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: background,
          foregroundColor: foreground,
          elevation: 0,
          title: Text(
            AppStrings.writeAReviewTitle,
            style: TextStyle(
              color: foreground,
              fontFamily: 'EB Garamond',
              fontSize: 22,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF252830)
                              : const Color(0xFFF3EFE8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: widget.productImage.trim().isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  widget.productImage,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.watch_outlined,
                                      color: gold,
                                      size: 30,
                                    );
                                  },
                                ),
                              )
                            : const Icon(
                                Icons.watch_outlined,
                                color: gold,
                                size: 30,
                              ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              AppStrings.reviewing,
                              style: TextStyle(
                                color: orange,
                                fontSize: 9,
                                letterSpacing: 1.1,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.productName,
                              style: TextStyle(
                                color: foreground,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  AppStrings.yourRating,
                  style: TextStyle(
                    color: foreground,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: List.generate(5, (index) {
                    final selected = index < _rating;
                    return IconButton(
                      onPressed: () => setState(() => _rating = index + 1),
                      padding: const EdgeInsets.only(right: 8),
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        selected
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: gold,
                        size: 34,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Text(
                  ['', 'Poor', 'Fair', 'Good', 'Very Good', 'Excellent'][_rating],
                  style: const TextStyle(
                    color: gold,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 26),
                _fieldLabel('YOUR REVIEW'),
                const SizedBox(height: 9),
                _reviewField(
                  controller: _reviewController,
                  hint: 'Share your experience with this timepiece...',
                  maxLines: 6,
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isSubmitting
                        ? null
                        : () {
                            final comment = _reviewController.text.trim();
                            if (comment.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please write a review first'),
                                ),
                              );
                              return;
                            }
                            FocusScope.of(context).unfocus();
                            context.read<ReviewsCubit>().addReview(
                              widget.productId,
                              comment,
                              _rating,
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: gold,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      isSubmitting ? 'SUBMITTING...' : AppStrings.submitReview,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        color: foreground,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _reviewField({
    required TextEditingController controller,
    required String hint,
    required int maxLines,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: foreground, fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: muted, fontSize: 12),
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(
            color: isDark ? Colors.white10 : Colors.black12,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: orange),
        ),
      ),
    );
  }
}
