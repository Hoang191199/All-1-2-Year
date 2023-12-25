class ReviewRate {
  ReviewRate({
    this.totalRate,
    this.rate,
    this.percent,
  });

  int? totalRate;
  double? rate;
  int? percent;

  factory ReviewRate.fromJson(Map<String, dynamic>? json) {
    return ReviewRate(
      totalRate: json?['totalRate'] == null ? 0 : json?['totalRate'] as int,
      rate: json?['rate'] == null ? 0.0 : json?['rate'].toDouble(),
      percent: json?['percent'] == null ? 0 : json?['percent'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'totalRate': totalRate,
    'rate': rate,
    'percent': percent,
  };
}