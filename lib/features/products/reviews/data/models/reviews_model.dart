class ReviewModel {
  final String comment;
  final int rating;
  final String createdAt;
  final String userName;
  final String? userPicture;

  ReviewModel({
    required this.comment,
    required this.rating,
    required this.createdAt,
    required this.userName,
    this.userPicture,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      comment: json['comment']?.toString().trim() ?? '',
      rating: _parseRating(json['rating']),
      createdAt: json['createdAt']?.toString().trim() ?? '',
      userName: _parseUserName(json['userName'] ?? json['user']?['userName'] ?? json['user']?['name']),
      userPicture: json['userPicture']?.toString() ?? json['user']?['picture']?.toString(),
    );
  }

  static int _parseRating(dynamic val) {
    if (val == null) return 0;
    if (val is num) return val.toInt().clamp(0, 5);
    if (val is String) {
      final parsed = double.tryParse(val.trim());
      if (parsed != null) return parsed.toInt().clamp(0, 5);
    }
    return 0;
  }

  static String _parseUserName(dynamic val) {
    final name = val?.toString().trim();
    if (name == null || name.isEmpty) return 'Patron Client';
    return name;
  }

  String get initials {
    final trimmed = userName.trim();
    if (trimmed.isEmpty) return 'P';
    final parts = trimmed.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return 'P';
    if (parts.length == 1) {
      return parts.first.substring(0, parts.first.length.clamp(1, 2)).toUpperCase();
    }
    return '${parts.first[0]}${parts[1][0]}'.toUpperCase();
  }

  String get formattedDate {
    if (createdAt.isEmpty) return '';
    final dt = DateTime.tryParse(createdAt);
    if (dt == null) return createdAt;
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final day = dt.day.toString().padLeft(2, '0');
    final month = months[(dt.month - 1).clamp(0, 11)];
    final year = dt.year;
    return '$day $month $year';
  }
}

class ReviewsResponseModel {
  final String? message;
  final double averageRating;
  final int reviewsCount;
  final List<ReviewModel> reviews;

  ReviewsResponseModel({
    this.message,
    double? averageRating,
    int? reviewsCount,
    required this.reviews,
  })  : reviewsCount = (reviewsCount != null && reviewsCount >= reviews.length)
            ? reviewsCount
            : reviews.length,
        averageRating = (averageRating != null && averageRating > 0)
            ? double.parse(averageRating.toStringAsFixed(1))
            : (reviews.isNotEmpty
                ? double.parse(
                    (reviews.fold<int>(0, (acc, r) => acc + r.rating) / reviews.length)
                        .toStringAsFixed(1),
                  )
                : 0.0);

  factory ReviewsResponseModel.fromJson(Map<String, dynamic> json) {
    final reviewsMap = json['reviews'];
    List items = [];
    int? totalCountFromPaging;

    if (reviewsMap is Map<String, dynamic>) {
      if (reviewsMap['items'] is List) {
        items = reviewsMap['items'] as List;
      }
      if (reviewsMap['totalCount'] is num) {
        totalCountFromPaging = (reviewsMap['totalCount'] as num).toInt();
      }
    } else if (reviewsMap is List) {
      items = reviewsMap;
    } else if (json['items'] is List) {
      items = json['items'] as List;
    } else if (json['data'] is Map<String, dynamic> && json['data']['items'] is List) {
      items = json['data']['items'] as List;
      if (json['data']['totalCount'] is num) {
        totalCountFromPaging = (json['data']['totalCount'] as num).toInt();
      }
    } else if (json['data'] is List) {
      items = json['data'] as List;
    }

    final parsedReviews = items
        .whereType<Map<String, dynamic>>()
        .map((e) => ReviewModel.fromJson(e))
        .toList();

    final explicitCount = (json['reviewsCount'] as num?)?.toInt() ??
        (json['totalCount'] as num?)?.toInt() ??
        totalCountFromPaging;

    final resolvedCount = (explicitCount != null && explicitCount >= parsedReviews.length)
        ? explicitCount
        : parsedReviews.length;

    final rawAverage = (json['averageRating'] as num?)?.toDouble() ??
        (json['rating'] as num?)?.toDouble() ??
        (json['avgRating'] as num?)?.toDouble();

    final double resolvedAverage;
    if (rawAverage != null && rawAverage > 0) {
      resolvedAverage = double.parse(rawAverage.toStringAsFixed(1));
    } else if (parsedReviews.isNotEmpty) {
      final sum = parsedReviews.fold<int>(0, (acc, r) => acc + r.rating);
      resolvedAverage = double.parse((sum / parsedReviews.length).toStringAsFixed(1));
    } else {
      resolvedAverage = 0.0;
    }

    return ReviewsResponseModel(
      message: json['message']?.toString(),
      averageRating: resolvedAverage,
      reviewsCount: resolvedCount,
      reviews: parsedReviews,
    );
  }

  int getCountForStar(int star) {
    return reviews.where((r) => r.rating == star).length;
  }

  double getPercentageForStar(int star) {
    if (reviews.isEmpty) return 0.0;
    final count = getCountForStar(star);
    return (count / reviews.length).clamp(0.0, 1.0);
  }

  Map<int, int> get starCounts => {
        5: getCountForStar(5),
        4: getCountForStar(4),
        3: getCountForStar(3),
        2: getCountForStar(2),
        1: getCountForStar(1),
      };

  Map<int, double> get starPercentages => {
        5: getPercentageForStar(5),
        4: getPercentageForStar(4),
        3: getPercentageForStar(3),
        2: getPercentageForStar(2),
        1: getPercentageForStar(1),
      };

  String get formattedAverageRating =>
      averageRating > 0 ? averageRating.toStringAsFixed(1) : '0.0';
}
