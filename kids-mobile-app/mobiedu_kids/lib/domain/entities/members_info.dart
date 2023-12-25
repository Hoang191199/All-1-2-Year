class MembersInfo {
  MembersInfo(
      {this.user_id,
      this.user_name,
      this.user_fullname,
      this.user_firstname,
      this.user_lastname,
      this.user_gender,
      this.user_picture,
      this.connection});

  String? user_id;
  String? user_name;
  String? user_fullname;
  String? user_firstname;
  String? user_lastname;
  String? user_gender;
  String? user_picture;
  String? connection;

  factory MembersInfo.fromJson(Map<String, dynamic>? json) {
    return MembersInfo(
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
      user_name:
          json?["user_name"] == null ? null : json?['user_name'] as String,
      user_fullname: json?["user_fullname"] == null
          ? null
          : json?['user_fullname'] as String,
      user_firstname: json?["user_firstname"] == null
          ? null
          : json?['user_firstname'] as String,
      user_lastname: json?["user_lastname"] == null
          ? null
          : json?['user_lastname'] as String,
      user_gender:
          json?["user_gender"] == null ? null : json?['user_gender'] as String,
      user_picture: json?["user_picture"] == null
          ? null
          : json?['user_picture'] as String,
      connection:
          json?["connection"] == null ? null : json?['connection'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        "user_name": user_name,
        "user_fullname": user_fullname,
        "user_firstname": user_firstname,
        "user_lastname": user_lastname,
        "user_gender": user_gender,
        "user_picture": user_picture,
        "connection": connection
      };
}
