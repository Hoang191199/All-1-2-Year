class DataTeacher {
  DataTeacher({
    this.user_id,
    this.user_fullname,
    this.user_phone,
    this.user_picture,
    this.user_email
  });

    String? user_id;
    String? user_fullname;
    String? user_phone;
    String? user_picture;
    String? user_email;

  factory DataTeacher.fromJson(Map<String, dynamic>? json) {
    return DataTeacher(
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
      user_fullname: json?["user_fullname"] == null ? null : json?['user_fullname'] as String,
      user_phone: json?["user_phone"] == null ? null : json?['user_phone'] as String,
      user_picture: json?["user_picture"] == null ? null : json?['user_picture'] as String,
      user_email: json?["user_email"] == null ? null : json?['user_email'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': user_id,
    'user_fullname': user_fullname,
    'user_phone': user_phone,
    'user_picture': user_picture,
    'user_email': user_email
  };
}