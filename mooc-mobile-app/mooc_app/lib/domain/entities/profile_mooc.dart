class ProfileMooc {
  ProfileMooc({
    required this.id,
    required this.gender,
    required this.city,
    required this.fullname,
    required this.email,
    required this.phone,
    this.dob,
    required this.address,
    this.avatar,
  });

  int id;
  String gender;
  String city;
  String fullname;
  String email;
  String phone;
  String? dob;
  String address;
  String? avatar;


  factory ProfileMooc.fromJson(Map<String, dynamic>? json) {
    return ProfileMooc(
      id: json?['id'] as int,
      address: json?['address'] as String,
      fullname: json?['fullname'] as String,
      email: json?['email'] as String,
      phone: json?['phone'] as String,
      gender: json?['gender'] as String,
      avatar: json?['avatar'] == null ? null : json?['avatar'] as String,
      city: json?['city'] as String,
      dob: json?['dob'] == null ? null : json?['dob'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'gender': gender,
    'city': city,
    'address': address,
    'fullname': fullname,
    'email': email,
    'phone': phone,
    'dob': dob,
    'avatar': avatar,
  };
}