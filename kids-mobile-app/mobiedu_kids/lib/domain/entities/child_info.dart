class ChildInfo {
  ChildInfo({
    this.child_id,
    this.child_code,
    this.child_name,
    this.birthday,
    this.gender,
    this.parent_name,
    this.parent_phone,
    this.parent_email,
    this.status,
    this.child_picture,
  });

  String? child_id;
  String? child_code;
  String? child_name;
  String? birthday;
  String? gender;
  String? parent_name;
  String? parent_phone;
  String? parent_email;
  String? status;
  String? child_picture;

  factory ChildInfo.fromJson(Map<String, dynamic>? json) {
    return ChildInfo(
      child_id: json?["child_id"] == null ? null : json?['child_id'] as String,
      child_code:
          json?["child_code"] == null ? null : json?['child_code'] as String,
      child_name:
          json?["child_name"] == null ? null : json?['child_name'] as String,
      birthday: json?["birthday"] == null ? null : json?['birthday'] as String,
      gender: json?["gender"] == null ? null : json?['gender'] as String,
      parent_name:
          json?["parent_name"] == null ? null : json?['parent_name'] as String,
      parent_phone: json?["parent_phone"] == null
          ? null
          : json?['parent_phone'] as String,
      parent_email: json?["parent_email"] == null
          ? null
          : json?['parent_email'] as String,
      status: json?["status"] == null ? null : json?['status'] as String,
      child_picture: json?["child_picture"] == null
          ? null
          : json?['child_picture'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "child_id": child_id,
        "child_code": child_code,
        "child_name": child_name,
        "birthday": birthday,
        "gender": gender,
        "parent_name": parent_name,
        "parent_phone": parent_phone,
        "parent_email": parent_email,
        "status": status,
        "child_picture": child_picture
      };
}
