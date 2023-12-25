import 'package:qltv/domain/entities/user_site_ids.dart';

class UserData {
  UserData({
    this.id,
    this.fullname,
    this.phone,
    this.email,
    this.role,
    this.gender,
    this.birthday,
    this.default_site_id,
    this.avatar_url,
    this.accessToken,
    this.refreshToken,
    this.code,
    this.site_ids,
  });

  int? id;
  String? fullname;
  String? phone;
  String? email;
  String? role;
  int? gender;
  String? birthday;
  int? default_site_id;
  String? avatar_url;
  String? accessToken;
  String? refreshToken;
  String? code;
  List<UserSiteIds>? site_ids;

  factory UserData.fromJson(Map<String, dynamic>? json) {
    return UserData(
      id: json?["id"] == null ? null : json?['id'] as int,
      fullname: json?["fullname"] == null ? null : json?['fullname'] as String,
      phone: json?["phone"] == null ? null : json?['phone'] as String,
      email: json?["email"] == null ? null : json?['email'] as String,
      role: json?["role"] == null ? null : json?['role'] as String,
      gender: json?["gender"] == null ? null : json?['gender'] as int,
      birthday: json?["birthday"] == null ? null : json?['birthday'] as String,
      default_site_id: json?["default_site_id"] == null
          ? null
          : json?['default_site_id'] as int,
      avatar_url:
          json?["avatar_url"] == null ? null : json?['avatar_url'] as String,
      accessToken:
          json?["accessToken"] == null ? null : json?['accessToken'] as String,
      refreshToken: json?["refreshToken"] == null
          ? null
          : json?['refreshToken'] as String,
      code: json?["code"] == null ? null : json?['code'] as String,
      site_ids: json?["site_ids"] == null ? null : List<UserSiteIds>.from(json?["site_ids"].map((x) => UserSiteIds.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullname': fullname,
        'phone': phone,
        'email': email,
        'role': role,
        'gender': gender,
        'birthday': birthday,
        'default_site_id': default_site_id,
        'avatar_url': avatar_url,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'code': code,
        'site_ids': site_ids,
      };
}
