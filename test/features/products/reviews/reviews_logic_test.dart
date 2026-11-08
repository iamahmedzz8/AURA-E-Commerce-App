import 'package:aura_maison_e_commerce/features/products/reviews/data/models/reviews_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ReviewModel Unit Tests', () {
    test('safely parses ratings from various types and clamps to 0..5', () {
      final r1 = ReviewModel.fromJson({
        'comment': 'Awesome',
        'rating': 5,
        'userName': 'John Doe',
      });
      expect(r1.rating, 5);
      expect(r1.initials, 'JD');

      final r2 = ReviewModel.fromJson({
        'comment': 'Good',
        'rating': '4.0',
        'userName': 'Alice',
      });
      expect(r2.rating, 4);
      expect(r2.initials, 'AL');

      final r3 = ReviewModel.fromJson({
        'comment': 'Too high',
        'rating': 10,
        'userName': 'Bob Builder Junior',
      });
      expect(r3.rating, 5); // clamped
      expect(r3.initials, 'BB');

      final r4 = ReviewModel.fromJson({
        'comment': 'Negative',
        'rating': -2,
        'userName': '',
      });
      expect(r4.rating, 0); // clamped
      expect(r4.userName, 'Patron Client');
      expect(r4.initials, 'PC');
    });

    test('formats ISO 8601 dates to readable text', () {
      final r = ReviewModel.fromJson({
        'comment': 'Great',
        'rating': 5,
        'createdAt': '2026-11-08T18:30:00.000Z',
      });
      expect(r.formattedDate, '08 Nov 2026');
    });
  });

  group('ReviewsResponseModel Calculation Logic Tests', () {
    test('calculates accurate averageRating and reviewsCount when backend omits them', () {
      final json = {
        'reviews': {
          'items': [
            {'comment': 'Excellent', 'rating': 5, 'userName': 'User 1'},
            {'comment': 'Very good', 'rating': 4, 'userName': 'User 2'},
            {'comment': 'Good', 'rating': 3, 'userName': 'User 3'},
          ],
          'totalCount': 3,
        },
      };

      final model = ReviewsResponseModel.fromJson(json);

      // (5 + 4 + 3) / 3 = 4.0
      expect(model.averageRating, 4.0);
      expect(model.formattedAverageRating, '4.0');
      expect(model.reviewsCount, 3);
      expect(model.reviews.length, 3);
    });

    test('uses backend averageRating if explicitly provided and > 0', () {
      final json = {
        'averageRating': 4.75,
        'reviewsCount': 10,
        'reviews': {
          'items': [
            {'comment': 'Good', 'rating': 4, 'userName': 'User 1'},
          ],
          'totalCount': 10,
        },
      };

      final model = ReviewsResponseModel.fromJson(json);

      expect(model.averageRating, 4.8); // rounded to 1 decimal
      expect(model.formattedAverageRating, '4.8');
      expect(model.reviewsCount, 10);
    });

    test('calculates star distribution and percentages accurately', () {
      final json = {
        'reviews': {
          'items': [
            {'comment': 'A', 'rating': 5},
            {'comment': 'B', 'rating': 5},
            {'comment': 'C', 'rating': 4},
            {'comment': 'D', 'rating': 2},
          ],
        },
      };

      final model = ReviewsResponseModel.fromJson(json);

      expect(model.reviews.length, 4);
      expect(model.getCountForStar(5), 2);
      expect(model.getCountForStar(4), 1);
      expect(model.getCountForStar(3), 0);
      expect(model.getCountForStar(2), 1);
      expect(model.getCountForStar(1), 0);

      // Percentages:
      // 5 stars: 2/4 = 0.5 (50%)
      // 4 stars: 1/4 = 0.25 (25%)
      // 3 stars: 0/4 = 0.0 (0%)
      // 2 stars: 1/4 = 0.25 (25%)
      // 1 star:  0/4 = 0.0 (0%)
      expect(model.getPercentageForStar(5), 0.5);
      expect(model.getPercentageForStar(4), 0.25);
      expect(model.getPercentageForStar(3), 0.0);
      expect(model.getPercentageForStar(2), 0.25);
      expect(model.getPercentageForStar(1), 0.0);

      expect(model.starCounts, {5: 2, 4: 1, 3: 0, 2: 1, 1: 0});
      expect(model.starPercentages, {
        5: 0.5,
        4: 0.25,
        3: 0.0,
        2: 0.25,
        1: 0.0,
      });
    });

    test('handles empty reviews gracefully without errors or division by zero', () {
      final json = {
        'reviews': <dynamic>[],
        'averageRating': null,
        'reviewsCount': 0,
      };

      final model = ReviewsResponseModel.fromJson(json);

      expect(model.averageRating, 0.0);
      expect(model.formattedAverageRating, '0.0');
      expect(model.reviewsCount, 0);
      expect(model.reviews.isEmpty, true);
      expect(model.getCountForStar(5), 0);
      expect(model.getPercentageForStar(5), 0.0);
      expect(model.starCounts, {5: 0, 4: 0, 3: 0, 2: 0, 1: 0});
      expect(model.starPercentages, {5: 0.0, 4: 0.0, 3: 0.0, 2: 0.0, 1: 0.0});
    });
  });
}
