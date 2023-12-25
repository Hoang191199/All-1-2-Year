import 'package:mobiedu_kids/domain/entities/parent_details.dart';

class ChildDetails {
  ChildDetails({
    this.child_id,
    this.child_name,
    this.child_code,
    this.first_name,
    this.last_name,
    this.child_nickname,
    this.birthday,
    this.gender,
    this.child_picture,
    this.child_admin,
    this.parent_name,
    this.parent_phone,
    this.parent_email,
    this.address,
    this.description,
    this.created_user_id,
    this.school_id,
    this.status,
    this.begin_at,
    this.parent,
  });

  String? child_id;
  String? child_name;
  String? child_code;
  String? first_name;
  String? last_name;
  String? child_nickname;
  String? birthday;
  String? gender;
  String? child_picture;
  String? child_admin;
  String? parent_name;
  String? parent_phone;
  String? parent_email;
  String? address;
  String? description;
  String? created_user_id;
  String? school_id;
  String? status;
  String? begin_at;
  List<ParentDetails>? parent;

  factory ChildDetails.fromJson(Map<String, dynamic>? json) {
    return ChildDetails(
      child_id: json?["child_id"] == null ? null : json?['child_id'] as String,
      child_name:
          json?["child_name"] == null ? null : json?['child_name'] as String,
      child_code:
          json?["child_code"] == null ? null : json?['child_code'] as String,
      first_name:
          json?["first_name"] == null ? null : json?['first_name'] as String,
      last_name:
          json?["last_name"] == null ? null : json?['last_name'] as String,
      child_nickname: json?["child_nickname"] == null
          ? null
          : json?['child_name'] as String,
      birthday: json?["birthday"] == null ? null : json?['birthday'] as String,
      gender: json?["gender"] == null ? null : json?['gender'] as String,
      child_picture: json?["child_picture"] == null
          ? null
          : json?['child_picture'] as String,
      child_admin:
          json?["child_admin"] == null ? null : json?['child_admin'] as String,
      parent_name:
          json?["parent_name"] == null ? null : json?['parent_name'] as String,
      parent_phone: json?["parent_phone"] == null
          ? null
          : json?['parent_phone'] as String,
      parent_email: json?["parent_email"] == null
          ? null
          : json?['parent_email'] as String,
      address: json?["address"] == null ? null : json?['address'] as String,
      description:
          json?["description"] == null ? null : json?['description'] as String,
      created_user_id: json?["created_user_id"] == null
          ? null
          : json?['created_user_id'] as String,
      school_id:
          json?["school_id"] == null ? null : json?['school_id'] as String,
      status: json?["status"] == null ? null : json?['status'] as String,
      begin_at: json?["begin_at"] == null ? null : json?['begin_at'] as String,
      parent: json?["parent"] == null
          ? null
          : List<ParentDetails>.from(
              json?["parent"].map((x) => ParentDetails.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'child_id': child_id,
        'child_name': child_name,
        "child_code": child_code,
        "first_name": first_name,
        "last_name": last_name,
        "child_nickname": child_nickname,
        "birthday": birthday,
        "gender": gender,
        "child_picture": child_picture,
        "child_admin": child_admin,
        "parent_name": parent_name,
        "parent_phone": parent_phone,
        "parent_email": parent_email,
        "address": address,
        "description": description,
        "created_user_id": created_user_id,
        "school_id": school_id,
        "status": status,
        "begin_at": begin_at,
        "parent": parent
      };
}
