import 'package:mooc_app/domain/entities/avatar.dart';

class Profile {
  Profile({
    required this.id,
    required this.gender,
    this.idGender,
    required this.province,
    this.idProvince,
    required this.fullname,
    required this.email,
    required this.phone,
    this.birthday,
    required this.address,
    required this.code,
    required this.groupName,
    required this.avatar,
  });

  int id;
  int? idGender;
  String gender;
  int? idProvince;
  String province;
  String fullname;
  String email;
  String phone;
  String? birthday;
  String address;
  String code;
  String groupName;
  Avatar avatar;

  factory Profile.fromJson(Map<String, dynamic>? json) {
    return Profile(
      id: json?['id'] as int,
      address: json?['address'] as String,
      fullname: json?['fullname'] as String,
      email: json?['email'] as String,
      phone: json?['phone'] as String,
      gender: json?['gender'] as String,
      avatar: Avatar.fromJson(json?['avatar']),
      idGender: json?['idGender'] == null ? null : json?['idGender'] as int,
      province: json?['province'] as String,
      idProvince: json?['idProvince'] == null ? null : json?['idProvince'] as int,
      birthday: json?['birthday'] == null ? null : json?['birthday'] as String,
      code: json?['code'] as String,
      groupName: json?['groupName'] as String,

    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'idGender': idGender,
    'gender': gender,
    'idProvince': idProvince,
    'province': province,
    'address': address,
    'fullname': fullname,
    'email': email,
    'phone': phone,
    'birthday': birthday,
    'code': code,
    'groupName': groupName,
    'avatar': avatar
  };
}