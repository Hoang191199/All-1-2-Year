class ReviewData {
  ReviewData({
    this.fullname,
    this.avatarUrl,
    this.avatar,
    this.rating,
    this.comment,
  });

  String? fullname;
  String? avatarUrl;
  String? avatar;
  double? rating;
  String? comment;

  factory ReviewData.fromJson(Map<String, dynamic>? json) {
    return ReviewData(
      fullname: json?['fullname'] == null ? null : json?['fullname'] as String,
      avatarUrl: json?['avatarUrl'] == null ? null : json?['avatarUrl'] as String,
      avatar: json?['avatar'] == null ? null : json?['avatar'] as String,
      rating: json?['rating'] == null ? 0.0 : json?['rating'].toDouble(),
      comment: json?['comment'] == null ? null : json?['comment'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'fullname': fullname,
    'avatarUrl': avatarUrl,
    'avatar': avatar,
    'rating': rating,
    'comment': comment,
  };
}