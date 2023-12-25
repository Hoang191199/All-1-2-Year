class UserSSO {
  UserSSO({
    this.accessToken,
    this.notificationToken,
    this.id,
    this.fullname,
    this.phone,
    this.email,
    this.dob,
    this.avatar,
    this.address,
    this.gender,
    this.city,
  });

  String? accessToken;
  String? notificationToken;
  int? id;
  String? fullname;
  String? phone;
  String? email;
  String? dob;
  String? avatar;
  String? address;
  String? gender;
  String? city;

  factory UserSSO.fromJson(Map<String, dynamic>? json) {
    return UserSSO(
      accessToken: json?["accessToken"] == null ? null : json?['accessToken'] as String,
      notificationToken: json?["notificationToken"] == null ? null : json?['notificationToken'] as String,
      id: json?["id"] == null ? null : json?['id'] as int,
      fullname: json?["fullname"] == null ? null : json?['fullname'] as String,
      phone: json?["phone"] == null ? null : json?['phone'] as String,
      email: json?["email"] == null ? null : json?['email'] as String,
      dob: json?["dob"] == null ? null : json?['dob'] as String,
      avatar: json?["avatar"] == null ? null : json?['avatar'] as String,
      gender: json?["gender"] == null ? null : json?['gender'] as String,
      city: json?["city"] == null ? null : json?['city'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'notificationToken': notificationToken,
    'id': id,
    'fullname': fullname,
    'phone': phone,
    'email': email,
    'dob': dob,
    'avatar': avatar,
    'gender': gender,
    'city': city,
  };
}
