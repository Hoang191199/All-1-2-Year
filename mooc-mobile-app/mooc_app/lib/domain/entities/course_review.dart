import 'package:mooc_app/domain/entities/review.dart';
import 'package:mooc_app/domain/entities/review_data.dart';

class CourseReview {
  CourseReview({
    this.review,
    this.reviewData,
    this.isShowReviewInput,
  });

  Review? review;
  List<ReviewData>? reviewData;
  bool? isShowReviewInput;

  factory CourseReview.fromJson(Map<String, dynamic>? json) {
    return CourseReview(
      review: json?['review'] == null ? null : Review.fromJson(json?['review']),
      reviewData: json?["reviewData"] == null ? null : List<ReviewData>.from(json?["reviewData"].map((x) => ReviewData.fromJson(x))),
      isShowReviewInput: json?['isShowReviewInput'] == null ? false : json?['isShowReviewInput'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'review': review,
    'reviewData': reviewData,
    'isShowReviewInput': isShowReviewInput,
  };
}