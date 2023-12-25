class SchoolReview {
  SchoolReview({
    this.user_review_id,
    this.user_id,
    this.time,
    this.type,
    this.school_id,
    this.class_id,
    this.teacher_id,
    this.post_id,
    this.rating,
    this.comment,
    this.created_at,
    this.user_fullname,
    this.user_name,
    this.user_picture,
    this.user_gender,
  });

  String? user_review_id;
  String? user_id;
  String? time;
  String? type;
  String? school_id;
  String? class_id;
  String? teacher_id;
  String? post_id;
  String? rating;
  String? comment;
  String? created_at;
  String? user_fullname;
  String? user_name;
  String? user_picture;
  String? user_gender;

  factory SchoolReview.fromJson(Map<String, dynamic>? json) {
    return SchoolReview(
      user_review_id: json?["user_review_id"] == null ? null : json?['user_review_id'] as String,
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
      time: json?["time"] == null ? null : json?['time'] as String,
      type: json?["type"] == null ? null : json?['type'] as String,
      school_id: json?["school_id"] == null ? null : json?['school_id'] as String,
      class_id: json?["class_id"] == null ? null : json?['class_id'] as String,
      teacher_id: json?["teacher_id"] == null ? null : json?['teacher_id'] as String,
      post_id: json?["post_id"] == null ? null : json?['post_id'] as String,
      rating: json?["rating"] == null ? null : json?['rating'] as String,
      comment: json?["comment"] == null ? null : json?['comment'] as String,
      created_at: json?["created_at"] == null ? null : json?['created_at'] as String,
      user_fullname: json?["user_fullname"] == null ? null : json?['user_fullname'] as String,
      user_name: json?["user_name"] == null ? null : json?['user_name'] as String,
      user_picture: json?["user_picture"] == null ? null : json?['user_picture'] as String,
      user_gender: json?["user_gender"] == null ? null : json?['user_gender'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'user_review_id': user_review_id,
    'user_id': user_id,
    'time': time,
    'type': type,
    'school_id': school_id,
    'class_id': class_id,
    'teacher_id': teacher_id,
    'post_id': post_id,
    'rating': rating,
    'comment': comment,
    'created_at': created_at,
    'user_fullname': user_fullname,
    'user_name': user_name,
    'user_picture': user_picture,
    'user_gender': user_gender,
  };
}