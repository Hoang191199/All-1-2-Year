class AdminInSchool {
  AdminInSchool({
    this.user_id,
    this.user_name,
    this.user_fullname,
    this.user_picture,
    this.user_email,
  });

  String? user_id;
  String? user_name;
  String? user_fullname;
  String? user_picture;
  String? user_email;

  factory AdminInSchool.fromJson(Map<String, dynamic>? json) {
    return AdminInSchool(
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
      user_name: json?["user_name"] == null ? null : json?['user_name'] as String,
      user_fullname: json?["user_fullname"] == null ? null : json?['user_fullname'] as String,
      user_picture: json?["user_picture"] == null ? null : json?['user_picture'] as String,
      user_email: json?["user_email"] == null ? null : json?['user_email'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': user_id,
    'user_name': user_name,
    'user_fullname': user_fullname,
    'user_picture': user_picture,
    'user_email': user_email
  };

}