import 'package:mooc_app/domain/entities/review_rate.dart';

class Review {
  Review({
    this.star,
    this.total,
    this.reviewRate,
  });

  double? star;
  int? total;
  List<ReviewRate>? reviewRate;

  factory Review.fromJson(Map<String, dynamic>? json) {
    return Review(
      star: json?['star'] == null ? 0.0 : json?['star'].toDouble(),
      total: json?['total'] == null ? 0 : json?['total'] as int,
      reviewRate: json?["reviewRate"] == null ? null : List<ReviewRate>.from(json?["reviewRate"].map((x) => ReviewRate.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'star': star,
    'total': total,
    'reviewRate': reviewRate,
  };
}
