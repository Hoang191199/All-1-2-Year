class UserData {
  UserData({
    this.user_id,
    this.user_name,
    this.user_email,
    this.user_token,
    this.user_fname,
    this.user_lname,
    this.user_fullname,
    this.user_picture,
    this.is_manager,
  });

  String? user_id;
  String? user_name;
  String? user_email;
  String? user_token;
  String? user_fname;
  String? user_lname;
  String? user_fullname;
  String? user_picture;
  bool? is_manager;

  factory UserData.fromJson(Map<String, dynamic>? json) {
    return UserData(
      user_id: json?['user_id'] == null ? null : json?['user_id'] as String,
      user_name:
          json?['user_name'] == null ? null : json?['user_name'] as String,
      user_email:
          json?['user_email'] == null ? null : json?['user_email'] as String,
      user_token:
          json?['user_token'] == null ? null : json?['user_token'] as String,
      user_fname:
          json?['user_fname'] == null ? null : json?['user_fname'] as String,
      user_lname:
          json?['user_lname'] == null ? null : json?['user_lname'] as String,
      user_fullname: json?['user_fullname'] == null
          ? null
          : json?['user_fullname'] as String,
      user_picture: json?['user_picture'] == null
          ? null
          : json?['user_picture'] as String,
      is_manager:
          json?['is_manager'] == null ? false : json?['is_manager'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        "user_name": user_name,
        "user_email": user_email,
        "user_token": user_token,
        "user_fname": user_fname,
        "user_lname": user_lname,
        "user_fullname": user_fullname,
        "user_picture": user_picture,
        "is_manager": is_manager,
      };
}
