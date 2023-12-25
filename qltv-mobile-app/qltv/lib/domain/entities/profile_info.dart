import 'package:qltv/domain/entities/group_info.dart';
import 'package:qltv/domain/entities/permission_info.dart';

class ProfileInfo {
  ProfileInfo({
    this.id,
    this.phone,
    this.email,
    this.gender,
    this.birthday,
    this.end_year,
    this.fullname,
    this.start_year,
    this.expired_date,
    this.role,
    this.groups,
    this.permissions,
  });

  int? id;
  String? phone;
  String? email;
  int? gender;
  String? birthday;
  int? end_year;
  String? fullname;
  int? start_year;
  String? expired_date;
  String? role;
  List<GroupInfo>? groups;
  List<PermissionInfo>? permissions;

  factory ProfileInfo.fromJson(Map<String, dynamic>? json) {
    return ProfileInfo(
      id: json?["id"] == null ? null : json?["id"] as int,
      phone: json?["phone"] == null ? null : json?["phone"] as String,
      email: json?["email"] == null ? null : json?["email"] as String,
      gender: json?["gender"] == null ? null : json?["gender"] as int,
      birthday: json?["birthday"] == null ? null : json?["birthday"] as String,
      fullname: json?["fullname"] == null ? null : json?["fullname"] as String,
      end_year: json?["end_year"] == null ? null : json?["end_year"] as int,
      start_year:
          json?["start_year"] == null ? null : json?["start_year"] as int,
      role: json?["role"] == null ? null : json?["role"] as String,
      expired_date: json?["expired_date"] == null
          ? null
          : json?["expired_date"] as String,
      groups: json?["groups"] == null
          ? null
          : List<GroupInfo>.from(
              json?["groups"].map((x) => GroupInfo.fromJson(x))),
      permissions: json?["permissions"] == null
          ? null
          : List<PermissionInfo>.from(
              json?["permissions"].map((x) => PermissionInfo.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "gender": gender,
        "birthday": birthday,
        "end_year": end_year,
        "fullname": fullname,
        "start_year": start_year,
        "expired_date": expired_date,
        "role": role,
        "groups": groups,
        "permissions": permissions
      };
}
