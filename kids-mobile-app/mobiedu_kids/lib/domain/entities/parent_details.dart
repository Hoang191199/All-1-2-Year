class ParentDetails {
  ParentDetails({
    this.user_id,
    this.user_name,
    this.user_fullname,
    this.user_gender,
    this.user_picture,
    this.user_phone,
    this.user_email,
    // this.user_last_active,
  });

  String? user_id;
  String? user_name;
  String? user_fullname;
  String? user_gender;
  String? user_picture;
  String? user_phone;
  String? user_email;
  // String? user_last_active;

  factory ParentDetails.fromJson(Map<String, dynamic>? json) {
    return ParentDetails(
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
      user_name:
          json?["user_name"] == null ? null : json?['user_name'] as String,
      user_fullname: json?["user_fullname"] == null
          ? null
          : json?['user_fullname'] as String,
      user_gender:
          json?["user_gender"] == null ? null : json?['user_gender'] as String,
      user_picture: json?["user_picture"] == null
          ? null
          : json?['user_picture'] as String,
      user_phone:
          json?["user_phone"] == null ? null : json?['user_phone'] as String,
      user_email:
          json?["user_email"] == null ? null : json?['user_email'] as String,
      // user_last_active: json?["user_last_active"] == null
      //     ? null
      //     : json?['user_last_active'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        "user_name": user_name,
        "user_fullname": user_fullname,
        "user_gender": user_gender,
        "user_picture": user_picture,
        "user_phone": user_phone,
        "user_email": user_email,
        // "user_last_active": user_last_active
      };
}
